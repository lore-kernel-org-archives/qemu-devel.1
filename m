Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8E9C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACA1208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYN/autc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACA1208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34823 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbnz-0003B2-Gd
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 09:06:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hVblc-0001oB-8c
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hVblb-00079S-Dc
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:03:48 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hVblZ-000776-DG; Tue, 28 May 2019 09:03:45 -0400
Received: by mail-ot1-x343.google.com with SMTP id n18so415983otq.0;
	Tue, 28 May 2019 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=6FkbOs506Cg5v41z6X1t4DO0p8AP7fc6PbC38YgIWu8=;
	b=FYN/autcIUD3tsEh9zTqT5yMuIYK0lAeDLYZ8oKOBl1zxCJ7Z0m0swx1S+ANZAdZqN
	3QU/vLYZOB1XtdlU3YpKxO/wVAlU9ao5bTSluBL5l+lTB1c7XKZ53OaP09vyconjjb9D
	EzSf8HZIsHQTH3X1K3KTMIXAySG/OWlm4JJ8aI2NN8UhgY0akvFnMvhXfla7awY1xE/E
	4xe/DRDTzYnWfCHKfhFU/3kMi0IppRQP85VWTy/9HggB2xrt95Kz5E8meIMHaaAqAUDt
	1Jr1+GsIdb7r8DkIStdNho6Wcv2CcJEgKwX9Eq37d5eZBxBWDrsDOaxhm+CFPpfpk0Cl
	65qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=6FkbOs506Cg5v41z6X1t4DO0p8AP7fc6PbC38YgIWu8=;
	b=uIrPuIuLEuugOQGRfQ7pI+QbNKmUZhAYkZWNRVuUASV1DxDpIqiAOJ1leqcoB7rI6M
	ewgTOFeHDB8DVKM9RhIU+32mLXShN3Fx4iAhX58Na5Fl4urNS9zTcKH67EN3h1pqYV7+
	alXsXnALZw9JhmEpItjwCx1zDhG9VxHAJnR49GZ1tNGrwDLXCqamQOJ4k6ZBCdMzpDXB
	0pi8GxEHw5pHuXMyYm7V1EYGE/u9LkHVkC5xhSUYCW2ngwMYyzMzEyuOlFsJfdzq2e+L
	OeC85FbQo83iFEiUi4pfz/XlXo8r5b73eJ1DzW+9NYhCtn/2DY76+MBF1dbp9Lojx2uR
	G4uw==
X-Gm-Message-State: APjAAAVubLyYIXD8/OsMA1QFSNNRLjHuRiWjEnwmtLh15YcvvHCKWtym
	gsgPg98JFOeVFveoHY16Kd4StGGgGMI=
X-Google-Smtp-Source: APXvYqw4r8Ej4zDyWXDrSOeybr/pjBD5+LKfuDZ1ocfABwem2nIwzklh+H3y/cwvWJ8EeSCYRx62CA==
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr13632372oti.327.1559048623907;
	Tue, 28 May 2019 06:03:43 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.googlemail.com with ESMTPSA id
	x64sm5094115oia.32.2019.05.28.06.03.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 06:03:42 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190524093335.22241-1-david@redhat.com>
	<20190524093335.22241-4-david@redhat.com>
	<ede41873-91f7-b1cb-8812-7c2f0c0ab54d@linaro.org>
	<e2ee25b7-1a67-91bb-2985-7eae2c96881f@redhat.com>
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
Message-ID: <a21d40bf-84a3-8426-5e71-f973eb87c6cf@twiddle.net>
Date: Tue, 28 May 2019 08:03:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e2ee25b7-1a67-91bb-2985-7eae2c96881f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 3/5] s390x/tcg: Implement VECTOR FIND
 ELEMENT NOT EQUAL
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

On 5/28/19 8:02 AM, David Hildenbrand wrote:
> On 28.05.19 14:55, Richard Henderson wrote:
>> On 5/24/19 4:33 AM, David Hildenbrand wrote:
>>> +    /* identify the smaller element */
>>> +    if (first_inequal < 16) {
>>> +        uint8_t enr = first_inequal / (1 << es);
>>> +        uint32_t a = s390_vec_read_element(v2, enr, es);
>>> +        uint32_t b = s390_vec_read_element(v3, enr, es);
>>> +
>>> +        smaller = a < b;
>>> +    }
>>> +
>>> +    if (zs) {
>>> +        z0 = zero_search(a0, mask);
>>> +        z1 = zero_search(a1, mask);
>>> +        first_zero = match_index(z0, z1);
>>> +    }
>>> +
>>> +    s390_vec_write_element64(v1, 0, MIN(first_inequal, first_zero));
>>> +    s390_vec_write_element64(v1, 1, 0);
>>> +    if (first_zero == 16 && first_inequal == 16) {
>>> +        return 3;
>>> +    } else if (first_zero < first_inequal) {
>>> +        return 0;
>>> +    }
>>> +    return smaller ? 1 : 2;
>>
>> Perhaps move the computation of smaller down here where it is used.
> 
> Wanted to do that but then I realized that I would have to move
> s390_vec_write_element64() as well, because v1 and v2/v3 could overlap.

Oh, yes of course.  R-B without any changes.  ;-)


r~

