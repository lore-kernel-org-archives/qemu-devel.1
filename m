Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C6C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182B720645
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioS1/4CV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182B720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuuD-0005aH-5I
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:06:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hYutE-0004zo-C1
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hYutD-0006Pt-IB
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:05:20 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hYutD-0006ML-82
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:05:19 -0400
Received: by mail-lf1-x141.google.com with SMTP id y198so582648lfa.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:user-agent:cc:references:in-reply-to
	:mime-version:content-transfer-encoding:content-disposition
	:message-id; bh=HC7aRqaVVlNhHdmdZNVeBbmaj2/0jODdA1XSxglZJCI=;
	b=ioS1/4CVvMzYY6Qi0rNjBR+MrW5mmUpZJXlLuGPPcpVQX/tIqF8xkLEpYRnGg/Fngb
	07qC56dLDh2p0fozdLPJOh3ircf3nKxhwlZgKgDuAJfdj5AMH/o5pwN+0X48Z7DznPkI
	R+x6uo9u9KlT7O//rX0C97mcZcQ5n4W2/WIYtpNSVEuzoCjAtc1H4JEBNN0pIhJo/XMN
	HaKOdJgbpJi4UbU3SHwifiJ6OqVODuEt2LtElr+Nwhzl6VFvaqjbY8Z6BWzxfzsmm/yQ
	ovCB9N2k88Gt+M716T/1LA9hgrTfvQ56r5IVZHWH80HkfeM8iulVbfetlY8Ft1WocJhF
	21mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
	:in-reply-to:mime-version:content-transfer-encoding
	:content-disposition:message-id;
	bh=HC7aRqaVVlNhHdmdZNVeBbmaj2/0jODdA1XSxglZJCI=;
	b=NBCji5c0m3hyfWM3u6Ax++QT+LNBsmyJS4gMLK4uYbs54PYgnUvTyTSI6qmfVcIHey
	VCalWnEk0UBC60azSF0htEUamJyfsXABxng+Tmiw7dufBzYdGj/VdBXaCwRIa2FdSnGy
	EBxPy57VtoEdJfHwZhtXguNLeUATJieUXbs0AHIaPcS7f71kmql0p8w1ur0+VeIjgVAS
	bxhf/VUX0ctbC4wzV4aSm5av3FmLbLE+LNPbbTQNNipPpiVOl2I2o27qqEa2DG2d4tIO
	tuXFilSnM+sf0otT4eiH2sKgXZrbNr67GbHzdDDfHi5lpndIrbBxie5czUAJDS9b44H3
	gdZw==
X-Gm-Message-State: APjAAAWnDe/XR7X7iaG9FNT/J9gPGIl+H+EOL/+FwCep2nTk/hOhMVz7
	pNXJD8tLarsKkKuLM3X3s1A=
X-Google-Smtp-Source: APXvYqzIJDKQ3bFcwDC5kRjq7Xint7kr62WVEubpz9+Gg6+mz/BU1ZhyeCBRV4aNMOrf2cuf5N7suw==
X-Received: by 2002:ac2:518d:: with SMTP id u13mr23460954lfi.40.1559837116138; 
	Thu, 06 Jun 2019 09:05:16 -0700 (PDT)
Received: from [192.168.1.112] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id w1sm473869ljm.81.2019.06.06.09.05.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 09:05:15 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 6 Jun 2019 18:57:12 +0300
User-Agent: KMail/1.9.10
References: <20190606154310.15830-1-alex.bennee@linaro.org>
In-Reply-To: <20190606154310.15830-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: base64
Content-Disposition: inline
Message-Id: <201906061857.12470.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH] cputlb: cast size_t to target_ulong before
 using for address masks
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

0JIg0YHQvtC+0LHRidC10L3QuNC4INC+0YIgVGh1cnNkYXkgMDYgSnVuZSAyMDE5IDE4OjQzOjEw
IEFsZXggQmVubsOpZSDQvdCw0L/QuNGB0LDQuyjQsCk6Cj4gYWRkcjEgPSBhZGRyICYgfigodGFy
Z2V0X3Vsb25nKXNpemUgLSAxKTsKCnllcywgdGhpcyBmaXhlcyBteSBoYW5nISBUaGFua3MhCg==

