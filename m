Received: from eggs.gnu.org ([2001:4830:134:3::10]:52001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs06X-0001J6-2p
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs06S-0006TY-54
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:25:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs06R-0006Sx-Pv
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:25:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9024402242D
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:25:18 +0000 (UTC)
Date: Tue, 21 Aug 2018 08:25:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821062516.6jr3xc3gvbf5crcw@sirius.home.kraxel.org>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180713130916.4153-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 04/29] dmabuf: add y0_top,
 pass it to spice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, airlied@redhat.com

On Fri, Jul 13, 2018 at 03:08:51PM +0200, Marc-Andr=E9 Lureau wrote:
> Some scanouts during boot are top-down without it.
>=20
> y0_top is set from VHOST_USER_GPU_DMABUF_SCANOUT code path in the last
> patch of this series.
>=20
> In current QEMU code base, only vfio/display uses dmabuf API. But the
> VFIO query interface doesn't provide or need that detail so far.

Cherry-picked into ui queue.

cheers,
  Gerd
