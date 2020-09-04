Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD65EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A13A206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7rTduFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A13A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECiS-00036l-Kh
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kECgo-000117-Tn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:27:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kECgl-0003Yi-Qk
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599229657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SkdmzbIuZbxlwvgJUYMzYokQsK2472CkYuqMxWz1Rnw=;
 b=P7rTduFYlO6Maqn+rC9inKDrxr/kBFoltPoGzAPH1D4VLNihNyQ/e8yb2AButrymMDtH9S
 yeXJa+w7dMJXuOQ5WRv7ThfQ2dMsFBhReQebRYcpoJcOm163eAh5sM7d78/OwJbulEmqBR
 vROUtdov1nDQ1bRIGM7tykW1EZLTY8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-BN026mUCNBuLsMENLISMvQ-1; Fri, 04 Sep 2020 10:27:34 -0400
X-MC-Unique: BN026mUCNBuLsMENLISMvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 169C81084D63;
 Fri,  4 Sep 2020 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB93F7FB7C;
 Fri,  4 Sep 2020 14:27:28 +0000 (UTC)
Date: Fri, 4 Sep 2020 10:27:27 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200904142727.GA232153@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709085507.GA536480@nautilus.usersys.redhat.com>
 <20200903211211.GC55646@localhost.localdomain>
 <547ef390fe84bd919f2601d5a29c98f345c6c881.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <547ef390fe84bd919f2601d5a29c98f345c6c881.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
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
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 11:11:25AM +0200, Andrea Bolognani wrote:
> On Thu, 2020-09-03 at 17:12 -0400, Cleber Rosa wrote:
> > On Thu, Jul 09, 2020 at 10:55:07AM +0200, Erik Skultety wrote:
> > > On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > > > +.. note:: there are currently limitations to gitlab-runner itself =
when
> > > > +          setting up a service under FreeBSD systems.  You will ne=
ed to
> > > > +          perform steps 4 to 10 manually, as described at
> > > > +          https://docs.gitlab.com/runner/install/freebsd.html
> > >=20
> > > What kinds of limitations? Is it architecture constrained maybe? I'm =
asking
> > > because we have all of the steps covered by an Ansible playbook, so I=
 kinda got
> > > triggered by the word "manually". Also, the document only mentions 9 =
steps
> > > overall.
> >=20
> > FreeBSD's "service management" (systemd/sys-v like) is not covered by
> > the GO library[1] used on gitlab-runner.  It's not ideal, and the
> > second best solution would be to script the equivalent handling within
> > the playbook, but I remember trying and finding some inconsistencies.
> > Then, I had to give it up and defer to whenever a FreeBSD job is
> > actually added.
> >=20
> > [1] - https://github.com/ayufan/golang-kardianos-service
>=20
> Note that this is a fork of
>=20
>   https://github.com/kardianos/service
>=20
> where FreeBSD support was added recently with
>=20
>   https://github.com/kardianos/service/commit/14b2cc59a290407a6f1cb3daba5=
9069429d9665b
>

That's good news!

> I'm not sure why gitlab-runner would use a fork rather than the
> primary repository, but perhaps they can be convinced to switch and
> gain better FreeBSD support in the process.
>

I can only imagine they were using the fork because the primary
repository did not have the bits they needed there... and were not
willing or were not successful and getting them there.

We can ask/hope/wait for gitlab to switch, and then this will no
longer be an issue indeed.

Thanks,
- Cleber.

> --=20
> Andrea Bolognani / Red Hat / Virtualization
>=20

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9STssACgkQZX6NM6Xy
CfO2bBAAu6aA/y1N6qyH6QCIT9tFD2+KUJmnRuPMXsYDy3BaZH75NgMZh1UQ3WPB
WsdUlVnR2aaAOPYRl3sQKNHCXb23svjiqiG5fvGU+FGz1+OqTC8shQm3d/+AwOld
enWByfaH0C56t/j1YPrMkX3OVSsw+dAYZJg1GSGAZRduuKnv4EkHPy7tgaoiHAJn
7uOdInI0TWU/2VaHMzdoxLF32EJeK4CH2xO94gsRrvTpt4aKTvBjULN6mSLfTeg3
kq1oBT0xIFcUPk1eL6SlOWJ0F9gGyEo7U6zHtTBd4PjNUezrndFQSP/g5SFt+woo
gmwahc/R56SZyIe9ZJJzzDqSRMyhgq1mSy011tXo5/MyPj9x/oLowfMTAb1ngTxB
M80kSg2WpV8i4HAyxjIqWnJ9ZRbRmbDs9j2im26GPPpbuKlVasUhkdNN/QfVpksh
c2s5GwmjLiZ7XfTJ6OSgo5uhODequ/rOw0eHl4q623K6ZJivZbWYdoYkRn8pycED
rBEDSf6yXRWWgEjrmtOWriK14YpIZK3Npmen8uF0aCquUJuHag1tPdGPNlqSWRYe
3gnH5lHimYor2kBWuW8+qU6V9ws4DPwp58vuHU9GeRN4KIL80fHfrEBdspggtyE/
kJBRg6+NhJgVfK6L3aVicHCADZsCORSoeJs1g2Og+uPh4b6Mc1Q=
=bcyk
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


