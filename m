Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD92C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB717222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVjBD+df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB717222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjtr-0001Oy-2g
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ihjtD-0000cm-3O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ihjtB-00071c-Tx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:42:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ihjtB-0006zz-Pe
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576716120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LU/PUD9oiUXymFL3OZZJ50YAuXvtpX1MkauCF3hTusw=;
 b=RVjBD+dfHx6SlTErAlNoVf1RXXO1tFpB4gwURVX6+iiJmO+MhD3UFNNwFEgSDSB5wvNUeG
 L5SWAnt4bZ4SpUfkwYSqSfoA6MsIY3gijGGXhgSRKsyVsBBs/9O2bKN272cExLbmewEBT+
 0yfm/Ri4T5BjBWcPSw6IERvvBCQg3xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-8e0uM5gyP9GVM7PsAZlRxA-1; Wed, 18 Dec 2019 19:41:57 -0500
X-MC-Unique: 8e0uM5gyP9GVM7PsAZlRxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66967184BEC6;
 Thu, 19 Dec 2019 00:41:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-25.gru2.redhat.com
 [10.97.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AC3667E47;
 Thu, 19 Dec 2019 00:41:49 +0000 (UTC)
Date: Wed, 18 Dec 2019 19:41:47 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 3/4] Acceptance tests: add make targets to download
 images
Message-ID: <20191219004147.GC29918@localhost.localdomain>
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-4-crosa@redhat.com>
 <e1dc21f1-a349-508e-db11-5aee59f31f2e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e1dc21f1-a349-508e-db11-5aee59f31f2e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 01:16:12AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 12/19/19 12:24 AM, Cleber Rosa wrote:
> > The newly introduced "boot linux" tests make use of Linux images that
> > are larger than usual, and fall into what Avocado calls "vmimages",
> > and can be referred to by name, version and architecture.
> >=20
> > The images can be downloaded automatically during the test. But, to
> > make for more reliable test results, this introduces a target that
> > will download the vmimages for the architectures that have been
> > configured and are available for the currently used distro (Fedora
> > 31).
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/Makefile.include | 17 +++++++++++++++--
> >   1 file changed, 15 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index b381387048..78a6f089ff 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -1177,7 +1177,20 @@ $(TESTS_RESULTS_DIR):
> >   check-venv: $(TESTS_VENV_DIR)
> > -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> > +FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(TARGETS))
> > +FEDORA_31_ARCHES :=3D x86_64 aarch64 ppc64le s390x
> > +FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_C=
ANDIDATES))
> > +
> > +# download one specific Fedora 31 image
> > +get-vmimage-fedora-31-%: $(check-venv)
> > +=09$(call quiet-command, \
> > +             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
> > +             --distro=3Dfedora --distro-version=3D31 --arch=3D$*)
> > +
> > +# download all vm images, according to defined targets
> > +get-vmimage: $(patsubst %,get-vmimage-fedora-31-%, $(FEDORA_31_DOWNLOA=
D))
> > +
> > +check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vmimage
> >   =09$(call quiet-command, \
> >               $(TESTS_VENV_DIR)/bin/python -m avocado \
> >               --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_=
RESULTS_DIR) \
> > @@ -1188,7 +1201,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> >   # Consolidated targets
> > -.PHONY: check-block check-qapi-schema check-qtest check-unit check che=
ck-clean
> > +.PHONY: check-block check-qapi-schema check-qtest check-unit check che=
ck-clean get-vmimage
> >   check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-=
schema/doc-good.texi
> >   check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
> >   check-block: $(patsubst %,check-%, $(check-block-y))
> >=20
>=20
> We have both 'make vm-help' and 'make check-help'. The check-acceptance
> target is in check-help. We get vm image... confusing.
>

I know... I had a hard time coming up with a name, and I'm aware it's not
a very good one.

> Anyway, can you list this new target, with a hint about the storage size
> required?

Sure thing, good point.

> Can you add an entry in the 'make
>=20

I suspect you mean adding an entry in the 'make check-help' output, right?

- Cleber.

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl36x0oACgkQZX6NM6Xy
CfMB2RAAnqg3v5A35cB4xyhd4j8OtcKWIKETXaU6KG2T3KQVy/LkmvsEbDbNphMg
FqCe73FhiVwbecoyoFTo4RfLEODfcSIO4Dhtfj3+6KnJZH+gnva1U/wFXvTByQ1M
r0sc9XKVUJPcaCgE3vuM7OsjY5pa2Ie/hKXY6FWLqIkwydENCqpQaHSrPl7XdNFI
9qLN1UCMgCnb0xdErsxw5dz7njlIEMHOhFUz9SpIfV8DYvJiAzK/8950UmcJE64U
xhm7m2uJ9QbN7M4Sz/SIJI+oYrg3kFf89YU9xazVBfX8PTr8OjFIJI0V5NuyrUAc
iB3J/X3UQBdTB//KQXco1Me+A+5qWbqWxsTib46u/vSkcKOKeajej4sRtZnnB0EC
m/AddWu2eBBB1U4Hhc12h2M2cZKD9JGxOOTOg48e2DCSnLQ0pPBdkNi3CcR9lke3
yjO6D8qAKDSqDu2pX92rR9rCTkCHLclpL6SylcRFx0wObqSMl/L3QzWiCgN2c7gC
I7ZQlXwPvKHGj0cYHn/sA/A0sRw41dy7jya7AQ8F27+5GMT5hN2FZQ6JfKtJdWM/
A7wljfTRqylupt0SK8a2IHbwJGbcEZ8aueBNccUxJgrYKBC0iNIFPyAhSkjNbqJW
xjBcDVv8A+UNckMI4nzYvVYRgiCeRfno/VwJlFnVPRAagz6wQzM=
=CYYw
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--


