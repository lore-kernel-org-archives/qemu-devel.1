Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F73EC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59CC208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMAgsjSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59CC208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6q4-00083r-Qe
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN6ok-0007bl-IF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN6oi-0005pz-CS
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:00:42 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601352039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNq8BUBo3o7cCE5oADaRFRsdCSKs3kDjHsJujhZ12Zk=;
 b=CMAgsjSjKhQWruwn7R+qOz9SIV24NJiTVJYmqDv50zBsRb4yVaw/4axXCHOfy3y8AF2NA1
 6HzonltETFUVNuzWfBov5hfYp7sG4XaxOvDaYRVO+ISytD1lI5swLEWA+nvA51ziBm7x8K
 G/V51QVLn2uEovhvcbjzLs0PYXqxm2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Hkh211gVPbiY4uo7uh_Vxw-1; Tue, 29 Sep 2020 00:00:31 -0400
X-MC-Unique: Hkh211gVPbiY4uo7uh_Vxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EA921868421
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F47B5C1BD;
 Tue, 29 Sep 2020 04:00:29 +0000 (UTC)
Date: Tue, 29 Sep 2020 00:00:27 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 06/47] [DO-NOT-MERGE] docs: enable sphinx-autodoc for
 scripts/qapi
Message-ID: <20200929040027.GG700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-7-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-7-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:19PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/conf.py                          |  6 +++++-
>  docs/devel/index.rst                  |  1 +
>  docs/devel/python/index.rst           |  7 +++++++
>  docs/devel/python/qapi.commands.rst   |  7 +++++++
>  docs/devel/python/qapi.common.rst     |  7 +++++++
>  docs/devel/python/qapi.doc.rst        |  7 +++++++
>  docs/devel/python/qapi.error.rst      |  7 +++++++
>  docs/devel/python/qapi.events.rst     |  7 +++++++
>  docs/devel/python/qapi.expr.rst       |  7 +++++++
>  docs/devel/python/qapi.gen.rst        |  7 +++++++
>  docs/devel/python/qapi.introspect.rst |  7 +++++++
>  docs/devel/python/qapi.parser.rst     |  8 ++++++++
>  docs/devel/python/qapi.rst            | 26 ++++++++++++++++++++++++++
>  docs/devel/python/qapi.schema.rst     |  7 +++++++
>  docs/devel/python/qapi.source.rst     |  7 +++++++
>  docs/devel/python/qapi.types.rst      |  7 +++++++
>  docs/devel/python/qapi.visit.rst      |  7 +++++++
>  17 files changed, 131 insertions(+), 1 deletion(-)
>  create mode 100644 docs/devel/python/index.rst
>  create mode 100644 docs/devel/python/qapi.commands.rst
>  create mode 100644 docs/devel/python/qapi.common.rst
>  create mode 100644 docs/devel/python/qapi.doc.rst
>  create mode 100644 docs/devel/python/qapi.error.rst
>  create mode 100644 docs/devel/python/qapi.events.rst
>  create mode 100644 docs/devel/python/qapi.expr.rst
>  create mode 100644 docs/devel/python/qapi.gen.rst
>  create mode 100644 docs/devel/python/qapi.introspect.rst
>  create mode 100644 docs/devel/python/qapi.parser.rst
>  create mode 100644 docs/devel/python/qapi.rst
>  create mode 100644 docs/devel/python/qapi.schema.rst
>  create mode 100644 docs/devel/python/qapi.source.rst
>  create mode 100644 docs/devel/python/qapi.types.rst
>  create mode 100644 docs/devel/python/qapi.visit.rst
>=20
> diff --git a/docs/conf.py b/docs/conf.py
> index a68f616d5a..d03ef465a6 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -54,6 +54,9 @@
>  #
>  sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
> =20
> +# Make scripts/qapi module available for autodoc
> +sys.path.insert(0, os.path.join(qemu_docdir, "../scripts"))
> +

Do I hear qapi asking to moved out of "scripts" and becoming more like
"python/qemu"?

> =20
>  # -- General configuration ---------------------------------------------=
---
> =20
> @@ -67,7 +70,8 @@
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>  # ones.
> -extensions =3D ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile']
> +extensions =3D ['kerneldoc', 'qmp_lexer', 'hxtool',
> +              'depfile', 'sphinx.ext.autodoc']
> =20
>  # Add any paths that contain templates here, relative to this directory.
>  templates_path =3D ['_templates']
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 04773ce076..04726ca787 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -31,3 +31,4 @@ Contents:
>     reset
>     s390-dasd-ipl
>     clocks
> +   python/index
> diff --git a/docs/devel/python/index.rst b/docs/devel/python/index.rst
> new file mode 100644
> index 0000000000..31c470154b
> --- /dev/null
> +++ b/docs/devel/python/index.rst
> @@ -0,0 +1,7 @@
> +qapi
> +=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 4
> +
> +   qapi
> diff --git a/docs/devel/python/qapi.commands.rst b/docs/devel/python/qapi=
.commands.rst
> new file mode 100644
> index 0000000000..018f7b08a9
> --- /dev/null
> +++ b/docs/devel/python/qapi.commands.rst
> @@ -0,0 +1,7 @@
> +qapi.commands module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.commands
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> diff --git a/docs/devel/python/qapi.common.rst b/docs/devel/python/qapi.c=
ommon.rst
> new file mode 100644
> index 0000000000..128a90d74b
> --- /dev/null
> +++ b/docs/devel/python/qapi.common.rst
> @@ -0,0 +1,7 @@
> +qapi.common module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.common
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> diff --git a/docs/devel/python/qapi.doc.rst b/docs/devel/python/qapi.doc.=
rst
> new file mode 100644
> index 0000000000..556c2bca1f
> --- /dev/null
> +++ b/docs/devel/python/qapi.doc.rst
> @@ -0,0 +1,7 @@
> +qapi.doc module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.doc
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> diff --git a/docs/devel/python/qapi.error.rst b/docs/devel/python/qapi.er=
ror.rst
> new file mode 100644
> index 0000000000..980e32b63d
> --- /dev/null
> +++ b/docs/devel/python/qapi.error.rst
> @@ -0,0 +1,7 @@
> +qapi.error module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.error
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> diff --git a/docs/devel/python/qapi.events.rst b/docs/devel/python/qapi.e=
vents.rst
> new file mode 100644
> index 0000000000..1fce85b044
> --- /dev/null
> +++ b/docs/devel/python/qapi.events.rst
> @@ -0,0 +1,7 @@
> +qapi.events module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.events
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> diff --git a/docs/devel/python/qapi.expr.rst b/docs/devel/python/qapi.exp=
r.rst
> new file mode 100644
> index 0000000000..0660270629
> --- /dev/null
> +++ b/docs/devel/python/qapi.expr.rst
> @@ -0,0 +1,7 @@
> +qapi.expr module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.expr
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> diff --git a/docs/devel/python/qapi.gen.rst b/docs/devel/python/qapi.gen.=
rst
> new file mode 100644
> index 0000000000..7b495fd4bf
> --- /dev/null
> +++ b/docs/devel/python/qapi.gen.rst
> @@ -0,0 +1,7 @@
> +qapi.gen module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.gen
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> diff --git a/docs/devel/python/qapi.introspect.rst b/docs/devel/python/qa=
pi.introspect.rst
> new file mode 100644
> index 0000000000..f65ebfccd1
> --- /dev/null
> +++ b/docs/devel/python/qapi.introspect.rst
> @@ -0,0 +1,7 @@
> +qapi.introspect module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.introspect
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> diff --git a/docs/devel/python/qapi.parser.rst b/docs/devel/python/qapi.p=
arser.rst
> new file mode 100644
> index 0000000000..1a8f7b347e
> --- /dev/null
> +++ b/docs/devel/python/qapi.parser.rst
> @@ -0,0 +1,8 @@
> +qapi.parser module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi.parser
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> +   :private-members:
> diff --git a/docs/devel/python/qapi.rst b/docs/devel/python/qapi.rst
> new file mode 100644
> index 0000000000..24fbf34981
> --- /dev/null
> +++ b/docs/devel/python/qapi.rst
> @@ -0,0 +1,26 @@
> +qapi package
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: qapi
> +   :members:
> +   :undoc-members:
> +   :show-inheritance:
> +

This renders *very* timidly, ending up almost invisible.  Also,
there's no useful introduction to what this "qapi" when you enter this
section.

Maybe create a "API reference" section, explaining it first?

- Cleber.

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ysVQACgkQZX6NM6Xy
CfMMcQ//XEqBzAbSsVBjixH4KbyMCECYG+6rOEdLy/+id5JF03mEwuf0WDHMdmRv
YNn+fJ6nD82QEDTaVPk//aksrgOgylMw5F+g6IaAPXH5SQIfYZVOo+StwuJAQ6to
POCwEPNxT9gIHVxa2Y74UUUmCQiSeArbNaMRsG8NC8v4frrnBUKfTaabixyuovLg
OyHk9Na+4Y6nEpZXPs7ca5K/nPQZ+EEPfreEtkhNxLCA+Dk3U0J6karPVqDdAUlS
DXz7QyRqDKDJMmsdb2XnxIbkGnDiaXcH2lB7CG05teRM6SBnWL/KaqwKSy+n0/WT
rIWHeg243DTI9ffDU0fAH7mUGGk6+Fj4xtldaky8fQ5t/cpwmFACJ7X3BFcgTTDN
prG9LLaT6tFMdoc+2I+OPqJqCY71P3HfIXc47HHArfkPkuwM9pgjAV58vbdp+ZHI
FJ3FBPP8DZhmD9dQEMCGavLNoAd2HSxL4qCcUzgMr7i6JlW86HVATGuE6nve8oMv
RNM+hwIKC+a+ze2CFVgFmzjVC9oI7XXm6jSJfiLFyRkw5Sb7B3NlSA9sAPsIId/4
9eN08hwdI6XL/6TW8rMHSvQ8KOre2vhp37+wumHTx0iRFzBndkaMou6JphlKl8Me
r7FimKq+F9jvH1vhqkDab1e42UdIIzgE1T2imwrx3jm4Bskn5Qw=
=GXX1
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--


