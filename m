Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6B9C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 14:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2792520854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 14:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2792520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6bgY-0004rY-6g
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 10:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6bfp-0004Kw-H0
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 10:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6bfo-0001ES-F3
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 10:26:45 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6bfo-0001Dk-6O
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 10:26:44 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mof1D-1iUKm21z7R-00p3yT; Sat, 07 Sep 2019 16:26:35 +0200
To: Shu-Chun Weng <scw@google.com>
References: <20190822231443.172099-1-scw@google.com>
 <20190822231443.172099-3-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4386a232-5853-72ac-5779-5f8782b9b94e@vivier.eu>
Date: Sat, 7 Sep 2019 16:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822231443.172099-3-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NZHRi8l3FrVLd8AinOEe5Sx9ZqT1+b5TGBaD2VHb6qlwG0FR1y7
 qC9cTTyTKGqSQSOqMCMcKnGgg3+BaaSVvVZgD5OAgKUegqEUNp9fUpQAqjWL4BM/y1S27rt
 aEZ/CwaO0RukWQxI1Tb8tR9AR8BGc+NOKeSmDw+zMUNbtiexTmFz+L+HbMm+i5U2Egmwn5C
 DCiOs4w8VBMJmXqylLLcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PPeOWM/zazA=:weAE7vNbMPln34W81lbeaO
 u5baPd+qkVMfN59zOH0RzUhnakIOlyGEXUwqwSHXXVjEW+S5wvWB8IovlYjc0yulsDf8e3kxS
 I3kUX04QhmyMLy4oOPItHhAi32yiM7bkgsp0Vwp1dOxwxGX13TBR/QYcPn9mEYqCL/MFDgmKd
 yeFsCBt3OzvGLe/jkrsUMWR0ndklCe5Xjqk3BTiJyWFNm49mQrj1jjcp9DT08ZOBMZYyeIgoU
 yPbGadQk0+Hy59quah7LHg3MWFVYsIILcrKVlk09wezQLjq+n6fyODe5Npi5UGo3kLVJn5X4C
 Mkp02kaJBgc8JE6/YNBh2tNULoEEEIMQbuRMVT1ORs1eGKwZeBLX8PeiXoFOuQ/ouXLvqqDp3
 zys3gVe1YlD5DAFeei/JW2ybmVqWgVV02A5GCS/CkIZA1J/ZJf3vao5j4isisVey2dCSZ2hGM
 GiLMvbhBoF85FYr4ZqgAPJKuJLU5lTj6U7WcnWySXqN6EgLuSlKMIoIxD0M1gm+ZhQt+HvtVb
 COBJgf2zisO5n5i4xrnZNnVLMKq0zDEhaQ0oEeJy1xr+DND4wwtMicRGNCISqZ6UzrnFAYWqq
 YtJq2TxMhtsH5pKFJXH2ag6XVhBTDk7sfOM0L2u8p4vDFcdXwJwnKHn4PtJRS8K6V91X2+HEr
 Z8Xz65Bvy9n0XAW3bhz53Da76fvXkGdw+V3l65ZMPTlnj9iUTngq2nZzy2+L7mqfUmWYaHkpa
 zuHLNplXqOZJo7KCWiuZvPXvUrOooB0jlBheLo/1WBLkbckUp9hithHK6OOItLuQKw+9XCPnX
 LTf5tYOOvHnjg7xY9aliylib0FY76UXPuKU4B7yvk0P2IpfkfY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: time stamping options for
 setsockopt()
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/08/2019 à 01:14, Shu-Chun Weng via Qemu-devel a écrit :
> This change supports SO_TIMESTAMPNS and SO_TIMESTAMPING for
> setsocketopt() with SOL_SOCKET.
> 
> The TARGET_SO_TIMESTAMP{NS,ING} constants are already defined for
> alpha, hppa, and sparc. In include/uapi/asm-generic/socket.h:
> 
> In arch/mips/include/uapi/asm/socket.h:
> 
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  linux-user/generic/sockbits.h |  4 ++++
>  linux-user/mips/sockbits.h    |  4 ++++
>  linux-user/syscall.c          | 10 ++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
> index e44733c601..5cbafdb49b 100644
> --- a/linux-user/generic/sockbits.h
> +++ b/linux-user/generic/sockbits.h
> @@ -51,6 +51,10 @@
>  #define TARGET_SO_PEERNAME             28
>  #define TARGET_SO_TIMESTAMP            29
>  #define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
> +#define TARGET_SO_TIMESTAMPNS          35
> +#define TARGET_SCM_TIMESTAMPNS         TARGET_SO_TIMESTAMPNS
> +#define TARGET_SO_TIMESTAMPING         37
> +#define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING

We must not rely on TARGET_SO_TIMESTAMP and TARGET_SO_TIMESTAMPNS but on
the _OLD and _NEW versions.

See:

6d5d5dde9adb ("linux-user: fix to handle variably sized SIOCGSTAMP with
new kernels")

So the existing definitions must be removed and the _NEW and _OLD
versions added.

Thanks,
Laurent


