Received: from eggs.gnu.org ([2001:4830:134:3::10]:34589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAYf9-00074Y-IV
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAYf6-0004o7-7z
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:53:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAYf6-0004n9-1P
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:53:16 -0400
Message-ID: <1509702793.31823.13.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 10:53:13 +0100
In-Reply-To: <CAHmvugfcOMEZf1UKAcV0o_-EynuWtSFtzPznDCrVk1R42KWwLg@mail.gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-6-makovick@gmail.com>
	<1509533019.3856.9.camel@redhat.com>
	<CAHmvugfcOMEZf1UKAcV0o_-EynuWtSFtzPznDCrVk1R42KWwLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] sdl2 uses surface relative coordinates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, 2017-11-02 at 17:07 +0000, Jind=C5=99ich Makovi=C4=8Dka wrote:
> Hi,
>=20
> this patch fixes the exact case you mentioned. Currently, with
> surface size
> smaller than the window, the pointer is confined to the top left
> corner
> when using the absolute mode (-usbdevice tablet).

Tracked down.  Seems to be broken since commit
46522a82236ea0cf9011b89896d2d8f8ddaf2443.  SDL doesn't only scale
window output for us, but also pointer input, so qemu doesn't need to
do this by itself any more.

Patch is correct then.

cheers,
  Gerd
