Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1FAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F3C20825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F3C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQKy-0001zj-Ce
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaQJX-0001Cu-O9
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:27:31 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:37789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kaQJS-0005lF-Uu
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:27:31 -0500
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N2V8T-1kCjLi37j5-013xa5; Wed, 04 Nov 2020 22:27:21 +0100
Subject: Re: [PATCH v1 1/1] linux-user/syscall: Fix missing
 target_to_host_timespec64() check
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
References: <cad74fae734d2562746b94acd9c34b00081c89bf.1604432881.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <75f4d0a4-34a9-8a4c-0ddf-092562eeddca@vivier.eu>
Date: Wed, 4 Nov 2020 22:27:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cad74fae734d2562746b94acd9c34b00081c89bf.1604432881.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IcuaExc1iPfe785xLYsYq65DBD/XvEUu3YRvN7vOR3fvslyyDfa
 /EekejzU4ju5HGinwMDJhYjalhcOcUrrAebQghW3hxpkS3jOckpfR4f79fLzNApf/nKzgng
 NKE3pTnJa24wP7R6zbD4ac90ekmRFxPv2yEkz+B1TqpG6JWqg4eOHAXmFv2l0NCpPZCKw1X
 rbB/AyP3OschExVsTBEuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dpWtmpbGP84=:C9VlovWhkOReun2JCWBbK5
 M76/gFXXmEa7z4MDGzVFXbOlIrEiFhcf/u1kBrm3Gg8htx7nWxE8ee+/frBXcWlIql1V7vVHT
 enn7vWH9p33u4nEg2dhr5Hxs3ndFBlC8t9IgmuLLT8/wo6C4/t+QBadWZczCe2SgRPUydjILW
 9wlyowDI1B67G6tmIpV9NotQAOtt9Eut5cDsurJ2ekT4mduhE4+u7TC32a0ng18zO2fIN2grI
 gP0JFT8FBaZQLUx36lgi7rRpFAFh1MXO2mkK80arFRtHKSPVtUMB6n00mAxmftZPm63swo9n8
 BwOy6T7LGdEa6vimz9z3aagKj5sgbPQr8xHi26JINm3rUsK6WxIgmuTgg03REjuW7I9/96LVp
 dqBETtZryJ287gOHCAKZ5f7/dAYVpHWCvTErY8gnuD0R0OU5e+4e6zh+3Efe8
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 16:22:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/11/2020 à 20:48, Alistair Francis a écrit :
> Coverity pointed out (CID 1432339) that target_to_host_timespec64() can
> fail with -TARGET_EFAULT but we never check the return value. This patch
> checks the return value and handles the error.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/syscall.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 6fef8181e7..3160a9ba06 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7592,7 +7592,9 @@ static int do_futex_time64(target_ulong uaddr, int op, int val, target_ulong tim
>      case FUTEX_WAIT_BITSET:
>          if (timeout) {
>              pts = &ts;
> -            target_to_host_timespec64(pts, timeout);
> +            if (target_to_host_timespec64(pts, timeout)) {
> +                return -TARGET_EFAULT;
> +            }
>          } else {
>              pts = NULL;
>          }
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


