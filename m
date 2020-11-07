Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BFEC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0F420885
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRjTaeAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0F420885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbH3N-00006E-Ki
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 00:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbH2b-0007kb-Rf
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbH2Y-0006FI-KP
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604727928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nRpLKAXVVGQNYDxOX+V8MPgzhta2NuCg1AZBiUdKaXU=;
 b=GRjTaeAoMhAb25evJ+ux9OitNFjCPsBnDiYg8xWZzgCvRbUjqpDaS2t+bMCgUQDhviETBE
 984OAw8I9cN9nPXSk7RFAKQL7FBmTPjhUasYfBMJh4jrzfg/V0BF1713iciQxqfU/A2vDF
 fV9oYoCnCiPZf+bcC3HcQx+guyB+5Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-eTk8X9yiO1-RXmO8S3F-sw-1; Sat, 07 Nov 2020 00:45:26 -0500
X-MC-Unique: eTk8X9yiO1-RXmO8S3F-sw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBBDF1007464
 for <qemu-devel@nongnu.org>; Sat,  7 Nov 2020 05:45:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-47.rdu2.redhat.com
 [10.10.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BCDE1A4D8;
 Sat,  7 Nov 2020 05:45:24 +0000 (UTC)
Date: Sat, 7 Nov 2020 00:45:22 -0500
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 09/11] qapi/introspect.py: create a typed 'Annotated'
 data strutcure
Message-ID: <20201107054522.GE2208@localhost.localdomain>
References: <20201026194251.11075-1-jsnow@redhat.com>
 <20201026194251.11075-10-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-10-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
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

--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 03:42:49PM -0400, John Snow wrote:
> This replaces _make_tree with Annotated(). By creating it as a generic
> container, we can more accurately describe the exact nature of this
> particular value. i.e., each Annotated object is actually an
> Annotated<T>, describing its contained value.
>=20
> This adds stricter typing to Annotated nodes and extra annotated
> information. It also replaces a check of "isinstance tuple" with the
> much more explicit "isinstance Annotated" which is guaranteed not to
> break if a tuple is accidentally introduced into the type tree. (Perhaps
> as a result of a bad conversion from a list.)
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/introspect.py | 97 +++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 49 deletions(-)
>=20
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index a0978cb3adb..a261e402d69 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -13,12 +13,13 @@
>  from typing import (
>      Any,
>      Dict,
> +    Generic,
> +    Iterable,
>      List,
>      Optional,
>      Sequence,
> -    Tuple,
> +    TypeVar,
>      Union,
> -    cast,
>  )
> =20
>  from .common import (
> @@ -63,50 +64,48 @@
>  _scalar =3D Union[str, bool, None]
>  _nonscalar =3D Union[Dict[str, _stub], List[_stub]]
>  _value =3D Union[_scalar, _nonscalar]
> -TreeValue =3D Union[_value, 'Annotated']
> +TreeValue =3D Union[_value, 'Annotated[_value]']
> =20
>  # This is just an alias for an object in the structure described above:
>  _DObject =3D Dict[str, object]
> =20
> -# Represents the annotations themselves:
> -Annotations =3D Dict[str, object]
> =20
> -# Represents an annotated node (of some kind).
> -Annotated =3D Tuple[_value, Annotations]
> +_AnnoType =3D TypeVar('_AnnoType', bound=3DTreeValue)

Here it becomes much harder to keep the suggestions I made on patch
5 because of forward and backward references.

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+mNG0ACgkQZX6NM6Xy
CfOcOhAAkilNmqlMDV9SJ1jkeQ4F7C5ckUY6qYPJI5qYyWMj/QwXwDrprc/bVpmz
SL0VOiepg1rYRJy7ChH1xx9N1+RS9exMshgYx0QYxt4qfUYyt5hUc4gudgUTFs1t
Njs5gTouP36VajcuO2RBKjn8hJAfulcLH814dYtSwEAdvoQzTB/VUPFFsarBdrCo
tlLl6O3Oq2EKI7zbqjq6gwcx7hH373ucjIGI1OCz39SrIbcWW0xgdbMGjjBWYfx7
Xbugby/cOxttrTBju/znWP+ClmeFodxfvcwGpkUwr1XLp8ciKnnmFZazb/qtQ8VH
tAKEqbDeFRuJb80jdmkgdNSw/MvNJbcIK5AJ3MVsKa88YLzmha0IdP2MRLas4DfF
znDTamKF03yf8PFwF5fAjR2p5+N8M9ak/iwj+cE76guKY5panf/m546b813N0yBQ
5hJKQIVFpPapdapSKTiUWl9AZqcaFJjXs5DeL8mMICR0qnfmzfn8xVuB1fiPKsaR
Bb5ZrFyFs565CaFQLBV//IsrkqjZg0gg5l83HTpkBktAALP3bERT/u1kHAuhtkcW
Vz94ZkwJJYdPfjbs6zzmpWUQWrME6X4W+LdHRH9Wt+xazS4ds2IOzxX89iwqNn+T
svVCUAAkwTs+iRu0UP4DFstO74J0S+FyEPoo2tPjuGDrzyV5GIw=
=hX+0
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--


