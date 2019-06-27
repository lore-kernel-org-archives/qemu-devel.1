Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ABFC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD4E205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD4E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXu9-0003IP-3W
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgXsk-0001j1-0h
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgXsi-00010y-Vi
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:08:21 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hgXsi-00010G-MN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 13:08:20 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIdS1-1hk3yC25g5-00EcwE; Thu, 27 Jun 2019 19:08:05 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561649510-21183-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561649510-21183-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0a6e8362-6096-a56b-0d7c-8ead12cd157a@vivier.eu>
Date: Thu, 27 Jun 2019 19:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561649510-21183-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LeCyubCvTC0qWqQnUfjL6QcwdFgWCZMXKTeI1M3lGLjEH0T7rcr
 L9GQhN2qxhm3YHDeS0yVeiEGiLsIrxmBv40QWWuSAwRby20Bqws7gb95qqFw+azHXh7nHsQ
 O7YEjqMMlVc/lGtzineGik/hXadERFARx52iriT5AK5opbWoD0h9gBC4WQetAycKWW7GuLS
 6EwmcO383X7CZ2EVflJ7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ln9Zeq2lUQE=:dXb0gZreLUrpVBUFpOODqx
 hQB3E8MNIPvLIvc01o+XcemOPp9Wvv61q7TNpwme1glpVUgLcFm0NjTr/FaznUHV7oB8nqDgw
 i42AeQgM8dCLHdO2cWvq9vwk7YGUqsrw+0mQr9PF2ysUIXG5GxTjogiTOSZh5gkCPZ3PQXHZU
 3zbm/g/X+8aBUgISg6cm6c9RGTe+fRQ2FV1xlFLJJ0nkL9gl9Y8asqM56ATj3pw/ht3fLUik2
 zLjlUrmSUkRUciRegOLNMRO+sDPtj0TFM7aCZGql9FNfQpofsPbfliNs9C61RmtXMgOQw+iLf
 u5yOFVZa+K8wn4V08VB7ud6arpkXb0jHmUa7HuD3dWY8koS5mPyHoZ9clPeTYZBGlcdiu8bmz
 ksDLoL3O9BUezvn/q/vnYKKlMfP3mPIRhPk/Zkm93qZREb+B1zT+nb9Mdp+SzPZGymAe3amn1
 nGiwdky/zzQVf33yDdH0HJsku21iv8mihWlCYf8dkV5SFarE2BNBADwnHt3enyuKMvAhrEDRC
 ww7ODaTG6CF/r/6GTFimsfBI0IHzbwPFdNwdsSB+NA4fz5DQtjTGh+jH5LHnNGCE15+xisN9/
 B6Pglfy+vRQmMCz/psQc3FBQ7bBx5i7SLb2ZH5inl5JtTn3F7eoMIkWN1DtUtbI/iy9RbhxwK
 ks3HAN9yZ05lvSi3kWYmrUBU94pV9RJAKJI/otTEX0F/mZ4x6yNPCE9BrGItzrWL0H0cEAGqG
 Fvf+6BFmgQNCtyDWODz48DCNrCQVlSHnppmGIuIOTp8CT5/7EMksleNeCI4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH v14 3/5] linux-user: Fix flock structure
 for MIPS O64 ABI
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/06/2019 à 17:31, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Only MIPS O32 and N32 have special (different than other
> architectures) definition of structure flock in kernel.
> 
> Bring flock definition for MIPS O64 ABI to the correct state,
> which is currently different than the most common definition,
> and it should be the same.
> 
> Reported-by: Dragan Mladjenovic <dmladjenovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/generic/fcntl.h     | 2 +-
>  linux-user/mips/target_fcntl.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
> index a775a49..1b48dde 100644
> --- a/linux-user/generic/fcntl.h
> +++ b/linux-user/generic/fcntl.h
> @@ -129,7 +129,7 @@ struct target_flock {
>      short l_whence;
>      abi_long l_start;
>      abi_long l_len;
> -#if defined(TARGET_MIPS)
> +#if defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
>      abi_long l_sysid;
>  #endif
>      int l_pid;
> diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
> index 000527c..795bba7 100644
> --- a/linux-user/mips/target_fcntl.h
> +++ b/linux-user/mips/target_fcntl.h
> @@ -27,7 +27,11 @@
>  #define TARGET_F_SETOWN        24       /*  for sockets. */
>  #define TARGET_F_GETOWN        23       /*  for sockets. */
>  
> +#if (TARGET_ABI_BITS == 32)
>  #define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
> +#else
> +#define TARGET_ARCH_FLOCK_PAD
> +#endif
>  #define TARGET_ARCH_FLOCK64_PAD
>  
>  #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

