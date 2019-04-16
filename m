Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA17C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E70120645
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3Y2cXPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E70120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33477 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGK6L-0002JZ-Fg
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 05:10:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGK59-0001fc-DV
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGK57-00025X-Np
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:08:46 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:39536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hGK53-00023V-Lu; Tue, 16 Apr 2019 05:08:42 -0400
Received: by mail-pg1-x52c.google.com with SMTP id k3so10019727pga.6;
	Tue, 16 Apr 2019 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=u5VZrIqhBiZN7qlI4iwCPvfUdmlwqv6KnlYUCHDUmF0=;
	b=O3Y2cXPSd6BuJyCRhXs+IpCFwn119t+TCd0m23V+/1fplxzAo9amYe4UCuPorjcTre
	XaoMuQq5wcR9dMNgjTGr1QUsGa5myaQEdG6dle8JN4mRthCoq120twlDc2DwH9/mE8aT
	YvKS94jwFBemp5D4AMqh7OGr2cvqXS3apqRuX6Ub0QO5ZixBekuu0oinpcgroXZKdiaR
	v097fFP1QavUygWD1HC374uEpHG/a/2p1PFTMnovRUEjk4iUJujz4yLV22tEs64wY/8o
	J4EmZFXMMSgIMPaqgHOQKwdcPVcubliFbQXmbtFMGBw67znprjp0/YFey2iwwu0LpEXZ
	jrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=u5VZrIqhBiZN7qlI4iwCPvfUdmlwqv6KnlYUCHDUmF0=;
	b=FxMRmPwnIgtqyeQ2aH7GdmLgjy3wPMirgU9qwwoLK1oLqBjK4jgApfn0FBQJnnDG5H
	Es4t8TFhLEhvuah71gK5/+AczhnrjyphoqMHHXF+5HPKZw53rmhG8e88E/5MfXoisL8G
	mziy2RX/hscqlhY5X9dWEXF/kTgVPW6mK4OJsz3GdnPai4OxaeRYtXi4XIGdOgn2irtU
	gwPp2e/Aa6SPChNmF2VsZ80vOcKFbEMpJEIVvqXXbA5LVzk2ZqroV9+S6OmRooZ4Ly12
	Vd+VfKZa5g/MjL28NdPTRP7SjL4h5tphI5lRJhxcBQyB4OtlvKBuhU3gf9UUUTWnmyAe
	q5dg==
X-Gm-Message-State: APjAAAX5Vm8oPn0tg4c7Kh7oqnx/GD5hR9Mhmcz6io8/hX/xOmkomz52
	2qk+mT/ck9+9Sc7nJg+1mxs=
X-Google-Smtp-Source: APXvYqysdIOCaK6uux+W3rWZdQDJ2V4Ip3FA1UooTpcfOiifGe+Wt20jF8MbtEErSWbrDfRd0osfNg==
X-Received: by 2002:a63:4847:: with SMTP id x7mr76041583pgk.233.1555405717988; 
	Tue, 16 Apr 2019 02:08:37 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.googlemail.com with ESMTPSA id
	v1sm81903644pff.81.2019.04.16.02.08.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 02:08:36 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-10-david@redhat.com>
	<71ce854d-da00-565e-0b36-9458a7bc9183@linaro.org>
	<a7298c65-fea3-7839-6b68-5b3bf5d64c1a@redhat.com>
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
Message-ID: <7e9ca895-031e-9843-8617-491e72a330e7@twiddle.net>
Date: Mon, 15 Apr 2019 23:08:32 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a7298c65-fea3-7839-6b68-5b3bf5d64c1a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52c
Subject: Re: [Qemu-devel] [PATCH v1 09/41] s390x/tcg: Implement VECTOR
 CHECKSUM
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
Message-ID: <20190416090832.8eDMfo39A28sHDg2g3nC8pFeMlg6VT__tPTVNWzaH7U@z>

On 4/15/19 10:58 PM, David Hildenbrand wrote:
>> You could use
>>
>>   tcg_gen_add2_i32(sum, tmp, sum, zero, tmp, zero);
>>   tcg_gen_add_i32(sum, sum, tmp);
> That makes perfect sense, I will use that for now, thanks!
> 

Here's a funny one.  We can do this in one operation:

  tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);

The lower (sum+tmp) carries into the upper (sum+tmp).
We take the upper result and discard the lower.


r~

