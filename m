Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gWQcc-0002JQ-Fs
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gWQQ7-0001gW-T9
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:36:48 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gWQQ7-0001fy-Nv
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:36:43 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so7063252qka.12
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 10:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
In-Reply-To: <20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 10 Dec 2018 22:36:29 +0400
Message-ID: <CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hoffmann, Gerd" <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange,
	Daniel" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Hi

On Mon, Dec 10, 2018 at 6:30 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Nov 26, 2018 at 04:42:40PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > As discussed during "[PATCH v4 00/29] vhost-user for input & GPU"
> > review, let's define a common set of backend conventions to help with
> > management layer implementation, and interoperability.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>
> btw: have you seen the idea to use a vfio-style interface for
> communication between qemu and external device emulation processes?

I heard there was some discussion during KVM forum.

Fwiwi, this is also an idea I proposed last year (and quickly
discussed during my talk about multi-process qemu).
I also experimented with the idea, and wrote a vfio-user backend, with
a PCI serial device running in a seperate process:
the qemu tree: https://github.com/elmarco/qemu/tree/wip/vfio-user (dirty tr=
ee)
and the serial device:
https://github.com/elmarco/qemu/blob/wip/vfio-user/contrib/libvfio-user/vfi=
o-user-serial.c



>
> cheers,
>   Gerd
>
