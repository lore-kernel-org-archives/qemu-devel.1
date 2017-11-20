Received: from eggs.gnu.org ([2001:4830:134:3::10]:57519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eGmiU-0000jt-D9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eGmiP-0001ub-FZ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:06:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eGmiP-0001tv-9b
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:06:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so18838297wmd.5
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 06:06:24 -0800 (PST)
Date: Mon, 20 Nov 2017 15:06:19 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171120150619.456c56f0@fiorina>
In-Reply-To: <2e8c12f5242bcf755a33ee3a0e9ef94339d1808c.1510487579.git.tgolembi@redhat.com>
References: <2e8c12f5242bcf755a33ee3a0e9ef94339d1808c.1510487579.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] virtio_balloon: include disk/file
 caches memory statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Huang Ying <ying.huang@intel.com>, Gal Hammer <ghammer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Rik van Riel <riel@redhat.com>

On Sun, 12 Nov 2017 13:05:38 +0100
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:

> Add a new field VIRTIO_BALLOON_S_CACHES to virtio_balloon memory
> statistics protocol. The value represents all disk/file caches.
>=20
> In this case it corresponds to the sum of values
> Buffers+Cached+SwapCached from /proc/meminfo.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 4 ++++
>  include/uapi/linux/virtio_balloon.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
=20
ping


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
