Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC31C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC8421548
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6pFXgZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC8421548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jle7p-0004RS-CR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jle7G-00040p-1H
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:52:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jle7D-0004ps-HS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592423573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pYJ9p9lKz01VML3mFoBkQ8xaifVtSw0FWwahHRvRF70=;
 b=T6pFXgZcIwYSoYx2JDnVupehjT6b4lvtWZ9hbJIZGJBRR4TBKEssnpT6KWAXl5BYb7FMfM
 qVNU3XGxFqYjGRK7fhE2NO4TMRZza0wliQqnGPYw5qGDLQQTotGQSWbgA4fuzJdjikpqqw
 GRFM8YkDT0/gRnoecdmrLVwgjZOf46A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-nipYgPZqMPabxXHtAjx62A-1; Wed, 17 Jun 2020 15:52:49 -0400
X-MC-Unique: nipYgPZqMPabxXHtAjx62A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B3E8035CE;
 Wed, 17 Jun 2020 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-214.rdu2.redhat.com
 [10.10.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FD3719D71;
 Wed, 17 Jun 2020 19:52:43 +0000 (UTC)
Date: Wed, 17 Jun 2020 15:52:41 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 0/7] python: create installable package
Message-ID: <20200617195241.GA434320@localhost.localdomain>
References: <20200603001523.18085-1-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200603001523.18085-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 15:42:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 08:15:16PM -0400, John Snow wrote:
> Based-on: 20200602214528.12107-1-jsnow@redhat.com
>=20
> This series factors the python/qemu directory as an installable
> module. As a developer, you can install this to your virtual environment
> and then always have access to the classes contained within without
> needing to wrangle python import path problems.
>

First of all, major kudos for picking up this task.  It's so high in
importance to so many users (myself included) that I feel like I owe
you many truck loads of beers now. :)

> When developing, you could go to qemu/python/ and invoke `pipenv shell`
> to activate a virtual environment within which you could type `pip
> install -e .` to install a special development version of this package
> to your virtual environment. This package will always reflect the most
> recent version of the source files in the tree.
>=20
> When not developing, you could install a version of this package to your
> environment outright to gain access to the QMP and QEMUMachine classes
> for lightweight scripting and testing.
>=20
> This package is formatted in such a way that it COULD be uploaded to
> https://pypi.org/project/qemu and installed independently of qemu.git
> with `pip install qemu`, but of course that button remains unpushed.
>=20
> There are a few major questions to answer first:
>=20
> - What versioning scheme should we use? See patch 2.
>=20
> - Should we use a namespace package or not?
>   - Namespaced: 'qemu.machine', 'qemu.monitor' etc may be separately
>     versioned, packaged and distributed packages. Third party authors
>     may register 'qemu.xxx' to create plugins within the namespace as
>     they see fit.
>=20
>   - Non-namespaced: 'qemu' is one giant glob package, packaged and
>     versioned in unison. We control this package exclusively.
>

For simplicity sake, I'd suggest starting with non-namespaced
approach.  It should be easier to move to a namespaced package if the
need arises.  Also, there are many ways to extend Python code without
necessarily requiring third party authors to register their packages
according to a namespace.

In the Avocado project, we have been using setuptools entrypoints with
a reasonable level of success.  Anyone can have code under any
namespace whatsoever extending Avocado, as long as it register their
entrypoints.

> - How do we eliminate sys.path hacks from the rest of the QEMU tree?
>   (Background: sys.path hacks generally impede the function of static
>   code quality analysis tools like mypy and pylint.)
>=20
>   - Simplest: parent scripts (or developer) needs to set PYTHONPATH.
>=20
>   - Harder: Python scripts should all be written to assume package form,
>     all tests and CI that use Python should execute within a VENV.
>

Having a venv is desirable, but it's not really necessary.  As long as
"python setup.py develop --user" is called, that user can access this
code without sys.path hacks.  And if the user chooses to use a venv,
it's just an extra step.

In the Avocado project, we have a `make develop` rule that does that
for the main setup.py file, and for all plugins we carry on the same
tree, which is similar in some regards to the "not at the project root
directory" situation here with "qemu/python/setup.py".

>   In either case, we lose the ability (for many scripts) to "just run" a
>   script out of the source tree if it depends on other QEMU Python
>   files. This is annoying, but as the complexity of the Python lib
>   grows, it is unavoidable.
>

Like I said before, we may introduce a "make develop"-like
requirement, but after that, I don't think we'll loose anything.
Also, I think this is just a sign of maturity.  We should be using
Python as it's inteded to be used, and sys.path hacks is not among
those.

>   In the VENV case, we at least establish a simple paradigm: the scripts
>   should work in their "installed" forms; and the rest of the build and
>   test infrastructure should use this VENV to automatically handle
>   dependencies and path requirements. This should allow us to move many
>   of our existing python scripts with "hidden" dependencies into a
>   proper python module hierarchy and test for regressions with mypy,
>   flake8, pylint, etc.
>=20
>   (We could even establish e.g. Sphinx versions as a dependency for our
>   build kit here and make sure it's installed to the VENV.)
>=20
>   Pros: Almost all scripts can be moved under python/qemu/* and checked
>   with CQA tools. imports are written the same no matter where you are
>   (Use the fully qualified names, e.g. qemu.core.qmp.QMPMessage).
>   Regressions in scripts are caught *much* faster.
>=20
>   Downsides: Kind of annoying; most scripts now require you to install a
>   devkit forwarder (pip3 install --user .) or be inside of an activated
>   venv. Not too bad if you know python at all, but it's certainly less
>   plug-n-play.
>=20
> - What's our backwards compatibility policy if we start shipping this?
>=20
>   Proposed: Attempt to maintain API compatibility (after stabilizing the
>   library). Incompatible changes should probably cause a semver bump.
>
>   Each published release makes no attempt to support any version of QEMU
>   other than the one it was released against. We publish this on the tin
>   in big red letters.

It may be too early to tell, but it's not clear to me how we'll keep
both the QEMU version supported by a given release, and its API
"level".

Are you proposing that we have, say, "python-qemu" version 10, being
the 10th API version, without any regard to the QEMU version
supported?  Or version 10.5.3 would mean 10th API version, intended
to support QEMU 5.3?

>=20
> TESTING THIS PACKAGE OUT:
>=20
> 1. You can install to your local user's environment normally by
> navigating to qemu/python/ and typing "pip3 install --user ."
>

s/install/develop/ should be a better option here.  I mean, I'm
not aware of any reason to user install while developing.

- Cleber.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl7qdIYACgkQZX6NM6Xy
CfOlSg//S3pfWrP7rJ66pfefDiwdlRwz1bb/L9yK7AqBA/T65X8ilOiKwiNHVWrt
lrCSF3sIgH8jTgIi3NkQligSrD1GgyBQV2jACjRKX9nijXu1xgTJ7gBzQTaZBw3Q
xzqqDdKABtACzge4RhSgGkReRNFk8bz0qk6nsi1Eghe8SqtQfAgG0oJUIPXsBvnZ
T0yA0CdUlpVAKT4y3rPQ/2CHV+gRyYhWC+MHAr1FUIFY5O7kd5QdyHO/rTT7qjsu
LMJ2FT0phM4VyBEEX/bZXAAYc5wpdqbBSBPigKKcT9k1VpzKMkeOyHW8f3TRrmEm
Bvd3x34FazBeiu5Mm+7k498RhmzgS9wxgOBRJBEQ2MsLFnR/U5avXFhkfFTIfVGW
ne5o2nZXa4hI56JQxuSVatlr2vXFBzsVWVbK2TH1ABsLZ10nQln/xlvAvMBlfx+T
m/bKt8y56lwkJWnYqAMmlYqs8ylw7AJJsITYpod/yKGKxKYnVwR6ZE9vLZM/9TpG
H+hd/gFT3V8TQhV8YQpCN43h8y5LSspfLLGhl5C3jaCqW0+8nK4UPRb9eKEsPxyx
zPpKsFG8seNaM3z24fqUYamqoGDkKZRzEXq5NCtoDLVgP8Kh1fUw4CVnTWTovK7W
lFlYk05Y0WmjRKQZA8ChtLBdJzaXxJXprJGVmkDBBQldNq5LJYM=
=qExQ
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--


