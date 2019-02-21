Received: from eggs.gnu.org ([209.51.188.92]:44873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwl1b-0007GW-Lx
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwkso-00022r-Fd
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:43:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwkso-00022S-9k
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:43:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B5E6C057E09
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:43:09 +0000 (UTC)
Date: Thu, 21 Feb 2019 10:42:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221094256.6l4rhurvzdgqedw7@sirius.home.kraxel.org>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190208112357.31615-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190208112357.31615-13-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/13] contrib: add vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Feb 08, 2019 at 12:23:56PM +0100, Marc-Andr=E9 Lureau wrote:
> Add a vhost-user input backend example, based on virtio-input-host
> device. It takes an evdev path as argument, and can be associated with
> a vhost-user-input device via a UNIX socket:
>=20
> $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
>=20
> $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
>   -device vhost-user-input-pci,chardev=3Dvuic

> +static int unix_sock_new(char *path)
> +{

Move to the library?  This looks like something other backends will need
too.

cheers,
  Gerd
