Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D27C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA7820673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA7820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnO3-0003n2-0n
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCmZE-0003uU-1w
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCmZB-0002yJ-0t
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:17:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50511)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iCmZA-0002y6-OL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:17:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95F1910C0949;
 Tue, 24 Sep 2019 15:17:23 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B2715D713;
 Tue, 24 Sep 2019 15:17:17 +0000 (UTC)
Subject: Re: [PATCH 06/25] qapi: Change frontend error messages to start with
 lower case
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-7-armbru@redhat.com>
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
Message-ID: <ab13d1b0-319c-1f57-de17-1718090f0e25@redhat.com>
Date: Tue, 24 Sep 2019 10:17:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924132830.15835-7-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f7t42RFnQ0kovlYmr60JHTJWmzPXC3Bv5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 24 Sep 2019 15:17:23 +0000 (UTC)
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
--f7t42RFnQ0kovlYmr60JHTJWmzPXC3Bv5
Content-Type: multipart/mixed; boundary="andyITz8RukCEKGyuXmttpnXhWStfXyhj";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <ab13d1b0-319c-1f57-de17-1718090f0e25@redhat.com>
Subject: Re: [PATCH 06/25] qapi: Change frontend error messages to start with
 lower case
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-7-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-7-armbru@redhat.com>

--andyITz8RukCEKGyuXmttpnXhWStfXyhj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 8:28 AM, Markus Armbruster wrote:
> Starting error messages with a capital letter complicates things when
> text can get interpolated both at the beginning and in the middle of
> an error message.  The next patch will do that.  Switch to lower case
> to keep it simpler.
>=20
> For what it's worth, the GNU Coding Standards advise the message
> "should not begin with a capital letter when it follows a program name
> and/or file name, because that isn=E2=80=99t the beginning of a sentenc=
e. (The
> sentence conceptually starts at the beginning of the line.)"

We're inconsistent throughout the code base, but this is one place where
I like the GCS rationale.  Fixing it everywhere may not be worth the
churn, but fixing it within the subset of the qapi generator is worthwhil=
e.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py                        | 175 +++++++++---------=

>  tests/qapi-schema/alternate-any.err           |   2 +-

>  tests/qapi-schema/unknown-expr-key.err        |   2 +-
>  125 files changed, 215 insertions(+), 204 deletions(-)
>  create mode 100644 tests/qapi-schema/escape-too-big.err
>  create mode 100644 tests/qapi-schema/string-control.err
>  create mode 100644 tests/qapi-schema/string-unclosed.err
>  create mode 100644 tests/qapi-schema/string-unicode.err

Umm, what's going on here?

You'll want to either drop these files (if they were leftovers in your
working directory from previous points in time), or defer their addition
to when the corresponding actual tests exist.

>      def get_doc(self, info):
>          if self.val !=3D '##':
> -            raise QAPIParseError(self, "Junk after '##' at start of "
> -                                 "documentation comment")
> +            raise QAPIParseError(
> +                self, "junk after '##' at start of documentation comme=
nt")

Reformatting like this also makes grepping for a particular message easie=
r.


> @@ -868,8 +869,8 @@ def check_union(expr, info):
>          enum_values =3D members.keys()
>          allow_metas =3D ['built-in', 'union', 'alternate', 'struct', '=
enum']
>          if base is not None:
> -            raise QAPISemError(info, "Simple union '%s' must not have =
a base" %
> -                               name)
> +            raise QAPISemError(
> +                info, "simple union '%s' must not have a base" % name)=

> =20

A bit odd that you reformat here to get the second argument all on one
line...

>      # Else, it's a flat union.
>      else:
> @@ -878,46 +879,47 @@ def check_union(expr, info):
>                     base, allow_dict=3Dname,
>                     allow_metas=3D['struct'])
>          if not base:
> -            raise QAPISemError(info, "Flat union '%s' must have a base=
"
> +            raise QAPISemError(info, "flat union '%s' must have a base=
"
>                                 % name)

=2E..but not here.  The reformatting is not the primary focus of the
patch, and doesn't hurt semantically whether or not you do it, but maybe
it is worth calling out in the commit message the criteria you used for
deciding when to reformat, and/or make the patch strive for more
consistency.  I'll leave that up to you; fixing the spurious new files,
and making your choice of where to place the linebreaks, doesn't affect
my ability to offer:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--andyITz8RukCEKGyuXmttpnXhWStfXyhj--

--f7t42RFnQ0kovlYmr60JHTJWmzPXC3Bv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KM30ACgkQp6FrSiUn
Q2qCkAf+K00zIkmYtRD1o6TORt9rtrTifgTvHJYJtznJyg8h+m+Affy8HNazXymH
azYp8sub+cKs0MmkDlg++c8pvEpq+vklwXpRdAMnRnxCvZllPmbTDPL6hwydQaDc
YPDMSpoowyle2iAmIlS/lPv4JODGdKjdd3u1wIVOhR3+AmuVZ7sBqsHn9gmPYAWJ
hKe/gEdJh0smHKUhin06NT2rtrzJctsVdg4wVx1UkpTUNrx2fmfxsvKWIHQInzso
9pYXT8meU8anJWUi2UetUY91nRnraKOcTiyfZ3qgjCG+VrmXqm+naU+2uoza7Izx
jiwNjOxYCx0+9QZYaeiVNuUSybPOHA==
=2V4d
-----END PGP SIGNATURE-----

--f7t42RFnQ0kovlYmr60JHTJWmzPXC3Bv5--

