Received: from eggs.gnu.org ([2001:4830:134:3::10]:60026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzFP-00054P-7S
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzFM-0002PC-0m
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:19:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZzFL-0002NH-Q1
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:19:47 -0500
Date: Fri, 12 Jan 2018 14:19:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112131944.wbdxi2nxv7zqpqeu@sirius.home.kraxel.org>
References: <a8b7c670cb61b8096291f5730af62f4230a3e7fa.1514187411.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a8b7c670cb61b8096291f5730af62f4230a3e7fa.1514187411.git.maozy.fnst@cn.fujitsu.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/usb/ccid: Make ccid_card_init() take
 an error parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Cao jin <caoj.fnst@cn.fujitsu.com>

On Mon, Dec 25, 2017 at 03:50:37PM +0800, Mao Zhongyi wrote:
> Replace init() of CCIDCardClass with realize, then convert
> ccid_card_init(), ccid_card_initfn() and it's callbacks to
> take an Error** in ordor to report the error more clearly.
>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com>
> Cc: Cao jin <caoj.fnst@cn.fujitsu.com>
>=20
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
> v3:
>   add 'qapi/error.h' header file.
>=20
>  hw/usb/ccid-card-emulated.c   | 44 +++++++++++++++++++++--------------=
--------
>  hw/usb/ccid-card-passthru.c   | 12 ++++++------
>  hw/usb/ccid.h                 |  2 +-
>  hw/usb/dev-smartcard-reader.c | 34 ++++++++++++++++++---------------
>  4 files changed, 48 insertions(+), 44 deletions(-)

Patch added to queue.

thanks,
  Gerd
