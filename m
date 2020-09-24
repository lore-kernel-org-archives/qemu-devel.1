Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A47AC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 23:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848582075F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 23:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux9kIbiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848582075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLb2w-00086x-9y
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 19:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLb28-0007hW-4J
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 19:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLb24-0004Ve-Qg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 19:52:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600991530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10jS/7Vy2njZo1HGDqR6VGuUPI4J0UkRssAK0rm8EGE=;
 b=Ux9kIbiLEF/AGBFzAfgyOQCV3EVACHoa4z5oqioAlYP9Q2ckXE6gvFcRrtwvX5ANiXii+M
 aY7GbXsIITrA1BtUt5RsLiY7Y00y3IMUULG36UiLmP0bEyXRrtOMPJ7g+eRsdSsBNlIWZM
 M/FKS6O0SlKlzy4j2+yyjNHYw14w+Cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-2gKYEkNWPBqDODh_f92EDA-1; Thu, 24 Sep 2020 19:52:06 -0400
X-MC-Unique: 2gKYEkNWPBqDODh_f92EDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 033F6344F3;
 Thu, 24 Sep 2020 23:52:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF1BB73684;
 Thu, 24 Sep 2020 23:52:03 +0000 (UTC)
Date: Thu, 24 Sep 2020 19:52:02 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 36/38] qapi/visit.py: assert tag_member contains a
 QAPISchemaEnumType
Message-ID: <20200924235202.GD347918@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-37-jsnow@redhat.com>
 <20200924191047.GH191229@localhost.localdomain>
 <3f37ab45-fd5b-ad8b-f033-d7887d1d6d93@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3f37ab45-fd5b-ad8b-f033-d7887d1d6d93@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
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

--LKTjZJSUETSlgu2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 03:36:23PM -0400, John Snow wrote:
> On 9/24/20 3:10 PM, Cleber Rosa wrote:
> > On Tue, Sep 22, 2020 at 05:00:59PM -0400, John Snow wrote:
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi/visit.py | 15 ++++++++++-----
> > >   1 file changed, 10 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> > > index 4edaee33e3..180c140180 100644
> > > --- a/scripts/qapi/visit.py
> > > +++ b/scripts/qapi/visit.py
> > > @@ -22,7 +22,10 @@
> > >       indent,
> > >   )
> > >   from .gen import QAPISchemaModularCVisitor, ifcontext
> > > -from .schema import QAPISchemaObjectType
> > > +from .schema import (
> > > +    QAPISchemaEnumType,
> > > +    QAPISchemaObjectType,
> > > +)
> > >   def gen_visit_decl(name, scalar=3DFalse):
> > > @@ -84,15 +87,17 @@ def gen_visit_object_members(name, base, members,=
 variants):
> > >           ret +=3D gen_endif(memb.ifcond)
> > >       if variants:
> > > +        tag_member =3D variants.tag_member
> > > +        assert isinstance(tag_member.type, QAPISchemaEnumType)
> > > +
> >=20
> > I'd be interested in knowing why this wasn't left to be handled by the
> > type checking only.  Anyway,
> >=20
>=20
> QAPISchemaVariants is a container type that is used to house a number of
> QAPISchemaVariant types; but it (can) also take a tag_member to identify =
one
> of the fields in the variants that can be used to differentiate them.
>=20
> Now, we assert that tag_member must be a QAPISchemaObjectTypeMember.
> QAPISchemaVariant is also a QAPISchemaObjectTypeMember.
>=20
> a QAPISchemaObjectTypeMember is a QAPISchemaMember. a QAPISchemaMember
> describes one 'member' of either an enum, a features list, or an object
> member.
>=20
> Now, the QAPISchemaObjectTypeMember (and not the QAPISchemaMember!) serve=
s
> as a container for a QAPISchemaType -- this is a wrapper type, effectivel=
y.
> That contained type can be *anything*, because object members can be
> *anything*.
>=20
> Oops, but if we zoom back out, we are only able to constrain tag_member t=
o
> being a QAPISchemaObjectTypeMember, we have no expressive power over its
> contained type.
>=20
> That's why you need the assertion here; because of a loss of specificity
> when we declare tag_member.
>=20
>=20
> "Wow, John, it sounds like you should use a Generic type to be able to
> describe the inner type of a QAPISchemaObjectTypeMember?"
>=20
> Uh, yup, you're right! I should. But it's complicated, because
> QAPISchemaMember does not have a contained type. Further, the contained t=
ype
> of a Member may or may not be known at construction time right now.
>=20
> It's fixable, and probably involves adding something like a "string
> constant" dummy type to allow QAPISchemaMember to have a contained type.
>=20
> "Hey, all of that sounds very messy. What if we just added in a few
> assertions for right now while we get the preliminary types in, and then =
we
> can make adjustments based on what makes the code prettier?"
>=20
> Sounds like a plan, hypothetical quote person.
>=20
> > Reviewed-by: Cleber Rosa <crosa@redhat.com>
> >=20

I did not attempt to learn the type names by heart (mental sanity
first) but I get the big picture.  Thanks!

- Cleber.

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tMR4ACgkQZX6NM6Xy
CfNb+xAAjSbtaRwEQjOa5/wdw7E7re5SF4JZQgCm6n8dpXBDZkiNJgBpFFaY0wTs
SUYpg4/Rjs/1N1OdsWXWaU1bJpVLleEoqyx7FbklZJLSPfNboGkzdUoVpBeG78WG
cLfyv9aD0WenSd7sK657u6+wHxO5NKfaOrwpKc3dbNwyv75V3nZENraJ+razXmhv
qVNNOdzv5eiW4rbrP/iK2fUD2ZjMrLfrruCwIwBHJKPKJH++2wkU/EnVKLZ79eyr
ieIT9vbzml0zZ/tFGWhiJLWjJAAnYgGYe3mXzVKvfnJjyyqsHOyg9onmSxw967um
kFluxl/I+E3BxoOl4QWR1y75oo2Qq38H00px7ENnal4CZGNKHix4w2mQl6L7fw6T
bp9aAHMWl1OFlzh/AtEt+4c2LDpBgnckiF1J8PG3fcHNHVktlQgN4LFQfPDBoJUW
QsesLtjYcD/FResJ8RwbUU6I1HlNhEnsv9zTvjPX7wW6ss+XUSzronpQvPa/oOXl
KQnaHX7MERCTqGmD+1NpI/h6Tb0v01IaZKfXEi8tkBciTfTn/fmpCtk+Fe67NL/8
WM459j+QY4zx2G2MRhdRIWYbUuiH73WeYgtr0Wy29NdfaTVOG2QNm1pptzyAl7/5
P/D5WC+5qNhLEPQ63Sud5PUmtht3jtINlp6cgjJXU6Z3PraQcw8=
=fRwy
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--


