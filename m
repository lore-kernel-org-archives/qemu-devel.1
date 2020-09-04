Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14396C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BB12078E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="F5LMNEdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BB12078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAyb-0004jS-In
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kEAua-0003Qc-Ht; Fri, 04 Sep 2020 08:33:50 -0400
Received: from mout.web.de ([212.227.17.11]:50637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kEAuW-0004ko-EQ; Fri, 04 Sep 2020 08:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1599222812;
 bh=+RLo/ZVW65kglykyVWrdi0g3aJcp2RgT/A8twL3InLM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=F5LMNEdX4JCNRVYUFgoErRnHWHTtVE6h9bXBS1NneVQFtbfmN/ptEra1VKMBI1OPr
 aVKjCnSb5JERBUyzFZs4Z/Vs6T/e0rBFJOTjXdsyaB3VpH12es35GRZZlqJKqjdWCP
 9VCjAWL0Sl6WDws3UjpZW86nxl73xH6BZ4eHWvMI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.238]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qr9-1kSw492yzl-00wXcd; Fri, 04
 Sep 2020 14:33:32 +0200
Date: Fri, 4 Sep 2020 14:33:05 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 1/8] Introduce yank feature
Message-ID: <20200904141312.185a20d5@luklap>
In-Reply-To: <871rjs9ser.fsf@dusky.pond.sub.org>
References: <cover.1596528468.git.lukasstraub2@web.de>
 <0092d4fe5f64078a18db3790c46c508416dbdb6b.1596528468.git.lukasstraub2@web.de>
 <871rjs9ser.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h.jymMyRN_67nTBYB9keTd/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:tiZVxRMmN6otur/z2BnjOCaKmPhwLXFcFfJWfw3tN5EO0tSqeDZ
 vuHZWSTzABFoFo65fI132aV3EcQ9CnkVXMAGyyZDizAL4VooMXW13bgtftL62J2BbHrCtJU
 IO6G4RL2CM7RVAbe5z78OPCpCP2evoa8z+/7WPKLrdQswo+mrh5Jcn4x1f08DYSvNIWQhTb
 iR0a8Z2VgxoBVwXoThahA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mYEq7XdSXYU=:DP42ZD1gICa6tvs7OUMiwV
 mcylTyoc/nHNeIut0m6405h7u5ycMHHM8y8+C+s21LtyPbfDRgvFkiVUSojl81wdUN6eNaFqo
 94Vai1BF7aMYW1Czj9NRtlAXvhYqmBSv0UWkT2s+7Nn62W/W0VP5+Z4nYIaBx17m1BNhGHJLv
 Uf0lMKp4ixx2f2uL7r13oCgg7RtYgqGdqs5nANh77E6SOJsTcDixS3SG8OhCLk01uc2s1FaZz
 Sh7hkaBLgfpq24gQJk9+Vf1UQJ9bB9jTSJdeUjVNRgfKqfupmqA71LYxOzhZR3YPJRLiiXhEb
 6cf/Pp9yZ2a2NZgzwCId2dlCRGjxV2RJYxXQ2iYRy1RZBWEv+dq9fKxO2undNdfnSkMmMvedQ
 OW6AotNVsMTX6EHrAsQDtVauKxuXzCnpc7A/968ypXxIgPb3moYdey+KxpUVebXoyEUxXRd+E
 1wlx/07OX1NQ5iI1UFlr0P0kfECphPmNYJV5GHQogPF69X7TWFTL6W36fy4KKLGKkiXZ/G+ry
 QYaUE/zSDdgsUxUk/hdm8v0DqeNiQvVIq6Rpbx5GkCRAbJc7sxX9qU2vskUp4FlDjP8E9bhen
 8JpWoLDEQRKcB3lacANYTYcUWF2TBhlZMvIvZ+CNs8T8zaHXZtB4IHT5TCT+3naII/Szj8VwI
 Tm5r8987ukPoLZhFL5vBJdSgYq0XKzE0zAejGNRbefjdm4CNtrfYHLqGbNisww366I8+oGOX5
 xu0D01G7w3zdHFprhTrlMa94wB1grQzsUuqp2GWo6cw5RWDFHSdk5lGvDr2hxduyFTXb5Ll94
 fqBfNe2B6c0Nf7V9mpWSsuKAeju8kbKWP/sV0Agu9mPXlpEqtLibo314ximLYXdW2kP0H51v9
 kRH6T/altDe/h8qx7nXsHzo0zNVc99DDBXlND2mF7bQ1zkS6kzkMVL42j4cv7NnGLyPgIH6SA
 +nDC6feEP8SfwMoK970E3FnmWC6LPHJ51mdpScolxt3au/pnOOqthkR9KdiljPDZBBVKpmCJv
 DBiUTTygNSeqmXGyns7vDeBDqJ6qBLL8OBjKIi6AvAmQQ5FSNKimSHEWrNAl4iy19Dyw+g5IX
 xikKpmeGmHUvLtPcOlzZVM8fip+gdRswDGHgr+ylsQVswxSJwBYqWfMDab69yrSKCunDPGWKY
 BRh3zost6ZGuOx+tcvJEXCubA4+cCGbNI9WJs4NHqkmdHm3aQ4gDxip9JUFj0nNmZOObCLvXn
 ckxZ36jjQN4FAU68wWwvwkfADFVf00RponkgoHA==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 08:33:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/h.jymMyRN_67nTBYB9keTd/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 14:37:00 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> I apologize for not reviewing this much earlier.
>=20
> Lukas Straub <lukasstraub2@web.de> writes:
>=20
> > The yank feature allows to recover from hanging qemu by "yanking"
> > at various parts. Other qemu systems can register themselves and
> > multiple yank functions. Then all yank functions for selected
> > instances can be called by the 'yank' out-of-band qmp command.
> > Available instances can be queried by a 'query-yank' oob command.
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> ...
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 9d32820dc1..0d6a8f20b7 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -1615,3 +1615,48 @@
> >  ##
> >  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> >
> > +##
> > +# @YankInstances:
> > +#
> > +# @instances: List of yank instances.
> > +#
> > +# Yank instances are named after the following schema:
> > +# "blockdev:<node-name>", "chardev:<chardev-name>" and "migration"
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'YankInstances', 'data': {'instances': ['str'] } } =20
>=20
> I'm afraid this is a problematic QMP interface.
>=20
> By making YankInstances a struct, you keep the door open to adding more
> members, which is good.
>=20
> But by making its 'instances' member a ['str'], you close the door to
> using anything but a single string for the individual instances.  Not so
> good.
>=20
> The single string encodes information which QMP client will need to
> parse from the string.  We frown on that in QMP.  Use QAPI complex types
> capabilities for structured data.
>=20
> Could you use something like this instead?
>=20
> { 'enum': 'YankInstanceType',
>   'data': { 'block-node', 'chardev', 'migration' } }
>=20
> { 'struct': 'YankInstanceBlockNode',
>   'data': { 'node-name': 'str' } }
>=20
> { 'struct': 'YankInstanceChardev',
>   'data' { 'label': 'str' } }
>=20
> { 'union': 'YankInstance',
>   'base': { 'type': 'YankInstanceType' },
>   'discriminator': 'type',
>   'data': {
>       'block-node': 'YankInstanceBlockNode',
>       'chardev': 'YankInstanceChardev' } }
>=20
> { 'command': 'yank',
>   'data': { 'instances': ['YankInstance'] },
>   'allow-oob': true }

This proposal looks good to me. Does everyone agree?

Regards,
Lukas Straub

> If you're confident nothing will ever be added to YankInstanceBlockNode
> and YankInstanceChardev, you could use str instead.
>=20
> > +
> > +##
> > +# @yank:
> > +#
> > +# Recover from hanging qemu by yanking the specified instances. =20
>=20
> What's an "instance", and what does it mean to "yank" it?
>=20
> The documentation of YankInstances above gives a clue on what an
> "instance" is: presumably a block node, a character device or the
> migration job.
>=20
> I guess a YankInstance is whatever the code chooses to make one, and the
> current code makes these three kinds.
>=20
> Does it make every block node a YankInstance?  If not, which ones?
>=20
> Does it make every character device a YankInstance?  If not, which ones?
>=20
> Does it make migration always a YankInstance?  If not, when?
>=20
> > +#
> > +# Takes @YankInstances as argument.
> > +#
> > +# Returns: nothing.
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "yank", "arguments": { "instances": ["blockdev:nbd0"=
] } }
> > +# <- { "return": {} }
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'command': 'yank', 'data': 'YankInstances', 'allow-oob': true }
> > +
> > +##
> > +# @query-yank:
> > +#
> > +# Query yank instances.
> > +#
> > +# Returns: @YankInstances
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "query-yank" }
> > +# <- { "return": { "instances": ["blockdev:nbd0"] } }
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'command': 'query-yank', 'returns': 'YankInstances', 'allow-oob': tr=
ue }
> ...

--Sig_/h.jymMyRN_67nTBYB9keTd/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9SNAEACgkQNasLKJxd
sliQog/9E9snwdjFZqRTxGyvoaujLfpoNA0Q3Wr5F4l4ZS6y/ecXlnFRInD/GxvY
fxvv/d0V+quxIMfQlk6mK7tYNEdBjRQlaqO1wn9zuoji/gmtzWNqtZz5jWRg0bcC
y67IKAYRHmjIUIxrVgJUm9XYiiDk5M3khX7DW/C3MiT27FIb4XndnEyqfhFkqhz1
Ez5qEU/XIU5Ml9mc7zlHEHBwntvZkxPhUE3nGw6ashztQH8MHD0FWXmgfeHeINof
3gE6rgbYzsnwHSqYUxTUGDFo+ebGO3xNNobRMBpVOcDc9Gt35TXp/p9mfMHE/zp7
w+zx8EPXkul2b57py3ISoMKa17fjLzCoYVb3Q+o4CTSPvibcV9ACR8kYtAxJzH7i
ShtjR6Et193FBTVFCLpy0VuqT8bZ136hUZBQBYrAMA5vD504nQJ3Us4kLN1+lQZO
6+ONrhqL47S01eUNXR7K2SCYNiq2F3BGR9p6jadNRAG1N/77x7pViStABHUclYe8
nCvB6c9Mhowp08HAF8dBtAp5MUDRMPDEGx7XYhdpEeMy4/5CWP2toDScRI9nZk32
KoUwkN3I2GRSQvThtYPFh930Ky+FTNRLHkvagPHVe29485/igaja1uBxqRLa/RFm
zT+dv9DrWbCA597bFcqgcPG2YelCx/36fzsQ4B5ZsF2E40UruuU=
=ftgr
-----END PGP SIGNATURE-----

--Sig_/h.jymMyRN_67nTBYB9keTd/--

