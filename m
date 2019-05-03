Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0269FC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0CE2081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPYNnz2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0CE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMd6t-00053f-Vk
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 14:40:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd5s-0004ZP-Ik
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd5r-00086S-ME
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:39:36 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMd5r-00085Z-Gh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:39:35 -0400
Received: by mail-pf1-x442.google.com with SMTP id u17so3292480pfn.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mFL0vn/sQYhaky4PmdLyoRvJg70I0KlHN26WvhwRl/Y=;
	b=uPYNnz2yHI7q5X/e3j30tRBsKFurR2EjF+nUSEOnFoz3tbfCDqtePdHfXH6fjS7mqR
	xqTPFP4Fw0uiQjpTPxx/x5l5t8278HULwZzrTtC6HyxdtgnZE93/+5WeKy/xOpDesXee
	o3WmQoaR2LBkCSyhTLu89rMMjVwFOyfk7CXGAm6Jku0ovBY9swE0srSi2DkwAAAdzh8s
	rO0net6fF4WGwqWry1PXlw6otM+gkSXW1T8Ye1H2TUM/RUfRqeh+cx2/x+8a2eARlkVB
	R1sHSAWzlUsGLs+8PWjact1JA40yg4D491boy5RtibW4t4au7HIv/xSZnElEgWApyohi
	punQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mFL0vn/sQYhaky4PmdLyoRvJg70I0KlHN26WvhwRl/Y=;
	b=kVX7cubFzj0TKG/XQViOL+uHfGd3mrcjL235jMz5oD40ZGirLjS95W+4+dc6lCc3mc
	ZerMgIHeKetDTJjp4rdbobJqpeqj32a7Io0eRWGQQuGYpPADGXt7w1qjSvDTLOX90Xbe
	qIFjCVevX2Ao2JVtZGUdHgWw3Cz/qx8JJMjd7Vgn+6XQ1mfscsxtWK6bkPchpeAmXWAl
	kgujOzYU9ae/uvHYAOmnNGrrJ7jR8749gYueeubkfnjXyU1fh/w4denp5PJ4gVAugHjH
	M+T1jb5FIpC3UalJmYpWcifGv7DwOlpl6R0lM0iPSQnpdJ+XLzf0zDwp4K3p/8KJ5AIa
	ZDFg==
X-Gm-Message-State: APjAAAUjjJ1pJI0d1f1ggD9aiANqm3tuMjPwvYDcEH8cLEYGYNBINMQr
	WUpn5ainYxRZtUTw/X9pv4SLcA==
X-Google-Smtp-Source: APXvYqz58S3AtS7E/7NXlVuHIiP9rVR9yqWgijLdMEw3gXF8xLQEWIcgc6TEFysx+/yxkPhBheegDw==
X-Received: by 2002:a63:1b11:: with SMTP id b17mr12420517pgb.207.1556908774158;
	Fri, 03 May 2019 11:39:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	q128sm3980031pfb.164.2019.05.03.11.39.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 11:39:33 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-13-ysato@users.sourceforge.jp>
	<87muk34kym.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3d73dc0e-dd08-9900-481c-232ad303a6f0@linaro.org>
Date: Fri, 3 May 2019 11:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87muk34kym.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH RFC v8 12/12] hw/registerfields.h: Add 8bit
 and 16bit register macros.
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
Cc: peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503183930.TWdPi8lx9mKqXePyNMi6Gu2E41GEc_8bk17Il7Y2kek@z>

On 5/3/19 8:27 AM, Alex Bennée wrote:
> 
> Yoshinori Sato <ysato@users.sourceforge.jp> writes:
> 
>> Some RX peripheral using 8bit and 16bit registers.
>> Added 8bit and 16bit APIs.
> 
> Doesn't this mean the build breaks at some point? Features used by other
> patches should be introduced first so the build remains bisectable.

The only bug I would fix in the ordering is to make the change to configure
last, so that the target/rx is not enabled while the patches are staging.


r~

