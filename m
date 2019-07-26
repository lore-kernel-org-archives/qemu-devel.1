Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05284C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4452166E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4452166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvjn-0005zB-2V
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hqvjd-0005WR-67
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hqvjb-0005c7-3w
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:37:52 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:58166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hqvja-0005Kr-1I
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:37:50 -0400
Received: from player798.ha.ovh.net (unknown [10.108.35.128])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 7D16E1D5BB0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:37:46 +0200 (CEST)
Received: from kaod.org (unknown [109.190.253.16])
 (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id 93D4786AE763;
 Fri, 26 Jul 2019 08:37:39 +0000 (UTC)
To: sathnaga@linux.vnet.ibm.com, qemu-devel@nongnu.org
References: <20190726071737.32298-1-sathnaga@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e18f2889-38ff-5ff9-6411-cf8c5f77d549@kaod.org>
Date: Fri, 26 Jul 2019 10:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726071737.32298-1-sathnaga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13536131633986505683
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.39.161
Subject: Re: [Qemu-devel] [PATCH 0/2] Add support for powerpc acceptance test
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/2019 09:17, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> This series attempt to add support for avocado acceptance
> test for powerpc and adds linux console boot test.
> 
> avocado run boot_linux_console.py:BootLinuxConsole.test_ppc64le_pseries version.py vnc.py 
> JOB ID     : 918ed65e5e8bc1370c84c166a2c41936a700571e
> JOB LOG    : /home/sath/tests/results/job-2019-07-26T03.08-918ed65/job.log
>  (1/6) boot_linux_console.py:BootLinuxConsole.test_ppc64le_pseries: PASS (3.98 s)
>  (2/6) version.py:Version.test_qmp_human_info_version: PASS (0.15 s)
>  (3/6) vnc.py:Vnc.test_no_vnc: PASS (0.14 s)
>  (4/6) vnc.py:Vnc.test_no_vnc_change_password: PASS (0.13 s)
>  (5/6) vnc.py:Vnc.test_vnc_change_password_requires_a_password: PASS (0.14 s)
>  (6/6) vnc.py:Vnc.test_vnc_change_password: PASS (0.14 s)
> RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
> JOB TIME   : 5.68 s
> 
> 
> Satheesh Rajendran (2):
>   tests.acceptance.avocado_qemu: Add support for powerpc
>   tests.acceptance.boot_linux_console: Add pseries linux boot console
>     test
> 
>  tests/acceptance/avocado_qemu/__init__.py |  4 ++++
>  tests/acceptance/boot_linux_console.py    | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 

Nice. Do you think we could do something similar for the PowerNV machine ? 

Thanks,

C. 


