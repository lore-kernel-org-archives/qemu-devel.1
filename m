Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB82C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E7424E0D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E7424E0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46125 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY2BW-000867-3R
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:40:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY29M-0006ep-8I
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY29L-0001bD-Di
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:38:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY29L-0001am-71
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:38:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so9401064wme.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1761AGrVN9TqYL/koANVX7FEYnPOvJb6ojjaQkd5dKk=;
	b=VkYOgIqhQNHZ44RCvrIk+ZLLuY0dvgYnA+H5o1zE39yvfdrrA4UmSiHUEKBV5kmQ9U
	cQV8lYbxlJ9tnVZRR+aVBSc1GmVFXQtnsIT9XN4obfCftqYuIMUf7vXLffayrAlZ1bOD
	Dw5mkZvA+K6Pin8SpO6dzyuCbqQ8VAPlM7FSa+JOgU8VoyRrjxgfqPZiTS8o+AXeHNUh
	qyYSHfAu1vet38WURRl17V5DrOnq7zGTMzF/yPGsOH/91JEQNNmdRAiLqaQF3vFBummr
	qST0ztFTZe4a7HPehZ6WX8FDZfh2zZWnJ6t4RvfCWQPZpaK34PBWVL82S+FjTi0lKirF
	EHVw==
X-Gm-Message-State: APjAAAXxAZX4l0dFt92ie5Q/EJcVHM6b5qt4DXL317OnNVL4wsWRAzx1
	CVA20ufcbyL15HE73fRyvKyv9GoGWnU=
X-Google-Smtp-Source: APXvYqz9NrGu93piXCtfoFd9aS+/Elos956sbFktzprAFqW3iOYqw1iUXMnbNiXOC1oAJD4SFZS5Ig==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr17024560wmh.96.1559626698403; 
	Mon, 03 Jun 2019 22:38:18 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183])
	by smtp.gmail.com with ESMTPSA id y12sm8932771wrr.3.2019.06.03.22.38.17
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:38:17 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b6a254dd-0e5b-afbc-2b24-54631391e4dc@redhat.com>
Date: Tue, 4 Jun 2019 07:38:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v16 20/23] target/rx: Use prt_ldmi for
 XCHG_mr disassembly
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 3:43 PM, Richard Henderson wrote:
> Note that the ld == 3 case handled by prt_ldmi is decoded as
> XCHG_rr and cannot appear here.
> 
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/rx/disas.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/target/rx/disas.c b/target/rx/disas.c
> index 515b365528..db10385fd0 100644
> --- a/target/rx/disas.c
> +++ b/target/rx/disas.c
> @@ -366,13 +366,7 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
>  /* xchg dsp[rs].<mi>,rd */
>  static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
>  {
> -    static const char msize[][4] = {
> -        "b", "w", "l", "ub", "uw",
> -    };
> -    char dsp[8];
> -
> -    rx_index_addr(ctx, dsp, a->ld, a->mi);
> -    prt("xchg\t%s[r%d].%s, r%d", dsp, a->rs, msize[a->mi], a->rd);
> +    prt_ldmi(ctx, "xchg", a->ld, a->mi, a->rs, a->rd);

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      return true;
>  }
>  
> 

