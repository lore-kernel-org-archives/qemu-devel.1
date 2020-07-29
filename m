Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C3EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBF5208A9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 14:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTdHYoAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBF5208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0nVx-0007hc-0y
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 10:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0nVH-0006zw-41
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:56:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k0nVE-000627-Ay
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 10:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596034578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kiXoj/CPJK2G/4VRLgNBz+AF/9chIgMHMotpmJmNCtw=;
 b=LTdHYoAHtpFc/CnwbHl0z91jtMMCjs45b3doCxNlhDNNNAiDcbuKAmgI1+i35+8tXvVugx
 vIqfzSOnZAzhhm2UCPzMsIUwWQQ04rCK0ocxQvY6ViPGI2vUIIa19ze6qB5Uba6atwGeqa
 xfbZKYomjSTWNk3r5jwoqH4Z6R+mvJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-pS1t0dpINHa6njfK02iE9Q-1; Wed, 29 Jul 2020 10:56:14 -0400
X-MC-Unique: pS1t0dpINHa6njfK02iE9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E8CB8035B2;
 Wed, 29 Jul 2020 14:55:36 +0000 (UTC)
Received: from localhost (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B12AB709F5;
 Wed, 29 Jul 2020 14:55:35 +0000 (UTC)
Date: Wed, 29 Jul 2020 15:55:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
Message-ID: <20200729145534.GH52286@stefanha-x1.localdomain>
References: <20200714162659.1017432-1-berrange@redhat.com>
 <20200729103719.GD37763@stefanha-x1.localdomain>
 <20200729113415.GB3451141@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200729113415.GB3451141@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:17:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2020 at 12:34:15PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jul 29, 2020 at 11:37:19AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jul 14, 2020 at 05:26:59PM +0100, Daniel P. Berrang=E9 wrote:
> > > In Fedora 33 rawhide, we now have sphinx 3.1.1, as opposed
> > > to previous 2.2.2. This new version generates a warning on
> > > the source:
> > >=20
> > > docs/qemu-option-trace.rst.inc:4:Malformed option description
> > >   '[enable=3D]PATTERN', should look like "opt", "-opt args",
> > >   "--opt args", "/opt args" or "+opt args"
> > >=20
> > > This turns into an error when QEMU passes -W to sphinx-build
> > >=20
> > > Strangely the previous 2.2.2 code has the exact same logic
> > > for checking the syntax, but it is not being triggered. While
> > > it is only complaining about the first option, I changed all
> > > the options to give consistency.
> > >=20
> > > Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > ---
> > >  docs/qemu-option-trace.rst.inc | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > Thanks, applied to my tracing tree:
> > https://github.com/stefanha/qemu/commits/tracing
>=20
> I'm not sure this is a good idea to queue it, based on the other
> part of this thread about incompatibilities with differnet sphinx
> versions, and the patchew failures.
>=20
> I don't have a answer for how to fix this to make every versions happy.

Yes, thanks. I was playing around with it and considering Sphinx
suppress_warnings.

Let's leave this patch for QEMU 5.1. Fedora rawhide is cutting-edge and
has a smaller userbase than those using older Sphinx versions. At the
moment we can keep the code as-is.

Stefan

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hjeYACgkQnKSrs4Gr
c8i6JQf9H0dj+QtU4QeZbMXbp9tPDAfPBJPOf1itw81TisytkLxdhW33jMDjwK72
NQvxF4c9CNWIOvmBsBfamdDJa2ucCBoKojaOOQ/+q8MfWMC69jnlOws0iDGL8bMe
pY/ovd064c9hZNuRycUAEltZllWuVAmlCwKRtoV+uV7XjEPZQu6CJyuAFC6k1CGt
j7qVsnstt6FybZBVH17Hf6dEq+t+DnKPp9z8QaN+Lb0QW7reCqIEcXewuRhouO/2
TgcQFOTwdDUEkyM2arRzaG/37sBbTsQhp0fRtM7FEvR2CRfzXOBuY+xH1LwbjW11
o6haM0CRvjbOOqg50nOd7ykZA0Vziw==
=3qGf
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--


