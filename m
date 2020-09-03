Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913BC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5981206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adWsP58z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5981206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDyUg-00040T-2w
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDyU6-0003an-1j
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 19:17:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54526
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDyU3-0007KK-BR
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 19:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599175053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TlMp80nRk+T8X9yJNGLjC3cA73q+T5VE26LjemymPto=;
 b=adWsP58z6tUm+fhjfJsW3sKRjer3x2mHsrouN0IAWT+5sRdXY3z6TTMP0slerVv1SQ7lNK
 iVVvovAJBxtrgkqpk17Q0l7YLTBza/SGIPEUzoaEWmLLqCF+G8CJb4jqUtfdQ7ZbH76KYd
 z/MFlGeKikhQcHA+rFpQXopTfvYq13w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-svwHc2F5MJyTN_8s16HhUQ-1; Thu, 03 Sep 2020 19:17:29 -0400
X-MC-Unique: svwHc2F5MJyTN_8s16HhUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50BFE8015A4;
 Thu,  3 Sep 2020 23:17:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 555945D9CC;
 Thu,  3 Sep 2020 23:17:24 +0000 (UTC)
Date: Thu, 3 Sep 2020 19:17:22 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200903231722.GD55646@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <05209e8d-e501-74d0-ef58-25f2a971a4a8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <05209e8d-e501-74d0-ef58-25f2a971a4a8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 19:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 12:07:32PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 7/9/20 4:46 AM, Cleber Rosa wrote:
> > This is a mapping of Peter's "remake-merge-builds" and
> > "pull-buildtest" scripts, gone through some updates, adding some build
> > option and removing others.
> >=20
> > The jobs currently cover the machines that the QEMU project owns, and t=
hat
> > are setup and ready to run jobs:
> >=20
> >  - Ubuntu 18.04 on S390x
> >  - Ubuntu 20.04 on aarch64
> >=20
> > During the development of this set of jobs, the GitLab CI was tested
> > with many other architectures, including ppc64, s390x and aarch64,
> > along with the other OSs (not included here):
> >=20
> >  - Fedora 30
> >  - FreeBSD 12.1
> >=20
> > More information can be found in the documentation itself.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++
> >  .gitlab-ci.yml                         |   1 +
> >  docs/devel/testing.rst                 | 147 +++++++++++++++++
>=20
> Time to consider moving the CI doc in a separate file...
>=20
> >  scripts/ci/setup/build-environment.yml | 217 +++++++++++++++++++++++++
> >  scripts/ci/setup/gitlab-runner.yml     |  72 ++++++++
> >  scripts/ci/setup/inventory             |   2 +
> >  scripts/ci/setup/vars.yml              |  13 ++
>=20
> Should we name these last two as inventory.template
> and vars.yml.template?
>

I get your point, and actually like your suggestion but I've not seen
this done on any Ansible based projects I've come across.  The
inventory file, for instance, is tends to be this "localhost" version
pretty much everywhere.  The same goes for vars.yml, so I'm inclined
to leave them as is...  but if you have strong feelings against it,
I won't fuss nor fight.

> Maybe you can add them with gitlab-runner.yml and a part of
> the documentation in a first patch,
>=20
> Then build-environment.yml and another part of the doc
> in another patch,
>=20
> Finally gating.yml and the related missing doc as the
> last patch?
>

Sounds good.  This is indeed a very large patch as it is.

Thanks!
- Cleber.

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ReYAACgkQZX6NM6Xy
CfNyiBAAyQNQ6gBi4ha6mjq8ubf3i9sBXTW+hC+0dIXVzc2hfWF68zoQLXhCND5o
YWZZFh++HUBsJ4rCkzyi8kNX1cVUY3sU6CSyVQCoAN/hR1QeXWCChIKojzCtmf7E
YXEJtT7ScDWEB8sgvLIUlwH6vQhHpV2lFhaGEC+xjVZ2We0+tlMLcJvJ/L1RW42b
rvnhWUj23bLd3YscIhWwQ82W+U5QIPGo9TrSofNB9NuRkM8uVq3CKGSycrqWDqEh
NiJtRHmuaMbwiOS8uJCvzX6Z2dVQdDodLcoZIkXJum6h7uOZYoTuYrMn/PsS3DPJ
1QpxfLGGPfnHnedjGZHf6zYX25cN8o2Qi0mPQnVTP8tiJPAs+daGdSs6pzqRwIX7
AZugPyt+YAUf5tRwFX7ZuN7Kej8FAId4yR6TrGq+qrY6eNbIYm55zf8wGri9KMGt
dhwAAV0g4XvyK9d1Ecz7nsj0NeppLNKFfVSxDJJn59AcE1qnql6VPzfX7z/eOAWL
+HglofWIqjUdmK62ay9mLxMYxfp31IWB/RC/iNfNNRNHYPW6nEVM8Ha9wX5ZuvGZ
q2wGvRQTE25hzmqQ8rEbPr3AsiBJNXjMoRfRJbnOUj0dohkpZZFECVZjx8xwh5cw
50rT+sipfs4McAe1MhsamoYEkDX7vYIaSXh0LJLoBQGKyK27fM0=
=mA8a
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--


