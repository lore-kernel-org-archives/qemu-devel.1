Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543FAC04AAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 02:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A72C2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 02:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBTWUTQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A72C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSu8S-0001td-AV
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 22:04:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSu7Z-0001Z0-41
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSu7Y-0000g8-3V
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:03:17 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:42266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSu7X-0000fe-SV
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:03:15 -0400
Received: by mail-yw1-xc42.google.com with SMTP id s5so6673697ywd.9
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=6eAO8b4W8KjvB9OJIraiMTNs2abxecW6FltAacsk2MM=;
	b=sBTWUTQahKn2dTf4kprJ5vAfSYh7+RnoKvOnwKm87hgDD1lU35bv1X8Aa3ZN8+xrGu
	GOJsfvPXU0MSMltRYHJ1SrzCOHwLN4vLotbS+gOnhbuL/xLt6YsKKD7CTkBJsab8uO/E
	l/oOpgEorvanz0bvb8xs8UPWKHF4rf+V9LhfTB9xdhtf3ALPnrMC9onkVn1IG57NX9mu
	VBTqb4vc9hUHrL5gecOag1LWHYiQw4ucBp7VrMEiDY5VxuSjmdOS2omcsnGSX6ScItXw
	ot4/kxylb+uhvBNO1bGHVAPJRVEbeccnZzu4ZOWUzbnyDRJnO1HwH2iv/kyshQ0MiQ4Z
	L73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=6eAO8b4W8KjvB9OJIraiMTNs2abxecW6FltAacsk2MM=;
	b=KPSNN1jxafFntLLPY1z68HszARuN5V3FiRC5+ppvFeLAD/AcmXDB1p2w7PkUKsNl+V
	giA5yLZlRkiUcIGhi8u2gjXqK1HU31wZX5ftad8lPlIsVbo7tpjH2u9nOTpZsjtMCjYa
	PaRbUwNdM23lm+tnL2jltD8kJlA+i5Bp3Ml0MSOM0mDIlydweTErWLW05YPXX25GUhOg
	ODzmJNtrvjHI+OLi1QWP+/3tt+VrKc59UG4gyX4hSsZmsSQpRKdc2YfL9k/qvi/bk/eW
	2OrkQ8ULS8qPj5VEilFXplSr5MQ84/Wlo6gSwMxJwjFqNrpurCJNBlzEhoqF+jv8mN/W
	TXUA==
X-Gm-Message-State: APjAAAW3D5rmESEc9y0oyiwEnT2FOfJ+dgaIwS4AQU2RNN1KRT18xJl9
	770vPP2Ba7kWOnNSLowpC8s4gzcLBjs=
X-Google-Smtp-Source: APXvYqye0QHOBW+HXBg3dBcmPkjsP6OOcw01FRii1r66ZM7/l/HZk1NsQF4yUcggWteyhHK9EDyaOw==
X-Received: by 2002:a81:4915:: with SMTP id w21mr20244233ywa.310.1558404194924;
	Mon, 20 May 2019 19:03:14 -0700 (PDT)
Received: from [10.241.221.248] ([71.46.56.86])
	by smtp.gmail.com with ESMTPSA id
	c85sm6393849ywa.90.2019.05.20.19.03.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 19:03:13 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190518191430.21686-1-richard.henderson@linaro.org>
	<20190518191430.21686-2-richard.henderson@linaro.org>
	<CAL1e-=h02FkYaKp0r2h0ihY=g2i=JityFyt6Jjw60ZB44=QRLw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <12f91287-0af7-97e0-2333-beb4cae3532e@linaro.org>
Date: Mon, 20 May 2019 22:03:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h02FkYaKp0r2h0ihY=g2i=JityFyt6Jjw60ZB44=QRLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: Re: [Qemu-devel] [PATCH 1/2] target/ppc: Use vector variable shifts
 for VSL, VSR, VSRA
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 2:49 AM, Aleksandar Markovic wrote:
> 
> On May 18, 2019 9:21 PM, "Richard Henderson" <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
>>
>> The gvec expanders take care of masking the shift amount
>> against the element width.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>>
>> ---
>>  target/ppc/helper.h                 | 12 ----------
>>  target/ppc/int_helper.c             | 37 -----------------------------
>>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
> 
> You changed the line
> 
> -GEN_VXFORM(vslw, 2, 6);
> 
> to be:
> 
> +GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
> 
> and left this line unchanged (even though it deals with the same vslw instruction):
> 
> GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \                 vrlwnm,
> PPC_NONE, PPC2_ISA300)
> 
> I just want to doublecheck - is this really what you wanted to do?

Yes, the macros do two different things.

The first defines a function using tcg_gen_gvec_shlv as the implementation.

The second defines a function that chooses between two overloaded encodings,
depending on whether PPC_ALTIVEC or PPC2_ISA300 is enabled.  If PPC_ALTIVEC, it
will forward the implementation to the function defined with the first macro.


r~

