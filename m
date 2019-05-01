Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7728BC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 09:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349DE21670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 09:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349DE21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLlmv-0007B1-Eo
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 05:44:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLljW-0004jq-7m
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLljT-0005nG-5k
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:40:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hLljS-0005mW-Ta; Wed, 01 May 2019 05:40:55 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1M5PRT-1hMb4n2Oe5-001TOt; Wed, 01 May 2019 11:40:40 +0200
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <ae0e2fe0-7354-ba9b-3f97-71955c792f88@vivier.eu>
Date: Wed, 1 May 2019 11:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yHyJzQ9bmLaWkmp/dlfFilj2cuzqNH93uIY+XDgN9qGkAlf/meo
	kINjuZPJ6Aivj+Dc5+WtqmdbQQk1v7Oltrq99VIgsAf4H+JnLko73JHVqdGQfspGcj4OCBk
	7wWw348ERtyJdKTETTe0SH+7PXXklQuKqhGCGDdj4oXG22FNSvhXTbfDpSsTSfTECM/MLjf
	XMJYLNDQFHxjALKuL3vyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gwQTj6o2T8w=:Wk6xWSvbSGCzoRm4sMgt2y
	FjTgoTz1+5OLqZFdmxcZwm933eienKS8mBnaII5xaKvmzjNEm5tCQTXIETBTP8aRR/RQwogZO
	MkAzdwTONCpb0A2OijBv8bopM+pCNYyJapd8l3IBAeLGlNGQxdticnlAtz9vOLAVARkDKITYk
	v3Dmrs0iSJRam9Fp53i8VXpuyxE6C8gACrzdsUqc5td4DuUGYAhJo4upXtA8qgsvgSBxm3F+r
	iKAYlpgsF77UdtcCTbuynGcr28r4zsM6BC3EMPYHUrH8bFyjMFekZ+6b5hvLAf1todWOpVgwT
	1o9dUebPF3F8WbW1PTpjRatkWtG5nc1zsf/HGk/YB8eHWt9bxmJzAVlkaM0Ecz3swRbL2ZQjJ
	6JIvmipEE+I2ireF3N1fnMaxeAREvVV/iHd62Ic/kLsQaL49IEuT1Y/VUgzsQvwR+sSfkrmI1
	O+VOYYlnRgf/YYC5VYFSHyyWtcucWUVkmvtzJxu6M5H0QWbJ0bKyUX4bX0mRVyjqy2mmBX98+
	Gd5zafqQxTNXz9mjps5ekrE7bK8qaY4vgnPpI8/21exn8oSpsqA81/S2j6jLONxOUKFfkyPTc
	4uTlLpniYnQu03CEMY429kdcHbwL2nDPRj/VhwM2DHuYTuunx08YqN19M5iaCt16N1yky9PzH
	J35yS3KSmzl3Tu5gvlCcYmRIY0fdjU2OyCOzFWW5PZKCjxzRDAeDzZfBlKX27aYz7qVg8SJgV
	IHi/fjLRw+RmwTBPXYOgDJltLD/Faso/D8i8TPiFmbHGky8nnxPHYh19BLw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH v2 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501094039.qJeoHE3O5GGH6i76JhklhSAEhxEyDJ2Mmk7UwQ68J4o@z>

On 01/05/2019 01:29, Alistair Francis wrote:
> Fix this warning when building with GCC9 on Fedora 30:
> In function ‘strncpy’,
>     inlined from ‘fill_psinfo’ at /home/alistair/qemu/linux-user/elfload.c:3208:12,
>     inlined from ‘fill_note_info’ at /home/alistair/qemu/linux-user/elfload.c:3390:5,
>     inlined from ‘elf_core_dump’ at /home/alistair/qemu/linux-user/elfload.c:3539:9:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..d08fe23466 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
>      target_gid_t pr_gid;
>      target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
>      /* Lots missing */
> -    char    pr_fname[16];           /* filename of executable */
> +    char    pr_fname[16] QEMU_NONSTRING; /* filename of executable */
>      char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
>  };
>  
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


