Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3ECC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321FF20673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321FF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnKZ-0008Qe-7q
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCmPh-0002bU-5D
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCmPf-0006HL-MO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:07:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iCmPf-0006H0-Ci
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:07:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B03C2898115;
 Tue, 24 Sep 2019 15:07:34 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42358608C0;
 Tue, 24 Sep 2019 15:07:18 +0000 (UTC)
Subject: Re: [PATCH 05/25] qapi: Clean up member name case checking
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <67f5d0d5-b78e-b126-6fe5-4078ceed6f23@redhat.com>
Date: Tue, 24 Sep 2019 10:07:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924132830.15835-6-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jUdmxgYwL1D6PyxbQcpYOqXhvl9WKzt0W"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 24 Sep 2019 15:07:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jUdmxgYwL1D6PyxbQcpYOqXhvl9WKzt0W
Content-Type: multipart/mixed; boundary="67RD5h14iQO8hFrbXw75WqZBrolKZfB7s";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <67f5d0d5-b78e-b126-6fe5-4078ceed6f23@redhat.com>
Subject: Re: [PATCH 05/25] qapi: Clean up member name case checking
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-6-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-6-armbru@redhat.com>

--67RD5h14iQO8hFrbXw75WqZBrolKZfB7s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 8:28 AM, Markus Armbruster wrote:
> QAPISchemaMember.check_clash() checks for member names that map to the
> same c_name().  Takes care of rejecting duplicate names.
>=20
> It also checks a naming rule: no uppercase in member names.  That's a
> rather odd place to do it.  Enforcing naming rules is
> check_name_str()'s job.
>=20
> qapi-code-gen.txt specifies the name case rule applies to the name as
> it appears in the schema.  check_clash() checks c_name(name) instead.
> No difference, as c_name() leaves alone case, but unclean.
>=20
> Move the name case check into check_name_str(), less the c_name().
> New argument @permit_upper suppresses it.  Pass permit_upper=3DTrue for=

> definitions (which are not members), and when the member's owner is
> whitelisted with pragma name-case-whitelist.
>=20
> Bonus: name-case-whitelist now applies to a union's inline base, too.
> Update qapi/qapi-schema.json pragma to whitelist union CpuInfo instead
> of CpuInfo's implicit base type's name q_obj_CpuInfo-base.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/qapi/qapi-schema.json
> @@ -71,7 +71,7 @@
>          'QapiErrorClass',           # all members, visible through err=
ors
>          'UuidInfo',                 # UUID, visible through query-uuid=

>          'X86CPURegister32',         # all members, visible indirectly =
through qom-get
> -        'q_obj_CpuInfo-base'        # CPU, visible through query-cpu
> +        'CpuInfo'                   # CPU, visible through query-cpu

Yes, much nicer.

>      ] } }
> =20
>  # Documentation generated with qapi-gen.py is in source order, with
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index f0e7d5ad34..ed4bff4479 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -704,8 +704,8 @@ valid_name =3D re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
>                          '[a-zA-Z][a-zA-Z0-9_-]*$')
> =20
> =20
> -def check_name(info, source, name, allow_optional=3DFalse,
> -               enum_member=3DFalse):
> +def check_name(info, source, name,
> +               allow_optional=3DFalse, enum_member=3DFalse, permit_upp=
er=3DFalse):
>      global valid_name
>      membername =3D name
> =20
> @@ -725,11 +725,14 @@ def check_name(info, source, name, allow_optional=
=3DFalse,
>      if not valid_name.match(membername) or \
>         c_name(membername, False).startswith('q_'):
>          raise QAPISemError(info, "%s uses invalid name '%s'" % (source=
, name))
> +    if not permit_upper and name.lower() !=3D name:
> +        raise QAPISemError(
> +            info, "%s uses uppercase in name '%s'" % (source, name))
> =20
> =20
>  def add_name(name, info, meta):
>      global all_names
> -    check_name(info, "'%s'" % meta, name)
> +    check_name(info, "'%s'" % meta, name, permit_upper=3DTrue)
>      # FIXME should reject names that differ only in '_' vs. '.'
>      # vs. '-', because they're liable to clash in generated C.
>      if name in all_names:
> @@ -797,10 +800,12 @@ def check_type(info, source, value,
>          raise QAPISemError(info,
>                             "%s should be an object or type name" % sou=
rce)
> =20
> +    permit_upper =3D allow_dict in name_case_whitelist
> +

so allow_dict changes from a bool to a string to be looked up...

>      # value is a dictionary, check that each member is okay
>      for (key, arg) in value.items():
>          check_name(info, "Member of %s" % source, key,
> -                   allow_optional=3DTrue)
> +                   allow_optional=3DTrue, permit_upper=3Dpermit_upper)=

>          if c_name(key, False) =3D=3D 'u' or c_name(key, False).startsw=
ith('has_'):
>              raise QAPISemError(info, "Member of %s uses reserved name =
'%s'"
>                                 % (source, key))
> @@ -870,7 +875,7 @@ def check_union(expr, info):
>      else:
>          # The object must have a string or dictionary 'base'.
>          check_type(info, "'base' for union '%s'" % name,
> -                   base, allow_dict=3DTrue,
> +                   base, allow_dict=3Dname,

=2E..and this is an example client affected by the change.  That threw me=

for a bit, but seems to work.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--67RD5h14iQO8hFrbXw75WqZBrolKZfB7s--

--jUdmxgYwL1D6PyxbQcpYOqXhvl9WKzt0W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KMSUACgkQp6FrSiUn
Q2rSmAf/YdkoBNcvlWIe2euJa5Fbtaia7FH91LxANrsYOBWp5A+I4B+IUalXdQLw
0G9E/yUWd3MjnBrEsJsEn8vyF9n++XFaSqYtxfQlrlr4R/C9a+Vf9ieoAW6Gcmy9
I2CLuu2JUINrqTpWBcb/JgAKk8i0NdonEpudD219opbIKwGIOsCoJWdxFnGA6vmW
h5iAQ2uM0pkmiJ0IN+vuc+cf85UCoozCsH/ONwJ8UfPCF2yxL5IiKKrCF5alIdG6
3VUe8MA9pQqV39wqT39uoKSzCUBDdT5nAgxPkhke8DUIbmZgjPdG6Z6ZsnszF+aU
R6K8OUAPLI5aorJjpt70n4CS9IurXQ==
=v+Z+
-----END PGP SIGNATURE-----

--jUdmxgYwL1D6PyxbQcpYOqXhvl9WKzt0W--

