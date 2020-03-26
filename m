Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C554C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377C020719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anzUVwcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377C020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHNI6-000110-Dq
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1jHNHX-0000Wd-He
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1jHNHV-0003Sz-KD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:50:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1jHNHV-0003SU-AP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585209024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AbGdK8AJvz1pO6naThOquiznkW2dAfUCjEHrIYXQW+k=;
 b=anzUVwcThSqL2ii3aYdSU2epEG+F9RsRQh328hgdDDTX+IFSRT/gUcfRKD7cQcj7iXsig9
 IDyHcPP7sgZ/CLyFa1K13sNYnXJ3ZnomKxEG0Z0A6Hs30zLvSGJwjgXZ8uAKe+RdBioZtV
 nZq8oo/PSkNapMcJX78Q5tbwy8vrlUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-abzpbKcjMJCi0NkFc4LaJw-1; Thu, 26 Mar 2020 03:50:22 -0400
X-MC-Unique: abzpbKcjMJCi0NkFc4LaJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C7891005514;
 Thu, 26 Mar 2020 07:50:21 +0000 (UTC)
Received: from localhost (unknown [10.33.36.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 360BF10002A5;
 Thu, 26 Mar 2020 07:50:17 +0000 (UTC)
Date: Thu, 26 Mar 2020 08:50:16 +0100
From: Sergio Lopez <slp@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: backup transaction with io-thread core dumps
Message-ID: <20200326074924.r4lmqqpeaizywkds@dritchie>
References: <2007060575.48.1585048408879@webmail.proxmox.com>
 <1512602350.59.1585056617632@webmail.proxmox.com>
 <1806708761.60.1585056799652@webmail.proxmox.com>
 <32c10c76-1c9f-3a6a-4410-09eebad0f6f3@redhat.com>
 <20200325081312.7wtz6crlgotsw5ul@dritchie>
 <20200325114639.rxwhs7h4bkxhkgsu@dritchie>
 <523142611.32.1585139388758@webmail.proxmox.com>
 <20200325123905.4mygg2ljie7prtbc@dritchie>
 <1427176168.41.1585150848553@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <1427176168.41.1585150848553@webmail.proxmox.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q6vx7b4gaux5d7w6"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--q6vx7b4gaux5d7w6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 04:40:48PM +0100, Dietmar Maurer wrote:
> > On March 25, 2020 1:39 PM Sergio Lopez <slp@redhat.com> wrote:
> >=20
> > =20
> > On Wed, Mar 25, 2020 at 01:29:48PM +0100, Dietmar Maurer wrote:
> > > > As expected, if both BDS are running on the same IOThread (and thus=
,
> > > > the same AioContext), the problem is not reproducible.
> > > >
> > > > In a general sense, we could say that completion modes other than
> > > > "individual" are not supported for a transaction that may access
> > > > different AioContexts. I don't see a safe an easy way to fix this. =
We
> > > > could opt for simply detect and forbid such completion modes when t=
he
> > > > BDS's are assigned to different AioContexts. Perhaps Kevin (in CC) =
has
> > > > a better idea.
> > >
> > > So the solution is to disable backups when using io-threads?
> > >
> >=20
> > I meant forbidding transactions with completion-mode =3D=3D grouped. It
> > would be still possible running transactions (and thus, backups) with
> > completion-mode =3D=3D individual, which is the default.
>=20
> As mentioned earlier, even a totally simple/normal backup job fails when
> using io-threads and the VM is under load. It results in a total
> VM freeze!
>=20

This is definitely a different issue. I'll take a look at it today.

Cheers,
Sergio.

--q6vx7b4gaux5d7w6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl58XrcACgkQ9GknjS8M
AjVeCw/9HbvO2FGChJNULerY7d05rXUxYnZtBSZNgOrlSzzyE/yIbqWW0buVsm2L
/1podsz/QFacgnRrnsCTMyxUBZ3gwvoRGuPPHVlK4kmjJwDvcWK12d+IL0AvT+xI
KJ0lKxbfuabsAM06JW7OwOAfFd7/LSY2RzAlKR9xoXP+Nz80Z7/sgiXE0cHymf1X
WqKBUZHM2K6o8PfRWXT9hnR1boe/wTmiZ/uIrwrHf2J0+mn3RS8r865EUWQM8K8R
iWZBLnoBUlmrBk2G0vbV9Zi9m9GbUFOu9qiu1ODp80LbHTzn42KorOi5ovfWSS+a
x+vqvxOs78MBHH7+trQjNKG23lnVuRVH3i+VVzt6ZDh+8ieyrKDggRu3CAEX7HxS
/HHZ8LB4e3W0YeRz9mwn9wElAm4uFPi1L2Q6TMWQ+ZxDRCljWIrW5OihP/aLkhTF
O0IVfqzQGIqy1HoYR7arpNyENkFD+mJIyJb6anjAHIzhsq3mSKwcFM5ayTizK/32
DbIOPfqfnTUCYroPBEyygVtYk2IwHQP57aoD8YrMpgZ9mJUe5gLa62YqNFJCOUpL
crAC+E61mZS0JOfYb9qWJqPldmkFFHua3V0uOtaAAt2bF50e3wDjBwkO4N3DbzfU
x+Q5FCJj7teaH0P/uFcKuGyPx8Ui4dp10hpT48iR513yQgTqXi4=
=B2PQ
-----END PGP SIGNATURE-----

--q6vx7b4gaux5d7w6--


