Received: from eggs.gnu.org ([209.51.188.92]:33363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwoKX-00048u-Iv
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwoKW-00086V-Se
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwoKW-00084Q-Ke
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:24:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2FE330BB8E4
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 13:23:55 +0000 (UTC)
Date: Thu, 21 Feb 2019 14:23:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221132352.f66y5qljs7q4dmse@sirius.home.kraxel.org>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
	<20190221110703.5775-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190221110703.5775-12-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/11] display: add -display spice-app
 launching a Spice client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Feb 21, 2019 at 12:07:03PM +0100, Marc-Andr=E9 Lureau wrote:
> Add a new display backend that will configure Spice to allow a remote
> client to control QEMU in a similar fashion as other QEMU display
> backend/UI like GTK.
>=20
> For this to work, it will set up Spice server with a unix socket, and
> register a VC chardev that will be exposed as Spice ports. A QMP
> monitor is also exposed as a Spice port, this allows the remote client
> fuller qemu control and state handling.
>=20
> - doesn't handle VC set_echo() - this doesn't seem a strong
>   requirement, very few front-end use it
> - spice options can be tweaked with other -spice arguments
> - Windows support shouldn't be hard to do, but will probably use a TCP
>   port instead
> - we may want to watch the child process to quit automatically if it
>   crashed

Hmm, not working on RHEL-7:

  qemu-system-x86_64: Failed to launch spice+unix:///tmp/.QON7WZ/spice.so=
ck URI: The specified location is not supported

virt-viewer + remote-viewer are installed.

any clue?

thanks,
  Gerd
