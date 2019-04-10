Received: from eggs.gnu.org ([209.51.188.92]:58853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hE8uZ-000588-EW
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hE8uY-0005SN-Gz
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:48:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hE8uY-0005Rw-9C
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:48:50 -0400
Date: Wed, 10 Apr 2019 10:43:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190410084309.ghr4b52qoabrpbkf@sirius.home.kraxel.org>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<20190409161009.6322-17-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190409161009.6322-17-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 16/20] console: add
 graphic_hw_update_done()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Apr 09, 2019 at 06:10:05PM +0200, Marc-Andr=E9 Lureau wrote:
> Add a function to be called when a graphic update is done.
>=20
> Declare the QXL renderer as async: render_update_cookie_num counts the
> number of outstanding updates, and graphic_hw_update_done() is called
> when it reaches none.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
