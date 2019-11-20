Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7DBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779DC22429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FI9+yDZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779DC22429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNRy-0000jq-Ie
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iXNQH-0007XT-LN
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iXNQG-0008RO-7q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:41:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47070
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iXNQG-0008QC-2x
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574246479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FnkbYX6g2LRanVgSQjVwjlcwp9f2PUUS0iWHhK22b4c=;
 b=FI9+yDZvkUUhnEkNkDojfrkunnxCyWrJQ/Ndk0fRY+sWdYQvq0fBn1lCrwrvsU1wYuBWLI
 ZMZsoOj8saMC+ogDuWrwtBuxXRPrSkNnRq+0PBhUYvmwk/SD7FolMnylRmY6/0GXTfKyJ9
 xE0/DFLP+1iGh4l7zDwQwqN+bt7I5SM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-YDCPFCg1OkChKo6VnUH2eQ-1; Wed, 20 Nov 2019 05:41:17 -0500
X-MC-Unique: YDCPFCg1OkChKo6VnUH2eQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2F14801E74;
 Wed, 20 Nov 2019 10:41:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C0F55F79D;
 Wed, 20 Nov 2019 10:41:12 +0000 (UTC)
Date: Wed, 20 Nov 2019 10:41:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL for-4.2-rc2 0/2] Tracing patches
Message-ID: <20191120104111.GA242924@stefanha-x1.localdomain>
References: <20191119204551.240792-1-stefanha@redhat.com>
 <CAL1e-=ibQBWUzUZvsvSWCZ5SwFk5T+b2P94D068W8G_taWVASg@mail.gmail.com>
 <CAL1e-=iEN9GEGDzEvoYM9q477Le4rs-mQZEgxOdzr51ZxLJd0w@mail.gmail.com>
 <02d25aa5-d913-947d-3ccd-5057bc516fd2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <02d25aa5-d913-947d-3ccd-5057bc516fd2@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:bochs" <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 10:33:35AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/19/19 10:35 PM, Aleksandar Markovic wrote:
> > On Tue, Nov 19, 2019 at 10:14 PM Aleksandar Markovic
> > <aleksandar.m.mail@gmail.com> wrote:
> > >=20
> > > On Tue, Nov 19, 2019 at 9:46 PM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > > >=20
> > > > The following changes since commit f086f22d6c068ba151b0f6e81e75a64f=
130df712:
> > > >=20
> > > >    Merge remote-tracking branch 'remotes/awilliam/tags/vfio-fixes-2=
0191118.0' into staging (2019-11-18 21:35:48 +0000)
> > > >=20
> > > > are available in the Git repository at:
> > > >=20
> > > >    https://github.com/stefanha/qemu.git tags/tracing-pull-request
> > > >=20
> > > > for you to fetch changes up to 6b904f1a528a6d8c21f7fbdeab13b9603d1b=
6df7:
> > > >=20
> > > >    hw/mips/gt64xxx: Remove dynamic field width from trace events (2=
019-11-19 16:17:05 +0000)
> > > >=20
> > > > ----------------------------------------------------------------
> > > > Pull request
> > > >=20
> > > > Tracing fixes for MIPS.
> > > >=20
> > > > ----------------------------------------------------------------
> > > >=20
> > >=20
> > > Hello, Stefan, Philippe, Peter.
> > >=20
> > > This appears to be a duplicate of the pull request sent today by Phil=
ippe
> > > (and already applied by Peter just hours ago):
> > >=20
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02894.html
> > >=20
> > > The patches from the two pull requests appear to be identical, except
> > > some minor details in commit messages: Stefan's versions contain
> > > "Message-Id:" identifiers, while Philippe's don't (my suggestion to
> > > Philippe is to include "Message-Id:" for all patches that are part of=
 any
> > > pull request in future; this can be achieved effortlessly/automatical=
ly
> > > by applying patches using patchwork).
> > >=20
> > > In summary, for this very situation, it looks to me we are all set, n=
o need
> > > for Peter to process this pull request.
> > >=20
> >=20
> > And just another really friendly advice for Philippe: When you apply
> > some patches or a series to your pull request, just inform others
> > about that by replying to the patches or a series: "I applied XXX to
> > my queue/pull request" - this helps avoiding duplicate efforts like
> > it happened here. This is also reminder to me too, I didn't do it in
> > all cases of my applying to my my pull requests, and I should have,
> > but I will improve too.
>=20
> You are totally correct, in a rush to get these patches merged before the
> release candidate get tagged, I neglected to reply to my series and let
> Stefan waste his time.
>=20
> Stefan, I sincerely apologize and will make efforts so this won't happen
> again.

No problem, I just wanted to make sure we don't miss these patches.

Stefan

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3VGEcACgkQnKSrs4Gr
c8i+3Qf+KCw2rx3z9jXf18TS/Md2IfXyWT4SZpZGabtaeBF/AF8FYhFLskcaGBqg
a5+sdzPBNMLAwASr+hP26z6N37mQCIXMHpsR7DqoDWb0METnCmVbE+YGqkPxdPd+
Unl2EHghdro7WQbWBqmiOKWduvsZziRBY5fvoDIyzSO1yiFpWi7TyKfzifw7SDjz
e0+ylncFjpLgdS38Kfr53farbVWGL0+Dbzc0bvxAOr9kACywgEa1Ltl10QvRoNgV
9sy6oX4Ro5l0sR4so2ZOOvpxkOffVcdW8g/+Uaq6IDz2dEttd1N/P5oRYxiQBIsh
SvOKDK187u1bIK0RGwuuu9igHyUNIQ==
=dhne
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


