Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E444C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220712089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220712089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhrwR-0006Vq-Cd
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 04:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39697)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hhrur-0004nj-8a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hhruq-0003Gw-39
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:44:01 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hhrup-0003Fl-QT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:44:00 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MmlbE-1iRPC73Y98-00jpi2; Mon, 01 Jul 2019 10:43:42 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561718618-20218-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561718618-20218-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <30a8fd18-3a5b-b9c0-00b5-1e2996bcc87c@vivier.eu>
Date: Mon, 1 Jul 2019 10:43:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561718618-20218-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:soEfCGM7dOMHF9qxAb1Ed7E1fDr2J9L8rZnibVDq4l6penIZFMC
 Ivl1OlGfFGShICkP0YGX2H2qebRq6GDURkXLq1jygI2sdbnVoyaKP8bCNTx0zSE7u7BB2hK
 t9p3dJeTudKdYqbp2cSfAHeG4XaHU7ovwWEuY+MIulJPr/UYp98L9JF0f86aarWHJrfuKgL
 lIXSu9oEXy6PEm2maGDBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+uWGQIUQdk=:hmW9tH3p8G3aWEaA71Q1eb
 b+WjBjz02+ZQSTRYVI2V5afx/FrKqWfQzTpTEtrD7LHAXl05aeY+nZvQEpK0rnEj9ZwBtNXAO
 4cakoqSqP2HWsoEVS2f2ZSZ5X4B2rVNNDbAQxiEMQdqnPyDw3Kh1wD+H8e+9Keuwf+zHxptPF
 lbP1BMSOjozLxlZ22x0RC+jATKdE5lbwoESLX0x2/qISk0nz/loy0YNJIHLLBM7kwjkKqwfT5
 LPRP9i+jLdv9VptQizANOVyGRb90jOJ9IqJIHyJPLKM4nu332GuNLUaS1Ljd4LkQPLMezQdSm
 fJ8KHD/3aOOhUSEaE118jyQzKST+exEuMzKLr+KBN2P4BoqQJr2sJoTqJf1uNKoU8k9dhwDtL
 n55gpS02jhwnvXE1MPTy8DMs1a7jCgXYmbM5EtdgAHcZt15A1oOcE3ost4fg1ndRugPKz+aTG
 s+QVD3aIp0exg/t0iO+m+7OE2IfsHp6H4n3eZaZukl9ujq74ZqbrZqrzOV+ZVHc2y0EZJrM0z
 fNbukB5eC4MomA6g5hnz6C3ScghhOCJaChOu0O8YrAnhZzuaIN3wHLrqpg88UAhsPqCiqedU8
 NpBqwKztyQVl8coyqDb3QdOM6Z8Nb++I1YKQinnuupb6YbB2Tfl+Xbwwj90GLH7HxCQAnSHLo
 vcOhTtBWenLKHqwXm3eTv2IbWRex7FC41+DIaXe3boccRCZoBoJ+u6/1PlXehkJCv2XXT4XMT
 7b2/9p0ziRMwa+55d26mKWii+eihfo7R6mH3mRFek54VuOt7yZ7dER4yt/w=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v16 4/5] linux-user: Introduce
 TARGET_HAVE_ARCH_STRUCT_FLOCK
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

Le 28/06/2019 à 12:43, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Bring target_flock definitions to be more in sync with the way
> flock is defined in kernel.
> 
> Basically, the rules from the kernel are:
> 
> 1. Majority of architectures have a common flock definition.
> 
> 2. Architectures with 32-bit MIPS ABIs have a sligtly different
> flock definition; those architectures are the only arcitectures
> that have HAVE_ARCH_STRUCT_FLOCK defined, and that preprocessor
> constant is used in the common header as a flag for including or
> not including common flock definition.
> 
> 3. Sparc architectures also have a sligtly different flock
> definition, but the difference is only the padding at the end of
> the structure. The presence of that padding is determined by
> preprocessor constants __ARCH_FLOCK6_PAD and __ARCH_FLOCK64_PAD.
> 
> QEMU linux-user already implements rules 1. and 3. in a very
> similar way as they are implemented in kernel. However, rule 2.
> is implemented in a dissimilar way (for example, the constant
> TARGET_HAVE_ARCH_STRUCT_FLOCK is missing), and this patch brings
> QEMU implementation much closer to the kernel implementation.
> TARGET_HAVE_ARCH_STRUCT_FLOCK64 constant is also introduced to
> mimic HAVE_ARCH_STRUCT_FLOCK64 from kernel, but it is not defined
> anywhere, however, this is the case with HAVE_ARCH_STRUCT_FLOCK64
> in kernel as well.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/generic/fcntl.h     |  8 +++++---
>  linux-user/mips/target_fcntl.h | 17 +++++++++++++----
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
> index 1b48dde..9f727d4 100644
> --- a/linux-user/generic/fcntl.h
> +++ b/linux-user/generic/fcntl.h
> @@ -120,6 +120,7 @@ struct target_f_owner_ex {
>  #define TARGET_F_SHLCK         8
>  #endif
>  
> +#ifndef TARGET_HAVE_ARCH_STRUCT_FLOCK
>  #ifndef TARGET_ARCH_FLOCK_PAD
>  #define TARGET_ARCH_FLOCK_PAD
>  #endif
> @@ -129,13 +130,12 @@ struct target_flock {
>      short l_whence;
>      abi_long l_start;
>      abi_long l_len;
> -#if defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
> -    abi_long l_sysid;
> -#endif
>      int l_pid;
>      TARGET_ARCH_FLOCK_PAD
>  };
> +#endif
>  
> +#ifndef TARGET_HAVE_ARCH_STRUCT_FLOCK64
>  #ifndef TARGET_ARCH_FLOCK64_PAD
>  #define TARGET_ARCH_FLOCK64_PAD
>  #endif
> @@ -149,3 +149,5 @@ struct target_flock64 {
>      TARGET_ARCH_FLOCK64_PAD
>  };
>  #endif
> +
> +#endif
> diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
> index 795bba7..6fc7b8a 100644
> --- a/linux-user/mips/target_fcntl.h
> +++ b/linux-user/mips/target_fcntl.h
> @@ -28,11 +28,20 @@
>  #define TARGET_F_GETOWN        23       /*  for sockets. */
>  
>  #if (TARGET_ABI_BITS == 32)
> -#define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
> -#else
> -#define TARGET_ARCH_FLOCK_PAD
> +
> +struct target_flock {
> +    short l_type;
> +    short l_whence;
> +    abi_long l_start;
> +    abi_long l_len;
> +    abi_long l_sysid;
> +    int l_pid;
> +    abi_long pad[4];
> +};
> +
> +#define TARGET_HAVE_ARCH_STRUCT_FLOCK
> +
>  #endif
> -#define TARGET_ARCH_FLOCK64_PAD
>  
>  #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
>  #define TARGET_F_SETLK64       34
> 

Applied to my linux-user branch.

Thanks,
Laurent


