Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A0EC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D7D2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Scgfpsav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D7D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0jS-0006Yq-Tf
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iw0ik-0005vC-J2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iw0ij-0004lg-1K
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:30:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27423
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iw0ii-0004kE-Jw
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580117411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L5EobFJT4aH/4ZpIcDXnVIfCn8TwnjRtyB7YojeE9M8=;
 b=Scgfpsav7ynABrdq7FDH72NX/a3EgOZG3L2OmJjkmUMwKGwTJRMYMVUyQoLa5Za/aUXOe+
 TRMCXvRCHEC2gHLtiqLCmTVnv3pVa/G3nIKmqaWmbLFL9TGncuxMTaFyMyP0/6/ZFpavGb
 vxX188pqeziJ0Fp49wA0IPDWdKRp/u4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263--pvGfOvvNkKWrrA3mPVkNg-1; Mon, 27 Jan 2020 04:30:07 -0500
X-MC-Unique: -pvGfOvvNkKWrrA3mPVkNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40CAA102C8BF;
 Mon, 27 Jan 2020 09:30:06 +0000 (UTC)
Received: from localhost (ovpn-117-180.ams2.redhat.com [10.36.117.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE6260BF1;
 Mon, 27 Jan 2020 09:30:05 +0000 (UTC)
Date: Mon, 27 Jan 2020 09:30:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
Message-ID: <20200127093004.GA18565@stefanha-x1.localdomain>
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 02:34:01PM +0100, Aleksandar Markovic wrote:
> *Extend support for ioctls in QEMU linux-user mode*
>=20
>=20
>=20
> *PLANNED ACTIVITIES*
>=20
> BACKGROUND
>=20
> There is currently 2500+ ioctls defined in Linux kernel. QEMU linux-user
> currently supports only several hundred. There is a constant need for
> expanding ioctl support in QEMU. Users use Linux-user mode in variety of
> setups (for example, building and testing tools and applications under
> chroot environment), and, on a regular basis, efforts by multiple people
> are made to fill in missing support. However, these efforts have been
> usually done on a piece-by-piece basis, i a limited way covering a

s/ i / in /

> partucular need. This project will take more proactive stance, and try to

s/partucular/particular/

> improve QEMU before users start complaining.
>=20
> PART I:
>=20
>    a) Add strace support for outputing ioctl IDs (the second argument of
> ioctl()) as strings rather than numbers - for all platform independant
> ioctls.
>    b) Add strace support for printing the third argument of ioctl() (be i=
t
> int, string, structure or array) - limited to selected ioctls that are
> frequently used.
>=20
> PART II:
>=20
>    a) Amend support for existing groups of ioctls that are not completed
> 100% (let's say, filesystem ioctls)
>    b) Add support for a selected group of ioctls that are not currently
> supported (for example, dm ioctls, Bluetooth ioctls, or Radeon DRM ioctls=
)
>=20
> PART III:
>=20
>   a) Develop unit tests for selected ioctls that are already supported in
> QEMU.
>=20
>=20
> *DELIVERABLES*
>=20
> The deliverables are in the form of source code for each part, intended t=
o
> be upstreamed, and time needed for upstreaming (addressing reviews, etc.)
> process is included int this project.
>=20
> The delivery of results can and should be distributed over larger period =
of
> time 2-3 months.

Good project idea.  Please choose concrete ioctls.  Applicants may not
have the necessary experience to choose a set of ioctls that are useful.

I wonder if it's possible to use something like the Debian popularity
contest (https://popcon.debian.org/) and then scan the source of the
most popular N packages for ioctl() calls.  Maybe this is overthinking
it, but it would give an idea of which ioctl() calls are relevant and
missing from QEMU.

Stefan

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4urZkACgkQnKSrs4Gr
c8g+wQf9Hb8e/px6V3K4VxYqsKqWW4FJ8K3Kta5IWm7lM3VzkL2GncK1hp3K9o4r
eMMHaBHxftRrZ6eksYxFWjzWLC4jFziupIsOv7dsi5EkokdkgpaBGtYsDcEpZgLP
gXusqRaGm3wyufuYGhuvZLdILD6FZpTicR6zQkeeOW/+k7QZWI2B5yP6Ehg9MrLO
lfFB711lyrpoFZr6p9CYQ/tTDQfWjsz+8j1hmWYJ1badgznuOTKAKdEfgqbYal5C
SXJvpugS3J0v7T8DlYr5z7tZ/WF4CDRsi28KvvUttcp+X1t19iWl2ovJZCaWRlIU
oV5ylLnvtROzmDZv7W9ZmZxlnWDzXQ==
=bPjz
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--


