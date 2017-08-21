Received: from eggs.gnu.org ([2001:4830:134:3::10]:48540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1djn7M-0007y5-7S
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1djn7H-0007PK-Dg
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:51:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1djn7H-0007JI-83
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:51:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C86CC806B8
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 13:51:40 +0000 (UTC)
Date: Mon, 21 Aug 2017 09:51:30 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1576327362.1079876.1503323490461.JavaMail.zimbra@redhat.com>
In-Reply-To: <1503321812.26016.19.camel@redhat.com>
References: <20170808224750.23904-1-marcandre.lureau@redhat.com>
	<1503321812.26016.19.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-input: send rel-wheel events for
 wheel buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Hi

----- Original Message -----
> On Wed, 2017-08-09 at 00:47 +0200, Marc-Andr=C3=A9 Lureau wrote:
> > qemu uses wheel-up/down button events for mouse wheel input, however
> > linux applications typically want REL_WHEEL events.
>=20
> --verbose please.
>=20
> Both should work just fine.

I haven't done extensive review of all input code on linux, but from what I=
 remember the event got dropped here:

https://cgit.freedesktop.org/xorg/driver/xf86-input-evdev/tree/src/evdev.c#=
n2720

It seems BTN_GEAR isn't clearly defined either.

Perhaps libinput does a better job at mapping the event, but we should cons=
ider older guests. Spice agent is using rel-wheel events, and we never had =
issues with it.

thanks
