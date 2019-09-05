Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFEBC3A5AB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2EA21743
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2EA21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5n15-00044B-Ad
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 04:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5n05-0003WQ-9T
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5n02-0000Pa-39
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:20:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5n01-0000ON-Qr
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:20:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56462308A98C;
 Thu,  5 Sep 2019 08:20:12 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB13A5D772;
 Thu,  5 Sep 2019 08:20:08 +0000 (UTC)
Date: Thu, 5 Sep 2019 09:20:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeff Cody <jeff@codyprime.org>
Message-ID: <20190905082007.GA32415@stefanha-x1.localdomain>
References: <20190829154851.GA26717@stefanha-x1.localdomain>
 <3fce8d5a5fcccbff8f27f681eb685167d2c0845f.camel@redhat.com>
 <20190902092509.GC9069@stefanha-x1.localdomain>
 <CAGwXPVpN0ndzAEpDtV+-mAgmGZOv5gL2_=5sBka0iHRg6drCrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <CAGwXPVpN0ndzAEpDtV+-mAgmGZOv5gL2_=5sBka0iHRg6drCrA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 05 Sep 2019 08:20:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] git.qemu.org gitweb misrenders on git/ URLs
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2019 at 06:35:40AM -0400, Jeff Cody wrote:
> On Mon, Sep 2, 2019 at 5:25 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Thu, Aug 29, 2019 at 06:13:34PM +0200, Andrea Bolognani wrote:
> > > On Thu, 2019-08-29 at 16:48 +0100, Stefan Hajnoczi wrote:
> > > > Hi Jeff,
> > > > Philippe noticed that the git HTTPS clone URL
> > > > https://git.qemu.org/git/libslirp.git renders a gitweb page that lo=
oks
> > > > right but has broken links.  The correct gitweb URL listed on
> > > > https://git.qemu.org/ is https://git.qemu.org/?p=3Dlibslirp.git;a=
=3Dsummary,
> > > > but there's a chance that people will open the HTTPS clone URL in t=
heir
> > > > browser and expect to see gitweb working.
> > > >
> > > > Is it possible to tweak the Apache configuration so that
> > > > https://git.qemu.org/git/libslirp.git[/] redirects to the working g=
itweb
> > > > URL?
> > > >
> > > > The tricky part is not breaking HTTPS git clone, which accesses URLs
> > > > below https://git.qemu.org/git/libslirp.git/ :).
> > >
> > > I know that's not quite the answer to your question, but if you look
> > > for example at
> > >
> > >   https://git.zx2c4.com/cgit
> > >
> > > you'll see that the same URL can be used both for viewing with a
> > > browser *and* cloning.
> > >
> > > Basically with cgit all requests go through the CGI script, and an
> > > advantage of that is that you don't even need to call
> > >
> > >   git update-server-info
> > >
> > > to make the repository accessible via HTTPs. It's also pretty fast
> > > and extremely easy to setup. Maybe consider switching from gitweb
> > > to it?
> >
> > Thanks, switching to cgit is an option.  Let's see what Jeff thinks.
> >
>=20
> Hi Stefan & Andrea,
>=20
> I'm not familiar with cgit, but I am happy to investigate it as an
> option if it looks to be a better fit.  I can't get to it until this week=
end
> however (Sept 7), as I'm traveling right now.   Is that soon enough?

Yes, thanks.  This is not urgent.

Stefan

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wxTcACgkQnKSrs4Gr
c8iKtggAtmLu7K7dQ0bMJl6g6JfVkiYovym+GY7EBJlEPsKJhJQiN2vY6GAolREY
9Yl5GiUnbQj0vjWRJZ+n940L6xLDKplilvWemD/vBfGH/JRx4NWj6I9FdGV4JWo1
BIuhD/JMca+a2svxvv4kf/AnBi+hTPEvWWkPM0IgfXEMfcYUExY21uKUuuKLJTvX
4oI1ZdrjJsZv8aSdmNTF/sipOnCnkGN4+oLGVNteDhB9t4OsgaBdZtb2Z6s80q6/
iT9uRfbCD0v2mjhSOixa0d/gZLjnD6rkX9rEPygjkxGMUtH4C7pg0Z07SJzPp7Tg
sBDuzM8mymJ0I+GmCG25REWn/Saseg==
=1ReX
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

