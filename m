Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2DBC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F68221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOOrgqtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F68221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWvn-0001cD-0I
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWu6-0000aP-Gn
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWu4-0006ZD-Bw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600975659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Dl7cOrl2+k8iDj/Eud2y2Y0eMs5V0YlLFnSkld7g3U=;
 b=IOOrgqtLN9hcSsRo5gAb71XCnTK7HWxfzE4wK7Ti0aocHrhehQCP03YJPZhNrRxpzB6Rpk
 1GUi23Zq3fervcxoQ7TE737N7shyI0jFrUCilXLOmXSsGG/dY2diYG3j/JzeEeotLA8eaW
 sJdXirUqvZOmSKdNj4I430lD2yI4sR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-pO2lm9N2NN-RVQ-sqSnM2A-1; Thu, 24 Sep 2020 15:27:36 -0400
X-MC-Unique: pO2lm9N2NN-RVQ-sqSnM2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93A6881F006;
 Thu, 24 Sep 2020 19:27:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A34BA3782;
 Thu, 24 Sep 2020 19:27:34 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:27:32 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 05/38] qapi: Remove wildcard includes
Message-ID: <20200924192732.GC347036@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-6-jsnow@redhat.com>
 <20200923132735.GE191229@localhost.localdomain>
 <fcf633f4-c0f9-984b-ba84-acc14851ee72@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fcf633f4-c0f9-984b-ba84-acc14851ee72@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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

--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 01:21:37PM -0400, John Snow wrote:
> On 9/23/20 9:27 AM, Cleber Rosa wrote:
> > On Tue, Sep 22, 2020 at 05:00:28PM -0400, John Snow wrote:
> > > Wildcard includes become hard to manage when refactoring and dealing
> > > with circular dependencies with strictly typed mypy.
> > >=20
> > > flake8 also flags each one as a warning, as it is not smart enough to
> > > know which names exist in the imported file.
> > >=20
> > > Remove them and include things explicitly by name instead.
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi/commands.py   |  6 +++++-
> > >   scripts/qapi/events.py     |  7 ++++++-
> > >   scripts/qapi/gen.py        | 12 +++++++++---
> > >   scripts/qapi/introspect.py |  7 ++++++-
> > >   scripts/qapi/types.py      |  8 +++++++-
> > >   scripts/qapi/visit.py      | 10 +++++++++-
> > >   6 files changed, 42 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> > > index ce5926146a..e1df0e341f 100644
> > > --- a/scripts/qapi/commands.py
> > > +++ b/scripts/qapi/commands.py
> > > @@ -13,7 +13,11 @@
> > >   See the COPYING file in the top-level directory.
> > >   """
> > > -from .common import *
> > > +from .common import (
> > > +    build_params,
> > > +    c_name,
> > > +    mcgen,
> > > +)
> > >   from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
> >=20
> > Is this import style being suggested or enforced by any tool?  I've
> > been using isort with very good results (both as a check tool, and as
> > an emacs extension).  For instance, the block about would look like:
> >=20
> >     from .common import build_params, c_name, mcgen
> >     from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
> >=20
>=20
> Not enforced by any tool, no. Just subjective preference for git-friendly
> import lines. They conflict on rebase a lot less.
>=20
> I have been using emacs sort-lines to order the names in a group.
>=20
> > > diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> > > index 0467272438..6b3afa14d7 100644
> > > --- a/scripts/qapi/events.py
> > > +++ b/scripts/qapi/events.py
> > > @@ -12,7 +12,12 @@
> > >   See the COPYING file in the top-level directory.
> > >   """
> > > -from .common import *
> > > +from .common import (
> > > +    build_params,
> > > +    c_enum_const,
> > > +    c_name,
> > > +    mcgen,
> > > +)
> > >   from .gen import QAPISchemaModularCVisitor, ifcontext
> > >   from .schema import QAPISchemaEnumMember
> > >   from .types import gen_enum, gen_enum_lookup
> > > diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> > > index 8df19a0df0..11472ba043 100644
> > > --- a/scripts/qapi/gen.py
> > > +++ b/scripts/qapi/gen.py
> > > @@ -11,13 +11,19 @@
> > >   # This work is licensed under the terms of the GNU GPL, version 2.
> > >   # See the COPYING file in the top-level directory.
> > > -
> > > +from contextlib import contextmanager
> > >   import errno
> > >   import os
> > >   import re
> > > -from contextlib import contextmanager
> > > -from .common import *
> > > +from .common import (
> > > +    c_fname,
> > > +    gen_endif,
> > > +    gen_if,
> > > +    guardend,
> > > +    guardstart,
> > > +    mcgen,
> > > +)
> > >   from .schema import QAPISchemaVisitor
> > > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> > > index 2a34cd1e8e..b036fcf9ce 100644
> > > --- a/scripts/qapi/introspect.py
> > > +++ b/scripts/qapi/introspect.py
> > > @@ -10,7 +10,12 @@
> > >   See the COPYING file in the top-level directory.
> > >   """
> > > -from .common import *
> > > +from .common import (
> > > +    c_name,
> > > +    gen_endif,
> > > +    gen_if,
> > > +    mcgen,
> > > +)
> > >   from .gen import QAPISchemaMonolithicCVisitor
> > >   from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
> > >                        QAPISchemaType)
> > > diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> > > index ca9a5aacb3..53b47f9e58 100644
> > > --- a/scripts/qapi/types.py
> > > +++ b/scripts/qapi/types.py
> > > @@ -13,7 +13,13 @@
> > >   # See the COPYING file in the top-level directory.
> > >   """
> > > -from .common import *
> > > +from .common import (
> > > +    c_enum_const,
> > > +    c_name,
> > > +    gen_endif,
> > > +    gen_if,
> > > +    mcgen,
> > > +)
> > >   from .gen import QAPISchemaModularCVisitor, ifcontext
> > >   from .schema import QAPISchemaEnumMember, QAPISchemaObjectType
> > > diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> > > index 7850f6e848..ea277e7704 100644
> > > --- a/scripts/qapi/visit.py
> > > +++ b/scripts/qapi/visit.py
> > > @@ -13,7 +13,15 @@
> > >   See the COPYING file in the top-level directory.
> > >   """
> > > -from .common import *
> > > +from .common import (
> > > +    c_enum_const,
> > > +    c_name,
> > > +    gen_endif,
> > > +    gen_if,
> > > +    mcgen,
> > > +    pop_indent,
> > > +    push_indent,
> > > +)
> >=20
> > And here, isort will add the paranthesis (it does so based on space dem=
ands):
> >=20
> >     from .common import (c_enum_const, c_name, gen_endif, gen_if, mcgen=
,
> >                          pop_indent, push_indent)
> >     from .gen import QAPISchemaModularCVisitor, ifcontext
> >     from .schema import QAPISchemaObjectType
> >=20
> > Other than those suggestions, it LGTM.
> >=20
>=20
> OK. We can add a check that asserts that isort(file) =3D=3D file to keep =
our
> include regimes consistent. I'll look into the tool, but it will be after
> this marathon of a series.
>=20

That goes without saying!

> Here's a gitlab issue I made on my QEMU fork to help me keep track of
> Python-related issues that I intend to use:
> https://gitlab.com/jsnow/qemu/-/issues/6
>=20

Nice!

- Cleber.

> > Reviewed-by: Cleber Rosa <crosa@redhat.com>
> >=20
>=20
> Thanks!
>=20
> --js

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s8yQACgkQZX6NM6Xy
CfOBvRAAvH4XcMCA1Hb6Qgy50mgZjEkxVDJi+CXZVVDMx6IbPPpCK/1E653G+FWH
g4OgThAkd7jfM04Zf+BO2kmKVWiWNRQxpaP1y4uwHXniv4u84Rz3Y+dNyMoo7UW1
6PrnFBGdjapf37bA7uM6qOY9kavXDk7LmDkFNdv34GSpp+82LtnccFPDgxD0blc2
7Y9d2C3DazNze79gGH1JTQHA2wiQOKb7bpU1tjibOHMOM1kFARMBHhG3fOftHqOK
TjEA+02z3PHl+qkuqTOvdAubGEURmVRuI8Ev8IermfbGoHglKIg99Zrk4VWUS3vy
9dvQnJQeox98ERod/klva3aP5ZV1Gzam11JD2Yl6w6P5gcQslzFb4ClN+CVtZdY2
6YITpF8tHfP18vOFn/UVpFnMCmo+GmO1HkKmRED1K7guZty/ZKKqBdfVFXxIcAJZ
QPMep1rsUyQZzASqj20WYOzcfLpmZqdpo0jHYZl19RjKGq6WdaLaZKl1YB/sIlFW
ntC0OFU//Bva2gGYnZgG61RvUdQzn4VSxpnK8ICx0f31oyYfW13SWFbWHvXRUXN/
ABYjah1xD4li7BC2tc9TTBRlGTaQJg5oqmgklcvWs2HedinfdEQ0DFPJbA+aMxHU
JsT3F2tQT2oq2BrcSsP3imyjTTGCRBJlykl0IaAi1UlBVBWAjTM=
=T0AV
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--


