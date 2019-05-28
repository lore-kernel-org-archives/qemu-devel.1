Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7A5C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D4D2075C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kG1F22Tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D4D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYYE-00042s-M6
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:37:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYXK-0003dq-PC
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYXI-00074J-UE
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:36:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYXH-00072H-Bx
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:36:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id h1so5283521wro.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=rzZ0Fa0Uz65TU72AZUbXd9HUrWLid1YP9xH7EZIiqYs=;
	b=kG1F22TkT+ADPVP7B6dDtHR2G6OFRtCk/VS/uiSmw/4wV4W45zvqYhXcfRbAGDMyXY
	kXjrsIE2yjqECweQY8Sw1/+J71CkHzdz+KoASK6eLsHzS6+CireuFNxGksLp5jqDoA4v
	S2yLvzRTpbwVazgHjEVdiThnFnAWpqUXsT2cJOC3AQmpMyfNvNU7A42xAzY+aaRfwulh
	RNYgiwUyo4WpPQykAgJABfaK7Cf9fqpI8nxv5vuY9ogCOJmGdIHh0VNs6WDMivkqDqRQ
	ir4n9nORgCE4KHezl3iuOTzUDwkSUtBDv7mj+QNQCQwm7Nl0PI+KtyjWwCtNSipcDDsU
	7nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=rzZ0Fa0Uz65TU72AZUbXd9HUrWLid1YP9xH7EZIiqYs=;
	b=ugvX5I2nPgOJCdqN+DqYHWNwSWtVMY5nGQagqOGgzV5DYoCHIECgb6Joq5F4am5ROw
	44mCyb8jzUOu6vExDMIV49tpFAZIOsAB3udpQyCI3xGM9D5frSTQprhg/I6bB8MCWy81
	g7a1bUpWk83idmFQ3b3NdT2HWVPjuEfEydvWBZJxnlevpUt7+0pxUNvUGfdYtfd4OoLy
	LKS16FEb6iFntnIXjAS2iVt+HS8iE+R7FAbY/Z0FUEcbn2aujrCfLm3qmXbSY0ReGv2z
	0FWZodkupJT8TGAX3VykzXYjU8PnXmQnsZwVc1G/RCQxdwqCcjAiIM/7YJSKfwuk+0OA
	iWAg==
X-Gm-Message-State: APjAAAUt/9oF3mhhf6LTPUVDmKBwREyk0BA6ZVBtNcHVzWVUNJJ9GRtw
	6wXhLF2m3cc+k0AAlgVmtaMhPA==
X-Google-Smtp-Source: APXvYqzIQOrqv/eTsSiqqkdAl4MIS9fRvJf7xME6o72kNvQcQief6/5wtOtvmGc6K6fx6p5DafByEw==
X-Received: by 2002:a5d:6a87:: with SMTP id s7mr13233505wru.50.1559036205444; 
	Tue, 28 May 2019 02:36:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id w10sm618030wrr.67.2019.05.28.02.36.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:36:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2DD1A1FF87;
	Tue, 28 May 2019 10:36:44 +0100 (BST)
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-5-alex.bennee@linaro.org>
	<0426116b-6141-34ef-a6aa-a269c6d624d3@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <0426116b-6141-34ef-a6aa-a269c6d624d3@linaro.org>
Date: Tue, 28 May 2019 10:36:44 +0100
Message-ID: <87blzmsyxf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 04/28] semihosting: enable chardev
 backed output for console
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/23/19 6:25 AM, Alex Benn=C3=A9e wrote:
>>  int qemu_semihosting_log_out(const char *s, int len)
>>  {
>> -    return write(STDERR_FILENO, s, len);
>> +    Chardev *chardev =3D semihosting_get_chardev();
>> +    if (chardev) {
>> +        return qemu_chr_write_all(chardev, (uint8_t *) s, len);
>> +    } else {
>> +        return write(STDERR_FILENO, s, len);
>> +    }
>>  }
>
> Can we not create a default chardev that outputs to stderr, so that the
> conditional is not required?  Or does that somehow interfere with how this
> connects up for linux-user/?

The one linux-user case does it's own thing which uses the same API but
has a dumb implementation without a chardev. I'm unsure how you go about
creating a plain chardev backend programatically although I'll probably
want to do that for the plugins as well so I'll look into it.

I'll merge this as is for now though.

--
Alex Benn=C3=A9e

