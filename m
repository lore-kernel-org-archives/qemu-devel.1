Received: from eggs.gnu.org ([209.51.188.92]:44906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyzAA-0007br-5i
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyzA9-0008If-3A
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:22:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gyzA8-0008IC-Mt
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:22:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C43BE3B73D
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 13:14:21 +0000 (UTC)
Date: Wed, 27 Feb 2019 14:14:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190227131416.nrgt5jgvrdtyxmry@sirius.home.kraxel.org>
References: <20190227103017.29515-1-marcandre.lureau@redhat.com>
	<20190227103017.29515-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190227103017.29515-13-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 12/12] contrib: add vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Wed, Feb 27, 2019 at 11:30:17AM +0100, Marc-Andr=E9 Lureau wrote:
> Add a vhost-user input backend example, based on virtio-input-host
> device. It takes an evdev path as argument, and can be associated with
> a vhost-user-input device via a UNIX socket:
>=20
> $ vhost-user-input -p /dev/input/eventX -s /tmp/vui.sock
>=20
> $ qemu ... -chardev socket,id=3Dvuic,path=3D/tmp/vui.sock
>   -device vhost-user-input-pci,chardev=3Dvuic
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
