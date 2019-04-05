Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CB6C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28313217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28313217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKpo-0003HD-4O
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:08:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hCKoC-0002Ft-KW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hCKoB-0005UR-GK
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1hCKoA-0005Q7-Sf
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:06:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DE3681F11;
	Fri,  5 Apr 2019 09:01:16 +0000 (UTC)
Received: from vader (ovpn-117-203.ams2.redhat.com [10.36.117.203])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2FDB6611D9;
	Fri,  5 Apr 2019 09:01:13 +0000 (UTC)
Date: Fri, 5 Apr 2019 11:01:13 +0200
From: Eduardo Otubo <otubo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190405090113.GC12104@vader>
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<20190403161729.GW25150@redhat.com>
	<CAFEAcA-85Z9wtZrf2AddGkrPZFOPgxFZ5sNOZCCBkqZRp8M2Dg@mail.gmail.com>
	<43102ef9-2f96-2863-00aa-b6f2906c2f4f@redhat.com>
	<20190404085621.GD10471@redhat.com>
	<20190404183923.GA22347@ls3530.dellerweb.de>
	<e4202c5d-1fab-a032-99ca-9d41f0611677@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <e4202c5d-1fab-a032-99ca-9d41f0611677@redhat.com>
User-Agent: Mutt/1.8.3+47 (5f034395e53d) (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 05 Apr 2019 09:01:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] configure: Relax check for libseccomp
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405090113.dWS4KjB5Qa8RHG6b8JZ-CGXEJDETG0gKXmJHHKE8OD4@z>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/04/2019 - 22:01:38, Thomas Huth wrote:
> On 04/04/2019 20.39, Helge Deller wrote:
> > All major distributions do support libseccomp version >=3D 2.3.0, so th=
ere
> > is no need to special-case on various architectures any longer.
> >=20
> > Signed-off-by: Helge Deller <deller@gmx.de>
> >=20
> > diff --git a/configure b/configure
> > index 1c563a7027..8fe4fc84d8 100755
> > --- a/configure
> > +++ b/configure
> > @@ -2377,36 +2369,16 @@ fi
> >  ##########################################
> >  # libseccomp check
> >=20
> > -libseccomp_minver=3D"2.2.0"
> >  if test "$seccomp" !=3D "no" ; then
> > -    case "$cpu" in
> > -    i386|x86_64|mips)
> > -        ;;
> > -    arm|aarch64)
> > -        libseccomp_minver=3D"2.2.3"
> > -        ;;
> > -    ppc|ppc64|s390x)
> > -        libseccomp_minver=3D"2.3.0"
> > -        ;;
> > -    *)
> > -        libseccomp_minver=3D""
> > -        ;;
> > -    esac
> > -
> > -    if test "$libseccomp_minver" !=3D "" &&
> > -       $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ;=
 then
> > +    libseccomp_minver=3D"2.3.0"
> > +    if $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ;=
 then
> >          seccomp_cflags=3D"$($pkg_config --cflags libseccomp)"
> >          seccomp_libs=3D"$($pkg_config --libs libseccomp)"
> >          seccomp=3D"yes"
> >      else
> >          if test "$seccomp" =3D "yes" ; then
> > -            if test "$libseccomp_minver" !=3D "" ; then
> > -                feature_not_found "libseccomp" \
> > -                    "Install libseccomp devel >=3D $libseccomp_minver"
> > -            else
> > -                feature_not_found "libseccomp" \
> > -                    "libseccomp is not supported for host cpu $cpu"
> > -            fi
> > +            feature_not_found "libseccomp" \
> > +                 "Install libseccomp devel >=3D $libseccomp_minver"
> >          fi
> >          seccomp=3D"no"
> >      fi
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Acked-by: Eduardo Otubo <otubo@redhat.com>

--=20
Eduardo Otubo

Red Hat GmbH,http://www.de.redhat.com/, Sitz: Grasbrunn,
Handelsregister: Amtsgericht M=C3=BCnchen, HRB 153243,
Gesch=C3=A4ftsf=C3=BChrer: Charles Cachera, Michael O'Neill, Tom Savage, Er=
ic Shander

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcpxlZAAoJEN8y58Dw//milUsIAK/hnqo4m9b57GJy5sIZULOI
iFcK3W45hDaua3oMQf7Xq109hwpYe+8kJWvqotRF6BWFSzLBOp3UOBI42Xv+L+eU
z/43HvHwldX3XlJcC77BnQs5nYQY6q+v61rgg/LDbdyMcdM+EEVLyIYqecUAl4wQ
mmnVd9sFpp6NUcXgDSJFn/+1uCbJkpRdS8vXNpZ5qDqwUd7756ofgoBgIRleBC8r
I6BZAFPNvRJ/ca0zxyjfitRkviFODaJSdForVTKX45z/ZjfyS0qRMZuIDWE6ES56
K6NwVG1FSeLSoxX7/2XOWL46uuRwH2giA2b5RCTChOHWSn9x2Fvzn9r1fLnzPww=
=hTZ0
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--

