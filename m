Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C6C31E45
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 02:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9514E205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 02:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iMl1/NlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9514E205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbc1u-0001C0-0g
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 22:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbzv-00008c-ON
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 22:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbzs-0000bb-WF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 22:31:23 -0400
Received: from ozlabs.org ([203.11.71.1]:50601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hbbzk-0000T6-Dy
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 22:31:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45Q4NT4K8nz9sDB; Fri, 14 Jun 2019 12:31:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560479465;
 bh=iCV1MFUefGBK5q+7kdSxgFqKzcV08wR59N4WxnxrJQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iMl1/NlGoNHmbhJadTUok2MmzSg9bSqMdmlwr9i4okDvVTktjrRNltfdZhRsuqweI
 Drdy7+QZEsdRcycX0mc6yCrj5bxRDBVbGVuqmYTjlO0iTdFncmVZ6Iyobm72T1c2Ih
 0dZ9O8ZEWhtYa6quRutImbdRiHipUWyPwC90IwWU=
Date: Fri, 14 Jun 2019 11:53:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190614015329.GE11158@umbus.fritz.box>
References: <20190613060728.26955-1-david@gibson.dropbear.id.au>
 <20190613060728.26955-3-david@gibson.dropbear.id.au>
 <617a8179-7dcc-7c51-1239-6e4893090d43@redhat.com>
 <20190614014056.GD11158@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <20190614014056.GD11158@umbus.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/acceptance: Handle ppc64le host
 arch correctly
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
Cc: arikalo@wavecomp.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 aurelien@aurel32.net, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 11:40:56AM +1000, David Gibson wrote:
> On Thu, Jun 13, 2019 at 11:01:19AM +0200, Philippe Mathieu-Daud=E9 wrote:
> > On 6/13/19 8:07 AM, David Gibson wrote:
> > > ppc64 and ppc64le are different archs from the host kernel point of v=
iew
> > > and are advertised as such in uname.  But these cover the same set of=
 CPUs,
> > > just in different endianness modes.  qemu-system-ppc64 handles both m=
odes,
> > > so make sure we select the correct binary when running on ppc64le host
> > > architecture.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  tests/acceptance/avocado_qemu/__init__.py | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accept=
ance/avocado_qemu/__init__.py
> > > index 2b236a1cf0..0ba9c536f4 100644
> > > --- a/tests/acceptance/avocado_qemu/__init__.py
> > > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > > @@ -39,6 +39,8 @@ def pick_default_qemu_bin(arch=3DNone):
> > >      """
> > >      if arch is None:
> > >          arch =3D os.uname()[4]
> > > +        if arch =3D=3D 'ppc64le':
> > > +            arch =3D 'ppc64'
> >=20
> > I prefer the generic patch from Cleber:
> > https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03418.html
> > (I guess remember another version with a json file)
>=20
> I hadn't seen that, that does indeed look better.

Hrm.  Well, it is better but it's been outstanding for like 8 months.
I'd just like to get this working on a ppc host in the near future.

>=20
> >=20
> > >      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
> > >                                            "qemu-system-%s" % arch)
> > >      if is_readable_executable_file(qemu_bin_relative_path):
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0C/hcACgkQbDjKyiDZ
s5LwABAA02V83Zs+LvWkmcJ2z9B0ZYjTNtfQyrk5fp01jXw2bH8PpaZT+DeIwuaK
g8yHLgt8n9L+5iuOQ/FcoibLRH6nJAmBma8TgGdC4J8hcFWNLSu5WJFHwxcB2Qug
repwXkAHZ59RsmvNupOFWIA/RAGbA81t9fLS43SeUEit5LrZCV55+RH3RogQdTb6
w9zSEBxh/wRP4qvZvzM0vIcFwX82XeDFO2oIeIGOw9kfY63apOtJS+NtF6ZzISKo
13L0J5Wipy6BpaTvybjQbScrzJjuxKKJgG01b2aFUjDcwCz718SbW3hwjYXLHaG7
ka+/F+Z8nzt5j0lDtMfo4iJX1etork9vVkMAN/mb9+yJgG64DUHiN/y2n2ZOQPyN
TA3odUpsHWXLQj4sRTCzctO0RawOAZZveP23tojBXFYsVJIisPfDr41OevKNMAH0
dKYIRr4viCPsZ5axomPMPClmLrLVC5t8aEcVjUYzoDYvL/q9Uwqv+R8fxDUZLeun
a0rPC/O5qq03lpcD81Ee4oj6UVaZB5YRzwg2xdoDGcxToC94gvHi5BIr3yOCR+eS
wb6UZAQKtfe6BeeW8G9WLjjl6IKGbfhLcMCuzrOIZo017basNARVRA95mCkkDCmq
ECOuAcEhKApVGKA94tRGcwEhumMO7sjdhXTKFtZHppIPoNMMAPY=
=xR7G
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--

