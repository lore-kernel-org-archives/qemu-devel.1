Received: from eggs.gnu.org ([2001:4830:134:3::10]:33608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZW9g-0004qA-PT
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZW9c-0003HM-QL
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:20:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZW9a-0003F1-Qa
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:20:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A562781F12
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 07:20:24 +0000 (UTC)
Date: Wed, 19 Dec 2018 08:20:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181219072023.2hbaoqrfp6r2ihog@sirius.home.kraxel.org>
References: <20181218142629.15943-1-berrange@redhat.com>
	<20181218142629.15943-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181218142629.15943-2-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] ui: install logo icons to
 $prefix/share/icons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Dec 18, 2018 at 02:26:27PM +0000, Daniel P. Berrang=E9 wrote:
> QEMU currently installs loogs to $prefix/share/qemu/ which means no GUI
> toolkit or applications can find them by default.
>=20
> The accepted standards for desktop applications declare that applicatio=
n
> logos / icons should be installed under $prefix/share/icons, so use thi=
s
> directory location.
>=20
> Pre-rendered icons are provided at the standard sizes expected for GUI
> applications, along with the scalable SVG, to ensure maximum portabilit=
y.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  Makefile                                       |  13 ++++++++++++-
>  configure                                      |   2 ++
>  ui/gtk.c                                       |  17 +++++------------
>  .../qemu_logo_no_text.svg =3D> ui/icons/qemu.svg |   0
>  ui/icons/qemu_128x128.png                      | Bin 0 -> 7761 bytes
>  ui/icons/qemu_16x16.png                        | Bin 0 -> 751 bytes
>  ui/icons/qemu_24x24.png                        | Bin 0 -> 1167 bytes
>  ui/icons/qemu_256x256.png                      | Bin 0 -> 16216 bytes
>  .../qemu-icon.bmp =3D> ui/icons/qemu_32x32.bmp   | Bin
>  ui/icons/qemu_32x32.png                        | Bin 0 -> 1656 bytes
>  ui/icons/qemu_48x48.png                        | Bin 0 -> 2604 bytes
>  ui/icons/qemu_512x512.png                      | Bin 0 -> 34609 bytes
>  ui/icons/qemu_64x64.png                        | Bin 0 -> 3588 bytes

How did you create the png files?
Can you drop a script or Makefile for that into the ui/icons directory?

Should we commit them to git, or generate at build time?
Is the tool used something we can expect to be installed?

cheers,
  Gerd
