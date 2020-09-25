Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2DF208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLJ3AKSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2DF208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLr8h-0005uG-8N
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLr77-0004VW-Sz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLr72-000408-96
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:02:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601053338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KVMnKPEPxuq0Y/y5gC7+Pu8jW6tAEz6TNQyBkS+wrdA=;
 b=WLJ3AKSPXVigJSb5jl8QubZAfq2SVSm635fQYsqlfDBjjIkWbdNfTfeBhyj5EFYjIew3eR
 znT3SPKQ3AvCBYrOr/ex0aXojo9TC/0NhWalR0HhpRO6E3ZnPSVkoPjEqF8gjQHAjkDf9U
 +3xQIW/PxWX2LBf2DFGiJQDrM0saiwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-HDMhVmrPPfyqiZcyAnV4Uw-1; Fri, 25 Sep 2020 13:02:15 -0400
X-MC-Unique: HDMhVmrPPfyqiZcyAnV4Uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7ED11084CA6;
 Fri, 25 Sep 2020 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A5F6198C;
 Fri, 25 Sep 2020 17:02:10 +0000 (UTC)
Date: Fri, 25 Sep 2020 13:02:09 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 14/38] qapi/common.py: Convert comments into
 docstrings, and elaborate
Message-ID: <20200925170209.GC402155@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-15-jsnow@redhat.com>
 <20200923193842.GN191229@localhost.localdomain>
 <24bfc59d-e97e-e5f1-7443-c625612575fb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <24bfc59d-e97e-e5f1-7443-c625612575fb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
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

--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 05:18:54PM -0400, John Snow wrote:
> On 9/23/20 3:38 PM, Cleber Rosa wrote:
> > On Tue, Sep 22, 2020 at 05:00:37PM -0400, John Snow wrote:
> > > As docstrings, they'll show up in documentation and IDE help.
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi/common.py | 51 ++++++++++++++++++++++++++++++---------=
---
> > >   1 file changed, 37 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > > index 0ce4a107e6..730283722a 100644
> > > --- a/scripts/qapi/common.py
> > > +++ b/scripts/qapi/common.py
> > > @@ -20,10 +20,18 @@
> > >   _C_NAME_TRANS =3D str.maketrans('.-', '__')
> > > -# ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
> > > -# ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> EN=
UM_NAME2
> > > -# ENUM24_Name -> ENUM24_NAME
> > >   def camel_to_upper(value: str) -> str:
> > > +    """
> > > +    Converts CamelCase to CAMEL_CASE.
> > > +
> > > +    Examples:
> > > +      ENUMName -> ENUM_NAME
> > > +      EnumName1 -> ENUM_NAME1
> > > +      ENUM_NAME -> ENUM_NAME
> > > +      ENUM_NAME1 -> ENUM_NAME1
> > > +      ENUM_Name2 -> ENUM_NAME2
> > > +      ENUM24_Name -> ENUM24_NAME
> > > +    """
> > >       c_fun_str =3D c_name(value, False)
> > >       if value.isupper():
> > >           return c_fun_str
> > > @@ -45,21 +53,33 @@ def camel_to_upper(value: str) -> str:
> > >   def c_enum_const(type_name: str,
> > >                    const_name: str,
> > >                    prefix: Optional[str] =3D None) -> str:
> > > +    """
> > > +    Generate a C enumeration constant name.
> > > +
> > > +    :param type_name: The name of the enumeration.
> > > +    :param const_name: The name of this constant.
> > > +    :param prefix: Optional, prefix that overrides the type_name.
> > > +    """
> > >       if prefix is not None:
> > >           type_name =3D prefix
> > >       return camel_to_upper(type_name) + '_' + c_name(const_name, Fal=
se).upper()
> > > -# Map @name to a valid C identifier.
> > > -# If @protect, avoid returning certain ticklish identifiers (like
> > > -# C keywords) by prepending 'q_'.
> > > -#
> > > -# Used for converting 'name' from a 'name':'type' qapi definition
> > > -# into a generated struct member, as well as converting type names
> > > -# into substrings of a generated C function name.
> > > -# '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
> > > -# protect=3DTrue: 'int' -> 'q_int'; protect=3DFalse: 'int' -> 'int'
> > >   def c_name(name: str, protect: bool =3D True) -> str:
> > > +    """
> > > +    Map `name` to a valid C identifier.
> > > +
> > > +    Used for converting 'name' from a 'name':'type' qapi definition
> > > +    into a generated struct member, as well as converting type names
> > > +    into substrings of a generated C function name.
> > > +
> > > +    '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
> > > +    protect=3DTrue: 'int' -> 'q_int'; protect=3DFalse: 'int' -> 'int=
'
> > > +
> > > +    :param name: The name to map.
> > > +    :param protect: If true, avoid returning certain ticklish identi=
fiers
> > > +                    (like C keywords) by prepending ``q_``.
> > > +    """
> > >       # ANSI X3J11/88-090, 3.1.1
> > >       c89_words =3D set(['auto', 'break', 'case', 'char', 'const', 'c=
ontinue',
> > >                        'default', 'do', 'double', 'else', 'enum', 'ex=
tern',
> > > @@ -134,9 +154,12 @@ def decrease(self, amount: int =3D 4) -> int:
> > >   indent =3D Indentation()
> > > -# Generate @code with @kwds interpolated.
> > > -# Obey indent, and strip EATSPACE.
> > >   def cgen(code: str, **kwds: object) -> str:
> > > +    """
> > > +    Generate `code` with `kwds` interpolated.
> > > +
> > > +    Obey `indent`, and strip `EATSPACE`.
> > > +    """
> >=20
> > This probably won't help on IDEs (never checked any), but sphinx will
> > let you do:
> >=20
> >     """
> >     Generate `code` with `kwds` interpolated.
> >=20
> >     Obey `indent`, and strip :data:`EATSPACE`.
> >     """
> >=20
> > I'm not sure that a maximum level of docstring "sphinxzation" is the
> > goal here, though.
> >=20
> > Reviewed-by: Cleber Rosa <crosa@redhat.com>
> >=20
>=20
> It isn't yet, but I intend to address that when I remove missing-docstrin=
g
> from pylint exemptions. Do I need :data: if I set the default role to 'an=
y'?
>

That's a good question.  According to the docs "any" will do its best,
so it's probably a good fallback.  I do still favor using the correct
role from the start if I can help it.

> I'll probably try to enable sphinx at that time (and put the docs in a
> devel/python manual?) and worry about the formatting at that point.
>=20
> --js

Nice!

- Cleber.

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9uIo4ACgkQZX6NM6Xy
CfOHrRAAiRiEQezya17eF9CG0+4RJ4YpAFbYtz2RuM14fH/t4iZr3qa4SF6wPaZD
XwzrhpR2bDf/eFZQTlWy+sCXd8pjSDpOWxs2FOIQT8pmckEcfJjDV941khiVgIBD
PeUfZohfOVFBBXhfebV+d50m6YsZmE3zj8WhZWY6BTJYxCXe8QrODKicVCPs5utI
d8VIxD0wmerWXByyaB5Yq+gFrTnAiJYqEXdcjvoyIzcMKcI21KMLGs0HuVKX/DkU
DlwQeIptKpyveVdpai2NJ0qwypF9ZUHn/7wWf/Ok0rJw3aZjbN/2srVEljuYir+n
3G1pegpAHsoOJ4nK9cqVKJeQi2k/9XXQ1IjkHasq6OabbJYdiFmKEjt/lBfgS/Rl
BUwZV0EK3TdoCF75EP4+VX2FH7I9/6G/k98bHZ54yAozyK8xk/gBhxi/McW06yLa
7UdFDXzhJQT5J0ZPBzOwH1C9Cy39kdmKgAFukfkCSJYNMM3WVImWGkptefVsTp13
j7ek9T4ZW11AVNAKt85+Aq0mB4Q7jv3GKTIhpUH3stixjqSLGPs2Ovh1n+nG60iE
35ltUMTraBEgPzCfttCuJDoEU8tKwxE559PaezhNXGwR1r2aHy8dL/eeeJHCkDTf
Qj4Jne8i4v+88yye8A7htWafxh4E13T7Fa69SuPsg98DD/1GvCI=
=DyUX
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--


