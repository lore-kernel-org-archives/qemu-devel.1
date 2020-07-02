Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B88C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA4F20771
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA4F20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0sh-0001on-8b
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr0rW-0000zc-FX
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:10:55 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr0rU-00022u-MP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:10:54 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIMXE-1jcfNH2z1I-00EPq6; Thu, 02 Jul 2020 17:10:43 +0200
Subject: Re: [PATCH] linux-user: Fix "print_fdset()" in "strace.c" to not
 print "," after last value
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200702102749.22178-1-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <17e105d2-9c60-8a79-bcca-ec3704163c33@vivier.eu>
Date: Thu, 2 Jul 2020 17:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702102749.22178-1-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1KPRAgS6C1lyoCrm3p8FfzYAqiwzlVvt+nixRHAaBKO4fNoqXJb
 uLVOf239/2oKJzVtlAEyPPJZ1Pm4QVp8NUo+M9zWV199WEWhs8xf9AzhI/p8gXmdSneAxnn
 JTGxykzTbZh45H3v7eS9OnI1b66FEe7HDrHxWtcHRINyGOp2jjxJ8C7tgHFSmIk2zCm4mfp
 SAbLHwmH2yKp30qRVGBoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mfGkd+g9Tk4=:1Vmkb4T0I5OmGxqsLbbWz7
 pzr85XE6mvxRKG5SEyNhGsNqDSXXKg0fL/OXbsT6XpN4RmilZSCcAmsH6NJco2Z48SSXS26ZI
 9u+HICAF+E0IY22NveG0vgByywQTnGe4jS2ji+bW/9N4sg9yYM/YzBKqfD9yeHXZrxVnYgGk1
 LvMvdhtMfnNyJaaz0B8jTqanuUDSU384ped1n3gi5aOh96HGVUFTytSmJDxYs0h0aI8yiSi8G
 83fU8BlrvbLSXIY/wftV0mx1lV77P2BPChRIfXd7B0gns5YuQGRzd7D18bdzd2152whlMh4nx
 oDB47zTBzk1Z86MUP1AEkvA0ur8Xmm7ehPZy8vcOZXUnnMr0iQKHLbxCv5MBP4snzj2KIuOpy
 gxLvrkf56VGONJSd7QjRLveLNeL7VRnodOnCxLjdvMh+qXn3X2Zx2FmzyKVxl8y9XNMtTBUBM
 63YVJSIFiQ/1mfpnddZSJnpzKyyBpP7bYHDup+mZ763bV6qzQ02HCFDYDt44qxu0Z9QJbBNcL
 rUrV3/aGmU9svb5pNLUb6/OlEmHrRHD8dcjPsm1eJeB5sWYt1ELt8d1lA8hVn3J8m4AIoJaU6
 MY6phkYavzYzHBVdN99cJ/0j91As7zrcb9qkY9yl/FQLgJN+tQ2CfqCbAiDtEmqLDK9HL7fa+
 CJy6A1qJCixIgqfF6Y4d7mppY03XY1fKqso2u2ZTQVNOWFNFgGfs1EOPdQqJzuN9UskAxawPy
 1Zqg1uRk2cEMjbHe01CFBVfyko1Cvp/4q6iMCYSGVfit24SRbPemT1UYF/pNVTa8n4rrc2Bf7
 Ng0wR8oQiWnIjRd+aYXdCb8Ix35Hcrl/CDcf+H6bjXCQ4qSb1Qa4ucMmxvnHdb1+oqLiSAP
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:10:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/07/2020 à 12:27, Filip Bozuta a écrit :
> Function "print_fdset()" in "strace.c" is used to print the file descriptor
> values in "print__newselect()" which prints arguments of syscall _newselect().
> Until changes from this patch, this function was printing "," even after the
> last value of the fd_set argument. This was changed in this patch by removing
> this unnecessary "," after the last fd value and thus improving the estetics of
> the _newselect() "-strace" print.
> 
> Implementation notes:
> 
>    The printing fix was made possible by using an existing function "get_comma()"
>    which returns a "," or an empty string "" based on its argument (0 for "," and
>    other for "").
> ---
>  linux-user/strace.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 6044c66954..23ca5d88c8 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -541,6 +541,7 @@ static void
>  print_fdset(int n, abi_ulong target_fds_addr)
>  {
>      int i;
> +    int first = 1;
>  
>      qemu_log("[");
>      if( target_fds_addr ) {
> @@ -555,9 +556,12 @@ print_fdset(int n, abi_ulong target_fds_addr)
>              return;
>  
>          for (i=n; i>=0; i--) {
> -            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >> (i & (TARGET_ABI_BITS - 1))) & 1)
> -                qemu_log("%d,", i);
> +            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >>
> +                (i & (TARGET_ABI_BITS - 1))) & 1) {
> +                qemu_log("%s%d", get_comma(first), i);
> +                first = 0;
>              }
> +        }
>          unlock_user(target_fds, target_fds_addr, 0);
>      }
>      qemu_log("]");
> 

Please repost with your signed-off-by.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

