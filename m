Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40430C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9822521582
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9822521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW1Af-0001Gw-8l
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marius.vlad@collabora.com>)
 id 1kW19O-0000HS-FX
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:46:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marius.vlad@collabora.com>)
 id 1kW19M-00034n-6N
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:46:50 -0400
Received: from xpredator (unknown
 [IPv6:2a02:2f08:4b07:8e00:24d7:51ff:fed6:906d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: mvlad)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C22CA1F468FE;
 Fri, 23 Oct 2020 18:46:44 +0100 (BST)
Date: Fri, 23 Oct 2020 20:46:41 +0300
From: Marius Vlad <marius.vlad@collabora.com>
To: agl-dev-community@lists.automotivelinux.org
Subject: Re: [agl-dev-community] Tips for debugging GPU acceleration.
Message-ID: <20201023174641.GA49109@xpredator>
Mail-Followup-To: agl-dev-community@lists.automotivelinux.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <87o8kttj2e.fsf@linaro.org>
 <20201023105120.sqharyxujgh7nppk@sirius.home.kraxel.org>
 <87d019tb0u.fsf@linaro.org> <20201023123217.GA18593@xpredator>
 <CAHDbmO2_6=MgcJBgy3f8K4tkjHs_c34CvoL_krob+55CwL32hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <CAHDbmO2_6=MgcJBgy3f8K4tkjHs_c34CvoL_krob+55CwL32hw@mail.gmail.com>
Received-SPF: pass client-ip=46.235.227.227;
 envelope-from=marius.vlad@collabora.com; helo=bhuna.collabora.co.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 13:46:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 05:28:22PM +0100, Alex Benn=E9e wrote:
> Thanks - that seems to do the trick.
> I can't find where in the agl repo that is set. The recipe seems to be in:
>=20
>   meta-agl-cluster-demo/recipie-graphics/wayland/weston-ini-conf/virtual-=
landscape.cfg
>=20
> but I can't see where the "transform=3D270" got added.
I assume from
meta-agl/meta-agl-bsp/meta-aglprofilegraphical/recipes-graphics/wayland/wes=
ton-ini-conf/virtual.cfg
>=20
> Visually it looks a lot nicer now although I could still do with
> getting rid of the quite large AGL lower banner which is cropping out
> the main display.
Yes, like I've said, but apparently I've substituted landscape w/
portrait, applications are designed to accommodate portrait orientation.
The panels, are added dynamically by homescreen.
>=20
> On Fri, 23 Oct 2020 at 13:32, Marius Vlad <marius.vlad@collabora.com> wro=
te:
> >
> > On Fri, Oct 23, 2020 at 12:52:17PM +0100, Alex Benn=E9e wrote:
> > >
> > > Gerd Hoffmann <kraxel@redhat.com> writes:
> > >
> > > >   Hi,
> > > >
> > > >>   [    2.930300] [drm] virgl 3d acceleration not supported by host
> > > >
> > > > Nope, not active.
> > > >
> > > >>     -display gtk,show-cursor=3Don \
> > > >
> > > > Needs -display gtk,gl=3Don for opengl support.
> > >
> > > Awesome - even on TCG the display is now nice and snappy.
> > >
> > > For bonus points:
> > >
> > > The AGL panel display is rotated 90 degrees which is putting a bit of=
 a
> > > crink in my neck. Is their anyway to rotate the view port. I tried
> > > inverting xres and yres but that didn't do anything.
> > Hi,
> >
> > The output is rotated, edit /etc/xdg/weston/weston.ini and comment out
> > transform ini entry from the Virtual-1 output section. Reboot, or
> > restart weston@display service. Note that the apps are optimized for
> > landscape.
> >
> > Enabling 3D with qemu might be something worth adding in the docs.
> > >
> > > >>     -device virtio-gpu-pci,virgl=3Dtrue
> > > >
> > > > virgl is silently turned off in case opengl support is not availabl=
e.
> > > > Ideally virgl should be OnOffAuto not bool, but I fear changing that
> > > > now (and start throwing errors on virgl=3Don if opengl is not avail=
able)
> > > > will break stuff ...
> > >
> > > At least a warn_report maybe?
> > >
> > > >
> > > > take care,
> > > >   Gerd
> > >
> > >
> > > --
> > > Alex Benn=E9e
> > >
> > >
> > >
> > >
> > >
> >
> >
> >=20
> >
> >
>=20
>=20
> --=20
> Alex Benn=E9e
> KVM/QEMU Hacker for Linaro
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8773): https://lists.automotivelinux.org/g/agl-dev-co=
mmunity/message/8773
> Mute This Topic: https://lists.automotivelinux.org/mt/77748325/4043866
> Group Owner: agl-dev-community+owner@lists.automotivelinux.org
> Unsubscribe: https://lists.automotivelinux.org/g/agl-dev-community/leave/=
7327001/516878461/xyzzy [marius.vlad@collabora.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEcDKHej6x6uPk3J379jQS5glH1u8FAl+TFv0ACgkQ9jQS5glH
1u99FRAAxa0NwsQ+tB9O8Ukcn9iYnJLOmw7msu5wr7rH335ti9T3OyeJICOVweQu
7HoUq9+TiBhZbIGRM173Ta06N62W/kMckrR8Pod0cvb/omYN2p8hpY/FRQ4JkF8z
nC9i30Qswi+EwAVAhahQi3AnPMO/oi0CFoSzhhh4TMaJlKd1zDVW8SZG/e0xdnYQ
DmecTwwJaprmGmswqrEjLAWs3YGOdIJwBSfjNAogWB2q7MFfdOQkbUNv5tgRX9Oj
v4N3Z4ozfCAMVkMNJwOHBDJQ7g8ZzcvFkkjiTLF6ucXUyPFaGgEiTM3wi+b6qEc3
X1c91RQA4lQ9gt1cGeWpEnqkwgPFvgUYNTEohCNf5e7pwLjo8b4AP/2HxvQiRhye
RI1qG26kSurbtpTFX3GYbDUsnINbHXlPHTvFB3E2UNLOYklEwo1t6jZesPHboCJ2
374Yz5hI0YvCS7gIcoGZmo9d46uan5hPi4jgE2ogyoib5ribevYb6ubE11qXOp89
PWS4imcFjg7hgH1YTXY7bVEg3R767NShBNEJuUfkPuizmav7FtJ4yJCnI0FQfPf/
CPKmDbT1t8orteddaYzWuzNzqdxWLgzJYJEW3Byq6YKJUCICFoKmXHkJeXhpZGRU
3h1lYBaMGPWOQ94068HlZJlQgTtGpyTZ2fU0m0EtL10OYi7rvKw=
=9l1C
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

