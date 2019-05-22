Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5DAC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E0D20879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrwGdmP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E0D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTh6-00069V-35
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:02:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTTep-0004mm-0v
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTTeo-0005sf-4L
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:59:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTTen-0005qO-TU
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:59:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so2900040wro.8
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eq3TDb6mOGkCec/cmXeMI2dZ7rJBukbDvz6cokeRP9k=;
	b=QrwGdmP1/d+wY+pVv86RyxlAAtIlp5plNrDjHsE1AqI5UZCQEGbYQ67EJM45tsF+tk
	p5cTmBEz29o1SuSlXzyTgCjsYqSeu3j5fIe8G1FVBQgw29Mopfvtxe/58xgHJbFE8cBw
	V6bbIADvM/JrIn/twzT+I7k7zUtUtJ/eJOQVcbR9ncBY/vmKsuD1e2XvjysRus2p3jul
	AgYalOj6pQqtAIIi1a3Lq3gUVeIiWyLIWpVLv+ZPwluFm9ESQ3HGvNcDlDEl0ExDXryo
	NHo9Jmyla5zuCPW/cPLC+PZoNBUT96xAuBTRyNkIWWqMqh0rP2tDKThqA7v3KiRwBvhb
	FAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eq3TDb6mOGkCec/cmXeMI2dZ7rJBukbDvz6cokeRP9k=;
	b=PPOHTAin/Y6hGj0l0XMLVZ7hNYuxC63aaQROaEE3G6tLo8cqEAQbNQ2FlHYlwEQK+P
	r03QshPNNxr9dnlM4LDF+QjblFVwx/VlmMjQfDNQ5HGqYFR3VP1XtoR+UPeLdkt4iy8I
	HOy5cGsy+q3AVPwLyFpLQMSBcnlgeMDGGavQbTPMg9l/NVZKbu/hpISYU+Q4bHdo/SKc
	FrwphGVg/LLxq15lfvqwbQZaoNWtnOxBvQNksXCLhbuJW5YRujX0xqQEhnc6CDKx2h9F
	rs8EqLyh5/umVtXFp3UIm4RI6D055k6SZ1khCiy9VQDKBZzC2GipEIrlE57BPJBXIpQZ
	j/Ag==
X-Gm-Message-State: APjAAAWuMTxU5C2ONv3zCMY0oFzTbdNQZXANf9Kn1YwvXknOhuZcqzkm
	ZbEhL8TE3vIjFC9Q8XwHOorWtiGe20FAJ3OpMSAQDg==
X-Google-Smtp-Source: APXvYqwxCB5Re59ekvJUBAHmyseq7yFSreqg+xO5+WmLoA5+ciEI7TSxk8BTCWYhCnZEueeQUr3OtODg4Bl122e26fE=
X-Received: by 2002:adf:f208:: with SMTP id p8mr34645236wro.160.1558540796498; 
	Wed, 22 May 2019 08:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-2-david@redhat.com>
	<b3611279-15c4-f9b7-2a91-051ac6431b2c@linaro.org>
	<44d7ddb4-040f-6778-7439-043b94e354ec@redhat.com>
	<0935643f-941f-5883-c481-8ac18d57c98d@linaro.org>
	<1f6001a2-e1d3-2b6f-e84a-8b9963302a3c@redhat.com>
In-Reply-To: <1f6001a2-e1d3-2b6f-e84a-8b9963302a3c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 22 May 2019 11:59:45 -0400
Message-ID: <CAFXwXr=YzSuVa9wMKAczhojU+sK5zzPqpWOaJXDLovLNcmkYqg@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
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
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 07:16, David Hildenbrand <david@redhat.com> wrote:
> > Also plausible.  I guess it would be good to know, anyway.
>
> I'll dump the parameters when booting Linux. My gut feeling is that the
> cc option is basically never used ...

It looks like our intuition is wrong about that.

rth@cloudburst:~/glibc/src/sysdeps/s390$ grep -r vfaezbs * | wc -l
15

These set cc, use zs, and do not use rt.

rth@cloudburst:~/glibc/src/sysdeps/s390$ grep -r 'vfaeb' * | wc -l
3

These do not set cc, do not use zs, and do use rt.

Those are the only two VFAE forms used by glibc (note that the same
variants as 'f' are used by the wide-character strings).


r~

