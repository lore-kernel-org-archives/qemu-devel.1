Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777F0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A79D21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRwgO4VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A79D21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmtL-0005Il-EU
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:32:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hTmop-0002FJ-Pz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hTmoo-000431-Ow
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:27:35 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:34540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hTmom-00040Q-7t; Thu, 23 May 2019 08:27:32 -0400
Received: by mail-yb1-xb41.google.com with SMTP id v78so2201605ybv.1;
	Thu, 23 May 2019 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FANiTY/up6yJLM+G8m+j8Ux206U8nBBLK6uiTs1CeVM=;
	b=DRwgO4VVXAQOSggM8A+qWysOYTPa7rR7GNFyuy7JJA5JT29bYVHDiRw+J89/Wztq2k
	zcCBpqXBZ7okRYaig/dPXgFbNmT4c2GQmSmUi3NAlYvr2tr4NsToDojo9QB4ABwlUg+Y
	vHxqw7qCxBa16f/VuM4986jgXt+cEIfgjnJS8vuvvmOtPnTHv6edkgSahDEEu5OEPXST
	DV5wOABcWDQv1Lx0p/rKXnKVqTuJlEhkXwI4Yt5b9HgbPgOKVJ9QaNTo5cHeVR2BjrR+
	IwptFICrWx9Gj5E/dVFt/hKD0evgErLwSsohKz53dfiHEh33GfpyT3phBnf/DvQ6snsX
	/s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=FANiTY/up6yJLM+G8m+j8Ux206U8nBBLK6uiTs1CeVM=;
	b=WoOypVPbYVm9aeHiqRwTVXEz8AiYs/ob9TEmB99kugBd3VCnV1clau06cWwaGU1F2M
	8OKJgwA7T1UHLQwZaGkgCW5qJLw2YdmU8n2evacKAagLaONjrfHbQglpwNy3gph27tvw
	ds1iRcLbXuz9ZF0O3hGxnFBEc6E8q3tsX6EwZ0WEQnAvcMlUat8vQQZ9EHtdTxDPbX2c
	8k/r5mPegltGpBwglKJZtpPkiWEMxRdXd+O/T2VD/vk8wSkgoCLcOLU9qUVllRTbQofW
	dfBA3lpniyxC4AsH+p9sBXwkx0tfQcxGnoHWLHs33oefg0qXQVxvrKX6OiLKDzHXMFCm
	EKzg==
X-Gm-Message-State: APjAAAVJGjfHVD4Vho76VKIEWjlma0tRa+h8Dnuehyegg4mMbZSMR1OP
	mMHoxuOJutQo3fRyuYMH9T8=
X-Google-Smtp-Source: APXvYqyksVfDLtvincRrNSMwkxTywzUcpvP20VMLlY2iHB34ZyyseD7Y4IhwNXmlDvpEUwMpPbrdlQ==
X-Received: by 2002:a25:850d:: with SMTP id w13mr18193785ybk.515.1558614451225;
	Thu, 23 May 2019 05:27:31 -0700 (PDT)
Received: from [10.240.8.143] ([71.46.56.63])
	by smtp.googlemail.com with ESMTPSA id
	m185sm6853738ywf.38.2019.05.23.05.27.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 05:27:30 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-2-david@redhat.com>
	<b3611279-15c4-f9b7-2a91-051ac6431b2c@linaro.org>
	<44d7ddb4-040f-6778-7439-043b94e354ec@redhat.com>
	<0935643f-941f-5883-c481-8ac18d57c98d@linaro.org>
	<1f6001a2-e1d3-2b6f-e84a-8b9963302a3c@redhat.com>
	<CAFXwXr=YzSuVa9wMKAczhojU+sK5zzPqpWOaJXDLovLNcmkYqg@mail.gmail.com>
	<db392f3c-2bb2-6e16-ebe8-3175ef7859f4@redhat.com>
	<9b00d53e-d676-7d19-cab6-7fb7a6715d1e@twiddle.net>
	<273c1e4f-3216-78aa-508e-b063c0612854@redhat.com>
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
Message-ID: <1c3a49f8-56bd-1577-60a4-7c29ca1c0d83@twiddle.net>
Date: Thu, 23 May 2019 08:27:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <273c1e4f-3216-78aa-508e-b063c0612854@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390x/tcg: Implement VECTOR FIND
 ANY ELEMENT EQUAL
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Cornelia Huck <cohuck@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 3:50 AM, David Hildenbrand wrote:
> /*
>  * Returns the number of bits composing one element.
>  */
> static uint8_t get_element_bits(uint8_t es)
> {
>     return (1 << es) * BITS_PER_BYTE;
> }
> 
> /*
>  * Returns the bitmask for a single element.
>  */
> static uint64_t get_single_element_mask(uint8_t es)
> {
>     return -1ull >> (64 - get_element_bits(es));
> }
> 
> /*
>  * Returns the bitmask for a single element (excluding the MSB).
>  */
> static uint64_t get_single_element_lsbs_mask(uint8_t es)
> {
>     return -1ull >> (65 - get_element_bits(es));
> }
> 
> /*
>  * Returns the bitmasks for multiple elements (excluding the MSBs).
>  */
> static uint64_t get_element_lsbs_mask(uint8_t es)
> {
>     return dup_const(es, get_single_element_lsbs_mask(es));
> }
> 
> static int vfae(void *v1, const void *v2, const void *v3, bool in,
>                 bool rt, bool zs, uint8_t es)
> {
>     const uint64_t mask = get_element_lsbs_mask(es);
>     const int bits = get_element_bits(es);
>     uint64_t a0, a1, b0, b1, e0, e1, t0, t1, z0, z1;
>     uint64_t first_zero = 16;
>     uint64_t first_equal;
>     int i;
> 
>     a0 = s390_vec_read_element64(v2, 0);
>     a1 = s390_vec_read_element64(v2, 1);
>     b0 = s390_vec_read_element64(v3, 0);
>     b1 = s390_vec_read_element64(v3, 1);
>     e0 = 0;
>     e1 = 0;
>     /* compare against equality with every other element */
>     for (i = 0; i < 64; i += bits) {
>         t0 = i ? rol64(b0, i) : b0;
>         t1 = i ? rol64(b1, i) : b1;
>         e0 |= zero_search(a0 ^ t0, mask);
>         e0 |= zero_search(a0 ^ t1, mask);
>         e1 |= zero_search(a1 ^ t0, mask);
>         e1 |= zero_search(a1 ^ t1, mask);
>     }

I don't see that this is doing what you want.  You're shifting one element of B
down, but not broadcasting it so that it is compared against every element of A.

I'd expect something like

	t0 = dup_const(es, b0 >> i);
	t1 = dup_const(es, b1 >> i);

(I also don't see what rol is getting you that shift doesn't.)


>     /* invert the result if requested - invert only the MSBs */
>     if (in) {
>         e0 = ~e0 & ~mask;
>         e1 = ~e1 & ~mask;
>     }
>     first_equal = match_index(e0, e1);
> 
>     if (zs) {
>         z0 = zero_search(a0, mask);
>         z1 = zero_search(a1, mask);
>         first_zero = match_index(z0, z1);
>     }
> 
>     if (rt) {
>         e0 = (e0 >> (bits - 1)) * get_single_element_mask(es);
>         e1 = (e1 >> (bits - 1)) * get_single_element_mask(es);
>         s390_vec_write_element64(v1, 0, e0);
>         s390_vec_write_element64(v1, 1, e1);
>     } else {
>         s390_vec_write_element64(v1, 0, MIN(first_equal, first_zero));
>         s390_vec_write_element64(v1, 1, 0);
>     }
> 
>     if (first_zero == 16 && first_equal == 16) {
>         return 3; /* no match */
>     } else if (first_zero == 16) {
>         return 1; /* matching elements, no match for zero */
>     } else if (first_equal < first_zero) {
>         return 2; /* matching elements before match for zero */
>     }
>     return 0; /* match for zero */
> }

The rest of this looks good.


r~

