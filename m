Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F4C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 21:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93B120873
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 21:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5O6+P0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93B120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35306 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQITX-00073t-Ps
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 17:27:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQIRZ-00041n-CH
	for qemu-devel@nongnu.org; Mon, 13 May 2019 17:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQIHL-00015Z-TT
	for qemu-devel@nongnu.org; Mon, 13 May 2019 17:14:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQIHL-00012a-Je
	for qemu-devel@nongnu.org; Mon, 13 May 2019 17:14:35 -0400
Received: by mail-pg1-x542.google.com with SMTP id a3so7410559pgb.3
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=2yIMAOHgdtQWMc2Sa/XajJ04zkTcJKS7Mtb3fPJ8+bY=;
	b=V5O6+P0uzhf5RfKWX9eoMW3co9LjTv1CJG/K2Rkjvh7c15IyRx+DLBQFs0yEx/wi7j
	rSvpYZZ/48jWEPLhhDow9hxxztxz0RmBCqpOlU5jinh8Kw1cHifdB0e8xmRnGj0TtyS/
	MqxuCmTkroXN5FeQ/DdX+a/+jmlftPmYagMVqbhZywfOTxs1U2lV0jg81BLoXO6hXXZR
	fBOGyGb0QTIUrL0F3xPArHVLZn98+zsMTxQTFqN+BIf/mN4FiqI5Hlbra4faO4HM1taP
	BdjahUPDpVrP5gOegmucvTS/457mZBWdm5uYm81zfSpWa7muwAq6Myb5KN0u05ljIPry
	aDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2yIMAOHgdtQWMc2Sa/XajJ04zkTcJKS7Mtb3fPJ8+bY=;
	b=KWhqmEufGyPtPlW8qtcqyNrcfg0OvKjqKZFDuNuhmRZNW70mRYffnpUdAM7A54DJqj
	wQp0CMP/87Mq7KR2suCLoBKipzok8oxqq6rNfXqejNL4cD3d39vT1lboyICNsCae5gqE
	nO3IDhpzoboMeC7BUsGwiTTf0TRAWTrbW+8Y/sL5/ek/IQMFflJilcdxS7f9Ha6V+3HH
	X18uNa4OgqkL7jOIKgitgiT8ThRJUpsMQoRNIKFwy/kHR7JIYRcA4a4csS1dINfsl3GX
	csNkYhasPWKoe6kiKDUW2POAIDHF+MVtGVtg0nRbaSDnBGWKaL8rsDnbOfn3+Vh1jfkb
	aUrQ==
X-Gm-Message-State: APjAAAW8Xp8AzXs/DBmKL4C6RYxjCNAD/HsB5a5XscvDltjz+SsdieYL
	OaoOYpQaD8m+SVgFqw0tsQy/cg==
X-Google-Smtp-Source: APXvYqzdXeDC6+4iq67zgzSYoZuLZWT2axhnn4a/IZqmDwCgjuI1E9ocNwpYLoHXDicG3HTnjmMpkQ==
X-Received: by 2002:a62:7a8f:: with SMTP id
	v137mr36649750pfc.243.1557782073415; 
	Mon, 13 May 2019 14:14:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	c23sm33812640pfp.0.2019.05.13.14.14.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 14:14:32 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190510203452.11870-1-richard.henderson@linaro.org>
	<CAL1e-=hE4zMwDewsbD6=Kc32Ss9wcB-AyOtY-G=HhDKS9YMOoQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4a2f1364-b7d2-209e-3d17-ca1eef3b53e3@linaro.org>
Date: Mon, 13 May 2019 14:14:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hE4zMwDewsbD6=Kc32Ss9wcB-AyOtY-G=HhDKS9YMOoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] configure: Disable slirp if
 --disable-system
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
Cc: samuel.thibault@ens-lyon.org, qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/19 5:47 AM, Aleksandar Markovic wrote:
> 
> On May 10, 2019 10:36 PM, "Richard Henderson" <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
>>
>> For linux-user, there is no need to add slirp to the set of
>> git modules checked out, nor build it.
>>
>> This also avoids a makefile bug wrt insufficient dependencies
>> on subdir-slirp.  If slirp/ is not initially present, the
>> dependencies that check it out are associated with softmmu,
>> which then generates a build error on slirp/ not present.
>>
> 
> Hi,
> 
> Does this work if only user mode targets are specified via ˊ--target-listˊ
> switch?

Yes.  There is a bit of code that converts such a target list to the same
result as --disable-system, which is $softmmu = no.

> If no, the patch shoud be amended. If yes, the commit message should be
> extended.

Like what?  I think it's pretty clear as is.


r~

