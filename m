Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB11ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE6B205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE6B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZvl-0006fX-UH
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNZIJ-0006RI-Lw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNZIH-0000hx-Bw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:20:35 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:40404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNZIF-0000fu-Sm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:20:33 -0400
Received: from player792.ha.ovh.net (unknown [10.109.160.25])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id D014E145D3C
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:20:27 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id DD139B535424;
 Thu, 24 Oct 2019 09:20:22 +0000 (UTC)
Date: Thu, 24 Oct 2019 11:20:21 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/6] qom: Add object_child_foreach_type() helper function
Message-ID: <20191024112021.41c70e7c@bahia.lan>
In-Reply-To: <20191024030715.GX6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184233616.3053790.246919545000657597.stgit@bahia.lan>
 <20191024025903.GU6439@umbus.fritz.box>
 <20191024030715.GX6439@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H77nyE5qLY1xEuKeNR1vVOF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 7843863179972352486
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledugddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.219
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/H77nyE5qLY1xEuKeNR1vVOF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2019 14:07:15 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 24, 2019 at 01:59:03PM +1100, David Gibson wrote:
> > On Wed, Oct 23, 2019 at 04:52:16PM +0200, Greg Kurz wrote:
> > > Calling a function for children of a certain type is a recurring patt=
ern
> > > in the QEMU code base. In order to avoid the need to setup the same b=
oiler
> > > plate again and again, introduce a variant of object_child_foreach() =
that
> > > only considers children of the given type.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Actually.. a couuple of caveats on that.
>=20
> Reading it again the name is potentially misleading it's "for each
> object of given type" not "for each type"  So maybe
> "object_child_foreach_of_type()".
>=20

Makes sense.

> Also, having created these, using them to simplify hmp_info_irq() and
> hmp_info_pic() seems like a good idea.
>=20
> >=20
> > > ---
> > >  include/qom/object.h |   35 +++++++++++++++++++++++++++++++++++
> > >  qom/object.c         |   30 +++++++++++++++++++++++-------
> > >  2 files changed, 58 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/include/qom/object.h b/include/qom/object.h
> > > index 128d00c77fd6..e9e3c2eae8ed 100644
> > > --- a/include/qom/object.h
> > > +++ b/include/qom/object.h
> > > @@ -1728,6 +1728,41 @@ int object_child_foreach(Object *obj, int (*fn=
)(Object *child, void *opaque),
> > >  int object_child_foreach_recursive(Object *obj,
> > >                                     int (*fn)(Object *child, void *op=
aque),
> > >                                     void *opaque);
> > > +
> > > +/**
> > > + * object_child_foreach_type:
> > > + * @obj: the object whose children will be navigated
> > > + * @typename: the type of child objects to consider
> > > + * @fn: the iterator function to be called
> > > + * @opaque: an opaque value that will be passed to the iterator
> > > + *
> > > + * This is similar to object_child_foreach, but it only calls @fn for
> > > + * child objects of the give @typename.
> > > + *
> > > + * Returns: The last value returned by @fn, or 0 if there is no chil=
d of
> > > + * the given @typename.
> > > + */
> > > +int object_child_foreach_type(Object *obj, const char *typename,
> > > +                              int (*fn)(Object *child, void *opaque),
> > > +                              void *opaque);
> > > +
> > > +/**
> > > + * object_child_foreach_recursive_type:
> > > + * @obj: the object whose children will be navigated
> > > + * @typename: the type of child objects to consider
> > > + * @fn: the iterator function to be called
> > > + * @opaque: an opaque value that will be passed to the iterator
> > > + *
> > > + * This is similar to object_child_foreach_recursive, but it only ca=
lls
> > > + * @fn for child objects of the give @typename.
> > > + *
> > > + * Returns: The last value returned by @fn, or 0 if there is no chil=
d of
> > > + * the given @typename.
> > > + */
> > > +int object_child_foreach_recursive_type(Object *obj, const char *typ=
ename,
> > > +                                        int (*fn)(Object *child, voi=
d *opaque),
> > > +                                        void *opaque);
> > > +
> > >  /**
> > >   * container_get:
> > >   * @root: root of the #path, e.g., object_get_root()
> > > diff --git a/qom/object.c b/qom/object.c
> > > index 6fa9c619fac4..a2dec1261ff7 100644
> > > --- a/qom/object.c
> > > +++ b/qom/object.c
> > > @@ -986,7 +986,7 @@ void object_class_foreach(void (*fn)(ObjectClass =
*klass, void *opaque),
> > >      enumerating_types =3D false;
> > >  }
> > > =20
> > > -static int do_object_child_foreach(Object *obj,
> > > +static int do_object_child_foreach(Object *obj, const char *typename,
> > >                                     int (*fn)(Object *child, void *op=
aque),
> > >                                     void *opaque, bool recurse)
> > >  {
> > > @@ -999,12 +999,14 @@ static int do_object_child_foreach(Object *obj,
> > >          if (object_property_is_child(prop)) {
> > >              Object *child =3D prop->opaque;
> > > =20
> > > -            ret =3D fn(child, opaque);
> > > -            if (ret !=3D 0) {
> > > -                break;
> > > +            if (!typename || object_dynamic_cast(child, typename)) {
> > > +                ret =3D fn(child, opaque);
> > > +                if (ret !=3D 0) {
> > > +                    break;
> > > +                }
> > >              }
> > >              if (recurse) {
> > > -                do_object_child_foreach(child, fn, opaque, true);
> > > +                do_object_child_foreach(child, typename, fn, opaque,=
 true);
> > >              }
> > >          }
> > >      }
> > > @@ -1014,14 +1016,28 @@ static int do_object_child_foreach(Object *ob=
j,
> > >  int object_child_foreach(Object *obj, int (*fn)(Object *child, void =
*opaque),
> > >                           void *opaque)
> > >  {
> > > -    return do_object_child_foreach(obj, fn, opaque, false);
> > > +    return do_object_child_foreach(obj, NULL, fn, opaque, false);
> > >  }
> > > =20
> > >  int object_child_foreach_recursive(Object *obj,
> > >                                     int (*fn)(Object *child, void *op=
aque),
> > >                                     void *opaque)
> > >  {
> > > -    return do_object_child_foreach(obj, fn, opaque, true);
> > > +    return do_object_child_foreach(obj, NULL, fn, opaque, true);
> > > +}
> > > +
> > > +int object_child_foreach_type(Object *obj, const char *typename,
> > > +                              int (*fn)(Object *child, void *opaque),
> > > +                              void *opaque)
> > > +{
> > > +    return do_object_child_foreach(obj, typename, fn, opaque, false);
> > > +}
> > > +
> > > +int object_child_foreach_recursive_type(Object *obj, const char *typ=
ename,
> > > +                                        int (*fn)(Object *child, voi=
d *opaque),
> > > +                                        void *opaque)
> > > +{
> > > +    return do_object_child_foreach(obj, typename, fn, opaque, true);
> > >  }
> > > =20
> > >  static void object_class_get_list_tramp(ObjectClass *klass, void *op=
aque)
> > >=20
> >=20
>=20
>=20
>=20


--Sig_/H77nyE5qLY1xEuKeNR1vVOF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2xbNUACgkQcdTV5YIv
c9axxhAArHSYbUcIMNb1wX/J1yU1MLbnoxcREjI0vzjmnL+TvmEfLu8aWGSyfYkG
4KaorHT4+NFFhgzi0nSHXpJ1OHC9L/EMqeXD5OoksOsxhsSDDG518ufGODp/uHac
uDOpfwv5Rw1WXtpQC5AiZVBUBwD4VXTe+LIWgvTsiPHjqyDDpRCW0E5q/4AjxPqY
cJiPiVLrritBih5rBfxkjxUTForh0U2uRM5wYTD/hTsCFZzs7Uhi4qRKg5d00bFK
jxdtx/bjDp1hvpKK4oeNORAaMG0B+xDayftgR9MGhX1kMeXKpoaBBFcjU7mFhAMR
5xILNOCmJz+htpSGa/vGxH6Zy1dOew//cjErCnkvVF1rVVd53ByenZpP9LknUsf3
xkBPUbgi6yIIjTAVlKq+HSZJoqnQy1llJd5URCwthbh/tm5vAcWmjXjKA29XJDEC
ARwe4ZLWynTjf2DUI4P7fMONVJsOEOb+71xLVEyFY+GEo4UENMC/qKmaTM1dqb4Q
NccIk+8GY3Z5pwJ4EF5ni1XpI2fFKruydRTE0PnzsGBidrurfe8vyQJ7VY85+4ZT
QLXIaURHcamK9hso/NlZ0m3W2REmiyQbGF+avNaH3+CiuOjhuCaUHjWjm3pkjzqk
HfwGbdJk8//7y11Fw9oKU6VLqjPOQhRp8PA1WCTEg0c5F07W4Qk=
=uRcl
-----END PGP SIGNATURE-----

--Sig_/H77nyE5qLY1xEuKeNR1vVOF--

