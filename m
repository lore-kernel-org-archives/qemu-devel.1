Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803C9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447C5207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCENdGxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447C5207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaeg-00014v-FR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyadX-0008D5-GS
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:47:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25556
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyadV-0006bW-Jh
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHYMgp7dccR8OqdhT2Dvku33n1oGX34gNmZM7hmLvlA=;
 b=CCENdGxUvWQ5HjYztW6Xwy4626RBsin5CnEDNk34x2euU77M2Wmvr+eGLoqJ+cZftpnITQ
 un8tEdIrzfqsgY0C675gDCG85RKENTKjqGeVmgDEyAZL36QLWMhttM86g9G5b9zV/dSabo
 EqFnXujX7ZeYmkvdLb4w1MD6w0sE1VI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Tu-L44YnM-e-OqU0JrqCGw-1; Thu, 23 Jul 2020 08:47:43 -0400
X-MC-Unique: Tu-L44YnM-e-OqU0JrqCGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 608A010A1520
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 12:46:50 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 126E719D81;
 Thu, 23 Jul 2020 12:46:46 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:46:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH for-5.1 0/3] virtiofsd: allow virtiofsd to
 run in a container
Message-ID: <20200723124645.GM186372@stefanha-x1.localdomain>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722181914.GB598987@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722181914.GB598987@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
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
Cc: virtio-fs@redhat.com, vromanso@redhat.com, qemu-devel@nongnu.org,
 rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 02:19:14PM -0400, Vivek Goyal wrote:
> On Wed, Jul 22, 2020 at 02:02:03PM +0100, Stefan Hajnoczi wrote:
> > Container runtimes handle namespace setup and remove privileges needed =
by
> > virtiofsd to perform sandboxing. Luckily the container environment alre=
ady
> > provides most of the sandbox that virtiofsd needs for security.
> >=20
> > Introduce a new "virtiofsd -o chroot" option that uses chroot(2) instea=
d of
> > namespaces. This option allows virtiofsd to work inside a container.
> >=20
> > Please see the individual patches for details on the changes and securi=
ty
> > implications.
> >=20
> > Given that people are starting to attempt running virtiofsd in containe=
rs I
> > think this should go into QEMU 5.1.
>=20
> Hi Stefan,
>=20
> I have written a document to help with testing virtiofs with any changes.
>=20
> https://github.com/rhvgoyal/misc/blob/master/virtiofs-tests/virtio-fs-tes=
ting-requirement.txt
>=20
> Will be good to run some of these tests to make sure there are no
> regressions due to these changes.

Thank you! I will run them and post the results.

Stefan

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZhrUACgkQnKSrs4Gr
c8ifwQgAnRfwLw3v2RsrTVxdGUTdcqsHwsvUWfjyL9nd764aMInem2uO2wX1uwS8
LBCwSetSYNjGvZPUJTQ4EPAD/cE3Y7v6e8M9Uxc/iM69Nye10KnwfyOWizYi217G
JTaAjXYU5WEZJJzNtZW3oqJJKKTdbx+D8mVXYnBH58xqAbM0X3ijPgbuywrTz26g
U4+/fjbCD+9O1JYZEs6Mj89U6GKusjMG4bGVozNtWT9y1I5e6tJZuY9IGOyB9EtB
tRJWMZWQAy7Gut1C1bvCqR3hF3ff63OzJHAs6ORLC83ZZVrX0FYL+hQEnllS3pk0
FgJKkdj7Hv1A8e9vpw5y7aDL4xJ4Xw==
=GCV3
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--


