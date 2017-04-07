Received: from eggs.gnu.org ([2001:4830:134:3::10]:49436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cwRA6-0001nY-Es
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cwRA2-0002nZ-Dw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:30:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cwRA2-0002nK-8I
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B0A5787E2
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 10:30:33 +0000 (UTC)
Message-ID: <1491561030.26308.43.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 07 Apr 2017 12:30:30 +0200
In-Reply-To: <20170406120513.638-1-marcandre.lureau@redhat.com>
References: <20170406120513.638-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix incoming migration regression of
 QXL in VGA mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Do, 2017-04-06 at 14:05 +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> Commit cd958edb1fae85d introduced a migration regression in QXL VGA
> mode. The last patch fixes it. The first two patches helped me reason
> about the related console code.
>=20
> Marc-Andr=C3=A9 Lureau (3):
>   console: add same surface replace pre-condition
>   console: add same displaychangelistener registration pre-condition
>   qxl: switch display on entering VGA
>=20
>  hw/display/qxl.c | 1 +
>  ui/console.c     | 4 ++++
>  2 files changed, 5 insertions(+)
>=20

Added to vga queue.  Will cherry-pick 3/3 for 2.9

cheers,
  Gerd
