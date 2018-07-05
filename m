Received: from eggs.gnu.org ([2001:4830:134:3::10]:57898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fb6u6-00019T-Mz
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fb6u4-0008Pi-Ke
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:14:46 -0400
Date: Thu, 5 Jul 2018 18:14:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180705181436.6a2f796e.cohuck@redhat.com>
In-Reply-To: <20180705155811.20366-3-f4bug@amsat.org>
References: <20180705155811.20366-1-f4bug@amsat.org>
	<20180705155811.20366-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/7] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, "open
	list:virtio-ccw" <qemu-s390x@nongnu.org>

On Thu,  5 Jul 2018 12:58:06 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Patch created mechanically by rerunning:
>=20
>   $  spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/s390x/virtio-ccw.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I might send this via the s390x tree; in case trivial is quicker:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
