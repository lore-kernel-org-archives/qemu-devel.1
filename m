Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9368C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E056F247A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaXOKcWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E056F247A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrQ0-0002lD-Ss
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 15:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXrPI-0001mS-Ex
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXrPF-0003Um-14
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603914406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SZlS6wSC4OWBNALuwd3bFLwu9xZgrtXL8nObISzfXU=;
 b=MaXOKcWnE796liBigG5R1HxtyvxE1kj5MlkGlD8iN2NIqv+/imff7Q9Q7e+wTbUIknhhw6
 P2JC5rNB34uU5UOW6wAFBROqXIJZg48jCanbI8DcjC5GQWr0enx0GoBjprVwpnJbUR81BI
 5H1cZ6XNsCvhLD9h5epF38M1PwOPSgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-TUL0gD9uMaCvG3ugRiilWQ-1; Wed, 28 Oct 2020 15:46:41 -0400
X-MC-Unique: TUL0gD9uMaCvG3ugRiilWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BF938070F4;
 Wed, 28 Oct 2020 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63A3A1001281;
 Wed, 28 Oct 2020 19:46:34 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:46:32 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 02/15] python: add qemu package installer
Message-ID: <20201028194632.GE2201333@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-3-jsnow@redhat.com>
 <20201028151049.GC2201333@localhost.localdomain>
 <6498254a-46e0-a780-e7db-34275af734ae@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6498254a-46e0-a780-e7db-34275af734ae@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 01:02:52PM -0400, John Snow wrote:
> On 10/28/20 11:10 AM, Cleber Rosa wrote:
> > > +mirror <https://gitlab.com/jsnow/qemu/-/tree/python>`_, but
> > > +contributions must be sent to the list for inclusion.
> >=20
> > IMO it's not clear if this branch/mirror is your development work, a
> > staging area, etc.
> >=20
>=20
> Fair enough. jsnow/qemu/python is intended as a staging area for patches
> that have been vetted on-list.
>=20
> jsnow/qemu/master is a lazily-updated mirror. (I tend to update it every =
day
> as part of my development process, but there are days I don't write code.=
)
>=20
> jsnow/qemu/python-* is development work; review branches, etc.
>=20
> I'll try to rephrase this a bit. What I want to communicate:
>=20
> - This package exists as a subfolder of a larger project
> - I am responsible for maintaining this package, but not for the larger
> project
> - Please contact *me* for problems with this package
> - Contributions should go through qemu-devel (I will gently redirect
> contributors who may send pull requests to the qemu devel list.)
>

OK, sounds good.  I'll look at the exact rewording on v+1.

> > > diff --git a/python/setup.cfg b/python/setup.cfg
> > > new file mode 100755
> > > index 0000000000..12b99a796e
> > > --- /dev/null
> > > +++ b/python/setup.cfg
> > > @@ -0,0 +1,18 @@
> > > +[metadata]
> > > +name =3D qemu
> > > +maintainer =3D QEMU Developer Team
> > > +maintainer_email =3D qemu-devel@nongnu.org
> > > +url =3D https://www.qemu.org/
> > > +download_url =3D https://www.qemu.org/download/
> > > +description =3D QEMU Python Build, Debug and SDK tooling.
> > > +long_description =3D file:PACKAGE.rst
> > > +long_description_content_type =3D text/x-rst
> > > +classifiers =3D
> > > +    Development Status :: 3 - Alpha
> > > +    License :: OSI Approved :: GNU General Public License v2 (GPLv2)
> > > +    Natural Language :: English
> > > +    Operating System :: OS Independent
> > > +
> >=20
>=20
> Also ... licensing question, do we need *L*GPLv2, or does Python not have=
 a
> "linking exception" problem?
>=20
> I guess we can't really re-license these files anyway, so nevermind.
>=20
> (I immediately regret asking this.)
>

I'll just pretend you never did.

> > I know the sky is the limit, but I miss the Python version classifier,
> > at least:
> >=20
> >    Programming Language :: Python :: 3 :: Only
> >=20
>=20
> Sure.
>=20
> Wait, why can you specify Python as a language? Is it possible to have
> non-Python packages on PyPI?
>=20
> *CONCERNED*
>

I guess it has to do with packages that can interact or serve other
languages.  Or, that are (partially) written in another language?

> > And optionally those:
> >=20
> >    Programming Language :: Python :: 3.6
> >    Programming Language :: Python :: 3.7
> >    Programming Language :: Python :: 3.8
> >    Programming Language :: Python :: 3.9
> >=20
> > Although it may be a good idea to add them along test jobs on those
> > specific Python versions.
> >=20
>=20
> Are these worth adding? I've got python_requires >=3D 3.6 down below. Fro=
m my
> test of a blank package upload to PyPI, it seems to display prominently:
>=20
> https://pypi.org/project/qemu/
>=20
> Is there a tangible benefit that you are aware of?
>

AFAICT, the classifiers are about letting people search for packages
that match a given criteria.  It's all metadata, so the benefits are
not super tangible.  I've used those to keep track / document the
Python versions that I know the project has been actively tested on,
and that's the reason of my comment about (CI) test jobs.

> > > +[options]
> > > +python_requires =3D >=3D 3.6
> > > +packages =3D find_namespace:
> > > diff --git a/python/setup.py b/python/setup.py
> > > new file mode 100755
> > > index 0000000000..e93d0075d1
> > > --- /dev/null
> > > +++ b/python/setup.py
> > > @@ -0,0 +1,23 @@
> > > +#!/usr/bin/env python3
> > > +"""
> > > +QEMU tooling installer script
> > > +Copyright (c) 2020 John Snow for Red Hat, Inc.
> > > +"""
> > > +
> > > +import setuptools
> > > +import pkg_resources
> > > +
> > > +
> > > +def main():
> > > +    """
> > > +    QEMU tooling installer
> > > +    """
> > > +
> > > +    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-met=
adata-1babbe54c108
> > > +    pkg_resources.require('setuptools>=3D39.2')
> >=20
> > Getting back to the "test jobs on those specific Python versions" I
> > was really anxious that environments with Python 3.6 will fail to
> > have such a "recent" setuptools version.
> >=20
>=20
> Reasonable doubt. However, this isn't *required* to use the library (the
> QEMU code can continue to just set PYTHONPATH or sys.path as necessary) a=
nd
> bypasses the installer entirely.
>

Right, but I had the impression that activating it in develop mode (at
least) was the intention down the line.

> That gives us some leeway apart from the usual version constraints; in or=
der
> to independently use this library outside of the QEMU tree we may impose
> more modern setups -- as long as the minimum requirements for QEMU itself
> don't break.
>

OK.

> Having a modern setuptools in order to install seems like less of a probl=
em
> barrier; and it seemed like a good idea to make it explicitly fail instea=
d
> of silently doing something weird if it didn't see/understand setup.cfg.
>

Agreed.

> (And it seems like good practice to update pip in your venv, so I think
> we'll be OK except for the stodgiest of users, but sometimes you can't ha=
ve
> new things on old systems without learning some new tricks!)
>=20
> > CentOS 8 has that specific version, while Ubuntu 18.04 has version
> > 39.0.  Ubuntu 20.04 has a recent enough version though.  Given that
> > all GitLab CI moved to 20.04, this should be safe.
> >=20
> > - Cleber.
> >=20
>=20
> FWIW, for the purposes of running the linters, I am using Fedora32 and th=
e
> python36 package.
>

This is a minor suggestion: use CentOS 8 stock Python 3.6 packages,
and then Fedora 33 with also stock Python 3.9.  Even though all
tools are pinned, it's still a good idea to test at least min/max
(if not all) Python versions.

- Cleber.

> > > +
> > > +    setuptools.setup()
> > > +
> > > +
> > > +if __name__ =3D=3D '__main__':
> > > +    main()
> > > --=20
> > > 2.26.2
> > >=20
>=20

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+ZypUACgkQZX6NM6Xy
CfPKkRAAqAaGYxZVrH5SoNtbL5IA+TnooUSXowiveFcgrAP5NXNrNXxyVKmJ6f+b
5CxHcYlgyoozhokB21ySZAL74aZyUBafMCtU1IIDSgdDfEFg/mNca4IO5OrYYcuF
43QeCUzALhe/Ic1vVmRSJrEYN13gj2tAIBsQ00QUT2+is+hcaT4JNWCyWPmhkb9N
qaJvbV5teyfu743T253SP3cn7kk5cHYVeF8ShXGodvsUu4AZkrxovUjZu/kpxuOZ
gCfl+ZwUtLj0/G4Gn7dz3ngb1K1F4oMzQWdW+oK9B8Be+z2jpEKAAYlm6l3/lSI/
Glt06V0H+er01FRUCdZeWdsFGgNF1CFh1hLlgSizmtL81NOLWJkcsnbglskEIFL9
ylnk1X6yrXmBsE8c7mKTlrDOdYSLPj4cQC+pwrqZS+M3TZypkVSuMN6Cvc19oDSn
uPSPER/rq/Cdz9ZhIxjGGtEeKTUECxj4cvYHY84Dg/l2KTh7Ykz5WMYs4ENzkxRH
S6o3M70bGJ4/4xl+iw1b/aJyf6mz51t548vK3KJzq2F6yHv80F9Ck+uhQ0Qi1ASx
H99+wWyx4bgwPGAtR/JpTE9xxuAPp/Mh5AJ5lmqRTsnwKgljcAF2IAe+sFb1ViH1
0KkmjouihPMmVkRxCXHt0qXZ+6BPc4M/j9I/zeNaAdASrdMC5bU=
=B8Qk
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--


