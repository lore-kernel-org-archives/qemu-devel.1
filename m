Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90EAC4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C9D208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKpcfEDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C9D208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lK7-00068A-18
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lGa-0003l3-Qb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lGZ-0006j6-Ma
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:05:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8lGZ-0006iX-I9
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:05:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id k9so1230172oib.7
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vuLP4A/EVyHmsz+xdaxuusPVVYQJnMEMrotLGMCd3cU=;
 b=DKpcfEDkDeJoOXi0aTc4oPJ5aEoeBwkkkAXldgj37G+f/W0enZSbb6Jk3T1/0WQR6k
 kmd2DtoH6wGfkC+kM6ZLc9dKaSmQ7D6VohwIJLGIGRuJ+0VK9StUIbSCPldyNIngfhOi
 QP0oIg9YsTaSyONMoM35vLGZK5/Kkdbwxrn3/LNenvv27Q20WvORuTENrt33bwz7YLVt
 8xqOGy5U3YpyC5y8zqlrntXBjp6E8ggDPTCIdfw/UhBEpg/Q6teypj5IpKfPz1Mrh8DZ
 F6x+F4YKMM4ijfBBj8HlOtvY6PDIVRfLMqNEoUEasn49iU9MFH71vYfCCtdhB8z6w14Y
 o6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vuLP4A/EVyHmsz+xdaxuusPVVYQJnMEMrotLGMCd3cU=;
 b=STlSluwk+U/OSGHhT+khFxs+MLbLBQYZd9bqwk0glPFMSa/+l6eRQsf+TvwmTFhOqk
 DsHbDQi3v8ePJc7/WThGw2xeYgE/YNCRqGIUhvRN7AMS+IeuW5h7NB7j9iVB19jLILuK
 ktsEJIBb5qxo4nsEZPIUiNWdus1b/loU3CizqL2UMB8Jbi/I3oVOt8Ylo/uNFUctjqL3
 KNaVxBXJ+QR/PQOsw6P7WehI+Bfv0BB3qvgH9avtWxeoj0P+dBr34tYUmNBiA1GNzoGd
 tfV8xeSqyP8GHHc+20Huo41UMUJ+ENqkk8HYEkIKTh9YwDrrsox3Uy/48hrGOHK6b58Y
 Mlig==
X-Gm-Message-State: APjAAAU8+ugvSwk1tSdYugjdiQ2cHu+TB4PovvtQrfx8S+oz/aGwpWXb
 ZhnmNk0/ruEelz6i8YWe0NCPeZOmmZmFhm/EnxRKVg==
X-Google-Smtp-Source: APXvYqxQvpWwhj4L3JcfY8LP2hErtb55ZYa6GnBCSxcuMPDloZh9z1Qf0OM6WajZ3P1Mcmm5OfiazAXyxzCPp+XajBY=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr2049768oib.146.1568379934780; 
 Fri, 13 Sep 2019 06:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190911164959.11003-1-alex.bennee@linaro.org>
 <20190911164959.11003-6-alex.bennee@linaro.org>
In-Reply-To: <20190911164959.11003-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 14:05:23 +0100
Message-ID: <CAFEAcA-yyRX3u2r_s1u=gEou7s-eh1Yexof_HonCPHL4YqbcKA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v5 5/5] target/arm: remove run-time
 semihosting checks for linux-user
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 17:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Now we do all our checking at translate time we can make cpu_loop a
> little bit simpler. We also introduce a simple linux-user semihosting
> test case to defend the functionality. The out-of-tree softmmu based
> semihosting tests are still more comprehensive.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Could you not put the code cleanup in the same commit as
the test case, please ?

thanks
-- PMM

