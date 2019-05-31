Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7ECC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9109626A1B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2lSyYWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9109626A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiGQ-0003mZ-NV
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:12:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhzS-0007W6-Kl
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhzR-0001hr-Kq
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:54:38 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhzR-0001hQ-Fi
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:54:37 -0400
Received: by mail-ot1-x343.google.com with SMTP id 107so3425680otj.8
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=v38BXfjeXHYqYshs0HEFalSzmSNh0qCSLUr0pE7J2K4=;
	b=v2lSyYWtkecniPHlpZUVs+ipokpZneH8AOlAwwKtGNOMRBTx1Id6jeKuXXm1k6EMkc
	Ci1E+PvAbC4suq+Rfgc71sP/HvETEMkJfBTOAr91CaYPyd7jbPyhyactG0ZGYYpVkc+e
	3FeAN7MpRYnVYcqU4Dozo75IpDxDH34whzmPhBrE2AXH5GjlyBy7PcAUKJ5Sf+zDMFQM
	zLfRtHC2vac1rxIy8f2XGhMa2KLUqQL1qxXsSYI9P+FyrbvQyU1lN4+RsR3o1OzqcfBU
	VdJuoJERVe6Jv9nutklrDqtrzaD2pDDM7ZqHsPcf3tM76raF6y1gNYC33V/CCHQkeNLU
	S8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=v38BXfjeXHYqYshs0HEFalSzmSNh0qCSLUr0pE7J2K4=;
	b=NdF2bRyhWRubHN3XgW0u8cXZKbuFchmEfZd1kJ5m5fVfzmuTkrCPPvP2SPgaLm8fTe
	3Jf158nIz15PXbaDnPt2ahmhrjMpxIYb8RUwGCphq85bqUgbWS4B+D4bsIrQh+voz0Os
	NQsqOXdocdpMKwTSnIJ52EleID9A5d78yPK5hCEDQk7PQhhyNM05sxQelb3/qxHVREdD
	Qqz/X2GGRWbNYhEAbDKuYxPORy+YM/OPfX6m4RZ6uOhNBCjaNUKLUJIaa6htyugZ5tej
	Fa7ROxD1gKbGjpGkre08RSeOM8aipSyl047IFi/1Ep/0pdm0WOd8YCvwASPXN2YI6akD
	uHhg==
X-Gm-Message-State: APjAAAVFl8EF3GRqys6/FJ40ZS0kwuVtkyYooXt7e9yVQIcX7X6UhaPp
	vZzOfzLPve01Xcb98JAWcCdwTs2y/zmoVw==
X-Google-Smtp-Source: APXvYqzZtMFX3ECzGgt2z9dQUmE8E21xu9w7KgyPWfqak/DZUzluBuBfQVcKWOGPcTZtOWdR7vQJsA==
X-Received: by 2002:a9d:6d91:: with SMTP id x17mr1952755otp.14.1559310876782; 
	Fri, 31 May 2019 06:54:36 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r205sm2157557oig.0.2019.05.31.06.54.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:54:36 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
Date: Fri, 31 May 2019 08:54:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530190738.22713-4-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to
 check for active debugger connection
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 2:07 PM, Michael Rolnik wrote:
> From: Sarah Harris <S.E.Harris@kent.ac.uk>
> 
> AVR CPUs have a BREAK instruction which behaves differently depending on whether debugging is enabled.
> Since the hardware fuses that normally control this are difficult to emulate, and the BREAK instruction is useful for testing, the BREAK instruction is instead enabled/disabled depending on whether a GDB session is attached.

I don't think that this is the right way to model this.

I think that BREAK should always raise an exception and return to the main
loop.  If there we find that the debugger is not attached, the main loop will
simply continue.  Which becomes a nop, as documented.


r~

