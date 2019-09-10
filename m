Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA3DC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291B32082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291B32082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7k6d-0000Yr-5Y
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 13:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i7k5U-00085c-Uq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i7k5R-0003gL-Q6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:37:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i7k5R-0003ed-Gj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:37:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82F1E2A09C6;
 Tue, 10 Sep 2019 17:37:51 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F7A15D6B2;
 Tue, 10 Sep 2019 17:37:44 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-16-armbru@redhat.com>
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
Message-ID: <1b10e16d-9377-38ae-08ce-3bc0f8fc39d2@redhat.com>
Date: Tue, 10 Sep 2019 12:37:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910063724.28470-16-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JXWc3edGg6GBw2kqmOmBGQBdbxLF2co4j"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 10 Sep 2019 17:37:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 15/16] docs/devel/qapi-code-gen: Improve
 QAPI schema language doc
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
--JXWc3edGg6GBw2kqmOmBGQBdbxLF2co4j
Content-Type: multipart/mixed; boundary="oYFRfUklii6c0fiSsJU2BU6YWGg7Lpkxp";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <1b10e16d-9377-38ae-08ce-3bc0f8fc39d2@redhat.com>
Subject: Re: [PATCH v2 15/16] docs/devel/qapi-code-gen: Improve QAPI schema
 language doc
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-16-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-16-armbru@redhat.com>

--oYFRfUklii6c0fiSsJU2BU6YWGg7Lpkxp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/10/19 1:37 AM, Markus Armbruster wrote:
> We document the language by giving patterns of valid JSON objects.
> The patterns contain placeholders we don't define anywhere; their
> names have to speak for themselves.  I guess they do, but I'd prefer a
> bit more rigor.  Provide a grammar instead, and rework the text
> accordingly.
>=20
> Documentation for QAPI schema conditionals (commit 967c885108,
> 6cc32b0e14, 87adbbffd4..3e270dcacc) and feature flags (commit
> 6a8c0b5102) was bolted on.  The sections documenting types, commands
> and events don't mention them.  Section "Features" and "Configuring
> the schema" then provide additional syntax for types, commands and
> events.  I hate that.  Fix the sections documenting types, commands
> and events to provide accurate syntax, and point to "Features" and
> "Configuring the schema" for details.
>=20
> We talk about "(top-level) expressions other than include and pragma".
> Adopt more convenient terminology: a (top-level) expression is either
> a directive (include or pragma) or a definition (anything else).
>=20
> Avoid the terms "dictionary" and "key".  Stick to JSON terminology
> "object" and "member name" instead.
>=20
> While there, make spacing more consistent.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 592 ++++++++++++++++++++++-------------=

>  1 file changed, 369 insertions(+), 223 deletions(-)

> =20
> -The order of keys within JSON objects does not matter unless
> +* Production rules look like non-terminal =3D expression
> +* Concatenation: Expression A B matches expression A, then B
> +* Alternation: Expression A | B matches expression A or B
> +* Repetition: Expression A... matches zero or more occurences of

occurrences

> +  expression A; expression A, ... likewise, but separated by ,

worth calling out that trailing , are not allowed?

Is the 'expression A;' a copy-paste from RFC text, irrelevant to our
usage here?

> +* Grouping: Expression ( A ) matches expression A
> +* JSON's structural characters are terminals: { } [ ] : ,
> +* JSON's literal names are terminals: false true null
> +* String literals enclosed in 'single quotes' are terminal, and match
> +  this JSON string, with a leading '*' stripped off
> +* When JSON object member's name starts with '*', the member is
> +  optional.
> +* The symbol STRING is a terminal, and matches any JSON string
> +* The symbol BOOL is a terminal, and matches JSON false or true
> +* ALL-CAPS words other than STRING are non-terminals
> +
> +The order of members within JSON objects does not matter unless
>  explicitly noted.
> =20

> +A QAPI schema consists of a series of top-level expressions:
> +
> +    SCHEMA =3D TOP-LEVEL-EXPR...
> +
> +The top-level expressions are all JSON objects.  Their order does not
> +matter.

Is that always true for all directives?

Would it be worth reformulating as something like:

SCHEMA =3D DIRECTIVE... DEFINITION...

allowing zero-or-more of either, but where directives come first?

> +
> +A top-level expressions is either a directive or a definition:
> +
> +    TOP-LEVEL-EXPR =3D DIRECTIVE | DEFINITION
> +
> +There are two kinds of directives and six kinds of definitions:
> +
> +    DIRECTIVE =3D INCLUDE | PRAGMA
> +    DEFINITION =3D ENUM | STRUCT | UNION | ALTERNATE | COMMAND | EVENT=

> +
> +These are discussed in detail below.
> =20
> =20

>  =3D=3D=3D Pragma directives =3D=3D=3D
> =20
> -Usage: { 'pragma': DICT }
> +Syntax:
> +    PRAGMA =3D { 'pragma': { '*doc-required': BOOL },
> +                           '*returns-whitelist': [ STRING, ... ],
> +                           '*name-case-whitelist': [ STRING, ... ] }

This has matched {}, but looks wrong.  I think you meant

PRAGMA =3D { 'pragma': { '*doc-required': BOOL,
                       '*returns-whitelist': [ STRING, ... ],
                       '*name-case-whitelist': [ STRING, ... ] } }

>  =3D=3D=3D Enumeration types =3D=3D=3D
> =20
> -Usage: { 'enum': STRING, 'data': ARRAY-OF-STRING }
> -       { 'enum': STRING, '*prefix': STRING, 'data': ARRAY-OF-STRING }
> +Syntax:
> +    ENUM =3D { 'enum': STRING,
> +             'data': [ ENUM-VALUE, ... ],
> +             '*prefix': STRING,
> +             '*if': COND }
> +    ENUM-VALUE =3D STRING
> +               | { 'name': STRING, '*if': COND }
> =20

> +=3D=3D=3D Type references and array types =3D=3D=3D
> +
> +Syntax:
> +    TYPE-REF =3D STRING | ARRAY-TYPE
> +    ARRAY-TYPE =3D [ STRING ]

As written (and enforced by current code), we don't allow 2-d arrays; if
we ever decide we need that, we'd rewrite to ARRAY-TYPE =3D [ ARRAY-TYPE =
]

>  =3D=3D=3D Struct types =3D=3D=3D
> =20
> -Usage: { 'struct': STRING, 'data': DICT, '*base': STRUCT-NAME }
> +Syntax:
> +    STRUCT =3D { 'struct': STRING,
> +               'data': MEMBERS,
> +               '*base': STRING,
> +               '*if': COND,
> +               '*features': FEATURES }
> +    MEMBERS =3D { MEMBER, ... }
> +    MEMBER =3D STRING : TYPE-REF
> +           | STRING : { 'type': TYPE-REF, '*if': COND }

Down the road, we'll probably be amending this line:

 | STRING : { 'type': TYPE-REF, '*if': COND, '*default': VALUE }

with appropriate documentation on how VALUE must match type.


>  =3D=3D=3D Union types =3D=3D=3D
> =20
> -Usage: { 'union': STRING, 'data': DICT }
> -or:    { 'union': STRING, 'data': DICT, 'base': STRUCT-NAME-OR-DICT,
> -         'discriminator': ENUM-MEMBER-OF-BASE }
> -
> -Union types are used to let the user choose between several different
> -variants for an object.  There are two flavors: simple (no
> -discriminator or base), and flat (both discriminator and base).  A uni=
on
> -type is defined using a data dictionary as explained in the following
> -paragraphs.  Unions must have at least one branch.
> +Syntax:
> +    UNION =3D { 'union': STRING,
> +              'data': BRANCHES,
> +              '*if': COND }
> +          | { 'union': STRING,
> +              'data': BRANCHES,
> +              'base': ( MEMBERS | STRING ),
> +              'discriminator': STRING,
> +              '*if': COND }
> +    BRANCHES =3D { BRANCH, ... }

This syntactically allows zero or more branches per the intro, but in
code we semantically require at least one.  Is that a problem?

> +    BRANCH =3D STRING : TYPE-REF
> +           | STRING : { 'type': TYPE-REF, '*if': COND }
> +
> +Member 'union' names the union type.
> +
> +There are two flavors of union types: simple (no discriminator or
> +base), and flat (both discriminator and base).
> +
> +Each BRANCH of the 'data' object defines a branch of the union.  A
> +union must have at least one branch.

Is it worth trying to represent one-or-more in the grammar, in a
different manner than zero-or-more?


> +
> +All flat union branches must be of struct type.
> +

We may eventually relax that to permit another union, hopefully we
remember to fix the docs when doing so.

> +In the Client JSON Protocol, a flat union is represented by an object
> +with the common members (from the base type) and the selected branch's=

> +members.  The two sets of member names must be disjoint.  Member
> +'discriminator' must name a non-optional enum-typed member of the base=

> +struct.

We've already had patches proposed for relaxing that to allow an
optional discriminator as a way to select a default branch.  They'll
have to be rebased on top of this.


>  =3D=3D=3D Configuring the schema =3D=3D=3D
> =20
> -The 'struct', 'enum', 'union', 'alternate', 'command' and 'event'
> -top-level expressions can take an 'if' key.  Its value must be a strin=
g
> -or a list of strings.  A string is shorthand for a list containing jus=
t
> -that string.  The code generated for the top-level expression will the=
n
> -be guarded by #if COND for each COND in the list.
> +Syntax:
> +    COND =3D STRING
> +         | [ STRING, ... ]
> +
> +All definitions take an optional 'if' member.  Its value must be a
> +string or a list of strings.  A string is shorthand for a list
> +containing just that string.  The code generated for the definition
> +will then be guarded by #if COND for each COND in the list.

Should this read 'guarded by #if STRING for each STRING in the COND list'=
?


> -=3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
> +=3D=3D=3D=3D Definition documentation =3D=3D=3D=3D
> =20
> -Expressions other than include and pragma directives may be preceded
> -by a documentation block.  Such blocks are called expression
> -documentation blocks.
> +Definition documentation, if present, must immediately precede the
> +definition it documents.
> =20
> -When documentation is required (see pragma 'doc-required'), expression=

> -documentation blocks are mandatory.
> +When documentation is required (see pragma 'doc-required'), every
> +definition must have documentation.
> =20
> -The documentation block consists of a first line naming the
> -expression, an optional overview, a description of each argument (for
> -commands and events) or member (for structs, unions and alternates),
> -and optional tagged sections.
> +Definition documentation starts with a line naming the definition,
> +followed by an optional overview, a description of each argument (for
> +commands and events), member (for structs and unions), branch (for
> +alternates), or value (for enums), and finally optional tagged
> +sections.
> =20
>  FIXME: the parser accepts these things in almost any order.
> +FIXME: union branches should be described, too.
> =20
> -Extensions added after the expression was first released carry a
> +Extensions added after the definition was first released carry a
>  '(since x.y.z)' comment.

Not this patch's problem - but we are inconsistent between x.y and x.y.z.=


There are a couple of typo or grammar fixes worth fixing, but I'm
comfortable enough giving:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--oYFRfUklii6c0fiSsJU2BU6YWGg7Lpkxp--

--JXWc3edGg6GBw2kqmOmBGQBdbxLF2co4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1332cACgkQp6FrSiUn
Q2pJyQf8DnlUtDpqqAlG2i0M/B8ETZP4ncbBsrhbsI6tqmsFHgkDoN2+9A4aT3HZ
TjY/Dm3i7pvVweA3BCdBHUGpj9B/enRydjsXVjTFlI8TE04qLXrGtimK0Un3z9Zq
XqhuoekF9PKX8+s2zh671UzbVgae4j7dLenIrtaSrojo3gVf7lHLp+goJxwDiOnE
hHyIXMFDRfQ1QPz7zq8dMzW1v7NUHAJ8oGxP3hWxdMRSlBt6+b04hDPrX9hiZqJ1
81cf/++KxKUyPRDsc7RRhGppl2gH+DfdonsXKfyvjK+2jVMOJWEfQn9kzN7Zjsc2
SRv++Aruas6mE38m6B7r0K+7ZHNOow==
=IFew
-----END PGP SIGNATURE-----

--JXWc3edGg6GBw2kqmOmBGQBdbxLF2co4j--

