Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2DBC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3DD23A6A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLB2mmmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3DD23A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52347 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY982-0003uY-A7
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 09:05:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hY93H-0000mN-KW
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hY93G-0001Sp-N8
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:00:31 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hY93D-0001MK-2v; Tue, 04 Jun 2019 09:00:27 -0400
Received: by mail-oi1-x242.google.com with SMTP id s184so4440075oie.9;
	Tue, 04 Jun 2019 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=etDHn4AcdZvuAoC28iuFuS6wDnUf6C4Dyo1BwHeMYbA=;
	b=sLB2mmmc3QkCj3GB6BMVJkFgTd9huNY09IwFGDFQTTWKIOsG2pZBexZ38bE1wf/IuD
	iKBtyBeMH3ryUuCjOJ4GRRpACD3AcLoaZ739YhLJWPJfe+YGh7dvJilzAYWMjiHvl6Bd
	ZdUZC2NFvaBjNO9pjfpnWA3osnVNXq5jHYswONklQAA39VZUUEpOx9nFGVR24pBdbKq/
	H+Lk2A36GVO/O7zKNIoJDX0KS6vf2xfC1AfZCWG6QuUAzddV3N9pxAs3VQ+bSznmEpuS
	QlEfyNMs1isxxJrzGUd14y1AjlOFScjjkl39ha6jEDgUkMRm1H7n69bEN5VpPe2Evmnv
	5zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=etDHn4AcdZvuAoC28iuFuS6wDnUf6C4Dyo1BwHeMYbA=;
	b=jBglY1Pw+2awDGr5i/o4Pb9VQDDI8rwwusTZKNdK8/SY5lNMHkCwYufLpT/jiEng8A
	V1FAGjdoATeSpG+hvIuZZMvo0wmJaonDa6m/Ax3Ox+X0Qmm7zHNmBCQKGhanNrRKoDaQ
	N/VSdbWmCChe0tx/xojSwfbWD5mWE4vg07oRuyJEGhourQ5mPgh5Gi2C6SV82QzFER4n
	Pkoa448GfU+8JSksRmRBdBKB5K/E4lOoMmayjRtUUB5Z964T0gFQPDYbJ7urz0CBv0+2
	P0OF68+VYB7FAHmg1SRG0hCQ13NjO9k72eN2J9o6iQNSokEtDBg+9h7nwQymf5xynw/A
	vA1Q==
X-Gm-Message-State: APjAAAVIdtMlzziuKWrJk/sAduwzDjD5LuCGUu9A6K4MABOLHCWqvfzT
	kTiWstxD/QqVSDvL4kyDjtE=
X-Google-Smtp-Source: APXvYqxgpRx+RLJNhDsmMnEY8s61Ma/KwkuNdiiBISNnvExD9MvE+65NJy41fI3XkzIF6px85Fy3eg==
X-Received: by 2002:aca:dac3:: with SMTP id r186mr4135393oig.94.1559653225625; 
	Tue, 04 Jun 2019 06:00:25 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.googlemail.com with ESMTPSA id
	j8sm5880695otl.54.2019.06.04.06.00.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 06:00:24 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190604093656.23565-1-david@redhat.com>
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
Message-ID: <a48caa15-dafa-2f03-9fd2-769adf613ed2@twiddle.net>
Date: Tue, 4 Jun 2019 08:00:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604093656.23565-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v1] linux-user: elf: ELF_HWCAP for s390x
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/19 4:36 AM, David Hildenbrand wrote:
> +    if (s390_has_feat(S390_FEAT_ESAN3)) {
> +        hwcap |= HWCAP_S390_ESAN3;
> +    }
> +    if (s390_has_feat(S390_FEAT_ZARCH)) {
> +        hwcap |= HWCAP_S390_ZARCH;
> +    }

While it's nice and symetrical testing these two features, I don't think they
can ever be false.

> +    if (s390_has_feat(S390_FEAT_STFLE)) {
> +        hwcap |= HWCAP_S390_STFLE;
> +    }
> +    if (s390_has_feat(S390_FEAT_MSA)) {
> +        hwcap |= HWCAP_S390_MSA;
> +    }
> +    if (s390_has_feat(S390_FEAT_LONG_DISPLACEMENT)) {
> +        hwcap |= HWCAP_S390_LDISP;
> +    }
> +    if (s390_has_feat(S390_FEAT_EXTENDED_IMMEDIATE)) {
> +        hwcap |= HWCAP_S390_EIMM;
> +    }
> +    if (s390_has_feat(S390_FEAT_EXTENDED_TRANSLATION_3) &&
> +        s390_has_feat(S390_FEAT_ETF3_ENH)) {
> +        hwcap |= HWCAP_S390_ETF3EH;
> +    }
> +    /* 31-bit processes can use 64-bit registers */
> +    hwcap |= HWCAP_S390_HIGH_GPRS;

And certainly this could never be set unless ZARCH, otherwise you have no
64-bit registers.  ;-)

So maybe clearer to just start with

  hwcap = HWCAP_S390_ESAN3 | HWCAP_S390_ZARCH | HWCAP_S390_HIGH_GPRS;

and continue from there.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

