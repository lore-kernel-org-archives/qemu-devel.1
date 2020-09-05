Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F8C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B36220738
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B36220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfKf-0000pG-IV
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kEfJz-0000Nx-RZ
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:02:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kEfJx-0005nb-Tn
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:02:03 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MsrV2-1kYFTT2UxM-00tBAU; Sat, 05 Sep 2020 23:01:59 +0200
Subject: Re: [PATCH] linux-user: Map signal numbers in fcntl
To: Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>, qemu-devel@nongnu.org
References: <72cc725c-f344-b7f1-d559-401867067d80@members.leeds.ac.uk>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5fa595ee-1fbc-8ff2-4363-cfa069a23ebb@vivier.eu>
Date: Sat, 5 Sep 2020 23:01:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <72cc725c-f344-b7f1-d559-401867067d80@members.leeds.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Uxt2DzWZidSRC1u1diIdBHUmAq09PNvlNGV++mWHA13m6GVxSgf
 FcqYBe4FA1+8CRQjZWZprv3VKAcuT/Di4agFlX71xSBOUi7E6a7PYmMMkCGpGBJ8EaoDE7Y
 Gk1goe6AJeNnN2l3Js70TXCGEwL6ii62ij0+kxLTXNkaXNCe+U3HhOZHfIoDOTDuw7S1rYo
 6GlPVoxy8ovMHb3wY545g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UiHGRBk4Uyg=:8QVHu8/EgIzylqk82nxPmR
 f3uvDZ570wZPT12w3wOmJWAunGZHPLSd5IYJ6Hn6YvyBv/D46ARwQGVkq9d0Lln04+0kA2Iqe
 /Z7GXk2rx722aukaPgVd7NgcarfZTdjW5+Eyc8UKZ/MpcwmqwP/RnCjYyDJdTCJ5FoR7PxvEV
 y3cNtE3XSPEP6kM01Dx2YX74jbTzmwy2ED10CMNFRT2uj1zDCkBLFf+MftW8K+kRPxuyEue8/
 7Kj90ixs2W/fYosHFRcHKyRJWOPH8RdCeTQTSOJPOB1UyR1ctBYTwQokehNBb+HKF8mu2doua
 YookAy4x/IGCBGTTP3Gxb1ljQ2pVem4Gy4qJpkP2m8t6pJZr3BsY+/VJUo6MR2DLedBjTlnQA
 cuPQfAobTtZv/yhBnN495XFlAtHT1bNJXXCKv6D5gDU4HzWp8k6k/NbYlHeLzPi9ZEmYJ0V08
 P2HknL8I4gz0gwPGus51bQW9FgPu6Wm1nGRrx33+GrMcdjTOz6PfNzmAU+7Al3i/qFM8zvGmk
 Sk6fcHJb/7d0SxsShRsZBxHc+2jOBubJIHFxkZplCdq9kMzJy6l7qbSTyx8C0q4YDSlIf77wt
 DDE90VY4Hbu9HkKyBFbvriqgriH89Mw6nr53zCny5vcGn0sbJlqYzNtan+Xnx7HK5OA2iFX6E
 bFgLl04/dC7rGfwxAzPgoNeRmekKNwmrJbul58tl1hsrST4yFW8boWZIzcKUjOhAwY8sO2MjL
 zUJalEy0jyNZQP7sm9cADpKlw1C+r7ask4oVZ/1SCGJuTgu/lEPK4uWVyVljT7q5kc7+vZP+8
 YOea0x6UZta9x6MiTqY8phkPxm+Y1YDOdkjf/11/bcbXzX7Q/XaC4vhlymcyPM/Brd/295w
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 17:02:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/07/2020 à 22:06, Timothy Baldwin a écrit :
> Map signal numbers in fcntl F_SETSIG and F_GETSIG.
> 
> Signed-off-by: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
> ---
>  linux-user/syscall.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 945fc25279..8456bad109 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6583,10 +6583,16 @@ static abi_long do_fcntl(int fd, int cmd,
> abi_ulong arg)
>          break;
>  #endif
> 
> -    case TARGET_F_SETOWN:
> -    case TARGET_F_GETOWN:
>      case TARGET_F_SETSIG:
> +        ret = get_errno(safe_fcntl(fd, host_cmd,
> target_to_host_signal(arg)));
> +        break;
> +
>      case TARGET_F_GETSIG:
> +        ret = host_to_target_signal(get_errno(safe_fcntl(fd, host_cmd,
> arg)));
> +        break;
> +
> +    case TARGET_F_SETOWN:
> +    case TARGET_F_GETOWN:
>      case TARGET_F_SETLEASE:
>      case TARGET_F_GETLEASE:
>      case TARGET_F_SETPIPE_SZ:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

