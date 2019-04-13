Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF4C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 08:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAF220850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 08:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Db03IEfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAF220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFE5K-0007n5-K0
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 04:32:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFE4J-0007TE-BU
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFE4I-00020p-D9
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:31:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFE4H-00020K-P4
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:31:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id 85so6293658pgc.3
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hDwpJhnmfqkhFgd5PAuqYtLOXB/TQFZjAkjXV20/Wak=;
	b=Db03IEfh+3tR5EgO5N/FC7irMEa12uYLCxCB0Y3tUDwHb/Ogehg/ex5g9AAW42Mvvl
	pMDV4/0P2hputvSYlyBGvPcVsVvYH+FxloDH+Mt2zbJzeFgDTIcWsq7wp9k/MgtnfjSB
	0ZfjkSerSQzikCuu+7GYpAwR5F7UIUqwCLh4o3pz7bLmHMUzMz6OzsaHGWZfbCt/gNd0
	fgWzyNunQTZgOp/7Q7UJCu8urQve+qkz5iqbyFL2CWO4Um9abAKV2Zm7QcDc7SrvzZk4
	Lo8JjyhK3pHO2/z0DwW7NgB0pHTqD1rBCIltAoqCnqYHQFdyXmftXvjGmu/F7n/HLKqJ
	gMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hDwpJhnmfqkhFgd5PAuqYtLOXB/TQFZjAkjXV20/Wak=;
	b=PfyA7DRwV1kvyCXIcuEehuuj7x/OPCYQ5BiaqcHz8C5Fvbm8M2pGBQoDh5z9QVxvFK
	LkD3YL9SYxBM5SoQoBrhJIl7auoqJmUoQ4lJHndq6jpb+u8ZpwFJAohdrfzQ+9zMVI3D
	EMdFs69dAKmVSyd4dS9RcAM9PlvzttdtldKfqTHSWmhArinPHwuT3Bgiczs32Wtgo8WR
	7Aq1uhmDbGsmIV1Qi+inDGY/X/h/qnQ0TbuCQGQF65leGIH9hFDmMagN3/PTxx07ETl3
	y/CpgSKsvw154Abp9Ybn0l0fQfRSbFx87sYrJkAGXsd05HN1ZJic5T+AmWv85jT8xC50
	h+dg==
X-Gm-Message-State: APjAAAVrtLpbD1P8XKWKNGgz29l7CifPHyFAjIxWsnxqJ0NMbr2++LNl
	D8Yj2novcJ/7UQjNg6o0O4hSCij4YtA=
X-Google-Smtp-Source: APXvYqzBiki4mnJVYDVnUmnW8PAu2kP6uRVthZ1n42O8SkU2Q57EJNFIqK3gvJUoNXp5aYk2GOTdWQ==
X-Received: by 2002:a62:ab14:: with SMTP id p20mr61849822pff.23.1555144280004; 
	Sat, 13 Apr 2019 01:31:20 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	n5sm50448484pgp.80.2019.04.13.01.31.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 13 Apr 2019 01:31:18 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-3-richard.henderson@linaro.org>
	<CAFEAcA8JwtiBSgUg_8kg52GETGd3vbX86nvziXa6ZyvqDPLt5g@mail.gmail.com>
	<a17fffd5-6242-8efc-a8a6-2ca5a8ae9c3d@linaro.org>
	<CAFEAcA-ee-WmGLn=OMTDpisovgz6wCEfGygZ3Fy+JoHVbfdPKQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4dc82e13-86c7-0f23-957a-463173a86481@linaro.org>
Date: Fri, 12 Apr 2019 22:31:15 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ee-WmGLn=OMTDpisovgz6wCEfGygZ3Fy+JoHVbfdPKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 2/9] tcg: Add INDEX_op_extract2_{i32,i64}
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413083115.eh33TFz4N94Ui30dqT6GmcLMWduJWd2FMt53iHOm7j0@z>

On 4/3/19 1:56 AM, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 18:37, Richard Henderson
>> * extract2_i32/i64 dest, t1, t2, pos
>>
>> For N = {32,64}, extract an N-bit quantity from the concatenation
>> of t2:t1, beginning at pos.  The tcg_gen_extract2_* expander allows
>> values 0 <= pos <= N, but will expand 0 and N with mov, so only
>> 1 <= pos <= N-1 will be seen by the host tcg_out_op.
> 
> If I'm reading that correctly, it seems to be combining in one sentence
> the behaviour of the TCG API exposed to the front-end (pos can be
> between 0 and N inclusive) with a detail of the API that a backend
> needs to care about (that it can assume it never sees 0 or N).

You're not wrong.  ;-P

> I think we should be more careful to keep those separate, because
> a reader of this document is almost always going to care only about
> one or the other, never both at the same time. Perhaps things that
> apply only to the backend end of the interface should go in section 4
> of tcg/README?

Sadly, there's a lot of mix up on that count.

Indeed, the very next paragraph,

> * extrl_i64_i32 t0, t1
> 
> For 64-bit hosts only, extract the low 32-bits of input T1 and place it
> into 32-bit output T0.  Depending on the host, this may be a simple move,
> or may require additional canonicalization.

is entirely about the "section 4" opcode.  The "section 2" function,
tcg_gen_extrl_i64_i32, is expanded correctly for 32-bit hosts as a
simple move from the i32 "sub-temp" of the i64 temp.

Clearly the whole thing should be reorganized, but I'm not sure how best that
should be done.

> At any rate I think they should at least be in different sentences :-)

Now that I can do.  ;-)


r~

