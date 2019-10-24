Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3B8CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B919D205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HknQc5dS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B919D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNThT-0001de-Us
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTN-0006bL-T3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTL-0002vF-Jg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:37 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40471)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTL-0002sz-5W; Wed, 23 Oct 2019 23:07:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxT1DpGz9sQv; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886445;
 bh=IR1XkB/Zx0zZvnPYRuaFUoE2c/FC/XUFoM+W5GWVE/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HknQc5dSQYw/SlDTUQmFuofP9ne01+JZHzchFfL+n3gdo2XW2qXplziei9mjUCXq6
 1IGa76npjv3Splsqj6AL1uV3u649sUmZSWR/ip9qJaMoitRNbK33f8UpGR55gmb1HC
 fmKikIHS6nxZcCI4imnZC/fTImW0nBXkJ3VQbI2I=
Date: Thu, 24 Oct 2019 14:07:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/6] qom: Add object_child_foreach_type() helper function
Message-ID: <20191024030715.GX6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184233616.3053790.246919545000657597.stgit@bahia.lan>
 <20191024025903.GU6439@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kUoBhQsr7LsiFken"
Content-Disposition: inline
In-Reply-To: <20191024025903.GU6439@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kUoBhQsr7LsiFken
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 01:59:03PM +1100, David Gibson wrote:
> On Wed, Oct 23, 2019 at 04:52:16PM +0200, Greg Kurz wrote:
> > Calling a function for children of a certain type is a recurring pattern
> > in the QEMU code base. In order to avoid the need to setup the same boi=
ler
> > plate again and again, introduce a variant of object_child_foreach() th=
at
> > only considers children of the given type.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Actually.. a couuple of caveats on that.

Reading it again the name is potentially misleading it's "for each
object of given type" not "for each type"  So maybe
"object_child_foreach_of_type()".

Also, having created these, using them to simplify hmp_info_irq() and
hmp_info_pic() seems like a good idea.

>=20
> > ---
> >  include/qom/object.h |   35 +++++++++++++++++++++++++++++++++++
> >  qom/object.c         |   30 +++++++++++++++++++++++-------
> >  2 files changed, 58 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 128d00c77fd6..e9e3c2eae8ed 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1728,6 +1728,41 @@ int object_child_foreach(Object *obj, int (*fn)(=
Object *child, void *opaque),
> >  int object_child_foreach_recursive(Object *obj,
> >                                     int (*fn)(Object *child, void *opaq=
ue),
> >                                     void *opaque);
> > +
> > +/**
> > + * object_child_foreach_type:
> > + * @obj: the object whose children will be navigated
> > + * @typename: the type of child objects to consider
> > + * @fn: the iterator function to be called
> > + * @opaque: an opaque value that will be passed to the iterator
> > + *
> > + * This is similar to object_child_foreach, but it only calls @fn for
> > + * child objects of the give @typename.
> > + *
> > + * Returns: The last value returned by @fn, or 0 if there is no child =
of
> > + * the given @typename.
> > + */
> > +int object_child_foreach_type(Object *obj, const char *typename,
> > +                              int (*fn)(Object *child, void *opaque),
> > +                              void *opaque);
> > +
> > +/**
> > + * object_child_foreach_recursive_type:
> > + * @obj: the object whose children will be navigated
> > + * @typename: the type of child objects to consider
> > + * @fn: the iterator function to be called
> > + * @opaque: an opaque value that will be passed to the iterator
> > + *
> > + * This is similar to object_child_foreach_recursive, but it only calls
> > + * @fn for child objects of the give @typename.
> > + *
> > + * Returns: The last value returned by @fn, or 0 if there is no child =
of
> > + * the given @typename.
> > + */
> > +int object_child_foreach_recursive_type(Object *obj, const char *typen=
ame,
> > +                                        int (*fn)(Object *child, void =
*opaque),
> > +                                        void *opaque);
> > +
> >  /**
> >   * container_get:
> >   * @root: root of the #path, e.g., object_get_root()
> > diff --git a/qom/object.c b/qom/object.c
> > index 6fa9c619fac4..a2dec1261ff7 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -986,7 +986,7 @@ void object_class_foreach(void (*fn)(ObjectClass *k=
lass, void *opaque),
> >      enumerating_types =3D false;
> >  }
> > =20
> > -static int do_object_child_foreach(Object *obj,
> > +static int do_object_child_foreach(Object *obj, const char *typename,
> >                                     int (*fn)(Object *child, void *opaq=
ue),
> >                                     void *opaque, bool recurse)
> >  {
> > @@ -999,12 +999,14 @@ static int do_object_child_foreach(Object *obj,
> >          if (object_property_is_child(prop)) {
> >              Object *child =3D prop->opaque;
> > =20
> > -            ret =3D fn(child, opaque);
> > -            if (ret !=3D 0) {
> > -                break;
> > +            if (!typename || object_dynamic_cast(child, typename)) {
> > +                ret =3D fn(child, opaque);
> > +                if (ret !=3D 0) {
> > +                    break;
> > +                }
> >              }
> >              if (recurse) {
> > -                do_object_child_foreach(child, fn, opaque, true);
> > +                do_object_child_foreach(child, typename, fn, opaque, t=
rue);
> >              }
> >          }
> >      }
> > @@ -1014,14 +1016,28 @@ static int do_object_child_foreach(Object *obj,
> >  int object_child_foreach(Object *obj, int (*fn)(Object *child, void *o=
paque),
> >                           void *opaque)
> >  {
> > -    return do_object_child_foreach(obj, fn, opaque, false);
> > +    return do_object_child_foreach(obj, NULL, fn, opaque, false);
> >  }
> > =20
> >  int object_child_foreach_recursive(Object *obj,
> >                                     int (*fn)(Object *child, void *opaq=
ue),
> >                                     void *opaque)
> >  {
> > -    return do_object_child_foreach(obj, fn, opaque, true);
> > +    return do_object_child_foreach(obj, NULL, fn, opaque, true);
> > +}
> > +
> > +int object_child_foreach_type(Object *obj, const char *typename,
> > +                              int (*fn)(Object *child, void *opaque),
> > +                              void *opaque)
> > +{
> > +    return do_object_child_foreach(obj, typename, fn, opaque, false);
> > +}
> > +
> > +int object_child_foreach_recursive_type(Object *obj, const char *typen=
ame,
> > +                                        int (*fn)(Object *child, void =
*opaque),
> > +                                        void *opaque)
> > +{
> > +    return do_object_child_foreach(obj, typename, fn, opaque, true);
> >  }
> > =20
> >  static void object_class_get_list_tramp(ObjectClass *klass, void *opaq=
ue)
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kUoBhQsr7LsiFken
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xFWMACgkQbDjKyiDZ
s5IydxAA2xP6mPE154/8R0yR4g9+mBmSsJeWAcu57i3zcp0Slj8hdBrVSW57Xmjs
e9HB4BsBwIal95C55LJFHCVKMzSaI2HvQMx5/RJtG8vFJflOq3nJmDbuulauiaAF
PlgvC8va1G3krxNK1od9gDKTlZx6XoqniBCF95bHeB4UO59TNfiQoId9kyAOYHLG
P3v97TQ87Hqvg4XF0MfE7wTT+bkUuU/uU1cYXq6G5SpjOZCmKMS88NvFOHjKjCrz
yt00AVtnqX0unhN+kNCQhB58+PzqLel51S+/hRklI3uFBUNolnokh62X5+N9gnBc
ELF5NGk1MJcf+mwh1GvrtmcMTbqeNHkAWf+flkMrjZNDEGcJGWD7ugld+yhxba3Y
QjiLtxjy+j10mz06DjuarG3CGkH3LbXVuYSUXejJVcCjxOG3xMZTBpK0OFI8yKO9
ZQIw7gYyRbW5IvJVtfVRWe+PCHWLFwymBbj2vsJphSbqaj5nLEIW4sAD83KrD5KV
Y4qhGVOFVI2LKIexdzfX2/fMVp1YBt2rJFcFXiahKCFz/E9/xlaoFxSqxb/eJB/W
stfJnMDeSafU7sFPD0goXqdSWAYNHfg/XSj25+sHBLn8cKXOxeUhfXDh2PREsXVT
MK12GjaRoa2okoH6OJoYg25pDk1npodg67l27ywC1KUf/KTsJM4=
=BnPa
-----END PGP SIGNATURE-----

--kUoBhQsr7LsiFken--

