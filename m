Received: from eggs.gnu.org ([2001:4830:134:3::10]:37917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csO1Z-00084l-U4
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csO1V-0004rf-Tp
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1csO1V-0004rF-Nm
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 02:21:01 -0400
Message-ID: <1490595656.31035.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Mar 2017 08:20:56 +0200
In-Reply-To: <CAJSP0QX3z_Zn-jdi7=2qw795Ep2nG5xvWR9DqyWajnKjkCGd3g@mail.gmail.com>
References: <20170316120110.11677-1-iwona260909@gmail.com>
	<20170316120110.11677-2-iwona260909@gmail.com>
	<CAFEAcA8ZBAAqYNbh_3J69W5SMXRsbW4S367Xe8ceF1C0M-RNnA@mail.gmail.com>
	<1489673540.15659.93.camel@redhat.com>
	<CAJSP0QX3z_Zn-jdi7=2qw795Ep2nG5xvWR9DqyWajnKjkCGd3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: iwona260909@gmail.com, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> Some emulated graphics cards use qemu_console_surface() and that
> surface is always in 32 bits per pixel format.  Therefore, code for
> dealing with other pixel formats can be removed.

qemu_create_displaysurface() creates a displaysurface with the default
depth 32bpp.  qemu_console_resize() will create a new displaysurface,
with the given size, also with the default depth 32bpp.

qemu_console_surface() just asks for the current surface, that alone
isn't a good indicator, but often display drivers use
qemu_console_surface + qemu_console_resize.

cheers,
  Gerd
