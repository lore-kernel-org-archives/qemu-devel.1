Received: from eggs.gnu.org ([2001:4830:134:3::10]:47542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa1S-0002d8-L5
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa1R-0005Sb-Na
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:41:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJa1R-0005SF-J3
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A17C805A531
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:41:53 +0000 (UTC)
Date: Fri, 18 May 2018 09:41:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180518074150.feipgm46npwgmbig@sirius.home.kraxel.org>
References: <20180515153039.27514-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180515153039.27514-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ccid-card-passthru: fix regression in
 realize()
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

On Tue, May 15, 2018 at 05:30:39PM +0200, Marc-Andr=E9 Lureau wrote:
> Since cc847bfd16d894fd8c1a2ce25f31772f6cdbbc74, CCID card-passthru
> fails to intialize, because it changed a debug line to an error,
> probably by mistake. Change it back to a DPRINTF debug.
>=20
> (solves Boxes creating VM with smartcard passthru failing to start)

Added to usb queue.

thanks,
  Gerd
