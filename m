Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07465C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 13:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97C52490E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCj/sUyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97C52490E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWLK5-00073C-II
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 09:42:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWLJ8-0006ao-Cm
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWLJ7-00035x-E9
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:41:26 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:35357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWLJ7-00035T-7Z
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:41:25 -0400
Received: by mail-ot1-x330.google.com with SMTP id n14so5644629otk.2
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 06:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=yfy8gaQudA6qBkT8aOQQAh77J1AxSthIJuskrJUwyu0=;
	b=KCj/sUyW0FQ86uzlgGc9fzdh1K307UcyLTZpceRaQux+jPRJzLWVgvFegZqVaSW2mf
	10wMz0Fz2DK+FxvrYFtyuV7IusbEMwJXqRkSkS7fDm4XXbqQCtnl4u55xdJ3FO9z8p3T
	HOMSSpzGk0UwqGU/iwCybldNxRC4xsuN9/neyzvzxnUhsoPwL2fJ6gztOljJoFqtJhaC
	Z0d1LjL1KF4NzIDzmWjjq8OqOTK1WtlR39OOkwFFm57hqtKcMZ3hgjTQgKq/tj6nN8PW
	J0kmop6M/I5U5TGMNWyP+qh7hNCex5gMqVMSRO8CGApbgWwQHnT8h1kALQKXrmkH6jyh
	gZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yfy8gaQudA6qBkT8aOQQAh77J1AxSthIJuskrJUwyu0=;
	b=j35We0w8TOrTgUtoJfyChMKmRkLzf5/9a6fLy8F5p2Vx/FJ3NbwoPoSfsOyxlfgISM
	KYBzLJ8MdSXfodygo0jbdDqzNNXTVoqth58cjCcm2uH4HDtGS5glBQ1cfnWly2HudxpZ
	uGOc9hyyEFNeE4I7g2lh/XotWkfZkYyj4ih26lKWtWQDx2SMi1dWDmoSe8sndstXG1B/
	vUNWK4nzsqJeDNXdkksjjFGqdAl2icDfz52og0dm8C/QQHk6PfXhXFAawjvGNI8N4TCp
	m3mXOqsElSjLtvGEoZqGTyKK+9+lJUcN7OIVBrPkZDaVCyAEjxjNeEdLUfMrEW02fkAX
	Lk8g==
X-Gm-Message-State: APjAAAVYw4T9AqYlW2Gmba84CL77fAeoJoZ4oJ4I+ljlJRilL9xGWFHm
	jOeHQINXb1RIhfLJsLEhmASzpLO6lGV5fA==
X-Google-Smtp-Source: APXvYqwzX/zdpWzqguc3+tK+HP+GoIDxV3sTVAjMeixhXECRp8mmr/bYrpQFEU/wwBt/ymJRbEd5Zg==
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr2433446otj.257.1559223683968;
	Thu, 30 May 2019 06:41:23 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id i10sm948545oto.17.2019.05.30.06.41.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 06:41:22 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
	<20190522184226.17871-11-richard.henderson@linaro.org>
	<CAFEAcA-=D+812uru4ZWfS5B0V-ot-RUvdWm0wV4mO8RUsETgbw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4c6a0080-85db-e81d-10f1-50acab162d8c@linaro.org>
Date: Thu, 30 May 2019 08:41:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=D+812uru4ZWfS5B0V-ot-RUvdWm0wV4mO8RUsETgbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL 10/25] util: Add qemu_guest_getrandom and
 associated routines
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 6:29 AM, Peter Maydell wrote:
> On Wed, 22 May 2019 at 19:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This routine is intended to produce high-quality random numbers to the
>> guest.  Normally, such numbers are crypto quality from the host, but a
>> command-line option can force the use of a fully deterministic sequence
>> for use while debugging.
> 
>> +void qemu_guest_getrandom_nofail(void *buf, size_t len)
>> +{
>> +    qemu_guest_getrandom(buf, len, &error_fatal);
>> +}
>>
> 
> Hi; Coverity complains about this because in the other 4 places
> where we call qemu_guest_getrandom() we check its return
> value, but here we ignore it. If qemu_guest_getrandom() can't
> fail ever then we don't need the separate _nofail() version.
> If it can fail sometimes but not here then we should assert()
> so with a comment explaining why it can't fail, or we should
> do an error-exit check like qdev_init_nofail().
> (This is CID 1401701.)

Because of &error_fatal, we will have already exited on error.  As a qapi
programming pattern, that seems clear in this context.

I don't see how the qdev_init_nofail pattern is an improvement (although in
that specific case we certainly produce a better error message).  If we insist
on that pattern, then we should remove error_fatal and error_abort entirely.

Would coverity be happy with casting the return value to void?


r~

