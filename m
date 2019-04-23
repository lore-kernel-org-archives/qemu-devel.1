Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58651C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B92321738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B92321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3fC-0005s2-Cj
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:13:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3eH-0005Tk-3H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3eF-0004pn-VH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:12:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3eB-0004k9-Rv
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:12:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so1948921wmj.3
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=XJE/CEMO//27MEW6cH1n/Mun7DSEEUO+GMGa1tCo5DI=;
	b=a8Y9AwKNwFPmOinDlJ3egGPb811kyDMxCZEUyS4k4DVD28Kg9l8D9/5gti+AVQ5303
	qAvVnQoVirfFToDJVflI53nx2svNHX+EmaTZUqkXBgP8tmZAbbR2/aQozM/4sPWwtxRb
	cs7Gj4sglf/O/R5z/SRxfFIUZZTSHPv/tTOcYuwJPru3rEx5XvMUtEAU8HFDwaHLZBvZ
	fl2m1a8YPZ0lwi71vTCOWyS0SG/VJ5WBWYXNcgGD+zTi+5LzoDqjUwYDhLtaAL3fhFxN
	HzKQC6Hf7G6J047tYqjuGEUlftb2GfOkcWHGI3zj3rWvR3eZIoSzJu20hX3I0G4m5Gnp
	HnLA==
X-Gm-Message-State: APjAAAVNjUnjoYJlANfpEL3hSbqJRDnvceBC/EOOtacoLHkEHISHOe6z
	Ce62I/+4QpFQj6JvA6Ukl4pYBQ==
X-Google-Smtp-Source: APXvYqz2dEOP3lF1yV3IBIxi+2mtEOwYOJlZW3j2U3AT4p6YOEYhckD8NkIND4fBTXa38uUqPC8D+A==
X-Received: by 2002:a1c:9c97:: with SMTP id f145mr4081190wme.139.1556057532102;
	Tue, 23 Apr 2019 15:12:12 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	c139sm1146471wmd.26.2019.04.23.15.12.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:12:11 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a08047bc-7157-49e9-6584-41331dc3b9b4@redhat.com>
Date: Wed, 24 Apr 2019 00:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 24/38] target/s390x: Use tcg_gen_abs_i64
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
Message-ID: <20190423221210.g0pAZW-5Sk8su6TlSYFfgfogdUYCJmzs0STLtN7H9nU@z>

On 4/20/19 9:34 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/translate.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 0afa8f7ca5..030129acbb 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -1407,13 +1407,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
>  
>  static DisasJumpType op_abs(DisasContext *s, DisasOps *o)
>  {
> -    TCGv_i64 z, n;
> -    z = tcg_const_i64(0);
> -    n = tcg_temp_new_i64();
> -    tcg_gen_neg_i64(n, o->in2);
> -    tcg_gen_movcond_i64(TCG_COND_LT, o->out, o->in2, z, n, o->in2);
> -    tcg_temp_free_i64(n);
> -    tcg_temp_free_i64(z);
> +    tcg_gen_abs_i64(o->out, o->in2);
>      return DISAS_NEXT;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

