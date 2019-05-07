Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827E3C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3A720B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvBF18cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3A720B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNv3l-0002w8-Lr
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:02:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hNv2b-0002TS-Si
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hNv2a-0003Fx-Sp
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:01:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hNv2a-0003El-MS; Tue, 07 May 2019 04:01:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so18569363wmd.0;
	Tue, 07 May 2019 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=OB/6dqFhWPtTTxa0P/kXTzVl+XN72F1paLAlDb4wg0o=;
	b=YvBF18cNWDc6nGSViLkNgQ3QUhiRh8Wdb0csf0fVgd/hsRvD9w7al8KFCOdLGTbUrW
	i24yfIY9XEKcx7RY1ZY91Nz5mm+N3/It55c1oGZAArOXQybfuwQCpDbRhYhDgg9iOEMZ
	DQe3RgyX1ffL/JkJMR1RqmNu86NgMr9i9G/ElwcwYpcFjYoIFR23TP+JzeH+eJqhUEfV
	7LQNd7Zhr9i+K0HLvpyNuWqBpF4xt2bg1g2/X8A2M/F5I7YpMF+duLEvX/WjDBXc3fpe
	6RuLhfi3SbloScaUPUGo0yEuTHk5ChCSB85mP5YIb+JnflZ0dCoTspjjsnyO26KMEakq
	/CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=OB/6dqFhWPtTTxa0P/kXTzVl+XN72F1paLAlDb4wg0o=;
	b=TJV7cvWS8WHKI6hhqK7W8P5ZzEmVQXaVhL1jWCEcilmUas4Aj+RR7dry1NBiCq8AsI
	5BnhaCp/uw9E0SS2jdYF301LyaEfIegg+69RvR+q2SZ0mBNztGWpovbkDKqdaCl/9QvV
	6vSnzOtP/pt+J11sEsQS4KpzpvoOeehFMMnOvJVpTHk5iLrkqH4sjuQiG2TUVdE83+oT
	Q3ABSzwgh+p73f0tr9W5QFDT24HjU+oam3vZVgRT612fQkwf8m455XwOH1YsQs2z7nyw
	wNbpwEqBVJrGO2bhBCsn7OfTF4LoDXsflly5Mc2OKZDWLi6fXazQLd39ne6Tc1NWTTUM
	0zfQ==
X-Gm-Message-State: APjAAAU/wVluSC4FGe6O0+fPlhWJLLaIkk0bjrutSYMH9FKG0MULxyTb
	A2lFRNAcauQBAGjjQRg6n+w=
X-Google-Smtp-Source: APXvYqx/N1bZqUP2iZyzy+uJdBwINGbMPeitrxwIoIt2HJ0w1jKlewePMrp0Q8T90MHglJtUMuEXtg==
X-Received: by 2002:a05:600c:28c:: with SMTP id
	12mr19020848wmk.65.1557216090859; 
	Tue, 07 May 2019 01:01:30 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	y184sm13621904wmg.7.2019.05.07.01.01.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 01:01:30 -0700 (PDT)
To: Anton Blanchard <anton@ozlabs.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
References: <20190507004811.29968-1-anton@ozlabs.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <79aadb7c-52a0-34e4-dbd3-8e40a7203862@amsat.org>
Date: Tue, 7 May 2019 10:01:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507004811.29968-1-anton@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 1/9] target/ppc: Fix xvxsigdp
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
Cc: ego@linux.vnet.ibm.com, mark.cave-ayland@ilande.co.uk,
	sandipandas1990@gmail.com, richard.henderson@linaro.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 2:48 AM, Anton Blanchard wrote:
> Fix a typo in xvxsigdp where we put both results into the lower
> doubleword.
> 
> Fixes: dd977e4f45cb ("target/ppc: Optimize x[sv]xsigdp using deposit_i64()")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
> index 11d9b75d01..4d8ca7cf32 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1820,7 +1820,7 @@ static void gen_xvxsigdp(DisasContext *ctx)
>      tcg_gen_movi_i64(t0, 0x0010000000000000);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
> -    tcg_gen_deposit_i64(xth, t0, xbl, 0, 52);
> +    tcg_gen_deposit_i64(xtl, t0, xbl, 0, 52);

Argh I'm very sorry. I obviously failed while copy/pasting

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      set_cpu_vsrl(xT(ctx->opcode), xtl);
>  
>      tcg_temp_free_i64(t0);
> 

