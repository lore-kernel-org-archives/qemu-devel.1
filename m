Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE52C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE01A20FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE01A20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxIz-0003to-RL
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marius.vlad@collabora.com>)
 id 1kVwFE-0005MP-MP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:32:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marius.vlad@collabora.com>)
 id 1kVwF6-00032A-24
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:32:28 -0400
Received: from xpredator (unknown
 [IPv6:2a02:2f08:4b07:8e00:24d7:51ff:fed6:906d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: mvlad)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BD7A11F46917;
 Fri, 23 Oct 2020 13:32:20 +0100 (BST)
Date: Fri, 23 Oct 2020 15:32:17 +0300
From: Marius Vlad <marius.vlad@collabora.com>
To: agl-dev-community@lists.automotivelinux.org
Subject: Re: [agl-dev-community]  Tips for debugging GPU acceleration.
Message-ID: <20201023123217.GA18593@xpredator>
Mail-Followup-To: agl-dev-community@lists.automotivelinux.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <87o8kttj2e.fsf@linaro.org>
 <20201023105120.sqharyxujgh7nppk@sirius.home.kraxel.org>
 <87d019tb0u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <87d019tb0u.fsf@linaro.org>
Received-SPF: pass client-ip=46.235.227.227;
 envelope-from=marius.vlad@collabora.com; helo=bhuna.collabora.co.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 08:32:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 Oct 2020 09:39:14 -0400
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 12:52:17PM +0100, Alex Benn=E9e wrote:
>=20
> Gerd Hoffmann <kraxel@redhat.com> writes:
>=20
> >   Hi,
> >
> >>   [    2.930300] [drm] virgl 3d acceleration not supported by host
> >
> > Nope, not active.
> >
> >>     -display gtk,show-cursor=3Don \
> >
> > Needs -display gtk,gl=3Don for opengl support.
>=20
> Awesome - even on TCG the display is now nice and snappy.
>=20
> For bonus points:
>=20
> The AGL panel display is rotated 90 degrees which is putting a bit of a
> crink in my neck. Is their anyway to rotate the view port. I tried
> inverting xres and yres but that didn't do anything.
Hi,

The output is rotated, edit /etc/xdg/weston/weston.ini and comment out
transform ini entry from the Virtual-1 output section. Reboot, or
restart weston@display service. Note that the apps are optimized for
landscape.=20

Enabling 3D with qemu might be something worth adding in the docs.
>=20
> >>     -device virtio-gpu-pci,virgl=3Dtrue
> >
> > virgl is silently turned off in case opengl support is not available.
> > Ideally virgl should be OnOffAuto not bool, but I fear changing that
> > now (and start throwing errors on virgl=3Don if opengl is not available)
> > will break stuff ...
>=20
> At least a warn_report maybe?
>=20
> >
> > take care,
> >   Gerd
>=20
>=20
> --=20
> Alex Benn=E9e
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8771): https://lists.automotivelinux.org/g/agl-dev-co=
mmunity/message/8771
> Mute This Topic: https://lists.automotivelinux.org/mt/77748325/4043866
> Group Owner: agl-dev-community+owner@lists.automotivelinux.org
> Unsubscribe: https://lists.automotivelinux.org/g/agl-dev-community/leave/=
7327001/516878461/xyzzy [marius.vlad@collabora.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEcDKHej6x6uPk3J379jQS5glH1u8FAl+SzU4ACgkQ9jQS5glH
1u/TbQ/+I0NuOhgZpVfeBwy0evL68MskIqiV4oAYCOe5Mw+D4eacOWg9SwiDoTMN
qg/YQSY4JXOXltjWJTi2L06IcpSumEPdwhB1lHCSFR+7MV4r6vm3ta+kwao514+J
NXMLUbdDpZkMih7UztD3u2iOplWRCeVsFP3uRkxxy3j7kz9Habr23MHtF18GWuXM
LSDXTv92Wx6cK276SSjblcoDuAaIubNu1Ry37W2Uo1G9eGOAutgAb2JLE/dC+B+x
evUtU9op4lKB0rALcr3CHXaI1M6x0V53iFdXxdOpM+IutwqWZbUwewxBoAlU+gPS
b59luQBV9mQjLp2CmC0jE4SA5S+OlKZTxZOpRX578psPfEUcA0TsCLsCQCJa08Bn
ucjGC0ck2rmJn6Ht4bowU9HFMin2O1jEMsvhznVP8UbC7h06b6QWeGqPZvI7TJZ2
ggE3eA7zkv5SAa6zWEdMmxHXehkQjE5JlErWZxGqM53EJun1v3cH+AKmnJEEdo8P
xni6ueNeW0jbJb9eVgxnbvT0IkT+WEPNu/TyAIPb3zRYKhMcFMCJ/if8XaB5/9Tq
G4GYgCVZpi/gsCGiLZzkJAMOHJa9+AoZZZ23V9V7mD54POgHVbZwH3AFLBeYZdLn
7X8sulQ/l9Jqx6viTX/Ibw1gr7AycsvBJQNHy7oj7RxGZ0qzPfw=
=QuMQ
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

