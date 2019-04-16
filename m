Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42436C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 15:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AEE20656
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 15:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng3f7nsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AEE20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGPvT-0006aS-8S
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 11:23:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGPu3-000602-D7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGPtz-0003Ry-Ij
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:21:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hGPtt-0003Lf-Ov; Tue, 16 Apr 2019 11:21:34 -0400
Received: by mail-pl1-x642.google.com with SMTP id d1so10496009plj.8;
	Tue, 16 Apr 2019 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HnOciyb1mPiG9+m9xka/ejFMc54lhT7Sa3A4ejfNLXA=;
	b=Ng3f7nsr/at0AFOw0A8mC8NnupEv8qG2+U3A/ddp/Es/MGIt0XshNLOA3acNANNoQ6
	W/7Jr+V7pOfYUtlxiC6bl+eoQP5kCr0KlghQTB5TsY1Sp/gXq5P1r8BTKdtD4zo+3v1L
	l8JXaf0/z/U7l+2oyhfnd+w/MkqF/BSjiAfqDINyH9C5AVTYg/8r2fy0F24EO090y2ah
	DOlnrUVcdyRxKakElhWwQustBsXTD6RjTThgJVRpkS5v8yngwnIjs5vsgtwjMQE4Ph28
	8RaDC2oB/fsZoWFY0RCHfMP6Djsp4jQ9UMnUiflkjVh4vGT6OZpz6OP0XeynXBtHq9AQ
	X75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=HnOciyb1mPiG9+m9xka/ejFMc54lhT7Sa3A4ejfNLXA=;
	b=jQRvbWTqBDHRzkYo5N0h/kNUW82Lqsdt74zNZp7ZPFsJESJeVazDyiKpPyLrrdh22e
	KWlBHgNw4v5yXBZ/MFg1gUkDnh81G2Pz84zdEn07wdajOkv32g9h28zGIJyxLZ+lc75v
	Kln0oXplZWIzv6m2BEbnldNGLRqX2JBnqM5pLjMYMdyB2/3znlNT2D/19n6qlswAXshT
	R2uVl14Xzux5QPIMUzzH3ZRfdoeH50BZL4BE1CAxNbw4FeU8pNsEhbD/YmoNLfOWBaEI
	O2LnTXSEud3JsXYDzWDgpEUmUGWUMaM+d3vs97+1uM7f/29emu5zWmZw0KOqBNjIuy1P
	561w==
X-Gm-Message-State: APjAAAW+LuVxMnIysHI3UNxLKV2EJusgiCVHx7U8DMS8lEF4XU3uaryR
	Ih87VYqRM9t4irS3ahUTEZY=
X-Google-Smtp-Source: APXvYqw5Xo4nPqL2Z/610KM5zJXPDyYcLooDfFWIzQA9QYxirIhBwvV4vEj3vk+FpOZHhR4igIO2QQ==
X-Received: by 2002:a17:902:b78c:: with SMTP id
	e12mr30885806pls.29.1555428091250; 
	Tue, 16 Apr 2019 08:21:31 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.googlemail.com with ESMTPSA id
	t5sm66231009pfh.141.2019.04.16.08.21.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 08:21:30 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-32-david@redhat.com>
	<6594280f-cefb-cfb0-35b4-fcf53c32d871@linaro.org>
	<129e5499-a05c-15f1-fe26-6ae0a78cfa7b@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
	mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
	n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
	rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
	Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
	n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
	AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
	CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
	cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
	Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
	eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
	LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
	Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
	94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
	86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
	I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
	VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
	+PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
	AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
	Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
	prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
	/E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
	jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
	VcROBqvtH3ecaIL9iw==
Message-ID: <c3f8cae1-7be1-54ec-e225-d9423a0a92b3@twiddle.net>
Date: Tue, 16 Apr 2019 05:21:24 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <129e5499-a05c-15f1-fe26-6ae0a78cfa7b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416152124.X2h1kr47nvkNx2IyupV6UYqXFQBzAFejYxilBF8KFdM@z>

On 4/15/19 11:45 PM, David Hildenbrand wrote:
> On 13.04.19 02:54, Richard Henderson wrote:
>> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>>> +static DisasJumpType op_vsldb(DisasContext *s, DisasOps *o)
>>> +{
>>> +    int src_idx = get_field(s->fields, i4) & 0xf;
>>> +
>>> +    if (src_idx == 0) {
>>> +        gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2));
>>> +    } else {
>>> +        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2),
>>> +                       get_field(s->fields, v3), src_idx,
>>> +                       gen_helper_gvec_vsldb);
>>> +        return DISAS_NEXT;
>>
>> You could also expand this inline using your new extract2 primitive.
>>
>>   int i4 = get_field(s->fields, i4);
>>   int left_shift, right_shift;
>>
>>   left_shift = (i4 & 7) * 8;
>>   right_shift = 64 - left_shift;
>>
>>   if ((i4 & 8) == 0) {
>>       read_vec_element_i64(t0, get_field(s->fields, v2), 0, ES_64);
>>       read_vec_element_i64(t1, get_field(s->fields, v2), 1, ES_64);
>>       read_vec_element_i64(t2, get_field(s->fields, v3), 0, ES_64);
>>   } else {
>>       read_vec_element_i64(t0, get_field(s->fields, v2), 1, ES_64);
>>       read_vec_element_i64(t1, get_field(s->fields, v3), 0, ES_64);
>>       read_vec_element_i64(t2, get_field(s->fields, v3), 1, ES_64);
>>   }
>>   tcg_gen_extract2_i64(t0, t1, t0, right_shift);
>>   tcg_gen_extract2_i64(t1, t2, t1, right_shift);
> 
> Trying to understand the magic, left_shift is really only used to to
> calculate right_shift, right?

Yes.  I thought that was clearer as a separate step.


r~

