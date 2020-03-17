Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68014C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E50F206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPkAWaUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E50F206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELMW-0000ue-AI
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jELLo-0000LS-LJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jELLm-00011g-RL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:10:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jELLm-0000rT-Fb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584486617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBVlmo3wD7gBHiL9yf7lXGmy/YOVe3t9BaCifxbDauo=;
 b=RPkAWaUfcaLEHAy18U89Ub/v0AHfL4/BmqDHgkkswIEHuOHbnErV8juv8i+2KX+5IRTPVV
 opMHOcCzmbDzhhwtgd87s5ymhXgTJWUSqCebicidvJAjhAuz5s8SGunW2hgbNAVIq85LH+
 1IOY/WJEWqFoL6Kv7azUAu3wVXdEcAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-hdv58QlTPXKfXLvBGYZnyg-1; Tue, 17 Mar 2020 19:10:15 -0400
X-MC-Unique: hdv58QlTPXKfXLvBGYZnyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 617BE1005514;
 Tue, 17 Mar 2020 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-2.rdu2.redhat.com [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA2FF94941;
 Tue, 17 Mar 2020 23:10:06 +0000 (UTC)
Date: Tue, 17 Mar 2020 19:10:04 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v10 3/3] Acceptance tests: add make targets to download
 images
Message-ID: <20200317231004.GA158340@localhost.localdomain>
References: <20200317141654.29355-1-crosa@redhat.com>
 <20200317141654.29355-4-crosa@redhat.com>
 <87d09akevx.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87d09akevx.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 06:36:18PM +0000, Alex Benn=E9e wrote:
>=20
> Cleber Rosa <crosa@redhat.com> writes:
>=20
> > The newly introduced "boot linux" tests make use of Linux images that
> > are larger than usual, and fall into what Avocado calls "vmimages",
> > and can be referred to by name, version and architecture.
> >
> > The images can be downloaded automatically during the test. But, to
> > make for more reliable test results, this introduces a target that
> > will download the vmimages for the architectures that have been
> > configured and are available for the currently used distro (Fedora
> > 31).
> >
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Willian Rampazzo <willianr@redhat.com>
> > ---
> >  tests/Makefile.include | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 67e8fcddda..9c19229a06 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -20,6 +20,8 @@ check-help:
> >  =09@echo " $(MAKE) check-venv           Creates a Python venv for test=
s"
> >  =09@echo " $(MAKE) check-clean          Clean the tests and related da=
ta"
> >  =09@echo
> > +=09@echo " $(MAKE) get-vm-images        Downloads all images used by a=
cceptance tests, according to configured targets (~350 MB each, 1.5 GB max)=
"
> > +=09@echo
>=20
> I'm not overly enamoured with a super long line help for something that
> is a dependency anyway but whatever...
>=20
>

I had a hard time choosing the right info to put there, and I didn't
want to break the style of the majority of help messages that use a
single line.  Anyway, we can always improve that.

> >  =09@echo
> >  =09@echo "The variable SPEED can be set to control the gtester speed s=
etting."
> >  =09@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; th=
ey can be"
> > @@ -889,7 +891,20 @@ $(TESTS_RESULTS_DIR):
> > =20
> >  check-venv: $(TESTS_VENV_DIR)
> > =20
> > -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> > +FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(TARGETS))
> > +FEDORA_31_ARCHES :=3D x86_64 aarch64 ppc64le s390x
> > +FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_C=
ANDIDATES))
> > +
> > +# download one specific Fedora 31 image
> > +get-vm-image-fedora-31-%: $(check-venv)
>=20
> Why $(check-venv) instead of check-venv
>

Good point.

> > +=09$(call quiet-command, \
> > +             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
> > +             --distro=3Dfedora --distro-version=3D31 --arch=3D$*)
>=20
> Some short text for the operation would be nice (DNLD acceptance images?)
>

Another good point.

> > +
> > +# download all vm images, according to defined targets
> > +get-vm-images: $(check-venv) $(patsubst %,get-vm-image-fedora-31-%, $(=
FEDORA_31_DOWNLOAD))
> > +
> > +check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
> >  =09$(call quiet-command, \
> >              $(TESTS_VENV_DIR)/bin/python -m avocado \
> >              --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_R=
ESULTS_DIR) \
> > @@ -900,7 +915,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> > =20
> >  # Consolidated targets
> > =20
> > -.PHONY: check-block check-qapi-schema check-qtest check-unit check che=
ck-clean
> > +.PHONY: check-block check-qapi-schema check-qtest check-unit check che=
ck-clean get-vm-images
> >  check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-s=
chema/doc-good.texi
> >  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
> >  ifeq ($(CONFIG_TOOLS),y)
>=20
> Otherwise:
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
>

Thanks!
- Cleber.

> --=20
> Alex Benn=E9e
>=20

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5xWMkACgkQZX6NM6Xy
CfMkyhAAl1jJl/haB8x5DlXQoopJQX9l4TJQLlR6Bsjl2IEP4lZ3OIZEqK2YukD3
saenmtEi4ym5q/Uve8iOSy3qDIxctYCmFo5fJa1B8B1QwF7efOAIQDqGGSdcQ/rA
5H7/6rJqEWVJQloZHT1qJgwAVnvNUrivcNp7PaW4j/vUBoUtGIv70aMRXm2gBxPa
oCxMvoJUQv4f6AXCbukTmcyJuZnjACuZTQhCeIExq8KoboHfu45vqIfeilXdN3wb
dgZUM1x/hfBkiNVOMKc1Gewceeqe3TGzq8QWlcbKJtBVv7cAAOjMUQ+3vjtoGACa
7DX2WWzQsm8LR8DQLC0bZd5v9c9qEh6EHpY5AThn4e4VX+dHCtkYkVtmhm6LfH0o
GjObTJFz/4WVOeeFp1JOyjdoNDMA6UPAMbok1u5433nzyiNAfvM+m0fv0pkYDVCB
QlZXb2vbB0nsXPk3vaBPYM/awVefgruq6CQ1V5RQYeLvz56Pn4vk52EqFnYf9G5w
p/vcZBTmrq1IQPNBRvpZL2Yqg55z4Z09A2X8PzlLZCyTYm2qZzQDS9YzOFkRYBW3
ZotMPJtGjL4a9u0X3c5RmrjoDpcxcXh+9F/qif83kn9xV8NmO4azMQ1d6ui0/x3p
UdUyYy7G0WjheL3CDmuqzpS2GijY6ztYwShe5nJKaIvy4aUgZAk=
=LPBL
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


