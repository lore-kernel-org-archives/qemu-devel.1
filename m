Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6653DC47257
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33921206D9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQ7bDIvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33921206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXZk-0001p1-CE
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:27:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jUXYc-0000OD-06
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUXWZ-00009e-6Z
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:26:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jUXWY-0008WR-LW
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588346660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWhnE6mzYV1+Cdmb5gjnoKOOuuJr41RbuVLQah/yROg=;
 b=WQ7bDIvX7WNygVpu9JKg/BEjzP5q1R749V0XTFlGdioLKjm13jgzLJCDs7Vk5B45N9zCQ3
 rjBmTeEm2Qm/MN8mlV8V2m6JMcbTQUidxoA0Bl9oXtWZPxx08BsGUrwpM52nw3oa7e32BG
 XPmywrJ02BfphoO0ciYsJhmXDttHqIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-t3NcmVaYOpOFQJAowaD51A-1; Fri, 01 May 2020 11:24:08 -0400
X-MC-Unique: t3NcmVaYOpOFQJAowaD51A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995291800D42;
 Fri,  1 May 2020 15:24:06 +0000 (UTC)
Received: from localhost (ovpn-112-36.ams2.redhat.com [10.36.112.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD7A6196AE;
 Fri,  1 May 2020 15:23:57 +0000 (UTC)
Date: Fri, 1 May 2020 16:23:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/4] Block patches
Message-ID: <20200501152356.GC221440@stefanha-x1.localdomain>
References: <20200501082806.205696-1-stefanha@redhat.com>
 <CAFEAcA_VnBL8P4-UUgN9jGSTUCqvWpG2uaEYejjtJrEaFerRzw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VnBL8P4-UUgN9jGSTUCqvWpG2uaEYejjtJrEaFerRzw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 07:23:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Bandan Das <bsd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 10:32:02AM +0100, Peter Maydell wrote:
> On Fri, 1 May 2020 at 09:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > The following changes since commit 27c94566379069fb8930bb1433dcffbf7df3=
203d:
> >
> >   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-20=
20-04-30.for-upstream' into staging (2020-04-30 16:47:23 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stefanha/qemu.git tags/block-pull-request
> >
> > for you to fetch changes up to cc1adc4488059ac16d4d2772a7aa7cd1323deeca=
:
> >
> >   lockable: Replace locks with lock guard macros (2020-05-01 09:19:25 +=
0100)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > Fix the QEMU_LOCK_GUARD() macros, use them more widely, and allow the f=
uzzer
> > target to be selected from argv[0].
> >
> > ----------------------------------------------------------------
>=20
> Hi; this pullreq seems to include a stray change to the slirp
> submodule in the "fuzz: select fuzz target using executable name"
> commit. Could you fix that and resend, please?
>=20
> (You might like to include a molly-guard in your pullreq
> creation scripts; on my end I catch this sort of thing
> when applying with a test like
> if git diff master..staging | grep -q 'Subproject commit'; then
>     # complain and exit unless I used an explicit command
>     # line option to say I intended to include a submodule update
> fi
>=20
> though I haven't yet put the same test in the script I use
> to send pullreqs, for some reason. I guess my workflow now
> means I don't tend to accidentally commit submodule changes.)

Sorry for the spurious change.  Will send a v2!

Stefan

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6sPwwACgkQnKSrs4Gr
c8jOLwgAhCQsrwmTzZxP2oezs9wZv/Cw4Gq879xQEiJcPslJQdOGZTTNrz84znAn
lfSjybB9NMl8Un7ee9PkWP1nH/8ZAfHrf/oI5UmXG7hjSV1fRyHRbx/l/sGMdo13
bcoPUozlicQeto0mcHxcZ2Kw++/3TfWKeFjL/0/bYHGwohyF54h7Bs+5AvI7++gt
wET4cDaEkKP5myUhpqAgVouehExu2YZ6DdI0bP6zL9e6dixCdmtsp7bhMskkG/LW
OPyFFZyivHwGCsH062hVWqXCQ6vZT1UgPwjnqt6cSYIvhXb31NOcLsNwfwuf9JDm
4rlrFvFzJAV6Xs5TcBqJDYSO2/dAGQ==
=lr5q
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--


