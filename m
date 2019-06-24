Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356AFC4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017A820656
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 20:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017A820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfW1Q-0007ez-3Y
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 16:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40915)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hfW07-0007AT-UB
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hfW06-0000st-OA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:55:43 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39421)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hfW06-0000UN-1W
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 16:55:42 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MnIxu-1iOieW3YLU-00jHWI; Mon, 24 Jun 2019 22:55:33 +0200
To: Jim Wilson <jimw@sifive.com>, qemu-devel@nongnu.org
References: <20190618223252.10907-1-jimw@sifive.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7f3c6313-ee21-c281-1527-1e6e4fef3bf5@vivier.eu>
Date: Mon, 24 Jun 2019 22:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618223252.10907-1-jimw@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xMTAjhNF4A5RL7RRMZ/Xaj9WXBz1Ik3cHoOe/YPYOn0ScN16C6y
 MPvotB8qeua76/NMJ4OeaXtTukdO7fF00FbDSVVsMwPh3aQFI233mgJf98lreAULe7CNnyq
 x/XmOBsNO8Vzc0k5FazbxS/dAVYVY4NL2GWmVXji1AZV/m5aI4sdt36eW2xJK4glKIT75h9
 CUEhb0KA2Ll+vF5xdz3OA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eP8RZ5TGD+U=:7Jzu2j+b6HU3btYotgQgUz
 W2ajfBYq4eu9p8xisS1Puik/BhATe50h8p6k+amqvy3lnbp1DVVahlU8Y/UwR+ooWz3AuNdjD
 Y2ptycJUQHCpL//RwCie7kM5d68shKgHDwO+YXS1LM5uRwMOV9XiMaWuw7FEA2rtmvuUMXbJ7
 LEL62PYTeUTs40xYK0uRZhDqBsKGZt9nGlNWTHKu254P40ve54E2Kq2OIfwqBwmf0XleaZZVK
 q/fm9o6FLBCurkMygI9vXvm4LrfrQNvKKpkSvbR1nWsp4jD1VGRTUrpU3A+Yeh5NssGzNBR7X
 yhd03QVyMwRPprfg5vD+NeVMRja47SMBUus7CbcBJfW2iaqmU5YcEesCruIKLR63H2rCM5PK5
 I4gX6vrbT8MdN4/B6JSu9fPIlcNQWXnt00rRNKtSeKTq895N+BKZDTsxPqUXqDu6qELmqHv7H
 2EuXMy/ljW7eMK0qLeKeDyQNK9HpBlxTexIJOjNdNNQdQjzo6Tvqc6rqNGK4MJIv4oLAkrZ/1
 UWx2QdB+5AYYjZTwffMlMmgVABr0LsV8nMK5Do2qsYFtmmKF2cK+6W/i7ubzkXA/OFfRMPeZm
 tXQF624pftZU6lceGAKE+GyQPel8oIJGi5FPVSmvkyKofmVQkA4JZMzjp7H9LDobqIIao39lD
 zrC04mi1N3tbVTcDssB2YObjhpojw5n6o/gZhXjoCiRQ8/T6GJhkY3Ndq0eBdEAhqbq+UIq2S
 SoabkhDc/pPAzvLGwmEv0GkwKOMKnc0HsSG9J1Pkhj4WkmnbsH1ycO1/Nn4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Update syscall list for 32-bit
 support.
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

Le 19/06/2019 à 00:32, Jim Wilson a écrit :
> 32-bit RISC-V uses _llseek instead of lseek as syscall number 62.
> Update syscall list from open-embedded build, primarily because
> 32-bit RISC-V requires statx support.
> 
> Tested with cross gcc testsuite runs for rv32 and rv64, with the
> pending statx patch also applied.
> 
> Signed-off-by: Jim Wilson <jimw@sifive.com>
> ---
>  linux-user/riscv/syscall_nr.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/riscv/syscall_nr.h b/linux-user/riscv/syscall_nr.h
> index dab6509..5c87282 100644
> --- a/linux-user/riscv/syscall_nr.h
> +++ b/linux-user/riscv/syscall_nr.h
> @@ -72,7 +72,11 @@
>  #define TARGET_NR_pipe2 59
>  #define TARGET_NR_quotactl 60
>  #define TARGET_NR_getdents64 61
> +#ifdef TARGET_RISCV32
> +#define TARGET_NR__llseek 62
> +#else
>  #define TARGET_NR_lseek 62
> +#endif
>  #define TARGET_NR_read 63
>  #define TARGET_NR_write 64
>  #define TARGET_NR_readv 65
> @@ -286,7 +290,16 @@
>  #define TARGET_NR_membarrier 283
>  #define TARGET_NR_mlock2 284
>  #define TARGET_NR_copy_file_range 285
> +#define TARGET_NR_preadv2 286
> +#define TARGET_NR_pwritev2 287
> +#define TARGET_NR_pkey_mprotect 288
> +#define TARGET_NR_pkey_alloc 289
> +#define TARGET_NR_pkey_free 290
> +#define TARGET_NR_statx 291
> +#define TARGET_NR_io_pgetevents 292
> +#define TARGET_NR_rseq 293
> +#define TARGET_NR_kexec_file_load 294
>  
> -#define TARGET_NR_syscalls (TARGET_NR_copy_file_range + 1)
> +#define TARGET_NR_syscalls (TARGET_NR_kexec_file_load + 1)
>  
>  #endif
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

