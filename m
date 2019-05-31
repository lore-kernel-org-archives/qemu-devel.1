Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA9C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEF726ABC
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5GwML/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEF726ABC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44611 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWihE-0004vt-9I
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:39:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWifh-00045x-Mb
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWifg-0002aZ-G8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:38:17 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWifg-0002Z4-9t
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:38:16 -0400
Received: by mail-ot1-x342.google.com with SMTP id g18so9356351otj.11
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=k9imRTc2KnybCNJm8nEbnNoJcOizofvIciZMP+z2kNg=;
	b=l5GwML/0Ioc3k7JrOsYxbumFbW0IrpF0yS90LJB04ot0Gzyo6mJbGs/qFJ2w786oez
	jmP39V80UG3ratuDzfJwkRF1TJeT3VQ8j9BSIjcC58nvjTg0X8VeyasPGdKELawNDIf8
	fRrhnh7xibhLL9DoefhvJ0EjlpI12/PRKu1hvK6FuJfUQ1HP+8jSh4Wa6EDOax56L50o
	DBTupM6kgylEORr+0ukqitRRw9bTBqIfOsYAjrJcJO9xrVR8PsHgmFs5LNEkHgz9pIHC
	imtX7MmeeXxzVUVp9CTpwi8FUkdGAQ8foKU0Czm+lDV9ZBZ81DNborBoP3VkpLscKvl8
	k+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=k9imRTc2KnybCNJm8nEbnNoJcOizofvIciZMP+z2kNg=;
	b=AZkuWWFagqrnxlqlPTg4r+Gs2XtRL8bDGkor2l0cK90RV98QjwJGy43q3BiNaMFzhb
	X/3ak8RA3aEjkxemx1i9OcdEqsn70jfRpDEoZuvUSo+Jn3bLSAhVPb2gpcgEaNBSEiRh
	Kjj8EybwJniG6gb798odCr7A+kwozaHK/kLqLBqWCeegTAP3guATXTbVJrGVzTUVi7eE
	rFtiDBP5RhxmDUsPOxM18bKaWIZ1uNVEy3up0wyMvnvxn8wH0y/0Qav7bPX/gwXHLHO0
	5qYB3a51YMX9hEIp3YQq9cwCnlQbXy92zm1AhDCFqQVegNnzEecXyTZIbG584xoq2OlR
	aTsA==
X-Gm-Message-State: APjAAAXmAJJ68G6ivEtEb1V/xCjUqjW1KSCjsmuSRWWYUhq1hHY1o5MF
	nCbzLP4EyWEpfcXWjZb71L4bvPH3E+wDmtwxvWJxEQ==
X-Google-Smtp-Source: APXvYqy3g/5VQtwlPGzXkI2xmSGFdP7hk1u+DgG8xuvSvccJTitBX2pUadayHgfTEGkB88j+nDPKKQfbODwYeQDzhRQ=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr2193778otk.232.1559313495087; 
	Fri, 31 May 2019 07:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-7-alex.bennee@linaro.org>
	<20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
	<87sgsu51bd.fsf@zen.linaroharston>
	<833530119.25503992.1559302089822.JavaMail.zimbra@redhat.com>
	<874l5aahmx.fsf@zen.linaroharston>
	<627031963.25549126.1559311169316.JavaMail.zimbra@redhat.com>
	<87o93i8zrh.fsf@zen.linaroharston>
In-Reply-To: <87o93i8zrh.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2019 15:38:04 +0100
Message-ID: <CAFEAcA9UGSM_eNFErNHtx4vqosgTyPJ85mQ2t=QnnkpnGN7rDg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] target/arm: use the common
 interface for WRITE0/WRITEC in arm-semi
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
Cc: Miroslav Rezanina <mrezanin@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 at 15:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Miroslav Rezanina <mrezanin@redhat.com> writes:
> >From: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> >> OK - so from the upstream source tree CONFIG_SEMIHOSTING is still =3Dy
> >> (but I can see most of them are now =3Dn). Isn't the simplest solution=
 to
> >> fix-up your version of the default_config file to include SEMIHOSTING?
> >>
> >
> > It's fix but it goes against our policy of handling CONFIG options so w=
e
> > would prefer to have this fixed - otherwise there's no meaning in havin=
g
> > config option if you can't disable it.
>
> Is that what it means? For my part it means we don't build in
> CONFIG_SEMIHOSTING for the arches that don't need it (which we were
> before). Granted it only really simplified the vl.c parsing and dropped
> support for semihosting for the linux-user targets (except ARM).

Yes, that would be my interpretation of it. If we had
a 'config FOO' stanza for CPUs, then Arm CPUs would
"select SEMIHOSTING". If RedHat would like it to be possible
to build Arm CPUs without CONFIG_SEMIHOSTING then they're
free to submit patches for that, but that's a new feature
upstream doesn't currently support, not a bug in upstream.
(Also I'd be a bit dubious because it means that previously working
guest setups that use semihosting will break.)

PS: if we had a 'config FOO' stanza for CPUs that would also
allow us to say "building Arm CPUs requires the NVIC" and
similarly for things which in QEMU are devices but which are
architecturally tightly-coupled non-optional parts of the CPU.

thanks
-- PMM

