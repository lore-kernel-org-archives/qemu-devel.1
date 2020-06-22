Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F59C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3808720888
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3808720888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnGbW-0004xh-Fq
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnGat-0004Hg-Fz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:10:15 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:53850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jnGaq-0005Pe-7F
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:10:15 -0400
Received: from player770.ha.ovh.net (unknown [10.110.171.117])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 457E125A321
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:10:09 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-921-245.w86-210.abo.wanadoo.fr
 [86.210.152.245]) (Authenticated sender: clg@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id DE89E13ADA10E;
 Mon, 22 Jun 2020 07:09:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003faa364ff-180b-42df-879c-77c411717360,D5B34DF2F1998B4AFDB97B5973F1BB92C24DD330)
 smtp.auth=clg@kaod.org
Subject: Re: [PULL 10/10] ppc/pnv: Create BMC devices only when defaults are
 enabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
 <20200407043606.291546-11-david@gibson.dropbear.id.au>
 <CAP+75-UdJ9iT7T5ABETzdh38tLfM3ZB3OXtxc-WUu9zr93RYcA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <919a0804-3ea0-dc05-c789-224919be66c8@kaod.org>
Date: Mon, 22 Jun 2020 09:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP+75-UdJ9iT7T5ABETzdh38tLfM3ZB3OXtxc-WUu9zr93RYcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6435643868479195954
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekiedrvddutddrudehvddrvdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.165.232; envelope-from=clg@kaod.org;
 helo=10.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:10:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Nathan Chancellor <natechancellor@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 8:02 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On Tue, Apr 7, 2020 at 6:42 AM David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>> From: Cédric Le Goater <clg@kaod.org>
>>
>> Commit e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
>> introduced default BMC devices which can be a problem when the same
>> devices are defined on the command line with :
>>
>>   -device ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10
>>
>> QEMU fails with :
>>
>>   qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS
>>
>> Use defaults_enabled() when creating the default BMC devices to let
>> the user provide its own BMC devices using '-nodefaults'. If no BMC
>> device are provided, output a warning but let QEMU run as this is a
>> supported configuration. However, when multiple BMC devices are
>> defined, stop QEMU with a clear error as the results are unexpected.
>>
>> Fixes: e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
>> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Message-Id: <20200404153655.166834-1-clg@kaod.org>
>> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
> 
> Not sure if directly related to this patch, but on gitlab-ci we get:
> 
> TEST check-qtest-ppc64: tests/qtest/m48t59-test
> TEST check-qtest-ppc64: tests/qtest/device-plug-test
> TEST check-qtest-ppc64: tests/qtest/pnv-xscom-test
> TEST check-qtest-ppc64: tests/qtest/migration-test
> TEST check-qtest-ppc64: tests/qtest/rtas-test
> TEST check-qtest-ppc64: tests/qtest/usb-hcd-uhci-test
> TEST check-qtest-ppc64: tests/qtest/usb-hcd-xhci-test
> TEST check-qtest-ppc64: tests/qtest/test-filter-mirror
> TEST check-qtest-ppc64: tests/qtest/test-filter-redirector
> TEST check-qtest-ppc64: tests/qtest/display-vga-test
> TEST check-qtest-ppc64: tests/qtest/numa-test
> TEST check-qtest-ppc64: tests/qtest/ivshmem-test
> TEST check-qtest-ppc64: tests/qtest/cpu-plug-test
> TEST check-qtest-ppc64: tests/qtest/cdrom-test
> TEST check-qtest-ppc64: tests/qtest/device-introspect-test
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
> one
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
> one
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
> one

I can not reproduce. Is gitlab-ci doing something special ? 

C. 

