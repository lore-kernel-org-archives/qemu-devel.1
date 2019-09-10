Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1905C20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1905C20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7blZ-0003iF-QJ
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bjr-0002WH-QH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bjl-0005vJ-Vq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bjg-0005qE-QM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:42:57 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHGPA-1huOIu22gC-00DITs; Tue, 10 Sep 2019 10:42:28 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ab4cb766-4284-9c79-0ae1-de84a99962f3@vivier.eu>
Date: Tue, 10 Sep 2019 10:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567601968-26946-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9U9c544Z7WFzGTFwOEQ395aczPe8TSLlvn6WEWoR7VqUMY7r224
 jbm35LZ97771vHCLIztL9EtllkJ22F/dFz6u2KjqQRFWZvG90pOrG8TbVMROLwRH18nvumN
 IVU6KOe3Wxx4y1rw+s9nzcTRp644BLSV8YupAqxCtG4+OsVBuTjL4E3CiTGKanAEBp8kj38
 +q/1CJOjzClVRWpk3JLLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v9XxcOKx/lY=:2Ou2tsD1sR0Qw2HiVpJc89
 Dz5xOYjazcT6GUiWB+7C+3/IK6GYZCJOV+sSbDhDScapZ7d0QAihwzr8kKQU95b/XWW08XxN6
 EmcklZ8UyxS996c+p289U5dbTi3YZcWpkS7bIto7wLGFcFkk+9W+k81vgJ8WDFuPYCO6iSpqH
 PTT6BYRJJEwjfoRgEB16Ssjp8z3Iixk4rO8s1PefTonyLcugVRctoEKVV4ol90chy7NdXWq36
 X1N99zJiz87qpefsL6Vn3zPZS6MYGCHIVb/1QzdtEb1UCSA9q0cKobQxps8j1ElSRK2D8mlns
 q4ulN0npw2tU7uNt71fx0wjRInOO8lceHYkKJ2XH3nmxFPMS/9N5RZUFqMc/t2pQJwm1VYkGM
 pTm4uOZLWyG07NrmY+MdBU3brh0EkhvovVlKTMv6tkqqN0bW+8EocILBRVHZv1UwrRkBF0yLI
 sn44G91xutNDhZSqf7gBXAIVj/5KGymd/LUFH0izScDtw4PqxrdsILPgF3lfE4MacCUbeKnTb
 E/i3nPSfZ9FemL8NhBkBoZHVzzIi1tRXLKXrvods92KwhhNeRb7QLKhdfeaNSWiBdT1vG9+9o
 DoI5b4VVnTlAbZnZG3XASAI8Jx1gQAkZspNyq+7/G/Rg7X2PF6Bp0sBmd+usgPuqRpLf5vmW9
 WFJNVLEQWxZ165qDePVK/O/QtXVSrtvKrDH8YrhqhjUxpzJgtBKg435SQ7pyUWVGJ38JquZgy
 0T4aWuXZ6aZ+GqbKGyGH5qV7LO2Qt+bFGxfe/ZHgQrVDKBAYgSbaZkO4Zl88NJVzXDt/jAeZq
 +7wt3KTjMySc7Pzju7KA6T+1muLFQLg6QNjGBKaXWP0DCrMlcw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [PATCH v6 6/8] linux-user: Add support for FDRESET,
 FDRAWCMD, FDTWADDLE, and FDEJECT ioctls
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
Cc: riku.voipio@iki.fi, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/09/2019 à 14:59, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> FDRESET, FDRAWCMD, FDTWADDLE, and FDEJECT ioctls are misc commands
> for controlling a floppy drive.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 4 ++++
>  linux-user/syscall_defs.h | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index b253469..c6b9d6a 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -115,6 +115,10 @@
>       IOCTL(FDMSGON, 0, TYPE_NULL)
>       IOCTL(FDMSGOFF, 0, TYPE_NULL)
>       IOCTL(FDFLUSH, 0, TYPE_NULL)
> +     IOCTL(FDRESET, 0, TYPE_NULL)
> +     IOCTL(FDRAWCMD, 0, TYPE_NULL)
> +     IOCTL(FDTWADDLE, 0, TYPE_NULL)
> +     IOCTL(FDEJECT, 0, TYPE_NULL)
>  
>  #ifdef FIBMAP
>       IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 4e33ef3..fa69c6a 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -893,6 +893,10 @@ struct target_pollfd {
>  #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
>  #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
>  #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
> +#define TARGET_FDRESET        TARGET_IO(2, 0x54)
> +#define TARGET_FDRAWCMD       TARGET_IO(2, 0x58)
> +#define TARGET_FDTWADDLE      TARGET_IO(2, 0x59)
> +#define TARGET_FDEJECT        TARGET_IO(2, 0x5a)
>  
>  #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
>  #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
> 

Applied to my linux-user branch.

Thanks,
Laurent

