Received: from eggs.gnu.org ([2001:4830:134:3::10]:47998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmiWx-0004f8-LN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dmiWu-0005HP-IB
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:34:19 -0400
Date: Tue, 29 Aug 2017 18:34:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170829183303-mutt-send-email-mst@kernel.org>
References: <20170829152751.3174-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170829152751.3174-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] vhost-user-bridge reconnect
 regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, victork@redhat.com, qemu-stable@nongnu.org

On Tue, Aug 29, 2017 at 05:27:49PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> libvhost-user doesn't support resuming with the same trick vubr had
> since commit 523b018dde3b7650fe5401d0499b30cf2f117515. The following
> two patches fix that regression.


Thanks! Do we need this in 2.10? If not pls ping after 2.10 is out.

> Thanks
>=20
> Marc-Andr=E9 Lureau (2):
>   libvhost-user: support resuming vq->last_avail_idx based on used_idx
>   vhost-user-bridge: fix resume regression (since 2.9)
>=20
>  contrib/libvhost-user/libvhost-user.h |  7 +++++++
>  contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
>  tests/vhost-user-bridge.c             |  7 +++++++
>  3 files changed, 27 insertions(+)
>=20
> --=20
> 2.14.1.146.gd35faa819
