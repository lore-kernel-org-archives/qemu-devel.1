Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 02:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EC9221FA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 02:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7zDu5u+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EC9221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbDjQ-0006J2-5D
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 21:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbDiL-0005oC-Pt
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 21:12:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbDiI-0002ap-S9
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 21:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604715141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DiZ1gVas4086wJ3FwMyvQf5OJN+/LcKIRwPqFPY+4MA=;
 b=f7zDu5u+ZDOFmpsj38vbTz5pA/J+5ITn5yYl6MECCaIEHJKkeZsTYmTVN+G6iPzQj5Uhxg
 jAxq1Wvf0oRG6VgB0ZQjE3cjhl05BznFZYnDI7UWsztRqt75S2CNqHfN76vm3IWuGTeWw3
 Mpkf7WfWBPF9GPVOYFua148MnL9EFC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-c-lUhhs4NemLwFKnuhVLBg-1; Fri, 06 Nov 2020 21:12:19 -0500
X-MC-Unique: c-lUhhs4NemLwFKnuhVLBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2728A427F5
 for <qemu-devel@nongnu.org>; Sat,  7 Nov 2020 02:12:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-47.rdu2.redhat.com
 [10.10.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53D8C6EF70;
 Sat,  7 Nov 2020 02:12:17 +0000 (UTC)
Date: Fri, 6 Nov 2020 21:12:15 -0500
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 05/11] qapi/introspect.py: add preliminary type hint
 annotations
Message-ID: <20201107021142.GA2208@localhost.localdomain>
References: <20201026194251.11075-1-jsnow@redhat.com>
 <20201026194251.11075-6-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-6-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 03:42:45PM -0400, John Snow wrote:
> The typing of _make_tree and friends is a bit involved, but it can be
> done with some stubbed out types and a bit of elbow grease. The
> forthcoming patches attempt to make some simplifications, but having the
> type hints in advance may aid in review of subsequent patches.
>=20
>=20
> Some notes on the abstract types used at this point, and what they
> represent:
>=20
> - TreeValue represents any object in the type tree. _make_tree is an
>   optional call -- not every node in the final type tree will have been
>   passed to _make_tree, so this type encompasses not only what is passed
>   to _make_tree (dicts, strings) or returned from it (dicts, strings, a
>   2-tuple), but any recursive value for any of the dicts passed to
>   _make_tree -- which includes lists, strings, integers, null constants,
>   and so on.
>=20
> - _DObject is a type alias I use to mean "A JSON-style object,
>   represented as a Python dict." There is no "JSON" type in Python, they
>   are converted natively to recursively nested dicts and lists, with
>   leaf values of str, int, float, None, True/False and so on. This type
>   structure is not possible to accurately portray in mypy yet, so a
>   placeholder is used.
>=20
>   In this case, _DObject is being used to refer to SchemaInfo-like
>   structures as defined in qapi/introspect.json, OR any sub-object
>   values they may reference. We don't have strong typing available for
>   those, so a generic alternative is used.
>=20
> - Extra refers explicitly to the dict containing "extra" information
>   about a node in the tree. mypy does not offer per-key typing for dicts
>   in Python 3.6, so this is the best we can do here.
>=20
> - Annotated refers to (one of) the return types of _make_tree:
>   It represents a 2-tuple of (TreeValue, Extra).
>=20
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 157 ++++++++++++++++++++++++++++---------
>  scripts/qapi/mypy.ini      |   5 --
>  scripts/qapi/schema.py     |   2 +-
>  3 files changed, 121 insertions(+), 43 deletions(-)
>=20
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 63f721ebfb6..803288a64e7 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -10,7 +10,16 @@
>  See the COPYING file in the top-level directory.
>  """
> =20
> -from typing import Optional, Sequence, cast
> +from typing import (
> +    Any,
> +    Dict,
> +    List,
> +    Optional,
> +    Sequence,
> +    Tuple,
> +    Union,
> +    cast,
> +)
> =20
>  from .common import (
>      c_name,
> @@ -20,13 +29,56 @@
>  )
>  from .gen import QAPISchemaMonolithicCVisitor
>  from .schema import (
> +    QAPISchema,
>      QAPISchemaArrayType,
>      QAPISchemaBuiltinType,
> +    QAPISchemaEntity,
> +    QAPISchemaEnumMember,
> +    QAPISchemaFeature,
> +    QAPISchemaObjectType,
> +    QAPISchemaObjectTypeMember,
>      QAPISchemaType,
> +    QAPISchemaVariant,
> +    QAPISchemaVariants,
>  )
> +from .source import QAPISourceInfo
> =20
> =20
> -def _make_tree(obj, ifcond, features, extra=3DNone):
> +# This module constructs a tree-like data structure that is used to
> +# generate the introspection information for QEMU. It behaves similarly
> +# to a JSON value.
> +#
> +# A complexity over JSON is that our values may or may not be annotated.
> +#
> +# Un-annotated values may be:
> +#     Scalar: str, bool, None.
> +#     Non-scalar: List, Dict
> +# _Value =3D Union[str, bool, None, Dict[str, Value], List[Value]]

Here (and in a few other places) you mention `_Value`, but then define it a=
s
`_value` (lowercase).

> +#
> +# With optional annotations, the type of all values is:
> +# TreeValue =3D Union[_Value, Annotated[_Value]]
> +#
> +# Sadly, mypy does not support recursive types, so we must approximate t=
his.
> +_stub =3D Any
> +_scalar =3D Union[str, bool, None]
> +_nonscalar =3D Union[Dict[str, _stub], List[_stub]]

Why not use `Any` here instead of declaring/using `_stub`?

> +_value =3D Union[_scalar, _nonscalar]
> +TreeValue =3D Union[_value, 'Annotated']
> +

Maybe declare `Annotations` first, then `Annotated`, then *use*
`Annotated` proper here?

- Cleber.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+mAn8ACgkQZX6NM6Xy
CfMI6w//TnkLMBVenOCLNZXsySSZiZSnYV9oeCHItq9DexSEkaBRzic1ljUtZKV+
PuffTmZA8HTmYT4HeaoieNXoBJTT0Bku3fi3Ad7n68RgBhIy7d6vzxcOygWGNUwq
buQyGgm6Vtq3wH0ETzpe0VzLsfFDWUpWK+6IDyJXZSwF1FwRpSRDIwmOAQ/TL1eb
V3uIIChWamxdyds/t2xSrUt5zIiUhOQVxqjK1bLHeIeo+QN9sn8K5I4AP+PtQLna
Xqw/CQgnFgs1rMjUgY0uQvpxSfLEKQpNA4iLhbEfrpsaKYCRmDs54iGzuKBiER3j
b/R8TNlXOJy/sUziUvnXixG8OnnM7eCVbewckyGuZZ4tcln6d++Zmz2rjEVk1u71
rWm1P0+L9bkTGSW4dimToGol6zvi2kKNwZ9LvoNtxGClVtfEygkr29Ihst2vlf5A
sWdW+/Uu5EYOgYS4AMIXBo+6cFPS+tGWNGlYBKOSh385UPsm+gdaoz+eNi686+T+
NL3cs8aVmYgm2pBk+4srh7nBIheXAzwiSF5nDXbRoAw6vWCJgWeqtWfkWYaBCjJu
54ONWBz3C/HuN5sh8s1WkQt/yQ3yz/Ugi2muNoaWLJk7MX93rhKxpfJt8fSGDiwk
NjaK6NPzsnHNCyvJX6nfjAtZpQ65gMmwKDjoYl4zdG5OtOmV5XI=
=RIet
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--


