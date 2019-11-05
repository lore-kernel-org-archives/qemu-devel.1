Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDD3C49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981F120869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7TlZK5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981F120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvW7-0006Iy-J1
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRvUX-0004n9-9u
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRvUV-0000kA-Ou
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:51:13 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRvUV-0000iN-6O
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:51:11 -0500
Received: by mail-wr1-x42b.google.com with SMTP id l10so20537183wrb.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 01:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wuI+0tItT5+XOjf3okMrl9VD9XJQzyQvG224KSKsnHE=;
 b=Z7TlZK5kUz+aZm6qFvrX0zrkWK1BDz1dTvfIHmg7A/4wA3aXYYLvu/yYcOdjyD7xbs
 VbK8FU0VbUVR7I+Ozdl1zRYZIt47KilcrPH0nbn62zZ86bm3T+8ADTIiTv2Fp90T3Q4c
 zDniMhWYYIRxfN7jLXZFJ/xoBOxa/2BbjVxMeWDAD1kah6wBbZBGI6pOU5OIYwtyLoC/
 WefhDBT5lPHgX6RE02ePRWLaKh9D39tdxVTg84kjS1cB/zKvq0jo6qCZzOAdc3R3tld3
 eNHKXSpyaJ2QNr1bak+1MNm0zci1dl+cZqmjitQ7UOYotHxNkrRkxthX0HNdDBkJ41H1
 UXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wuI+0tItT5+XOjf3okMrl9VD9XJQzyQvG224KSKsnHE=;
 b=LZYWWjuN8gR6j+AzUrxv3jRyKdiIBxWNpKXwIQfUjjrXRAKNhFBLtkhioXTBMl8y/1
 Adb2jLcaO+bImfD1qRtqPWSmneHOGLWd3fNgiSN/jZx6z86roPwRgKmJHtkk/VQz/TAF
 9wWeX1TMMRGUmUh+PAnwDdoTmyawUjq2041jZiq/zcX9Q+KozEydrRYZrBBXcYL+Q0Nj
 BYq26hSarqigjOP625v9puIiHQQIVDwiESfUO69enyXqH9jt5z0Cp5Xic4b/u0mVr44G
 XAxnPFQ+5vsyK4cmH5/RVrwVOKxhK+us+FRngUu906MALUnpR/4lVF1myIdrbkrKdPpj
 Za3w==
X-Gm-Message-State: APjAAAU2iPx8Hyzgux6T3SwY9w+D3cJ3A80qKd5e403ozSRDqcoEc4ao
 y6njtjfKyRlL2KXVYv2bER0qzEjQ6yE=
X-Google-Smtp-Source: APXvYqzZdozHSl0BPV2eJSbuCQCYThHMT5Mw0N17vIyxRVjyI8lKvS9Z2ll3uIhjWDHK+X5GAA9MLw==
X-Received: by 2002:a05:6000:11d2:: with SMTP id
 i18mr28506307wrx.109.1572947469504; 
 Tue, 05 Nov 2019 01:51:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w18sm12134398wrl.2.2019.11.05.01.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 01:51:08 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 078B41FF87;
 Tue,  5 Nov 2019 09:51:08 +0000 (GMT)
References: <1572911399018.17766@sandia.gov>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Hanson\, Seth" <shanson@sandia.gov>
Subject: Re: Adding New, Unsupported ISA to Qemu
In-reply-to: <1572911399018.17766@sandia.gov>
Date: Tue, 05 Nov 2019 09:51:07 +0000
Message-ID: <87d0e6k5x0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hanson, Seth via <qemu-devel@nongnu.org> writes:

> Hello,
>
>
> I'm looking for in-depth documentation pertaining to how an unsupported 1=
6 bit RISC ISA can be emulated in Qemu.
>
>
> I've referenced this:
>
>
> https://wiki.qemu.org/Documentation/TCG

I've updated the wiki page to include links to all the TCG documentation
that exists in the source tree. The will hopefully give you a bit more
of an overview of how things go together.

> and have been hoping there's additional, related documentation that I've =
overlooked.
>
>
> Please advise.

Generally for new targets the guidance is to do what the newer and more
actively maintained front-ends do. In short a new front-end should:

  * use the common translator_loop
  * should probably use decodetree to reduce boilerplate
  * for system emulation emulate a real life device
  * have someone willing to maintain it once merged

Ideally we like to include at least some basic smoke tests for the
platform (tests/tcg/multiarch/system) which will require a publicly
available toolchain which can be wrapped up in our docker build system.

--
Alex Benn=C3=A9e

