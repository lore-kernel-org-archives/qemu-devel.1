Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE0DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D4420851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAn+u3pJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D4420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34183 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTm7b-0000Ep-Or
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:42:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTm3d-0005Oq-4Z
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTlo8-0004D7-7b
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:22:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hTlo7-0004CL-Uo
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:22:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id r7so5814176wrr.13
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Tq3odPWLK9RYc4u0GjIjKtTzgThCMFEJw2l4a77VbTI=;
	b=PAn+u3pJjB8eBHgmdpz0SC48ip0fkH9nLrckRVgVWB9uDY/cbj4R4st7v3TmripFXq
	lEAzPtUPHpbugBj4eIkXRmuF77/i7msQ4J9IET1N0QAOaSL42iar6gySU6b0cxQIcbor
	ZsDTFwQpfStdEtiVdCqrCHIl1gdNOfmNJFd6ciZpX20iGsfJMwDrnl7l9F7IZpU5phED
	tR+c0NKeQtsvGO83+cHLPeYK3umXomBqdwo4oPzgQ+TJ0kqv9pzWGldj58YCZKfQ6JwG
	0maJ29dCv1X4rVdb68ssXk8LJuKXckcYBXPKs10qfiF7nagB9RqQuKosvjLkVluz8E0T
	bBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Tq3odPWLK9RYc4u0GjIjKtTzgThCMFEJw2l4a77VbTI=;
	b=p6+yQKWmzChl5E5RSxRmQkrghjKmOTGqKfKU5RCOMPoM5BZN4ns1ynjYhxioPhvTUP
	qUHFyPDvSZBYy6ZNhi/QIJOggy55IDhDYZTWKWWBkg36X0nQN4VnIHVmEB2MJz+slu/B
	Geh5HoZ+5BbJ/v0mdAdZIWKQFoIY8dCcwXa0XlV2NvF6CxWMidIHFjQNEHNzAB7WvTqz
	bezEqwSYXo/qcJ30d1YvKEeI3W1Qcc4eihXbXNYX2CwkavCo1+eaA8eXv4YDI/75LD8a
	fxehebE4Ry/DqFcIlidCWML+2CWnrDQ4F4iYYC1t8oiqEBWN9OruJfJ9y3yXnFgrh/rY
	4rNQ==
X-Gm-Message-State: APjAAAVOaz217xWnCyqs8dECfg4sF4eo2HecVhZipU5h6cGKclHb6TSR
	0nfXH1o+4zek4SltPLeLAlQ=
X-Google-Smtp-Source: APXvYqw8R9kgXgL4AAHld3fM9OrT466PwzeTevo8snD/6rqEDccZNcVslbKsUAAR5u7Zfe7mGLV68A==
X-Received: by 2002:adf:fc8f:: with SMTP id g15mr6094047wrr.122.1558610566600; 
	Thu, 23 May 2019 04:22:46 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	u15sm52825115wru.16.2019.05.23.04.22.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 04:22:45 -0700 (PDT)
Date: Thu, 23 May 2019 12:22:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Message-ID: <20190523112244.GG26632@stefanha-x1.localdomain>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190311102006.GK12393@redhat.com>
	<20190507210059.GA26233@heatpipe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <20190507210059.GA26233@heatpipe>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
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
Cc: John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	konrad.wilk@oracle.com, qemu-devel@nongnu.org,
	ross.lagerwall@citrix.com, liran.alon@oracle.com,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jag Raman <jag.raman@oracle.com>, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 02:00:59PM -0700, Elena Ufimtseva wrote:
> On Mon, Mar 11, 2019 at 10:20:06AM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Mar 07, 2019 at 03:29:41PM -0800, John G Johnson wrote:
> > >=20
> > >=20
>=20
> Hi Daniel, Stefan
>=20
> We have not replied in a while as we were trying to figure out
> the best approach after multiple comments we have received on the
> patch series.
>=20
> Leaving other concerns that you, Stefan and others shared with us
> out of this particular topic, we would like to get your opinion on
> the following approach.
>=20
> Please see below.
>=20
> > > > On Mar 7, 2019, at 11:27 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
> > > >=20
> > > > On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrang=C3=A9 w=
rote:
> > > >> I guess one obvious answer is that the existing security mechanism=
s like
> > > >> SELinux/ApArmor/DAC can be made to work in a more fine grained man=
ner if
> > > >> there are distinct processes. This would allow for a more useful s=
eccomp
> > > >> filter to better protect against secondary kernel exploits should =
QEMU
> > > >> itself be exploited, if we can protect individual components.
> > > >=20
> > > > Fine-grained sandboxing is possible in theory but tedious in practi=
ce.
> > > > From what I can tell this patch series doesn't implement any sandbo=
xing
> > > > for child processes.
> > > >=20
> > >=20
> > > 	The policies aren=E2=80=99t in QEMU, but in the selinux config files.
> > > They would say, for example, that when the QEMU process exec()s the
> > > disk emulation process, the process security context type transitions
> > > to a new type.  This type would have permission to access the VM image
> > > objects, whereas the QEMU process type (and any other device emulation
> > > process types) cannot access them.
> >=20
> > Note that currently all QEMU instances run by libvirt have seccomp
> > policy applied that explicitly forbids any use of fork+exec as a way
> > to reduce avenues of attack for an exploited QEMU.
> >=20
> > Even in a modularized QEMU I'd be loathe to allow QEMU to have the
> > fork+exec privileged, unless "QEMU" in this case was just a stub
> > process that does nothing more than fork+exec the other binaries,
> > while having zero attack exposed to the untrusted guest OS.
>=20
> We see libvirt uses QEMU=E2=80=99s -sandbox option to indicate that QEMU
> should use seccomp() to prohibit future use of certain system calls,
> including fork() and exec().  Our idea is to enumerate the remote
> processes needed via QEMU command line options, and have QEMU exec()
> those processes before -sandbox is processed.
> And we also will init seccomp for emulated devices processes.

Sounds good.

My experience with seccomp is that whitelisting syscalls is fragile
because of library dependencies.  Even glibc might invoke syscalls you
didn't expect, especially after a kernel/glibc upgrade, forcing you to
modify the whitelist.

However, once a whitelist is successfully in place it's a simple way to
reduce the syscall attack surface and I think it's worthwhile.

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzmgoQACgkQnKSrs4Gr
c8gREQgAi6jR0M7TWcF5CL2aqJe8fH5k8s5I92fpS4z/QpXhPe1RUyaIIxQvEMYy
3IaRBVxDHQ720WCzZdq0nkExQ/0rbsCe4hcWY0g1LUtp9TqwoV+GPK8eR1EvhCKc
kSlhNoz9yEWW4BaCpUtAQsWM929X6kMhv+/hXBcAvfHfrqvwmsBpdU8EOtvdinZV
+A9bXsgd04VV/7CZ77S3oCaupwgIhiAIEGhhhHG3twHFA374yTrV9X6liTR+vHZa
4Wa1HLQx9MKm1s4xQK1qhQfGcz1xMg8rRvKGDMAV8P00s08lCcYwFEYWH5ewM6MN
f4eWzjmEiM75NVlHTwtea/m9JOUJCw==
=gb43
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--

