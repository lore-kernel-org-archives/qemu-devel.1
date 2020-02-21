Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE92C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85956222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaDOunaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85956222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j55nn-00069X-ML
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 05:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j55nF-0005iV-Hp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j55nE-0005bq-0a
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:44:25 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j55nD-0005aj-Pi
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:44:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id a9so1222911wmj.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 02:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uawWNR65+uvZdCiEla1V2RYcQ6AC9pgGiCSFnoe0q5g=;
 b=ZaDOunaDCDpm380aTbeQliLlOInzm7Mn2TgGS8DJ1gWYeNUNW3yK2KE5Z9IJEGjkkB
 1fvHLDlZIID6vFVqFB/b6gD/YwIDz7us73dleb2EyLVAO4JdyysgKDpaiHAdOPqV52x5
 9KMHdNZDoIHM20EgDFS4bnnPiISGzY4VpiVBXgvESu8RwiXwkXAUsRf3t7dSYOmtukUP
 fBLEThJWBIoQKLlhEanmMhM7KlrmPtZ+SQ3VMhOhmWLLGJszysQfel6R0JjEViQiPutb
 YhqI3/fGDsyKTGMoFnvdsvfQU/j7j+D1aYymbN5EXTwy1nxC0KPusmCdsiKqaQeSeuAD
 2OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uawWNR65+uvZdCiEla1V2RYcQ6AC9pgGiCSFnoe0q5g=;
 b=BjXktKwoI1vd8hQqVC4W3jMLepQ0InFRTgORG5alifeH5swchwowJxnlyt4/jeKRbP
 wYuluXT1oNqqJqr3+oxcIXVx45h4TA7GmzpfKaAYSsUQFIPa8T1yHBJ9bdmSkqVEFJ12
 4xXQEabsUU9orfybXZQOXEAveULDI8UOeOuJVA16z2C/tcoH4evYzwwneZYcQZdXzx+K
 6O7CFX+0CC2QELiAVnQYzHx2+xrzU9FotkUjDW/IlTGRrSivYXzdxSa7Q2krr3CfzgxT
 npfynA/rvDWo8GPo0ztaY4p/J8ap9sn6jppjY7PYgOKCU9X20BYpF2vCrhW2sY5ADF/C
 IM2Q==
X-Gm-Message-State: APjAAAVKqM85HBuyYvCcfAE3eR/MFABNC7aeNaIJ2KkhSC4jBUDIUIZE
 SIHw2q5lQyRO+lsBfcJOGGs=
X-Google-Smtp-Source: APXvYqypg2tCa/mIYpjHUHaCPoIlubq96YVrY/nDDwVrZSo+MNQqFCy8ywsFNfzIBSFOaN8GggS08w==
X-Received: by 2002:a05:600c:291e:: with SMTP id
 i30mr3157215wmd.40.1582281862500; 
 Fri, 21 Feb 2020 02:44:22 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y139sm3517680wmd.24.2020.02.21.02.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 02:44:21 -0800 (PST)
Date: Fri, 21 Feb 2020 10:44:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Nikos Dragazis <ndragazis@arrikto.com>
Subject: Re: [PATCH/RFC 0/1] Vhost User Cross Cable: Intro
Message-ID: <20200221104420.GB1484511@stefanha-x1.localdomain>
References: <CAJSP0QW6cC=rCTn--vJ84t+LzeFND_SeN76CdF1fv6-F4NVDyg@mail.gmail.com>
 <10735dfd-1da5-416e-1b25-b5c354bb1901@arrikto.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <10735dfd-1da5-416e-1b25-b5c354bb1901@arrikto.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Vangelis Koukis <vkoukis@arrikto.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "V." <mail@winaoe.org>, "Stojaczyk, Dariusz" <dariusz.stojaczyk@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 03:48:59PM +0200, Nikos Dragazis wrote:
> On Tue, 14 Jan 2020 at 10:20 Stefan Hajnoczi
> <stefanha@gmail.com> wrote:
> > On Fri, Jan 10, 2020 at 10:34 AM Marc-Andr=C3=A9 Lureau
> > <address@hidden> wrote:
> > > On Wed, Jan 8, 2020 at 5:57 AM V. <address@hidden> wrote:
> >
> > Hi V.,
> > I think I remember you from Etherboot/gPXE days :).
> >
> > > > 3.
> > > > Now if Cross Cable is actually a new and (after a code-rewrite of 1=
0) a
> > > > viable way to connect 2 QEMU's together, could I actually
> > > > suggest a better way?
> > > > I am thinking of a '-netdev vhost-user-slave' option to connect (as=
 client
> > > > or server) to a master QEMU running '-netdev vhost-user'.
> > > > This way there is no need for any external program at all, the mast=
er can
> > > > have it's memory unshared and everything would just work
> > > > and be fast.
> > > > Also the whole thing can fall back to normal virtio if memory is no=
t shared
> > > > and it would even work in pure usermode without any
> > > > context switch.
> > > >
> > > > Building a patch for this idea I could maybe get around to, don't c=
learly
> > > > have an idea how much work this would be but I've done
> > > > crazier things.
> > > > But is this is something that someone might be able to whip up in a=
n hour
> > > > or two? Someone who actually does have a clue about vhost
> > > > and virtio maybe? ;-)
> > >
> > > I believe https://wiki.qemu.org/Features/VirtioVhostUser is what you
> > > are after. It's still being discussed and non-trivial, but not very
> > > active lately afaik.
> >
> > virtio-vhost-user is being experimented with in the SPDK community but
> > there has been no activity on VIRTIO standardization or the QEMU
> > patches for some time.=C2=A0 More info here:
> > https://ndragazis.github.io/spdk.html
> >
> > I think the new ivshmem v2 feature may provide the functionality you
> > are looking for, but I haven't looked at them yet.=C2=A0 Here is the li=
nk:
> > https://www.mail-archive.com/address@hidden/msg668749.html
> >
> > And here is Jan's KVM Forum presentation on ivshmem v2:
> > https://www.youtube.com/watch?v=3DTiZrngLUFMA
> >
> > Stefan
>=20
>=20
> Hi Stefan,
>=20
> First of all, sorry for the delayed response. The mail got lost
> somewhere in my inbox. Please keep Cc-ing me on all threads related to
> virtio-vhost-user.
>=20
> As you correctly pointed out, I have been experimenting with
> virtio-vhost-user on SPDK and [1] is a working demo on this matter. I
> have been working on getting it merged with SPDK and, to this end, I
> have been interacting with the SPDK team [2][3] and mostly with Darek
> Stojaczyk (Cc-ing him).
>=20
> The reason that you haven=E2=80=99t seen any activity for the last months=
 is
> that I got a job and hence my schedule has become tighter. But I will
> definitely find some space and fit it into my schedule. Let me give you
> a heads up, so that we get synced:
>=20
> Originally, I created and sent a patch (influenced from your DPDK patch
> [4]) to SPDK that was enhancing SPDK=E2=80=99s internal rte_vhost library=
 with
> the virtio-vhost-user transport. However, a few weeks later, the SPDK
> team decided to switch from their internal rte_vhost library to using
> DPDK=E2=80=99s rte_vhost library directly [3]. Given that, I refactored a=
nd sent
> the patch for the virtio-vhost-user transport to the DPDK mailing list
> [5]. Regarding the virtio-vhost-user device, I have made some
> enhancements [6] on your original RFC device implementation and, as you
> may remember, I have sent some revised versions of the spec to the
> virtio mailing list [7].
>=20
> At the moment, the blocker is the virtio spec. The last update on this
> was my discussion with Michael Tsirkin (Cc-ing him as well) about the
> need for the VIRTIO_PCI_CAP_DOORBELL_CFG and
> VIRTIO_PCI_CAP_NOTIFICATION_CFG configuration structures [8].
>=20
> So, I think the next steps should be the following:
>=20
> 1. merging the spec
> 2. adding the device on QEMU
> 3. adding the vvu transport on DPDK
> 4. extending SPDK to make use of the new vhost-user transport
>=20
> To conclude, I still believe that this device is useful and should be
> part of virtio/qemu/dpdk/spdk and I will continue working on this
> direction.

Thanks for letting me know.  Feel free to resend the latest VIRTIO spec
changes to restart the discussion.  I am certainly interested.

Stefan

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5PtIMACgkQnKSrs4Gr
c8icbwgAqBTJU2VUDGhPEGN9rsV9/+nhF4/mO/V0jmwMltwvE03WcvoX228exdau
ha9cjHlZARSFpoDTKZgANgTVRyXk1oL7SOcXNIlk1kUtmMVzDluxhp4+ecSayKKK
WYN2QjNPJyGYt3dEyyw91xiZgfggPr8A/IZvfwHeoTcK/humvIUI6NfSSTcjTiWo
LJbmHfBvCBAkGsOX8EtJJ+D9V12/dTPkV3y5y/XkV5ULVC0k4ymUHuoAM6IjAaK8
yu6bglTnUCY8utDpBEg/cYKQYbYh9SeMUY8yDDtlvUMCWvIBMBxIb8Aky1mVbUAb
NJxpG0rjt/6fhavfC8GAjsf5dU8MCA==
=ZQdc
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--

