Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4294BC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67CC27286
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGokcyOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67CC27286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqo6-0006rm-NV
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:31:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXqgL-0000KH-T7
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXqgK-0000Mw-S5
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:23:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXqgK-0000LB-LW
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:23:36 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so16785901oth.10
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qXEFM9CJItJX0vpcqvPfTD/f9gNGf7/Ln/Ae8IkxzS0=;
	b=aGokcyOij0l6ucVUiT+J4da8d5/Fkxg9m0T6cXUSKbHoWFtZG714H8hsFhdlKq2Ds6
	rmXJ9wnzDPPtdk1gq1bEdWzYMrS3OFKQBxzeD7Zdb6/TJ8QFRkVAkLwUr8JbOsvGOwW5
	rTOFD9DDlpFWzOfbJNzPPzubOPs0SdgNsZ/pXuDguj+qhxdSur+Vk4VlzSYcURLrCARg
	yVw/x/Uou1HfBWQ+kFsllMvVo57TelfU1ewQEqJUqhIT2Dje/US+11K3Gb2zMVapcvcg
	3ExTBNpM1tFWS9U0hP/wG64omWiGR2omE9nmZPTeWzhPG/5N1LAocL+LNWPsslAcU0or
	Bhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qXEFM9CJItJX0vpcqvPfTD/f9gNGf7/Ln/Ae8IkxzS0=;
	b=PWqXY4yUQGzZbHINNwOQLOO3D5V1EYbtLs2YTIVJZJG3HRXPAxlPDyE3UhjdbwdpVF
	bqRmpQfu7xa2H0r/bKWQPsl9Vpzk3Q2HSDn3no+UzKqU5KH/+m3LKwX6ZMPlb+oow75z
	7ilyIuf1bMuzF9A/ndLU6VwnW31PsTuu0tSuuySHFFSYveZl1o7Br0da3rC6TbmWxC5K
	FkLuVwHN4x8CgCiyhbhvCpQ+3qckS7rPkEj+cXjxDYbP/VbnYbI/xie6X3hV+9rPyUnX
	xemT8AA1AWyYCkhN6xs18i0SP2pTjD/G7uZK2KXQ9KuK6bE/HrEjb7BGKq5sMmEc+xyL
	Xx/w==
X-Gm-Message-State: APjAAAWlzt8ey62okRUBD7j78phu26775tMuEYpMmDvOpgi8LEDRrWM1
	qZT1GTWwA70XFTrr95DVsAQqzg==
X-Google-Smtp-Source: APXvYqyn9LDABYynvSOSlaiYTp9wBKZVzRtH6qPC+vzA4Ofa3BH2XgKSsS8yIM2ra4EdVafhHvf70g==
X-Received: by 2002:a9d:6b0e:: with SMTP id g14mr2080580otp.206.1559582615211; 
	Mon, 03 Jun 2019 10:23:35 -0700 (PDT)
Received: from [192.168.3.43] ([200.56.192.86])
	by smtp.gmail.com with ESMTPSA id r7sm5438771oia.22.2019.06.03.10.23.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:23:34 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190518191934.21887-1-richard.henderson@linaro.org>
	<20190518191934.21887-2-richard.henderson@linaro.org>
	<CAFEAcA8rbLn53iP8SBKpDju-5n=u8ieWW6=RF8t37nF0UspNkQ@mail.gmail.com>
	<CAFEAcA_MnfJokoggLb5WmhaCZuPb8y7E8L5P+KO=nNaGyKUKAA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <00d8928c-a37a-770d-00b2-4d1781221b44@linaro.org>
Date: Mon, 3 Jun 2019 12:23:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_MnfJokoggLb5WmhaCZuPb8y7E8L5P+KO=nNaGyKUKAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Vectorize USHL and SSHL
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 8:03 AM, Peter Maydell wrote:
> On Thu, 23 May 2019 at 13:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Sat, 18 May 2019 at 20:19, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> These instructions shift left or right depending on the sign
>>> of the input, and 7 bits are significant to the shift.  This
>>> requires several masks and selects in addition to the actual
>>> shifts to form the complete answer.
>>>
>>> That said, the operation is still a small improvement even for
>>> two 64-bit elements -- 13 vector operations instead of 2 * 7
>>> integer operations.
>>>
>>> +void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
>>> +{
>>> +    TCGv_i32 lval = tcg_temp_new_i32();
>>> +    TCGv_i32 rval = tcg_temp_new_i32();
>>> +    TCGv_i32 lsh = tcg_temp_new_i32();
>>> +    TCGv_i32 rsh = tcg_temp_new_i32();
>>> +    TCGv_i32 zero = tcg_const_i32(0);
>>> +    TCGv_i32 max = tcg_const_i32(32);
>>> +
>>> +    /*
>>> +     * Perform possibly out of range shifts, trusting that the operation
>>> +     * does not trap.  Discard unused results after the fact.
>>> +     */
>>
>> This comment reads to me like we're relying on a guarantee
>> that TCG doesn't make, but in fact the readme says it does:
>> out-of-range shifts are "unspecified behavior" which may give
>> bogus results but won't crash. Perhaps phrasing the comment
>> as "relying on the TCG guarantee that these are only
>> 'unspecified behavior' and not 'undefined behavior' and so
>> won't crash" would be clearer ?

I've adjusted the comment along these lines.

> I had a look through the rest of the patch, but there is
> too much code here and I don't have enough context to
> figure out how all the various new gvec helpers are
> called and what jobs they are doing compared to the
> actual instruction operation. Maybe I'll have another try later.
If the host supports vectors, then the .fniv expander will be called.
Otherwise, .fni4 or .fni8 will be used to expand with 32-bit or 64-bit
integers.  Finally, the .fno expander calls an out-of-line helper.

Not strictly kosher perhaps, but in some places we Know that MAX_UNROLL is set
to 4 in tcg/tcg-op-gvec.c, and that since AdvSIMD uses 128-bit vectors, 4 *
32-bit will always be expanded inline, and so omit the out-of-line helper.

I'm not sure why I didn't do this here, since this is not one of the cases in
which we could share helpers with SVE.  (SVE dropped the right-shift as
negative shift count thing.)

> Why can we get rid of the 8-bit, 32-bit and 64-bit old shift
> helpers, but not 16-bit ?

It's still used by gen_neon_shift_narrow.


r~

