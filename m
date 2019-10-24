Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140BCA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866EF205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OyM1gfo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866EF205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTc2-0001sR-Ag
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTN-0006Z5-14
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTL-0002ue-A4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:36 -0400
Received: from ozlabs.org ([203.11.71.1]:48425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTK-0002sX-U6; Wed, 23 Oct 2019 23:07:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxS6YsFz9sQm; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886444;
 bh=mFjpjq3AOw7ehGA9jrAOd3anUpJ7f6KEFzwF3lNbTU4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OyM1gfo8Pu30un1SYs78o1+L3CmsVG8zQQpVxq4TNQBcK3zchkBhZiliE8qLt3MRn
 3/13qMcPxnpHsECuLp04jpLMyQ/gGMerN6Zkh0pKWlPfyW5XNzMEms4rsirXq7X2Di
 7XvHqUMEXjO2/TKMmhc7exN9wEVkimh2MkT4SnFE=
Date: Thu, 24 Oct 2019 13:59:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/6] qom: Add object_child_foreach_type() helper function
Message-ID: <20191024025903.GU6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184233616.3053790.246919545000657597.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ma2pZxZcUUd0eybH"
Content-Disposition: inline
In-Reply-To: <157184233616.3053790.246919545000657597.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--Ma2pZxZcUUd0eybH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 04:52:16PM +0200, Greg Kurz wrote:
> Calling a function for children of a certain type is a recurring pattern
> in the QEMU code base. In order to avoid the need to setup the same boiler
> plate again and again, introduce a variant of object_child_foreach() that
> only considers children of the given type.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qom/object.h |   35 +++++++++++++++++++++++++++++++++++
>  qom/object.c         |   30 +++++++++++++++++++++++-------
>  2 files changed, 58 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 128d00c77fd6..e9e3c2eae8ed 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1728,6 +1728,41 @@ int object_child_foreach(Object *obj, int (*fn)(Ob=
ject *child, void *opaque),
>  int object_child_foreach_recursive(Object *obj,
>                                     int (*fn)(Object *child, void *opaque=
),
>                                     void *opaque);
> +
> +/**
> + * object_child_foreach_type:
> + * @obj: the object whose children will be navigated
> + * @typename: the type of child objects to consider
> + * @fn: the iterator function to be called
> + * @opaque: an opaque value that will be passed to the iterator
> + *
> + * This is similar to object_child_foreach, but it only calls @fn for
> + * child objects of the give @typename.
> + *
> + * Returns: The last value returned by @fn, or 0 if there is no child of
> + * the given @typename.
> + */
> +int object_child_foreach_type(Object *obj, const char *typename,
> +                              int (*fn)(Object *child, void *opaque),
> +                              void *opaque);
> +
> +/**
> + * object_child_foreach_recursive_type:
> + * @obj: the object whose children will be navigated
> + * @typename: the type of child objects to consider
> + * @fn: the iterator function to be called
> + * @opaque: an opaque value that will be passed to the iterator
> + *
> + * This is similar to object_child_foreach_recursive, but it only calls
> + * @fn for child objects of the give @typename.
> + *
> + * Returns: The last value returned by @fn, or 0 if there is no child of
> + * the given @typename.
> + */
> +int object_child_foreach_recursive_type(Object *obj, const char *typenam=
e,
> +                                        int (*fn)(Object *child, void *o=
paque),
> +                                        void *opaque);
> +
>  /**
>   * container_get:
>   * @root: root of the #path, e.g., object_get_root()
> diff --git a/qom/object.c b/qom/object.c
> index 6fa9c619fac4..a2dec1261ff7 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -986,7 +986,7 @@ void object_class_foreach(void (*fn)(ObjectClass *kla=
ss, void *opaque),
>      enumerating_types =3D false;
>  }
> =20
> -static int do_object_child_foreach(Object *obj,
> +static int do_object_child_foreach(Object *obj, const char *typename,
>                                     int (*fn)(Object *child, void *opaque=
),
>                                     void *opaque, bool recurse)
>  {
> @@ -999,12 +999,14 @@ static int do_object_child_foreach(Object *obj,
>          if (object_property_is_child(prop)) {
>              Object *child =3D prop->opaque;
> =20
> -            ret =3D fn(child, opaque);
> -            if (ret !=3D 0) {
> -                break;
> +            if (!typename || object_dynamic_cast(child, typename)) {
> +                ret =3D fn(child, opaque);
> +                if (ret !=3D 0) {
> +                    break;
> +                }
>              }
>              if (recurse) {
> -                do_object_child_foreach(child, fn, opaque, true);
> +                do_object_child_foreach(child, typename, fn, opaque, tru=
e);
>              }
>          }
>      }
> @@ -1014,14 +1016,28 @@ static int do_object_child_foreach(Object *obj,
>  int object_child_foreach(Object *obj, int (*fn)(Object *child, void *opa=
que),
>                           void *opaque)
>  {
> -    return do_object_child_foreach(obj, fn, opaque, false);
> +    return do_object_child_foreach(obj, NULL, fn, opaque, false);
>  }
> =20
>  int object_child_foreach_recursive(Object *obj,
>                                     int (*fn)(Object *child, void *opaque=
),
>                                     void *opaque)
>  {
> -    return do_object_child_foreach(obj, fn, opaque, true);
> +    return do_object_child_foreach(obj, NULL, fn, opaque, true);
> +}
> +
> +int object_child_foreach_type(Object *obj, const char *typename,
> +                              int (*fn)(Object *child, void *opaque),
> +                              void *opaque)
> +{
> +    return do_object_child_foreach(obj, typename, fn, opaque, false);
> +}
> +
> +int object_child_foreach_recursive_type(Object *obj, const char *typenam=
e,
> +                                        int (*fn)(Object *child, void *o=
paque),
> +                                        void *opaque)
> +{
> +    return do_object_child_foreach(obj, typename, fn, opaque, true);
>  }
> =20
>  static void object_class_get_list_tramp(ObjectClass *klass, void *opaque)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ma2pZxZcUUd0eybH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xE3cACgkQbDjKyiDZ
s5K+FxAA5xPTyaJybv7EevyMrX+Qv+eIwbh+z1XEWm6NNkhNqIqF1mVvvsidtdTw
ewa3xdKCa4TYocoLud9007gatF8W//IX1PP2nDeKnhDvpPRyJeIkmb8O9iCpjZqD
g4xds9AU7HECR5BaH3UtXMbqVlhL+nloiG6qi4W42hfkjhHNEixfTj08Zk0guk3b
z8fPi48JPiso8ygJX7bj9ZtBWd/6reMnPu1KmX1FdnDGUsFdE/T38vpP+H85WUtJ
Zj4WyDDzD4QByxDFTLDospEUa4k0qOKYD7hpn2SqP4SLbuSCVExsN5xRKECH1JoB
u1HlLJAAqW22s9j/+Pg1UbdG9NXo/7Xaw0S8bQuVmRS/RuT2WtdHvu7VTQA7GjxO
02OLXOxwlqoXtljraPt4bThQgdEI1byba/hLbv8gaOJIHA35kvHacC0Aq24ocM05
Rc328clrQtOVyGgaub19AwAIiAFKXHu0qrUWk5p+gW/Gq1LtKeA3nmCNH9F81I71
JJCkrlind57jqsRl0bYTEMQfZ1OnYiWn89UFVs61w7W17q5UB5paRHY0Z7X+Phhv
+hRcTWr390Y0qGQGZ7HZ7lC9O+jt/KFiJIu2cuD5SM5RY5mQq0O/uUKKwV/qfgXU
2dY/SbLUFwy/e8YmIt83VwFVD0t5YrQvyJDKKWAvpSxFNKAPtoI=
=WyKM
-----END PGP SIGNATURE-----

--Ma2pZxZcUUd0eybH--

