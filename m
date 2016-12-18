Received: from eggs.gnu.org ([2001:4830:134:3::10]:59898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cIWJI-0000Go-PT
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 02:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cIWJF-0006u6-Od
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 02:55:08 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:34406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cIWJF-0006t5-HY
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 02:55:05 -0500
Received: by mail-wj0-x242.google.com with SMTP id xy5so19621440wjc.1
	for <qemu-devel@nongnu.org>; Sat, 17 Dec 2016 23:55:05 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <20161215200509.2239-2-dgilbert@redhat.com>
Date: Sun, 18 Dec 2016 09:55:10 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <98B4DDED-D776-49B4-84C2-1CA2B4057012@daynix.com>
References: <20161215200509.2239-1-dgilbert@redhat.com>
	<20161215200509.2239-2-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vmxnet3: Convert ring values to
 uint32_t's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com


Acked-by: Dmitry Fleytman <dmitry@daynix.com>

> On 15 Dec 2016, at 22:05 PM, Dr. David Alan Gilbert (git) =
<dgilbert@redhat.com> wrote:
>=20
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The index's in the Vmxnet3Ring were migrated as 32bit ints
> yet are declared as size_t's.  They appear to be derived
> from 32bit values loaded from guest memory, so actually
> store them as that.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
> hw/net/vmxnet3.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index 2cb2731..7853174 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -141,17 +141,17 @@ typedef struct VMXNET3Class {
> /* Cyclic ring abstraction */
> typedef struct {
>     hwaddr pa;
> -    size_t size;
> -    size_t cell_size;
> -    size_t next;
> +    uint32_t size;
> +    uint32_t cell_size;
> +    uint32_t next;
>     uint8_t gen;
> } Vmxnet3Ring;
>=20
> static inline void vmxnet3_ring_init(PCIDevice *d,
> 				     Vmxnet3Ring *ring,
>                                      hwaddr pa,
> -                                     size_t size,
> -                                     size_t cell_size,
> +                                     uint32_t size,
> +                                     uint32_t cell_size,
>                                      bool zero_region)
> {
>     ring->pa =3D pa;
> @@ -166,7 +166,7 @@ static inline void vmxnet3_ring_init(PCIDevice *d,
> }
>=20
> #define VMXNET3_RING_DUMP(macro, ring_name, ridx, r)                   =
      \
> -    macro("%s#%d: base %" PRIx64 " size %zu cell_size %zu gen %d next =
%zu",  \
> +    macro("%s#%d: base %" PRIx64 " size %u cell_size %u gen %d next =
%u",  \
>           (ring_name), (ridx),                                         =
      \
>           (r)->pa, (r)->size, (r)->cell_size, (r)->gen, (r)->next)
>=20
> --=20
> 2.9.3
>=20
