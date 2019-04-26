Received: from eggs.gnu.org ([209.51.188.92]:49277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJv5C-0005pB-0x
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJv5B-0006rI-1a
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJv5A-0006n3-M3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:15:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 131B281227
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:15:36 +0000 (UTC)
Date: Fri, 26 Apr 2019 09:15:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190426071530.y4eeu6ekx2nzvpar@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190423132004.13725-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/11] contrib: add vhost-user-input
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

On Tue, Apr 23, 2019 at 03:19:57PM +0200, Marc-Andr=E9 Lureau wrote:
> Add a vhost-user input backend example, based on virtio-input-host
> device. It takes an evdev path as argument, and can be associated with
> a vhost-user-input device via a UNIX socket:
>=20
> $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
>=20
> $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
>   -device vhost-user-input-pci,chardev=3Dvuic
>=20
> This example is intentionally not included in $TOOLS, to not be built
> and installed by default.

I think we should build it by default, so it doesn't bitrot,
even if we don't install it by default.

> +static int unix_sock_new(char *path)
> +{

Move to common code?

cheers,
  Gerd
