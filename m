Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC92C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EA0218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EA0218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60621 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ4AR-0000YB-V2
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:45:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ47z-00073h-7N
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ47w-0005Gk-RN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:43:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ47u-000595-2h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:42:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so22242571wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=jz04RrlmYVSAJ9es5OQ/JcXW4V1SvkvOMMvjwJfLf6M=;
	b=lq4B5tpsCn80EtomhNol/quSnWO3jzLeNXZR7DpQq+ejKyCf7jJfcpY7WlvnGwWYB4
	qmM+AuR/wGnHh8PMq0r9H8sYULpUqYTYcK+uGpAHICYp4iuo26+ez8z/9hd5RwloCJaW
	XL/pZHlqrNMOtIKhmQBacCE6AQ0dZf+TOkh83EhvDEpoF23uLyobUhyPGTU9pUH0mbuG
	Hse2x+auPIcg0kTWggN4xfJX+CziupxE3rORYpr4yy5TOJ02R5UhUKmeXlK/lbd0LgnF
	Qj5Q7WRYH/E+zieQAq5yaP3qWwiu1gSfZl7KbVrMcZj6chHEmAUMyFVWNPP+Pni6WRdy
	alnA==
X-Gm-Message-State: APjAAAU76rR3WIAiprRb2x05xpKuqMLT30L+Pqy8UTtGmqPmx0LEiOhU
	xAEcxZZSNRcHhTYTDm/oszXF9g==
X-Google-Smtp-Source: APXvYqzdp8HzcJe1pgAxbs5vaXPij5mrvJU6Me0M8hHCDosccbpGqvyJT2cfSv7VGRJxMWVp4bsF3Q==
X-Received: by 2002:adf:f102:: with SMTP id r2mr18162799wro.136.1556059370086; 
	Tue, 23 Apr 2019 15:42:50 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163])
	by smtp.gmail.com with ESMTPSA id d6sm5667062wrf.63.2019.04.23.15.42.48
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:42:49 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1556040926-23931-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556040926-23931-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8303cc43-6bc4-6225-e632-e02629ef74ff@redhat.com>
Date: Wed, 24 Apr 2019 00:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556040926-23931-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 4/4] linux-user: Sanitize interp_info and,
 for mips only, init field fp_abi
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
Cc: lvivier@redhat.com, thuth@redhat.com, daniel.santos@pobox.com,
	arikalo@wavecomp.com, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
	aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423224248.oJ7tC56A2yOnYXs8NGBfb_SryKMgUmMuWl-CujAjuto@z>

Hi Aleksandar,

On 4/23/19 7:35 PM, Aleksandar Markovic wrote:
> From: Daniel Santos <daniel.santos@pobox.com>
> 
> Sanitize interp_info structure in load_elf_binary() and, for mips only,
> init its field fp_abi. This fixes appearances of "Unexpected FPU mode"
> message in some MIPS use cases.
> 

Please add:

Fixes: https://bugs.launchpad.net/qemu/+bug/1825002

> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/elfload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a2602..7f09d57 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>      char *elf_interpreter = NULL;
>      char *scratch;
>  
> +    memset(&interp_info, 0, sizeof(interp_info));
> +#ifdef TARGET_MIPS
> +    interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
> +#endif
> +
>      info->start_mmap = (abi_ulong)ELF_START_MMAP;
>  
>      load_elf_image(bprm->filename, bprm->fd, info,
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

