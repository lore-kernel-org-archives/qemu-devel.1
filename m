Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5477FC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB732077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB732077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51157 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIsRO-0002FQ-VM
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 06:14:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIsMk-0006qZ-PJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIsMi-0005S7-DL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:09:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIsMg-0005KG-17
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:09:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so8088478wru.3
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 03:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pfVM1dT10cNbbTNk/ZLWbyhsUD5iEW9D5zWOxivpo1E=;
	b=PkClF2BrZQ/hb9wyfltZsgVBGBYbzyCEjs5+CLnwTSPkwst1BCpmpMlu3B5NfG2R63
	3OZasYsA4yyyRCtcgFoX2VlslO/1Z/svDoJTYoVQEbL862Q8UdkBMPOASsDm/+bCIfz+
	TNiTbnB/T9BQ5mdKuipxdQk1wol4TUX8Umi0JbS/4VMg4rzeWPTZ2+4ZKPBAVPJNoFR+
	ib6atqhoR2wDvMbxqQn89maEgHn6BTSsbu211GmiPL8oJd6YrWk6Q6kfcRCsYa1BGyb7
	8TTrEHrwWid36NX+IZa9dTcZvEtu0UUX4H13G4aM3++/WIKXCix1abo3gZKzUaZscUYU
	hAIA==
X-Gm-Message-State: APjAAAUCw6FbjYf6Pa2jjEWC0+C7haOIvIdXmjeGp6G7FtU5My418O4i
	am7kb1VCiEyCON0/LC4/JfA4ZA==
X-Google-Smtp-Source: APXvYqywpk4K3RTj9ezP86p8dAXZAZ3eW4hPExtGa5n99p6Yec27NPCKK/BHKX6sN/FvhgeUVmGmVA==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr17315513wrr.27.1556014163124; 
	Tue, 23 Apr 2019 03:09:23 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	62sm15663571wrm.18.2019.04.23.03.09.22
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 03:09:22 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d5f24e5a-0120-b7ab-e2d8-03956cd36eb9@redhat.com>
Date: Tue, 23 Apr 2019 12:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 22/38] target/cris: Use tcg_gen_abs_tl
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423100921._msc3zPlnIbzi-l9D5EFOT6U-bv_qAA8r7FcgLbObjI@z>

On 4/20/19 9:34 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/cris/translate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 11b2c11174..0374718f66 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -1685,18 +1685,11 @@ static int dec_cmp_r(CPUCRISState *env, DisasContext *dc)
>  
>  static int dec_abs_r(CPUCRISState *env, DisasContext *dc)
>  {
> -    TCGv t0;
> -
>      LOG_DIS("abs $r%u, $r%u\n",
>              dc->op1, dc->op2);
>      cris_cc_mask(dc, CC_MASK_NZ);
>  
> -    t0 = tcg_temp_new();
> -    tcg_gen_sari_tl(t0, cpu_R[dc->op1], 31);
> -    tcg_gen_xor_tl(cpu_R[dc->op2], cpu_R[dc->op1], t0);
> -    tcg_gen_sub_tl(cpu_R[dc->op2], cpu_R[dc->op2], t0);
> -    tcg_temp_free(t0);
> -
> +    tcg_gen_abs_tl(cpu_R[dc->op2], cpu_R[dc->op1]);
>      cris_alu(dc, CC_OP_MOVE,
>              cpu_R[dc->op2], cpu_R[dc->op2], cpu_R[dc->op2], 4);
>      return 2;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

