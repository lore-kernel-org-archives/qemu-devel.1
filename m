Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F13C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F01217D9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F01217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3h8-0006bF-8U
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:15:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3gN-0006I3-8T
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3gM-0007iL-CX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:14:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3gM-0007hD-5e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:14:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so1971677wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pYC1oeTLyUqqc5F3ZA084WQiTnD+Q00i0WIgC1+DXWI=;
	b=mocEwCaCV8ffbE0v5kiEwsrdkVExO9mF7kFJFqc8ofB5YtC8jO/dVe14WDVI1CSHfX
	FV/Pj20zr9N3zQFpI2Krm5FHHnhvQptaSCcCWV/QxQquIkFFALDU/xz29F3rh8I/EdCQ
	6C+SXYg51O7OzY2uvpRoNeZtsuAjgGCbDM7oczOyn58scHlb5SN652WR+F7AaLXnYSOH
	jo924qtDKZpSmjfF3FtsVj8eMtZlwz8arEAzcHXPHbOKgaMFYwWCv6ZDakn+MblYKwVz
	i4gLm6bJDfLZ2J2SfzQ5bBxoH3bUpjjAh3PqQVZVICIgcOFrv7j4FKHTNsbQQynDvRUy
	WnWg==
X-Gm-Message-State: APjAAAWlBMql6deI2NztT5BbKk8U7hN3iakzzpQ7sSfLIFaUR9wP0fwS
	lJq/KQKtrBzj4UR3dsJHJ7ypkQ==
X-Google-Smtp-Source: APXvYqzZAejylCBL8q6XOemipPpaAaT/Ipto2WtcqA/4TiFmth2xa31//+gpLEEN083BDiyWztk8JA==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr3992047wmh.134.1556057669185; 
	Tue, 23 Apr 2019 15:14:29 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	t81sm28613621wmb.5.2019.04.23.15.14.27
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:14:28 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-26-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bc6662b1-3e76-1c82-a402-86fababebc7b@redhat.com>
Date: Wed, 24 Apr 2019 00:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 25/38] target/xtensa: Use tcg_gen_abs_i32
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
Message-ID: <20190423221427.ws0sXUxbhpq9TVT58ez9IFJqeOTwYWZE44W19ZOaoDA@z>

On 4/20/19 9:34 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 65561d2c49..62be8a6f6a 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -1707,14 +1707,7 @@ void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
>  static void translate_abs(DisasContext *dc, const OpcodeArg arg[],
>                            const uint32_t par[])
>  {
> -    TCGv_i32 zero = tcg_const_i32(0);
> -    TCGv_i32 neg = tcg_temp_new_i32();
> -
> -    tcg_gen_neg_i32(neg, arg[1].in);
> -    tcg_gen_movcond_i32(TCG_COND_GE, arg[0].out,
> -                        arg[1].in, zero, arg[1].in, neg);
> -    tcg_temp_free(neg);
> -    tcg_temp_free(zero);
> +    tcg_gen_abs_i32(arg[0].out, arg[1].in);
>  }
>  
>  static void translate_add(DisasContext *dc, const OpcodeArg arg[],
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

