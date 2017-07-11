Received: from eggs.gnu.org ([2001:4830:134:3::10]:49530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUrnS-00078S-DV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dUrnR-00062F-Mb
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:49:34 -0400
Date: Tue, 11 Jul 2017 11:49:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170711094919.GH4335@noname.str.redhat.com>
References: <20170705102231.20711-1-stefanha@redhat.com>
	<20170705102231.20711-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170705102231.20711-3-stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: make qcow2_co_create2() a
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org

Am 05.07.2017 um 12:22 hat Stefan Hajnoczi geschrieben:
> qcow2_create2() calls qemu_co_mutex_lock().  Only a coroutine_fn may
> call another coroutine_fn.
>=20
> Rename the function (the block layer API is now called
> .bdrv_co_create()) and add coroutine_fn.  It is always called from
> coroutine context.
>=20
> Reported-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
