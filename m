Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC458CA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 03:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBEDB2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 03:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEDB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN7N1-000892-SV
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 23:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iN7MH-0007jw-Iv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iN7MG-0007zo-73
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:30:49 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3482)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iN7MF-0007tD-KJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:30:48 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by
 rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15dafc94e25a-2837a;
 Wed, 23 Oct 2019 11:30:25 +0800 (CST)
X-RM-TRANSID: 2ee15dafc94e25a-2837a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.144.122] (unknown[112.25.154.148])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75dafc94fad6-07a8f;
 Wed, 23 Oct 2019 11:30:25 +0800 (CST)
X-RM-TRANSID: 2ee75dafc94fad6-07a8f
Subject: Re: [PATCH v4 0/3] some fix in tests/migration
To: qemu-devel@nongnu.org
References: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <e65aeac9-555e-be0f-f246-b1af45083221@cmss.chinamobile.com>
Date: Wed, 23 Oct 2019 11:30:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.79
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

patch2 has been merged into the master by Laurent Vivier.
patch3 is still not reviewed.

So ping...

Thanks,
Mao

On 10/5/19 1:32 AM, Mao Zhongyi wrote:
> This patchset mainly fixes memory leak, typo and return
> value of stress function in stress test.
> 
> v4-v3:
> p1:
> - remove redundant g_malloc return value judgment.
>                                   [Laurent Vivier]
> p3:
> - always use exit_failure() as the exit function of main().
>                                   [Laurent Vivier]
> - update the commit message.
> 
> v3->v2:
> p1:
> - replace malloc with g_malloc   [Laurent Vivier]
> p3:
> - change stressone type to void and stree return value
>    to -1 to make the path of 'if (stress(ramsizeGB, ncpus) < 0)'
>    can be reached.                [Laurent Vivier]
> - update the commit message.
> 
> v2->v1:
> - use g_autofree to release memory automatically instead
>    of free().                     [Alex Bennée]
>                        
> Cc: armbru@redhat.com
> Cc: laurent@vivier.eu
> Cc: tony.nguyen@bt.com
> Cc: alex.bennee@linaro.org
> 
> Mao Zhongyi (3):
>    tests/migration: mem leak fix
>    tests/migration: fix a typo in comment
>    tests/migration：fix unreachable path in stress test
> 
>   tests/migration/stress.c | 36 ++++++++----------------------------
>   1 file changed, 8 insertions(+), 28 deletions(-)
> 



