Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30943C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E96A2068D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZ9MC5fQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E96A2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvxz-0008MU-K0
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFvwf-0007d7-Ge
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFvwd-0001oD-S1
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599641950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cY9cRBnYjvWVqsiiSLAA7ru1V0YbwB2nhKKq0+srhTY=;
 b=RZ9MC5fQtXE13J+Y75Wkgz/D+ePYb3N9Htx4fK7+0w3MOhJkhXVdYsSFqavBP/YnW0By2A
 mtdm9eQirl9puOl2UQqTqfwPVQt73tKFiFUvZU+3AseicPTs+TcNsEk9J0zH0hAVfnyTZC
 hR9+MAWUn+BRfg5pjmzk5hw6JXVdX3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-fkRaHis5M5K1l4f05_UvMA-1; Wed, 09 Sep 2020 04:59:08 -0400
X-MC-Unique: fkRaHis5M5K1l4f05_UvMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C8978015C6;
 Wed,  9 Sep 2020 08:59:07 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDDA360CC0;
 Wed,  9 Sep 2020 08:59:04 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:59:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 3/4] docs: add qemu-storage-daemon(1) man page
Message-ID: <20200909085900.GG12090@stefanha-x1.localdomain>
References: <20200908093113.47564-1-stefanha@redhat.com>
 <20200908093113.47564-4-stefanha@redhat.com>
 <20200908114233.GC19304@paraplu>
 <20200908143347.GE8175@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200908143347.GE8175@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3ecMC0kzqsE2ddMN"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>, afrosi@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 04:33:47PM +0200, Kevin Wolf wrote:
> Am 08.09.2020 um 13:42 hat Kashyap Chamarthy geschrieben:
> > On Tue, Sep 08, 2020 at 10:31:12AM +0100, Stefan Hajnoczi wrote:
> > > Document the qemu-storage-daemon tool. Most of the command-line optio=
ns
> > > are identical to their QEMU counterparts. Perhaps Sphinx hxtool
> > > integration could be extended to extract documentation for individual
> > > command-line options so they can be shared. For now the
> > > qemu-storage-daemon simply refers to the qemu(1) man page where the
> > > command-line options are identical.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Looks good to me.
>=20
> If you have to respin, maybe an example section with some full command
> lines for common cases would be nice. Maybe one for exporting a qcow2
> image via NBD, and another one for attaching a host_device and having a
> QMP monitor, or something like this.

Good idea. Will fix in v2.

> > > +**Warning:** Never modify images in use by a running virtual machine=
 or any
> > > +other process; this may destroy the image. Also, be aware that query=
ing an
> > > +image that is being modified by another process may encounter incons=
istent
> > > +state.
> >=20
> > I wonder if it's appropriate to mention libguestfs for safe, read-only
> > access to disk images (via `guestfish -ro -i -a disk.qcow2`).  I say
> > this because, the above warning tells what _not_ to do; a pointer on
> > what to do could be useful.  I let you decide on this.
>=20
> libguestfs may expose exactly the inconsistent state that the above
> warning is about. Maybe it breaks not very often in practice, but it's
> fundamentally unsafe and if it breaks, you get to keep both pieces.
>=20
> The safe way is to access it from the guest.

I agree. If a guest has disk.qcow2 open read/write then libguestfs
cannot open it (even just for reading) and expect a consistent view of
the disk.

Stefan

--3ecMC0kzqsE2ddMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9YmVQACgkQnKSrs4Gr
c8jynAf+KLLxp9yfSKxoS4Bw6U1ZCuNpxIX4MxIKbHG/YdPSzzyCX/rUAx/4XQ9G
dWTdHk9DCgZafwhNGEBxzpoxPh+BvSXyYLPUbBORCdgPnmhfVnpLr/S1kudJqYtM
KTv808Z2DDskaLXLvQXVk6u78ZDms7pAvMW1dht9t6RvgJjuohDpTgFuoCF9rsDP
bHozSylP6arBYpGhc+u5cgF+KzVIbCYYJFhhVjJCWJheSp8kr9+OMWnjtg48de0B
DffGB0d1GEMieAJ/L9JQqE9DxOXRIjxmG+pvh0DCO1S0Y9IBvjGQVgprWEbdz5CO
XfkSfwQb9Wewc2rsN4LjOFogib9VKQ==
=eQ7g
-----END PGP SIGNATURE-----

--3ecMC0kzqsE2ddMN--


