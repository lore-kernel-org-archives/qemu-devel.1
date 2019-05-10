Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EC6C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA842177B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX2p8gj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA842177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44137 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6ND-0004ch-L3
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:19:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hP6M5-0004Hp-C1
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hP6M4-0005uy-FF
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:18:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hP6M4-0005u3-4Q
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:18:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id v11so8143880wru.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=fMcy7VYhF4u9Q3gcp6UxV2VlPOzrkNa5b7WbXMtLnrA=;
	b=bX2p8gj+EsuJ0SPmloRw3WuXcieAEKfrhS0LMN9svM7Pak4dc4oQDwk5Wz164YlYlz
	osMxLo62/WTWq/czIhStR3b0MPqYfzdsHxJ7HC8I8RMHpL/NOou83vby8OtLxZsTjrSk
	XLD1mltKtqOtHA29VC30wGLCOY5zjyjtE4LgHska58/4yZyBfdMjfZN01aSItJWZScgv
	JYP3pCAq8RuZ1SRPgQ9ygyG0A2RyUFZjfWXtaB4hqZNzojFtgTpHTLlHfcvZ2aWs82WV
	C6yFwBKv/mhmYdEN7bIGteO5sD2DVIARvOIuWMxNHB//OGYjwcc8ztW9YFxmhaBQM8cU
	EWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=fMcy7VYhF4u9Q3gcp6UxV2VlPOzrkNa5b7WbXMtLnrA=;
	b=odeYdpQdEdK+F+YZa/ls7oPXz0jcoYjto1B88jkCXHi7MNhTvXkcfsVRgqxQgpAHlZ
	ELHZ5w3eGwf44XXCrrzL3QIC+42yZtDHFYiwwjBJmkpaaOiALZ7wpj4V2twAsi3rxaV3
	kYAyMnmXlPAbq8QkeiiIJrXd5IMg5zy0oeeIdpv+zLP9J4Nofb6POe3D10I9A525jC9w
	NI1dvRZuAunpZmj09pr4D0t4sR4rd3JDIM4K+MjAWcEes1mQAPYdTu6503a8Sld33lVr
	20Ngjv9IjXEWPE98UNAvYHHWKcUB8CMsTb4L1CE/OPyRa50MclZ5FsSyJyXf8ZWWk+DP
	cIvQ==
X-Gm-Message-State: APjAAAXg2wMMTENlxOk+ADF/2mqebyn5qC5xZt4f9NLSmzXT6tEZnl5t
	uJ/ecjY/6k85gEXW8C1uKDo=
X-Google-Smtp-Source: APXvYqy07a8TLtOR8Qj4iJGiIsAaytoSQjUvWHTv7uON3s0YkWTclJDV8XTBawTnAJyefL8cBv3WLQ==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr7660364wrq.23.1557497910393; 
	Fri, 10 May 2019 07:18:30 -0700 (PDT)
Received: from erokenlabserver ([41.203.78.145])
	by smtp.gmail.com with ESMTPSA id x5sm5247120wrt.72.2019.05.10.07.18.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 10 May 2019 07:18:29 -0700 (PDT)
Date: Fri, 10 May 2019 15:19:45 +0100
From: Ernest Esene <eroken1@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190510141945.GA1927@erokenlabserver>
References: <20190504181119.GA3317@erokenlabserver>
	<87ftpqb25m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <87ftpqb25m.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2] chardev/char-i2c: Implement Linux I2C
 character device
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 07:33:09PM +0200, Markus Armbruster wrote:
> Ernest Esene <eroken1@gmail.com> writes:
>=20
> > Add support for Linux I2C character device for I2C device passthrough
> > For example:
> > -chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
> >
> > Signed-off-by: Ernest Esene <eroken1@gmail.com>
>=20
> Could you explain briefly how passing through a host's I2C device can be
> useful?
QEMU supports emulation of I2C devices in software but currently can't
passthrough to real I2C devices. This feature is needed by developers
using QEMU for writing and testing software for I2C devices.

>=20
> Any particular reason not to use GPLv2+?
No, I used the wrong script. I'll update the licence.

> > +
> > +        if (addr > CHR_I2C_ADDR_7BIT_MAX) {
> > +            /*
> > +             * TODO: check if adapter support 10-bit addr
> > +             * I2C_FUNC_10BIT_ADDR
> > +             */
>=20
> What's the impact of not having done this TODO?
Not all I2C adapters supports 10-bit address.
> Should it be mentioned in the commit message?
I have handled it already.

> > +        return;
> > +    }
> > +    qemu_set_block(fd);
>=20
> Sure we want *blocking* I/O?  No other character device does.
No, it is a mistake.
>=20
> > +    qemu_chr_open_fd(chr, fd, fd);
> > +    addr =3D (void *) (long) i2c->address;
>=20
>=20
> Why not make option "addr" QEMU_OPT_NUMBER and use
> qemu_opt_get_number()?
I never knew QEMU_OPT_NUMBER can handle inputs such: "0x08 and 8",
appropriately.
>=20
> Missing: documentation update for qemu-options.hx.
I don't know much about this format (.hx), I'll be happy to have any
useful documentation on this.

Thank you.
-Ernest Esene

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlzViHcACgkQJZ4JoaCv
xKoI+hAAutv6JlDh8BX+gFPlNZ/W2TufzMQw2XJpJlQs3XprNIwIB0I3+zWDP7A6
JpcAqGeVc83bDHWipLyA1SuMgfbfdasZeNM3hP+alnhtvNv0fIXohOLFsfkeeuoE
jKCxmRHBDSAj2Bz01RLXF2Xh/9oWDr6f78z9Abv58UGfBH/OI3QreuL2/mfHqpcG
0z8yKeVrfKDHSmB39fAtqs+aGdPmdG0klffckU5hwP8ngYdCf+dykU6m0OUwglAb
3vyDCaVteGhbw+Xoc1EqHkV2OTZnjnzkExsia9p5gM761bQdQtHtBkotNmEc6Ff7
jJ1QsLDBncnoIYQxWvdV13R15pyIeqcmuz2SFZHTVWKhRLuwZPaWw/Zva6+TZOvK
ZhedOoZSOP4C0VC7OOEigmldv7wsEbkoS34kVis4bUih5z04ZqHUOoxhvx03uXg2
16SNTkpgI7CFJyJOezw+zAPQ+pJsI/P/N2Sy4JGCDoaMekO+9033Y5AYrZUUvOkA
pH4kBgQClh66lS7zgzYlstbUjQSaDGbXm8wAo1jbmHM+dFzOV9wWvhXvaMSygJYy
Y2PNpYzqT3J7BgYXUMMPPio1MoKizhv4rr+Tj/NMINrvd9nhvapc/7yG2zSL1oAJ
kP0zhMR2yz6Y1wR5b7wzBW+0QLZTgeFjKZKp+E18pbPtZzTvUvQ=
=XAoU
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

