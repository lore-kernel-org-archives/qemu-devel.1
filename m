Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD48CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387CE20936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm+I3RGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387CE20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrBI-0008Dq-8A
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLrA7-0007GU-39
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLrA5-0004RG-Bo
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:05:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601053532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C97UnCLx5aUxsRuXxM65dhJeYEGCEFkEri4zjJzU9KI=;
 b=Qm+I3RGIyupsDmZZFS5EDxlSyJEx/YyywfZzCcN2Y3/J5hPWrYlQWrfAar/hNz59luUGkx
 Bn8RlYyB6S7lTAhYFpXdfAcCkRSfgCtcx1WOqoweMrwuZUgDyCdG5jogvOhxPzsP0WS0Xw
 S/KFzjLbIz99qBJ6LMdgAtvrhntIflM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Bb8vw72QNR2d5IXg7xtuCg-1; Fri, 25 Sep 2020 13:05:28 -0400
X-MC-Unique: Bb8vw72QNR2d5IXg7xtuCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F27C2188C129;
 Fri, 25 Sep 2020 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28FF75C1BB;
 Fri, 25 Sep 2020 17:05:26 +0000 (UTC)
Date: Fri, 25 Sep 2020 13:05:24 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 22/38] qapi/source.py: add type hint annotations
Message-ID: <20200925170524.GD402155@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-23-jsnow@redhat.com>
 <20200923223619.GV191229@localhost.localdomain>
 <0ace0c8d-0853-d078-d865-1453640b1c06@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0ace0c8d-0853-d078-d865-1453640b1c06@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 07:55:50PM -0400, John Snow wrote:
> On 9/23/20 6:36 PM, Cleber Rosa wrote:
> > On Tue, Sep 22, 2020 at 05:00:45PM -0400, John Snow wrote:
> > > Annotations do not change runtime behavior.
> > > This commit *only* adds annotations.
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi/mypy.ini  |  5 -----
> > >   scripts/qapi/source.py | 31 ++++++++++++++++++-------------
> > >   2 files changed, 18 insertions(+), 18 deletions(-)
> > >=20
> > > diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> > > index 9da1dccef4..43c8bd1973 100644
> > > --- a/scripts/qapi/mypy.ini
> > > +++ b/scripts/qapi/mypy.ini
> > > @@ -39,11 +39,6 @@ disallow_untyped_defs =3D False
> > >   disallow_incomplete_defs =3D False
> > >   check_untyped_defs =3D False
> > > -[mypy-qapi.source]
> > > -disallow_untyped_defs =3D False
> > > -disallow_incomplete_defs =3D False
> > > -check_untyped_defs =3D False
> > > -
> >=20
> > This is what I meant in my comment in the previous patch.  It looks
> > like a mix of commit grannurality styles.  Not a blocker though.
> >=20
>=20
> Yep. Just how the chips fell. Some files were just very quick to cleanup =
and
> I didn't have to refactor them much when I split things out, so the
> enablements got rolled in.
>=20
> I will, once reviews are in (and there is a commitment to merge), try to
> squash things where it seems appropriate.
>=20
> > >   [mypy-qapi.types]
> > >   disallow_untyped_defs =3D False
> > >   disallow_incomplete_defs =3D False
> > > diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
> > > index e97b9a8e15..1cc6a5b82d 100644
> > > --- a/scripts/qapi/source.py
> > > +++ b/scripts/qapi/source.py
> > > @@ -11,37 +11,42 @@
> > >   import copy
> > >   import sys
> > > +from typing import List, Optional, TypeVar
> > >   class QAPISchemaPragma:
> > > -    def __init__(self):
> > > +    def __init__(self) -> None:
> >=20
> > I don't follow the reason for typing this...
> >=20
> > >           # Are documentation comments required?
> > >           self.doc_required =3D False
> > >           # Whitelist of commands allowed to return a non-dictionary
> > > -        self.returns_whitelist =3D []
> > > +        self.returns_whitelist: List[str] =3D []
> > >           # Whitelist of entities allowed to violate case conventions
> > > -        self.name_case_whitelist =3D []
> > > +        self.name_case_whitelist: List[str] =3D []
> > >   class QAPISourceInfo:
> > > -    def __init__(self, fname, line, parent):
> > > +    T =3D TypeVar('T', bound=3D'QAPISourceInfo')
> > > +
> > > +    def __init__(self: T, fname: str, line: int, parent: Optional[T]=
):
> >=20
> > And not this... to tune my review approach, should I assume that this
> > series intends to add complete type hints or not?
> >=20
>=20
> This is a mypy quirk you've discovered that I've simply forgotten about.
>=20
> When __init__ has *no* arguments, you need to annotate its return to expl=
ain
> to mypy that you have fully typed that method. It's a sentinel that says
> "Please type check this class!"
>

Ouch.  Is this a permanent quirk or a known bug that will eventually
be addressed?

- Cleber.

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9uI1QACgkQZX6NM6Xy
CfPgKBAAu9LbF29lMCT6nicGBe2SmU8fihnrlbDz+W4sdIHoAYnqmF9JVMfdnWj3
A/Yq8Tlpj2B6To3Byx8NvCgVMiuFnETZqSS5152Fo7EPM6Ya/h5epffQYdTgrfhh
I7uyOFwtcqrxUeRN3AVaUVliUlBmVSotVa9MdETW90iOyzT/z3YKjhDgm2aIEsXB
tSIkzP6zGZBTNF5b3f3qPseR2Vm7GNJpuTEV4MTfWZyHzgMrthNnE9uXQZaZU21t
DtqNWIKpSTT85E4L3Yh+eAQjpvn+TzgS07ZHNEa1rk6tCcRlwYRtnsB4uOuQHa6k
HJZXV4x7JWOjs3X7Z316dtLIYI0zZbHfEhpp9V3dJCyMdEi23NvIVmfJqHfRW5cV
nJmiM++0aQmyYMiOxVogWxD0InWhsp8QDAzKdOJkP3xZcjQ209NXejSxG0iGAnEc
pWrdzkpyqoEe51pBJJnbWkdECVMHm7aHi7v+BPGpDIl2shMVVrgu3k0ltjE3UoSI
m78qJj0kCpZIu+lmCWRKbjv/gU6TjbtwCZEPy1qoh3cUc3LQWRPQ5owrCfJtTTAY
/J5zqVxThGFs4jLXnOdnK//vFDme1fZIvksrWI2WtpaH2aiIVMjiKzggF3y6oRMY
ksKxxbJEx3jmimG86x/N/jHNjw5doipb2czAKabqVqCr2Ne72O8=
=6i8y
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--


