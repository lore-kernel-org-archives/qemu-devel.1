Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE85DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6FF206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ic9ibppl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6FF206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAd3-0008CJ-Q1
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLAbN-0006km-8v
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLAbK-0000bb-FI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600889929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oHN4qr/EI5v6BwWX0TPbgbyElWcqIEG0f9KMb4nkxWo=;
 b=Ic9ibpplN0ttAc4JBqoTtEq7/Zr6M/V5qFLSmJqrw2ZAANXtADFQqqG++wj7TIzjDNx7KT
 LPN6joWrGZAn8tCjkvJ6rsnibtflc8pdn/3oJBMpMfrG0AVI1CmVyKhN6PkqnTPkXt6Uf+
 vYm5Z9m4HOpmahXQrS4jEuDd5tiQSWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-sZNoFKCLNaaKpy6uLfoHzQ-1; Wed, 23 Sep 2020 15:38:47 -0400
X-MC-Unique: sZNoFKCLNaaKpy6uLfoHzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68D181074652;
 Wed, 23 Sep 2020 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B0719728;
 Wed, 23 Sep 2020 19:38:44 +0000 (UTC)
Date: Wed, 23 Sep 2020 15:38:42 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 14/38] qapi/common.py: Convert comments into
 docstrings, and elaborate
Message-ID: <20200923193842.GN191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-15-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-15-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9v2bTOXBzuB5Piju"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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

--9v2bTOXBzuB5Piju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:37PM -0400, John Snow wrote:
> As docstrings, they'll show up in documentation and IDE help.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/common.py | 51 ++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 14 deletions(-)
>=20
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 0ce4a107e6..730283722a 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -20,10 +20,18 @@
>  _C_NAME_TRANS =3D str.maketrans('.-', '__')
> =20
> =20
> -# ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
> -# ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_N=
AME2
> -# ENUM24_Name -> ENUM24_NAME
>  def camel_to_upper(value: str) -> str:
> +    """
> +    Converts CamelCase to CAMEL_CASE.
> +
> +    Examples:
> +      ENUMName -> ENUM_NAME
> +      EnumName1 -> ENUM_NAME1
> +      ENUM_NAME -> ENUM_NAME
> +      ENUM_NAME1 -> ENUM_NAME1
> +      ENUM_Name2 -> ENUM_NAME2
> +      ENUM24_Name -> ENUM24_NAME
> +    """
>      c_fun_str =3D c_name(value, False)
>      if value.isupper():
>          return c_fun_str
> @@ -45,21 +53,33 @@ def camel_to_upper(value: str) -> str:
>  def c_enum_const(type_name: str,
>                   const_name: str,
>                   prefix: Optional[str] =3D None) -> str:
> +    """
> +    Generate a C enumeration constant name.
> +
> +    :param type_name: The name of the enumeration.
> +    :param const_name: The name of this constant.
> +    :param prefix: Optional, prefix that overrides the type_name.
> +    """
>      if prefix is not None:
>          type_name =3D prefix
>      return camel_to_upper(type_name) + '_' + c_name(const_name, False).u=
pper()
> =20
> =20
> -# Map @name to a valid C identifier.
> -# If @protect, avoid returning certain ticklish identifiers (like
> -# C keywords) by prepending 'q_'.
> -#
> -# Used for converting 'name' from a 'name':'type' qapi definition
> -# into a generated struct member, as well as converting type names
> -# into substrings of a generated C function name.
> -# '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
> -# protect=3DTrue: 'int' -> 'q_int'; protect=3DFalse: 'int' -> 'int'
>  def c_name(name: str, protect: bool =3D True) -> str:
> +    """
> +    Map `name` to a valid C identifier.
> +
> +    Used for converting 'name' from a 'name':'type' qapi definition
> +    into a generated struct member, as well as converting type names
> +    into substrings of a generated C function name.
> +
> +    '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
> +    protect=3DTrue: 'int' -> 'q_int'; protect=3DFalse: 'int' -> 'int'
> +
> +    :param name: The name to map.
> +    :param protect: If true, avoid returning certain ticklish identifier=
s
> +                    (like C keywords) by prepending ``q_``.
> +    """
>      # ANSI X3J11/88-090, 3.1.1
>      c89_words =3D set(['auto', 'break', 'case', 'char', 'const', 'contin=
ue',
>                       'default', 'do', 'double', 'else', 'enum', 'extern'=
,
> @@ -134,9 +154,12 @@ def decrease(self, amount: int =3D 4) -> int:
>  indent =3D Indentation()
> =20
> =20
> -# Generate @code with @kwds interpolated.
> -# Obey indent, and strip EATSPACE.
>  def cgen(code: str, **kwds: object) -> str:
> +    """
> +    Generate `code` with `kwds` interpolated.
> +
> +    Obey `indent`, and strip `EATSPACE`.
> +    """

This probably won't help on IDEs (never checked any), but sphinx will
let you do:

   """
   Generate `code` with `kwds` interpolated.

   Obey `indent`, and strip :data:`EATSPACE`.
   """

I'm not sure that a maximum level of docstring "sphinxzation" is the
goal here, though.

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--9v2bTOXBzuB5Piju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rpD0ACgkQZX6NM6Xy
CfOJzA//Ty5b0vdtEWgtaFq6chWs4oNvgxyDMdQ286MboOm2ev2kPSbGgoiKej/V
+WOfoSqRlqsP3/xM0oyuzMpt3RPc3DmgmLd/UfB1rde//i/MHiswi20EHp8RaNmi
pjsyxT3FyUd/NiQLacc4WXK79kS8l8qu+PpBv+yru+ysiXZ2vWnIIcHuEP1pExvA
L4U6kSqprsPEmA6mbItszU+7wv0v4Y31f9F3bw5d+weIyRF63ZkkXmz/TfLK9mBC
kRGtvl2k5ndFT2UDuhGWSCuAceePfFU/8N02ee7l0dPH9eM0J15PfcDsm5OFys+r
H8lNkxGSI+2Xy8HIGDxGGoRCZdVqyQcRJiBZUWpkVAkLwQc499YiphduNOsMbeQq
fp1wv8AmEbJd89qwKVY86afml0ouuCHQNWLQ7G6POwUeLoWPrTHZ/6n0BtV5ESQH
h11Foe9yktO/urBvwhE4Z4XqG1jZNzg4aPjJ5KFULjGK9sp1Wb5gFTRQlxkhUbci
qK94A0kS5HQiAB4n17HePb18fHq1EuJ7qvz37CJDXnjGP13ocLUil+Kk8gpZJe3j
NCWnFCHDIiUAIXqpIvahkv7HXIswJj59ilYxFPWZN1SsrZ7n90j/x7/Sv+QBd/x5
S2uyUf27C/7liHF+uAtAPZsBQFN2rSL93T8f+bbqUwdms1sJydI=
=NBVe
-----END PGP SIGNATURE-----

--9v2bTOXBzuB5Piju--


