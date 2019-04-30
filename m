Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59B3C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7339C20651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqykmFpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7339C20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50541 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWOY-0005tE-KT
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:18:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2L-0004J9-Sn
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVyb-0007tQ-Gd
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:51:30 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:43566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVyb-0007sn-8u
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:51:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id t22so4098247pgi.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3nNI9J7qLZ++q8Oldfquu3ILhdnnNXsANzZl5rFmFw8=;
	b=GqykmFpipqpfXRA0ABQwJ/gxLAymdzyJMRccdS8zvmXKjHZGjGz1j0YgBp0An2o5JM
	BHfk5sSjAUrpNF5u03J5WGGXHk7vAWB70F3lf8PohV2/NmmaF73JzTaKDOL4HsoYsMHm
	qLV41K3W5KaO7aTG7kyn/H6D6kK872DuuRcWO3uNh5sbvPxr2P1xqFKjpP0n9YnQOIa+
	L1oiRXLkZZud3mjyOF9y9wQ5xjI1xm9V7l3k692Y+dicc6HnVN4elps2nohVWAbVK0Wp
	3vQUqELrTknXv8PFlHldK+DaYXDEF+JMQj6DISJ0WPtKQM6DlLHYgKeQQOkQVn40a7Ik
	Sp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3nNI9J7qLZ++q8Oldfquu3ILhdnnNXsANzZl5rFmFw8=;
	b=AASWEvZgFor8iBlLLwTtlKGBQMOcXFCrTqETfSVuAICuO9P0ofg6/as38RaReE2TFk
	zdX/ShC99hWlEnBaRqO1cDPVpa53ZfzIR7GdK8pT8oH110q8xrVLH83fwFtGRSc9IhM8
	LF1EIWngSpG6RhomXgRMWb99hCTILF5cLAUmHSXee12zRJp2kRTZGm7FMiI8j1AKomVw
	9K/+HvIAaT2YYPkNUqGzSRp6qxfMlZQVsbnlorbXEAZdTqA/NUKHWH77Z9BMxbphLTVQ
	pY+8VN2xOttIzZA/BBeM6UOctw+tD7gWi+6FXqZeuVzCuPykZvg4bDXwbnUjkrnxTi+p
	+a6Q==
X-Gm-Message-State: APjAAAXg2gKrMAEN+bJhO8htLXTXfJXe6LtRNO9vSgZf64FIhfsGFmI6
	hRHbP2RJnKPR4E/hwCXtWS+E8Q==
X-Google-Smtp-Source: APXvYqxKbcxLIUYk6au9HVm480UmYWJ4HeGcWEHuzcCrmO4KF63xTWDVP2LgNy36JhW2V/KoUG9EDQ==
X-Received: by 2002:a62:f24e:: with SMTP id y14mr72104727pfl.209.1556643088206;
	Tue, 30 Apr 2019 09:51:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	s85sm64728903pfa.23.2019.04.30.09.51.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:51:27 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-10-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <92815e75-c3da-51df-adb9-a1a2c5b06a30@linaro.org>
Date: Tue, 30 Apr 2019 09:51:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: Re: [Qemu-devel] [PATCH 09/14] target/ppc: introduce
 GEN_VSX_HELPER_R2 macro to fpu_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165115.1vnobUAUfZaVEhUNbQMf9ufJMVnVCzayeD4MR2oodP0@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> -void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
> +void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
> +                   ppc_vsr_t *xt, ppc_vsr_t *xb)
>  {
> -    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
> -    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
>      uint8_t r = Rrm(opcode);
>      uint8_t ex = Rc(opcode);
>      uint8_t rmc = RMC(opcode);

For future cleanup, it looks like the rounding mode should be passed in directly.

But anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


