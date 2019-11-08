Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8929AFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549262178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zmx7jzPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549262178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSzr2-00037V-DE
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 03:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iSzq1-00024f-Tw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iSzq0-0001C1-57
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:41:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iSzq0-0001BD-0W
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573202506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA17Sy4CFBYTySW+Hi2kJInt7iLtw6enWIuzl46FqXw=;
 b=Zmx7jzPpxOYTTqry9rQkR0XLzyxQEgfS+7uzHHpAIzlOJMuNmBsf8mMChYe97ICJUSq9Ab
 QUN6BCAyHHnkVUWJKTI5PTTCkT8HMjs1blxFKtGgVWVZHPqU2jeApeqa340pl+Or36IiDl
 bcktfRrrJ+QDCth423U2InNqaBIaJ0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-keuuH-BQODeQI8MWBBTGjg-1; Fri, 08 Nov 2019 03:41:42 -0500
X-MC-Unique: keuuH-BQODeQI8MWBBTGjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CFA08017DE;
 Fri,  8 Nov 2019 08:41:41 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06E82600C9;
 Fri,  8 Nov 2019 08:41:37 +0000 (UTC)
Date: Fri, 8 Nov 2019 09:41:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: QEMU HTML documentation now on qemu.org
Message-ID: <20191108084130.GA375005@stefanha-x1.localdomain>
References: <20191106161928.GA353373@stefanha-x1.localdomain>
 <20191107100606.GA120292@redhat.com>
 <CAJSP0QX6awKBSx_idYfXB85e09Tp6gKLRvO+zrk-+zrOiySC-w@mail.gmail.com>
 <20191107160142.GH120292@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191107160142.GH120292@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2019 at 04:01:42PM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Nov 07, 2019 at 04:44:34PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Nov 7, 2019 at 11:07 AM Daniel P. Berrang=E9 <berrange@redhat.c=
om> wrote:
> > >
> > > On Wed, Nov 06, 2019 at 05:19:28PM +0100, Stefan Hajnoczi wrote:
> > > > Hi,
> > > > You can now access the latest QEMU HTML documentation built from
> > > > qemu.git/master nightly at:
> > > >
> > > >   https://wiki.qemu.org/docs/qemu-doc.html
> > > >   https://wiki.qemu.org/docs/qemu-qmp-ref.html
> > > >   https://wiki.qemu.org/docs/qemu-ga-ref.html
> > > >   ...as well as interop/ and specs/
> > > >
> > > > Feel free to link to the documentation from the QEMU website and/or
> > > > wiki!
> > >
> > > What's the reason for putting on wiki.qemu.org URL ? It feels like
> > > having it under www.qemu.org would be a more natural home, especially
> > > if we can then make it pick up the jekyll theme around the pages.
> > >
> > > Ideally we should publish the docs under versioned URL when we
> > > make a release. eg  /docs/latest/....  for current GIT master
> > > which I presume the above is tracking, and then a /docs/$VERSION/...
> > > for each major release we cut.
> > >
> > > That way users can get an accurate view of features in the QEMU
> > > they are actually using.
> >=20
> > Versioned release docs should be generated during the release process.
> > I have CCed Mike Roth.  That way the docs are available as soon as the
> > release drops.  This container image only runs once a day and would
> > leave a window when users cannot access the docs yet.
> >=20
> > Moving from wiki.qemu.org should be possible.  How does the jekyll
> > theme you mentioned work?
>=20
> IIUC, when there's a push to the qemu-web.git repo, some git hook (?)
> runs on the server which invokes jekyll to build the content, and
> then publish it to the webroot.
>=20
> To integrate these docs into that we need something along the lines
> of:
>=20
>   1. Generate the HTML files as you do now
>   2. Copy them into the qemu-web.git in a /docs/ subdir
>   3. Prepend a magic header to make jeykll process the file
>=20
>      ---
>      permalink: /docs/qemu-doc
>      ---
>=20
>   4. Trigger the jekyll builder to refresh the generated docs
>   5. Publish the docs to the webroot
>=20
> You can see what I did here  as an example where I simply committed
> the generated docs to qemu-web.git:
>=20
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg578110.html
>=20
> If we're not storing the generated docs in git, then when
> pushing to qemu-web.git we need to ensure we preserve the
> extra /docs dir content in some manner.

For qemu.git/master the built docs might change every day.  Committing
them to qemu-web.git seems like overkill.  I'll send a documentation.md
patch for qemu-web.git instead that simply links to
wiki.qemu.org/docs/.

For release docs the process you described sounds good.  Peter Maydell
or Mike Roth may be interested in integrating it into the release
scripts.

Stefan

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3FKjoACgkQnKSrs4Gr
c8gBGQf/WPXzL9U+4kSfR5yz2I53Wys5aZNJGgYq1E3y4s28wPlCjwE4fDfYie6e
7iPXVyoInZCVEcQ2nlR/SKk/fSVvjk9zSoqxOezLBuBzbOZa0PbsGEuUkSiL9kbH
xgIsNAbWjKKAIU2XXFQOBV6z67wowEwkLKf5zn9/jidqezF5B+V6eF37H94bQ5aK
b3on8UMrsQNX9bqbX18i7bQI7iwk17sSTsQ4SY6ciUE4t8vvEyVqnDANl+r8gXyG
67Lr754fw0th8R1EVNmfjWW9kQcV3ROp2BEGmPict/xXhZd0j45w6pqNe+Qu3X/U
MuSedMCzDOVwI/cTeUyQlcxE6eEXIA==
=spdh
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


