Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E0C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA6120850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+b+boSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA6120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6xc-0003NO-06
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:56:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6wk-0002vS-7E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6wj-0004xN-9E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:55:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:35901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6wi-0004uj-DL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:55:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id z5so5908763pfn.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=53KWcDQ8vFItpSkK3SNDKq4laDP3+zyU/YqjepaY2ck=;
	b=d+b+boStnn9aeL45hOV9Mgp+yJchVNJ2DIozcoy40WCJ8rJUUeudiUz15ai5pbBlwm
	aYfamVF2TTMP7rT+xBcL4+QtnaoP6aJ2XBK7RHCdvGje7iEKcVor4XZ2wZbDGHzpLSRe
	/AmZfDP16RfPC/vaqICohGRK6I2yaiKujSY5O3hdnOixcfJhjBtxUWsQGwEgVt1FhINO
	93Clm1OJedhdJGwxl/JkD00d/Vx8iQOgXi5oKuBKvP11HP5fDjDL+JPD805u80qOmVJH
	kglV0s4et8BYtGT3ni5y7R1VOxrnftftqQ5DhOsJ1Xn/XlDHeQH76eUYg3o7uwhq5lWb
	Qvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=53KWcDQ8vFItpSkK3SNDKq4laDP3+zyU/YqjepaY2ck=;
	b=uZnrx6JUfXhiwgwHIGsDGQ3m+2yykhbEAbGEMw0CjyTx1VRI7g6AGtj+DeTZ0+KoaO
	LiKk5TwQgM9SSRyIM2xcxRIUowKCk7bd6A8LRh/rOtq9mhdT4vBFDgRK2nZmNsfnidtj
	W2zBa8bkyRIH9I7KsATJKI2svlw1wydE27WecM2ZL6rc4NwaccFgrXRyahdVVbWYaEFx
	pEIW3IqTTe5YRykwGXs1SwvS35Cp8/Ey3vbCvQub/GYJkXAlIjvbrP1RCT1kPLS7f/EU
	kZmvjwX5LBTQiQsb9WOgzO5kZtG2rn70vDoblSiGxprYF16z6HrL9PdWrMBLeyTDfeHc
	p5NA==
X-Gm-Message-State: APjAAAVAMSuatss4QFZnhLBqTLnGaoE28ARbgQAJUsY6wNKy/epA8klf
	j31ppUmP9pVixaUR4w++LcBF6g==
X-Google-Smtp-Source: APXvYqz2hXuAOgLJekNoa15QcKZCekHKXCSOTGQmDLDsM5DnaG6XFt48gKRl/VW6Kel/JsLlrVpc1w==
X-Received: by 2002:a63:6a43:: with SMTP id f64mr24108688pgc.366.1555116902637;
	Fri, 12 Apr 2019 17:55:02 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	r11sm82111460pga.87.2019.04.12.17.55.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:55:01 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-32-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6594280f-cefb-cfb0-35b4-fcf53c32d871@linaro.org>
Date: Fri, 12 Apr 2019 14:54:57 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-32-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42f
Subject: Re: [Qemu-devel] [PATCH v1 31/41] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413005457.2cBctkTAQsWPjFLCWNFMsL6HBUGdXqHb9tpgo0eNgyw@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +static DisasJumpType op_vsldb(DisasContext *s, DisasOps *o)
> +{
> +    int src_idx = get_field(s->fields, i4) & 0xf;
> +
> +    if (src_idx == 0) {
> +        gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2));
> +    } else {
> +        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2),
> +                       get_field(s->fields, v3), src_idx,
> +                       gen_helper_gvec_vsldb);
> +        return DISAS_NEXT;

You could also expand this inline using your new extract2 primitive.

  int i4 = get_field(s->fields, i4);
  int left_shift, right_shift;

  left_shift = (i4 & 7) * 8;
  right_shift = 64 - left_shift;

  if ((i4 & 8) == 0) {
      read_vec_element_i64(t0, get_field(s->fields, v2), 0, ES_64);
      read_vec_element_i64(t1, get_field(s->fields, v2), 1, ES_64);
      read_vec_element_i64(t2, get_field(s->fields, v3), 0, ES_64);
  } else {
      read_vec_element_i64(t0, get_field(s->fields, v2), 1, ES_64);
      read_vec_element_i64(t1, get_field(s->fields, v3), 0, ES_64);
      read_vec_element_i64(t2, get_field(s->fields, v3), 1, ES_64);
  }
  tcg_gen_extract2_i64(t0, t1, t0, right_shift);
  tcg_gen_extract2_i64(t1, t2, t1, right_shift);
  write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
  write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);


r~

