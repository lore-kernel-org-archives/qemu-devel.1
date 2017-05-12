Received: from eggs.gnu.org ([2001:4830:134:3::10]:44462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d97qg-00035E-PG
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d97qd-0003og-Lf
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:31:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d97qd-0003oU-DX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:30:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22F597F7A7
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 10:30:58 +0000 (UTC)
Message-ID: <1494585056.14352.59.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 12:30:56 +0200
In-Reply-To: <1493883704-27604-1-git-send-email-thuth@redhat.com>
References: <1493883704-27604-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] hw/usb/dev-serial: Do not try to set
 vendorid or productid properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Do, 2017-05-04 at 09:41 +0200, Thomas Huth wrote:
> When starting QEMU with the legacy USB serial device like this:
>=20
>  qemu-system-x86_64 -usbdevice serial:vendorid=3D0x1234:stdio
>=20
> it currently aborts since the vendorid property does not exist
> anymore (it has been removed by commit f29783f72ea77dfbd7ea0c9):
>=20
>  Unexpected error in object_property_find() at qemu/qom/object.c:1008:
>  qemu-system-x86_64: -usbdevice serial:vendorid=3D0x1234:stdio: Property
>                      '.vendorid' not found
>  Aborted (core dumped)
>=20
> Fix this crash by issuing a more friendly error message instead
> (and simplify the code also a little bit this way).

Added to usb queue.

thanks,
  Gerd
