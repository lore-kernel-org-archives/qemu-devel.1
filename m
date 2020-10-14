Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65D62078A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnW8rZTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65D62078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSm3N-0008Ll-Kf
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSm0a-0007NC-Jm
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSm0X-0007F8-35
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602702014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wN4OzxD4RMgeqEVYCftU9UlCR+Py2zA6F+3ybmdpfTE=;
 b=dnW8rZTEAMSJzzQG+yfSPy09Pcq/cUtpL1qLeAJdKGwRrCw5P63unjbPrdFwX0LefGozyw
 TwhBK3LPXJBZsI6JL+7yod9hN8eCgjisk1NoYgtrWhMUbZR1qD0mlufMHaOks01j4K6pxy
 VPhkrOsPWyjVj5iGK2tUENuT+MU0vno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-AI1KVnQEO3KoZpLy_WEl0A-1; Wed, 14 Oct 2020 14:59:59 -0400
X-MC-Unique: AI1KVnQEO3KoZpLy_WEl0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A39664084;
 Wed, 14 Oct 2020 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EE635577F;
 Wed, 14 Oct 2020 18:59:54 +0000 (UTC)
Date: Wed, 14 Oct 2020 14:59:52 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 2/4] Jobs based on custom runners: build environment
 docs and playbook
Message-ID: <20201014185952.GA1196177@localhost.localdomain>
References: <20201014052140.1146924-1-crosa@redhat.com>
 <20201014052140.1146924-3-crosa@redhat.com>
 <20201014173009.GU115189@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014173009.GU115189@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 06:30:09PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Oct 14, 2020 at 01:21:38AM -0400, Cleber Rosa wrote:
> > To run basic jobs on custom runners, the environment needs to be
> > properly set up.  The most common requirement is having the right
> > packages installed.
> >=20
> > The playbook introduced here covers a number of different Linux
> > distributions and FreeBSD, and are intended to provide a reproducible
> > environment.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  docs/devel/ci.rst                      |  32 ++++
> >  scripts/ci/setup/build-environment.yml | 220 +++++++++++++++++++++++++
> >  scripts/ci/setup/inventory             |   2 +
> >  3 files changed, 254 insertions(+)
> >  create mode 100644 scripts/ci/setup/build-environment.yml
> >  create mode 100644 scripts/ci/setup/inventory
> >=20
> > diff --git a/docs/devel/ci.rst b/docs/devel/ci.rst
> > index 41a4bbddad..208b5e399b 100644
> > --- a/docs/devel/ci.rst
> > +++ b/docs/devel/ci.rst
> > @@ -52,3 +52,35 @@ As a general rule, those newly added contributed job=
s should run as
> >  The precise minimum requirements and exact rules for machine
> >  configuration documentation/scripts, and the success rate of jobs are
> >  still to be defined.
> > +
> > +Machine Setup Howto
> > +-------------------
> > +
> > +For all Linux based systems, the setup can be mostly automated by the
> > +execution of two Ansible playbooks.  Start by adding your machines to
> > +the ``inventory`` file under ``scripts/ci/setup``, such as this::
> > +
> > +  [local]
> > +  fully.qualified.domain
> > +  other.machine.hostname
> > +
> > +You may need to set some variables in the inventory file itself.  One
> > +very common need is to tell Ansible to use a Python 3 interpreter on
> > +those hosts.  This would look like::
> > +
> > +  [local]
> > +  fully.qualified.domain ansible_python_interpreter=3D/usr/bin/python3
> > +  other.machine.hostname ansible_python_interpreter=3D/usr/bin/python3
> > +
> > +Build environment
> > +~~~~~~~~~~~~~~~~~
> > +
> > +The ``scripts/ci/setup/build-environment.yml`` Ansible playbook will
> > +set up machines with the environment needed to perform builds and run
> > +QEMU tests.  It covers a number of different Linux distributions and
> > +FreeBSD.
> > +
> > +To run the playbook, execute::
> > +
> > +  cd scripts/ci/setup
> > +  ansible-playbook -i inventory build-environment.yml
> > diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/=
build-environment.yml
> > new file mode 100644
> > index 0000000000..0e8894bca9
> > --- /dev/null
> > +++ b/scripts/ci/setup/build-environment.yml
> > @@ -0,0 +1,220 @@
> > +---
> > +- name: Installation of basic packages to build QEMU
> > +  hosts: all
> > +  tasks:
> > +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> > +      apt:
> > +        update_cache: yes
> > +        # Originally from tests/docker/dockerfiles/ubuntu1804.docker
> > +        pkg:
> > +          - ccache
> > +          - clang
> > +          - gcc
> > +          - gettext
> > +          - git
> > +          - glusterfs-common
> > +          - libaio-dev
> > +          - libattr1-dev
> > +          - libbrlapi-dev
> > +          - libbz2-dev
> > +          - libcacard-dev
> > +          - libcap-ng-dev
> > +          - libcurl4-gnutls-dev
> > +          - libdrm-dev
> > +          - libepoxy-dev
> > +          - libfdt-dev
> > +          - libgbm-dev
> > +          - libgtk-3-dev
> > +          - libibverbs-dev
> > +          - libiscsi-dev
> > +          - libjemalloc-dev
> > +          - libjpeg-turbo8-dev
> > +          - liblzo2-dev
> > +          - libncurses5-dev
> > +          - libncursesw5-dev
> > +          - libnfs-dev
> > +          - libnss3-dev
> > +          - libnuma-dev
> > +          - libpixman-1-dev
> > +          - librados-dev
> > +          - librbd-dev
> > +          - librdmacm-dev
> > +          - libsasl2-dev
> > +          - libsdl2-dev
> > +          - libseccomp-dev
> > +          - libsnappy-dev
> > +          - libspice-protocol-dev
> > +          - libssh-dev
> > +          - libusb-1.0-0-dev
> > +          - libusbredirhost-dev
> > +          - libvdeplug-dev
> > +          - libvte-2.91-dev
> > +          - libzstd-dev
> > +          - make
> > +          - python3-yaml
> > +          - python3-sphinx
> > +          - sparse
> > +          - xfslibs-dev
>=20
> This needs updating to add meson, and with Paolo's series today you
> might as well go ahead and add ninja-build immediately too
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg04025.html
>=20
> Same for all the other distro package lists.
>=20
>

Good point, will do.

Thanks!
- Cleber.

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20
>=20

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+HSqEACgkQZX6NM6Xy
CfOq5w/9FGhTFz0xoZoCEiwkYCNFgN8UxxYTVlFsOdhaBaGrn7p8/06kxqBfUzwH
KVOvvSrFF3DA4wDEI7hggpYuqFkz8t5cA5CvB98G/4tiRpZwlLHTWNrVcymmKPDE
TMKyilX29bkmkBP8oO399XB42SUxJtr6k4Vy0Ff/FOosrfN0Ak6DuJUD57cnMsr9
Edrjg1z19nhj2RkUt4UlG97CP4SV2kU18RewW9LoaLhCfd/AJgXLzMLhF4etEL0f
ho+RRQm8Uwbfxs+aSZHUJUaxj+1xelTAQMr2xx63+mVzbQR2cDCTX6ZmSmGDM/uh
LdyiR0HGuZTrzS0OthOyOeQivXu1kccGMgJx8VauGdiM9ENXTORvCdpBYsnHqoJx
3iw3LrrzvQV1gCP1xcKb5G8AJ+DjZy5HEim/2nIYUFgY7vnPZhm2jOhZbu2OpFf0
VXk2B6OyMKKrCU45jJOM2kUTk03wflKDn8N5cmGRMdAPYXvnBuyqEVN88soIUT5f
BUAkvJcPYIhm39bVHert5vhwIGQkWfhz3sT8eUwP7bFE2xCR/pGsfZOHEV0QALK5
QfJOdcBChlFJ6A7Alqq2M+Z42fuxDhpePj5REph5kosmO/uMnxoYPJe63OqBzsLS
MddwEagdDmmJnRDAb+SfSyXhLS75YIwCLlN2Tw18jxOk/vOwxu4=
=/m6v
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--


