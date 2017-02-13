Received: from eggs.gnu.org ([2001:4830:134:3::10]:46044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cdGmC-0001Bw-Jz
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cdGmB-0008HB-9i
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:34:44 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:32905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cdGmB-0008H6-1T
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 08:34:43 -0500
Received: by mail-lf0-x244.google.com with SMTP id x1so8537181lff.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 05:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20170212112118.16044-1-marcandre.lureau@redhat.com>
	<CAJ+F1CJBwjp70CgzTCwXYQzcpn6X0r9ka80rc6DmqnJbgHZNUA@mail.gmail.com>
	<1486992725.19677.20.camel@redhat.com>
In-Reply-To: <1486992725.19677.20.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 Feb 2017 13:34:30 +0000
Message-ID: <CAJ+F1C+EHym0e2FzNU_8qhOE=-8rO0pxo7=HObhTmnC69DUA=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spice: allow to specify drm rendernode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Mon, Feb 13, 2017 at 5:32 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mo, 2017-02-13 at 08:37 +0000, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Gerd,
> >
> >
> > Rendernode are not stable across reboots, it depends on module order.
> >
> > I have further patches to specify a pci address instead:
> > rendernode=3D<file|pciaddr>. Does that seem fine?
>
> No, IMO we should use udev rules to generate stable paths then
> (/dev/disk/by-* style).
>

Yes, we are discussing this approach on libvirt mailing list, I will work
on it.

In the meantime, this patch should be good enough for 2.9 hopefully.

Thanks
--=20
Marc-Andr=C3=A9 Lureau
