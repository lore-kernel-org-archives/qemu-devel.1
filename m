Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA63C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F1121D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emXeET6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F1121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFr2-0004e8-5O
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ihFqG-0003kW-EZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ihFqF-0007Fb-5M
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:37:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ihFqF-0007EJ-1D
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576600618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJ4ixTEtX46JAzlwdS4Vi4EOJvWbmYXX0MQ2w4YLQXI=;
 b=emXeET6LOFsSfB7SFS7Ka9/mye2uuQJHQqjGmQBuOXr0yK1QAo2Cn3TboaRNKGNloM54xU
 pUZTuiPQHBegMsagrRgrQ29XTnuK1LY+VgORRQWfG0bGLka/oYpqwQnsRJlqaZ2Luq0G0R
 S4Erpg/soA4G9yFQgN6q8QacooOenG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-1PUbDVFKMqOW03Yg8XBW0g-1; Tue, 17 Dec 2019 11:36:55 -0500
X-MC-Unique: 1PUbDVFKMqOW03Yg8XBW0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77F6C1809A3E;
 Tue, 17 Dec 2019 16:36:54 +0000 (UTC)
Received: from localhost (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06A871000322;
 Tue, 17 Dec 2019 16:36:53 +0000 (UTC)
Date: Tue, 17 Dec 2019 16:36:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] docs: build an index page for the HTML docs
Message-ID: <20191217163653.GD1333385@stefanha-x1.localdomain>
References: <20191111102157.440664-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191111102157.440664-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel Berrange <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 10:21:57AM +0000, Stefan Hajnoczi wrote:
> There is no index.html start page for the QEMU HTML documentation.  An
> index page is needed so that documentation can be browsed easily on the
> web.
>=20
> This patch adds an index.html.in template file where the QEMU version
> number is expanded.  It is written in HTML instead of using the existing
> sphinx (rST) and texi documentation generators because they are
> heavyweight and would make this harder.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile           |  6 ++++++
>  docs/index.html.in | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 docs/index.html.in

Ping?

> diff --git a/Makefile b/Makefile
> index aa9d1a42aa..581bc68918 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -347,6 +347,7 @@ DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/q=
emu-qmp-ref.txt docs/interop/
>  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/=
interop/qemu-ga-ref.7
>  DOCS+=3Ddocs/qemu-block-drivers.7
>  DOCS+=3Ddocs/qemu-cpu-models.7
> +DOCS+=3D$(MANUAL_BUILDDIR)/index.html
>  ifdef CONFIG_VIRTFS
>  DOCS+=3Dfsdev/virtfs-proxy-helper.1
>  endif
> @@ -818,6 +819,7 @@ install-sphinxdocs: sphinxdocs
> =20
>  install-doc: $(DOCS) install-sphinxdocs
>  =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
> +=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdi=
r)"
>  =09$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
>  =09$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
>  =09$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docd=
ir)"
> @@ -1024,6 +1026,10 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual=
-deps,specs)
>  $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
>  =09$(call build-manual,interop,man)
> =20
> +$(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-versi=
on.h
> +=09$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
> +             "GEN","$@")
> +
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtoo=
l
>  =09$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN"=
,"$@")
> =20
> diff --git a/docs/index.html.in b/docs/index.html.in
> new file mode 100644
> index 0000000000..c2df85a185
> --- /dev/null
> +++ b/docs/index.html.in
> @@ -0,0 +1,17 @@
> +<!DOCTYPE html>
> +<html>
> +    <head>
> +        <meta charset=3D"UTF-8">
> +        <title>QEMU @@VERSION@@ Documentation</title>
> +    </head>
> +    <body>
> +        <h1>QEMU @@VERSION@@ Documentation</h1>
> +        <ul>
> +            <li><a href=3D"qemu-doc.html">User Documentation</a></li>
> +            <li><a href=3D"qemu-qmp-ref.html">QMP Reference Manual</a></=
li>
> +            <li><a href=3D"qemu-ga-ref.html">Guest Agent Protocol Refere=
nce</a></li>
> +            <li><a href=3D"interop/index.html">System Emulation Manageme=
nt and Interoperability Guide</a></li>
> +            <li><a href=3D"specs/index.html">System Emulation Guest Hard=
ware Specifications</a></li>
> +        </ul>
> +    </body>
> +</html>
> --=20
> 2.23.0
>=20

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl35BCQACgkQnKSrs4Gr
c8ilCggAllAPHALVjRDOSlMJM6xJAtl+v8OaIucaIULKRwbcQv/TVuDRdKKXNoUH
e4GoM4u9LPhcziylRpli1lptABWwKHJPwoTioux2L5kNLtaEnFx0Z1077Eef8YZM
6UOF4o4/GJMqDJmWIxJRW2rLIbtl78a7/ViymAHCaP6OmDnZbyanEBGUYjd7FnlN
XUoO5UZ/4l53d0arjjndtfUVyu3pGE1LuOcGI7W9RMnHMMiBBpc95NoiIvfe2dCa
Vrez8pYdhBIiWRZYzu/DrphOBK25HkaXFJO9XUdU91AUjUOqQ5c1P/qmVlF2rHsb
DZP8eFwLoF9VRekPnO2SsIYZCbSudQ==
=PL3U
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--


