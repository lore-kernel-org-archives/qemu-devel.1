Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC290C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29D620835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 16:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s07KVMt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29D620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35978 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLs2H-0005Yk-UJ
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 12:24:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLs12-0004r1-DA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLs0z-00088Q-C2
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:23:28 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hLs0x-0007lz-9O; Wed, 01 May 2019 12:23:23 -0400
Received: by mail-io1-xd41.google.com with SMTP id r18so15261202ioh.2;
	Wed, 01 May 2019 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=F6wCBjdtZU+Hpe3vcFv+cXZg8wyzq3WAKXl6VPVrI8A=;
	b=s07KVMt3ev/pqPADn2hCUj9ZkwemeBCHbUfziSJXSocVrj+y64K/MKqDAb4qpQ5KZL
	25jb2u3cfUaLACDAhWEgTxxwZPMoIWaFXsPg9B3X8+7vatU2Y+Tuv27kMcw8KY0MEQ8O
	kieYhs5EEEEzuZOZLm7xWddw5N9A2uRQV1bFLnwE/47Vv9uaXOg+hmKo+gjWZeLWUA7e
	I3Z1DqmDF+yQjm5LobGbjcnyKlwP6z/ku25TmonCcNX+6S2GZTgFiELW5zA4iGcjb6ae
	IcyEzU15DRRg+yZc75o+f1fFWH0MKJhrOgdEH0S7+D9T+fvQZnm4c57yTy6jYQdJ+mPz
	Mu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=F6wCBjdtZU+Hpe3vcFv+cXZg8wyzq3WAKXl6VPVrI8A=;
	b=glB7fYqJlDeNrts+Y6w4BU7FVP9HbnEyxd2CdWvYCjefvMZh6iX7xanAAQhQAndxOv
	HWJY+rJpP3sJJpaPcyq+3Vr5iOnW2SLamcyn/zWHH4GxD55sRc9SvK49lbDXJhiWEelv
	cmiCHL0j/yACAGFddeBz4cyLF+azVJc5r2EswC87LnhgNdznmSoVfovphVQqK5SmLn9q
	hqyksP75oqx9MRiXFj1tQyptWloZ5mjE1PYTXAH7fNRLA6KAwqokdcH4nHRLKFt4Jbee
	8IZDbSvDCCMCRouC+Znbx71w2NPJC9z2LXIQsfmUecjCbWc2Rt2HL7xIilATXAjETUy0
	+l+w==
X-Gm-Message-State: APjAAAUojYHiqZt1io39h/+sd8Mydd5PwETtJIjEPK3epvO5PxUkptuU
	2K0yekLP/tiABuqwJlCDtBB3bJKm
X-Google-Smtp-Source: APXvYqwXhdnSo9wHhf69j7J9wrdaaacVlpWYrz1S1VbNzoUDzGZM3u20roLzpKIu9p/Huejxiz+pTQ==
X-Received: by 2002:a5d:91c1:: with SMTP id k1mr605145ior.180.1556727798668;
	Wed, 01 May 2019 09:23:18 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175]) by smtp.gmail.com with ESMTPSA id
	w81sm3091062itf.23.2019.05.01.09.23.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 09:23:17 -0700 (PDT)
Date: Wed, 1 May 2019 12:23:16 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Message-ID: <20190501162316.GD21155@stefanha-x1.localdomain>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CACPK8Xc5KgiaYCTs=8ceRu_hV=vC3M6pGV0=7jJNsbuz2a6LDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <CACPK8Xc5KgiaYCTs=8ceRu_hV=vC3M6pGV0=7jJNsbuz2a6LDA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501162316.UQbZnQ_bqSAmTngqSpiLkx6_Am9JuAl8V-vIzFhBZzg@z>


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 12:53:48PM +0000, Joel Stanley wrote:
> On Fri, 26 Apr 2019 at 09:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > A user-friendly error message is needed here.  The check for -kernel was
> > too specific and is not desirable for microbit where we use -device
> > loader.
> >
> > Old boards probably want to continue using -kernel.  New boards like
> > microbit may use just -device loader.  Perhaps there is even a group
> > that wants both options.
>=20
> FWIW, I used -kernel exclusively when working on the microbit model.
> Other users may chose to use the device loader/hex file.
>=20
> I am all for usability, but getting rid of the ability to use -kernel
> on some machine types would be a step in the wrong direction.

-kernel doesn't support the .hex file format that is most commonly used
for micro:bit programs.  Are you loading ELFs?

Stefan

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJx/QACgkQnKSrs4Gr
c8hpZggAukJnmfzU1WV5yz34v06vaJnRghdLQe54TmxuZRJiTjwhsVwfcTwTEsTe
4SgJ9LRi4dGz7+F4IvNUjLzePJX9dpcJ7SKFFoFUxAN1SvgPMTY26na56a4wJPNj
2ATUZsujzI4z9W4tl55U+iaxUTv5jSMwyGl3k4BsHHe5o25Ce97YNfd8fpoLBU0R
+fCGsjkebSSnSXARnLvy2hKefxwW7dlhQC0THL7pISY7rX6btRnuNzbe2eJvOvhG
kFtbEfaNrkObhVEqL+oz/s1+Xyo4lcLijm5Sxi95V4F6zmHMPHbVe+3GXGtABNoY
xp3NsWSV5Da4mY6HWloAQOjBIHixsA==
=W2f4
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--

