Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071E7C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEC3206FB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jxna5dlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEC3206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6D0-0003uZ-KZ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 10:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL6BH-0002zR-F5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:55:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL6BF-0008GU-LH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600872936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GxJHWS55hmiYx6iDBnXpmB2KpmbmaENJDNjiFW3+dA=;
 b=Jxna5dlj7Ny9hvOG5QGBVNK4pd9EIqd0yyeIpECJm5S07982yNpZZg12k7EhqhsYD1EXJh
 DuUX60uq/uE5FmVx7qSDkDPOuU9ockQpdmtqN5jgY2yvbTgiFp+dCbSnTUkst/8B6EZUDy
 HGfzQXczHbqjl5gAHfHpBJoGTZCiI5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-GkxTUfy2OYSjPig_lwDQxg-1; Wed, 23 Sep 2020 10:55:34 -0400
X-MC-Unique: GkxTUfy2OYSjPig_lwDQxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F1818ECE59;
 Wed, 23 Sep 2020 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 523DF60BF1;
 Wed, 23 Sep 2020 14:55:32 +0000 (UTC)
Date: Wed, 23 Sep 2020 10:55:30 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 09/38] qapi/common.py: Add indent manager
Message-ID: <20200923145530.GI191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-10-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-10-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 05:11:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:32PM -0400, John Snow wrote:
> Code style tools really dislike the use of global keywords, because it
> generally involves re-binding the name at runtime which can have strange
> effects depending on when and how that global name is referenced in
> other modules.
>=20
> Make a little indent level manager instead.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/common.py | 51 +++++++++++++++++++++++++++++-------------
>  scripts/qapi/visit.py  |  7 +++---
>  2 files changed, 38 insertions(+), 20 deletions(-)
>=20
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index cee63eb95c..e0c5871b10 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -93,33 +93,52 @@ def c_name(name, protect=3DTrue):
>  pointer_suffix =3D ' *' + eatspace
> =20
> =20
> -def genindent(count):
> -    ret =3D ''
> -    for _ in range(count):
> -        ret +=3D ' '
> -    return ret
> +class Indentation:
> +    """
> +    Indentation level management.
> =20
> +    :param initial: Initial number of spaces, default 0.
> +    """
> +    def __init__(self, initial: int =3D 0) -> None:
> +        self._level =3D initial
> =20
> -indent_level =3D 0
> +    def __int__(self) -> int:
> +        return self._level
> =20
> +    def __repr__(self) -> str:
> +        return "{}({:d})".format(type(self).__name__, self._level)
> =20
> -def push_indent(indent_amount=3D4):
> -    global indent_level
> -    indent_level +=3D indent_amount
> +    def __str__(self) -> str:
> +        """Return the current indentation as a string of spaces."""
> +        return ' ' * self._level
> =20
> +    def __bool__(self) -> bool:
> +        """True when there is a non-zero indentation."""
> +        return bool(self._level)
> =20
> -def pop_indent(indent_amount=3D4):
> -    global indent_level
> -    indent_level -=3D indent_amount
> +    def increase(self, amount: int =3D 4) -> int:
> +        """Increase the indentation level by `amount`, default 4."""
> +        self._level +=3D amount
> +        return self._level
> +

Do you have a use case for returning the level?  If not, I'd go
without it, and add a "level" property instead, as it'd serve more
cases.

Other than that,

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rYeAACgkQZX6NM6Xy
CfO8ZBAAy2SBoN8f/l1M0caEfViXHdiiwkltI0RkmZbyEhe5woa5/hHL5KW8zzK2
G2gBFdhGLByes0E8Qmg5g9ut5t9254kzn+Q3lUYgayxPcUMO/LwkDs3PF3cm0xl8
9m1ALLnXZsLKmMsS5fJxq9EiRwKXagQQGDfKvARkTe6dx8FV+LNowsp0gGMGYpSq
Bn/+U7zGWVn01+SC8xP8BPTz6hT1yubIclUkCNzcTmc6pcuKPQJz5sfRFlsNKnEv
FaFBWqkHWDEa9gYF+isqNW+wtDXuD/GcjFZTK8FcLsy+Yrmt7AADeQAO7iSx/VRx
iM62JA+lVjLTcRI6tZMJ1d5s+42z1DFfo9jvjHJ8IKicMDvHipYeMH9XcaEzP2pV
M08LoT/ASwkb8sgc/k3/Rt72pWgbfHVT9wsvezXDx2sJBPS4hJoWs3JU/uxrBuNJ
HMfSlBx4o+Sp59Rp/H1avBoXZDmzvr6iD4D5JcgmlO3XLO9DjbP9rbSELY5X+9M/
3KQ7TQPI1M+IDLZQG/9b4xkt1QWKLm0iljnXNpO3lmRYKETazHlHcFfWTWNx3I+J
BiqvFhpIUIb1E+nyvRBpB2WbwwC17cezDagI3D4vL/hYqRNJxr/0jixN8UshK8bB
5xhFZudzaDbwWL35e8x9VGUNisDE4wet+mLsjY6pWkSD3vonKCQ=
=Qb2W
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--


