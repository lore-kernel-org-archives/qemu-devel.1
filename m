Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF18C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AAA20773
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2nHdeiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AAA20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCaj-00088F-1W
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvCa5-0007cm-LF
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:30:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvCa3-0000Xw-0F
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594701009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LOxxxGcLpv50wQyT3VzCnFOlQQyLavJjICuoMhSqgec=;
 b=N2nHdeiFMLND3a9qGHM9ECQYOWx8Eg7EUCyguUC7tF4JG/8irSDUiEPY2wqlJRyFhhRXIz
 1vbgldZKPPpFubJRibCoC0twO2SR6itZkTAw4IOINJGe9qs67YEwi+ecm7UWcu3usjkmnS
 tkKczEuVieXBuB/hUTi6CJp7vTLRzro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-HY8K750BPoGkzJCInrZnrw-1; Tue, 14 Jul 2020 00:30:07 -0400
X-MC-Unique: HY8K750BPoGkzJCInrZnrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E7E71009441
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:30:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF2E476206;
 Tue, 14 Jul 2020 04:30:05 +0000 (UTC)
Date: Tue, 14 Jul 2020 00:30:03 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 1/1] python: add check-python target
Message-ID: <20200714043003.GA3012808@localhost.localdomain>
References: <20200714013026.9019-1-jsnow@redhat.com>
 <20200714013026.9019-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200714013026.9019-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:30:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2020 at 09:30:26PM -0400, John Snow wrote:
> Move pylintrc and flake8 up to the root of the python folder where
> they're the most useful. Add a requirements.cqa.txt file to house
> the requirements necessary to build a venv sufficient for running
> code quality analysis on the python folder. Add a makefile that
> will build the venv and run the tests.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  Makefile                    |  1 +
>  python/{qemu =3D> }/.flake8   |  0
>  python/Makefile.include     | 33 +++++++++++++++++++++++++++++++++
>  python/{qemu =3D> }/pylintrc  |  1 +
>  python/requirements.cqa.txt |  3 +++
>  5 files changed, 38 insertions(+)
>  rename python/{qemu =3D> }/.flake8 (100%)
>  create mode 100644 python/Makefile.include
>  rename python/{qemu =3D> }/pylintrc (99%)
>  create mode 100644 python/requirements.cqa.txt
>=20
> diff --git a/Makefile b/Makefile
> index b1b8a5a6d0..41808be392 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -478,6 +478,7 @@ dummy :=3D $(call unnest-vars,, \
>                  trace-obj-y)
> =20
>  include $(SRC_PATH)/tests/Makefile.include
> +include $(SRC_PATH)/python/Makefile.include
> =20
>  all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurs=
e-all modules $(vhost-user-json-y)
> =20
> diff --git a/python/qemu/.flake8 b/python/.flake8
> similarity index 100%
> rename from python/qemu/.flake8
> rename to python/.flake8
> diff --git a/python/Makefile.include b/python/Makefile.include
> new file mode 100644
> index 0000000000..917808e2f1
> --- /dev/null
> +++ b/python/Makefile.include
> @@ -0,0 +1,33 @@
> +# -*- Mode: makefile -*-
> +
> +PYLIB_VENV_DIR=3D$(BUILD_DIR)/venv/cqa
> +PYLIB_VENV_REQ=3D$(SRC_PATH)/python/requirements.cqa.txt
> +
> +$(PYLIB_VENV_DIR): $(PYLIB_VENV_REQ)
> +=09$(call quiet-command, \
> +=09    $(PYTHON) -m venv $@, \
> +=09    VENV, $@)
> +=09$(call quiet-command, \
> +=09    $(PYLIB_VENV_DIR)/bin/python3 -m pip -q install -r $(PYLIB_VENV_R=
EQ), \
> +=09    PIP, $(PYLIB_VENV_REQ))
> +=09$(call quiet-command, touch $@)
> +

Maybe we should try to create a generic rule that takes a directory
name and a requirements file and creates the venv accordingly, instead
of duplicating the other similar rules under tests/Makefile.include?

> +pylib-venv: $(PYLIB_VENV_DIR)
> +
> +check-python: pylib-venv
> +=09$(call quiet-command, cd $(SRC_PATH)/python && \
> +=09    $(PYLIB_VENV_DIR)/bin/python3 -m flake8 qemu, \
> +=09    FLAKE8, \
> +=09    $(SRC_PATH)/python/qemu \

I can see how this venv would be very useful to run the same checks on
other Python code (for instance, the acceptance tests themselves), so
we'd also need another "check-python"-like rule, or include those on
the same call.

Ideas? :)

Thanks!
- Cleber.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NNMkACgkQZX6NM6Xy
CfPCzxAAkDPvWZ034bXhULrS6bPHLfVF/0Qo3+GiOn4+kqkwNIFNltWhBwNJJHJf
DpHShGky/AK9PJTfk6Kuk4s0it2OTYdibVpV+jHp2LUMRHs8vtZ24CT6P5nZn4AE
fR4ZVCl8HPkjT0oO2HtkXCtjjK6TdhSPXQ659PGKDQ8G+pMLFLwgQwYVytUdmTUy
Xdm0vYifDUeb0DMDio2a3aiVgtkF7h4lzsCmxB97ITsHZJuIN6Wjz4OI4k0ibXhK
mmxxpPk8bbf99YdCobRS/ScCh+cc1ym1y6L4+iHQCXX0CuJaojCcKkJ338vjxDu8
pSpAI+IpfATuM+V91yi/WFkkfHTE1rsAjR9dyOUnWGeIQzhFva9/eVeJ6xw8cMsY
z4SuY1EVohv8sg68QWz7N9ikDrpIo/NavGNOgYoxt/z5kCmkRCnpUTRXBNCmtKKr
HEjt83Vzh5O1IVosew6O9sfW221g3sDXNtuu8QAi/R0iFcHBuMU93cTogpKMvHcc
nJsdbE/s9xeOHxr/Bjnx8N8hifOldB706aJh8TwCIIZMMfRw6n+VN/35m7FWFEVG
Rd9rbAFkotSBTBsH8dRwg8qkknvkivil9h8ViuxP3Mwm3Beyu9wM6w3Al/gAE7nj
oOacUjGdhAGp+EyO1lnj7VWROLhB9h1Gf6TkwGROJqq2qDjfmYs=
=RnCE
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--


