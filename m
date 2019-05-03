Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8802C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 21:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D82206C1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 21:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXp4Xr9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D82206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMfyG-00082w-O9
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 17:43:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hMfxQ-0007hR-5m
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hMfxP-0006ZB-4p
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:43:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hMfxO-0006YW-Te
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:43:03 -0400
Received: by mail-wm1-x341.google.com with SMTP id y197so8240372wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Q0idPW5Ta4dgujX8RSQPmUZh4xaYnxZ/tmolBoFPDMI=;
	b=dXp4Xr9rpDXcpwlmFYiARMzIDfgMh0jqmVkp8q4BNMZMEyrGYohX8iQyp/nTpRvYK2
	PlIU8pbbGrWjgoLzay0pIEr372AH6X31xzLhP4vUNq6al/ZNAQL5tK1Wzu8AFuhzoWzv
	rGR35QQS8fADuoFmUFQIuRyzPvROnuwG5OSaUD4KO6ebnFlYnfLWpkz+LskVTV/6K5c1
	v4B2quSsaMqKOL5VMcZ47ozHcjzstOCUhvIEt91HOX/u4Yn2hEGVLn9h1BYkgl2N0/WX
	WnP8mm2/TSnBCk1XlTmwGYC8QJZ0Ps558mmx/35QOPLDRUZ8c+0y8lWHSK3vmFN+phxX
	2FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Q0idPW5Ta4dgujX8RSQPmUZh4xaYnxZ/tmolBoFPDMI=;
	b=FCtxEeRhRQKnvzX4BT2eSYhrl119VQY5HYdM8pOYgTlhhHoyPa8JQ7cH4j+NCzMUsr
	ZFPEd/rFf3cx1pkh9PougBEPVuVOxpgPt9TzXrn6gVdx4s/ju12fBjFZFXQEdDkkNX9X
	dc4nDz2idDR0Nu5FFNOIYgSL9dphlgUpd3lL7B+ZR9sqy5ug7AVNPw9AWZFYu2QoGVbN
	vaQwTyr1U1koQNLbj4D4ssu76y6/73yqsOwkJFEWrq2Z8n6R7gmEwgi+4Xm91NQKY0Di
	jqQzwxshCOB1cXcseP0vqYNH+yig59QiH5jpGrYbAae1uJmhD9S99bKrUW3YDeoh0er9
	ay9Q==
X-Gm-Message-State: APjAAAWHyKgdtWOT+kGHg8DwkQ3e5EbCYHubIKpb7foM7MbxSO2I+hei
	olu3n1QO9O6iopracqIAHRw=
X-Google-Smtp-Source: APXvYqzM1c3yOdg9KpLrm5J31dJMgiMqRwd68hKap/4bpdEMW/JcsHg/Mzn9MINOIwTP/AnlYdiknQ==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr8255733wmq.102.1556919781757; 
	Fri, 03 May 2019 14:43:01 -0700 (PDT)
Received: from erokenlabserver ([41.203.78.113])
	by smtp.gmail.com with ESMTPSA id
	h81sm7777804wmf.33.2019.05.03.14.42.58
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 03 May 2019 14:43:00 -0700 (PDT)
Date: Fri, 3 May 2019 22:46:08 +0100
From: Ernest Esene <eroken1@gmail.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190503214608.GA20318@erokenlabserver>
References: <20190503193141.GA17700@erokenlabserver>
	<7f3b0a70-cec4-f267-c1fa-0bed6851b8cf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <7f3b0a70-cec4-f267-c1fa-0bed6851b8cf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] chardev/char-i2c: Implement Linux I2C
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503214608.3nZUWdReY8F7xvFV-xVHA3OZ3ElcoHdNcz_MyrYgK8c@z>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:24:06PM -0500, Eric Blake wrote:
> On 5/3/19 2:31 PM, Ernest Esene wrote:
> > Add support for Linux I2C character device for I2C device passthrough
> > For example:
> > -chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
> >=20
> > Signed-off-by: Ernest Esene <eroken1@gmail.com>
> > ---
>=20
> Just an interface review:
>=20
> > +++ b/qapi/char.json
> > @@ -240,6 +240,21 @@
> >    'data': { 'device': 'str' },
> >    'base': 'ChardevCommon' }
> > =20
> Missing a 'Since: 4.1' line.
4.1? Oh! I couldn't guess this number, I had to deliberately omit it.
>=20
> > +{ 'struct': 'ChardevI2c',
> > +  'data': { 'device': 'str',
> > +            'address': 'int16'},
> > +  'base': 'ChardevCommon'}
>=20
> 'if': 'defined(CONFIG_LINUX)'
>=20
> as part of the usage of this struct, so that introspection will only see
> the struct where it can be used.
>=20
> > +
> >  ##
> >  # @ChardevSocket:
> >  #
> > @@ -398,6 +413,7 @@
> >    'data': { 'file': 'ChardevFile',
> >              'serial': 'ChardevHostdev',
> >              'parallel': 'ChardevHostdev',
> > +            'i2c': 'ChardevI2c',
> >              'pipe': 'ChardevHostdev',
> >              'socket': 'ChardevSocket',
> >              'udp': 'ChardevUdp',
> >=20
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20
Thanks so much for the useful review. I have applied the changes and
will soon send v2 of the patch.

I hope it is OK to update the "MAINTAINERS" file this

Character Devices (Linux I2C)
M: Ernest Esene <eroken1@gmail.com>
S: Maintained
F: chardev/char-i2c.c


-Ernest Esene

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlzMtpwACgkQJZ4JoaCv
xKqUwA/9GkgzayiigY18eBeVzu6Dt9HHCgJgi+mlbMw1gvjJGOjQzLr1BbEbmadm
4N7TybYz4QVX/c0BiOOW14W/NABFOhzse8GU+LztVIMZXn9JlWXDwrRjOyajTPt/
g0naudGYMDUAcPwdWHQ9beUVbBX44BlFXzp2OQ73pPJ+BuwMP6HsvMHnpnKDZxyt
qN7PuLPBCZdGjSXX6mdxgMQeWmMTyX1n9BCmknU970srLM1BVROvQti/jaWmqvWc
5xfo+JjHCDmelGaNS/DXeKXnaSM7uotgpNK++U0Ow590k2s/biwE7/22mDedB/mm
6FG7IFpUVSspKmudwfNMwSu8rJTXA/ww1fjvAt3NNTHO9VltNrxJkhFyOaEYCk9X
ADhG7DVfqm9onhY1Mn3JVXyXaa0gPFzz7xY/I+Zx2bR97VXYHXT3if7ckjUxuYXM
nPUGxC1LMzJp0e+qbhYo266T4R4w5N8hgR9U+NHR2Qen5ubDDOroQY/Pz93dpX8D
DULrqZAkVzLrr/sZBVA8y/NULkZ5njGKmq7NkSVEVPuygMwjDK02WuIciJjdgmrM
6XS6APVYnaoiGnuj0WHUUzIKtaX+BpgYF9X+3yO68S4kOxA4oR5Ai6DMA+JmJ4g3
y7pDjYRKZFJ8A+pTpX29n6+rzKXTt2i1gNgkjTuLTNf0tT1MlJo=
=FJ+O
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

