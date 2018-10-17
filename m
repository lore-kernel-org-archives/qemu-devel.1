Received: from eggs.gnu.org ([2001:4830:134:3::10]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCi2P-0000xj-4J
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCi2L-00026W-V5
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:22:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gCi2L-00025c-Ka
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:22:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id l6-v6so28385037wrt.1
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:22:41 -0700 (PDT)
Date: Wed, 17 Oct 2018 10:22:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017092237.GD22755@stefanha-x1.localdomain>
References: <20181013025435.25785-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20181013025435.25785-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:54:35PM -0300, Eduardo Habkost wrote:
> This patch adds separate device types for each of those virtio
> device flavors:
>=20
> - virtio-*-pci: the existing multi-purpose device types
>   - Configurable using `disable-legacy` and `disable-modern`
>     properties
>   - Legacy driver support is automatically enabled/disabled
>     depending on the bus where it is plugged
>   - Supports Conventional PCI and PCI Express buses
>     (but Conventional PCI is incompatible with
>     disable-legacy=3Doff)
>   - Changes PCI vendor/device IDs at runtime
> - virtio-*-pci-0.9: legacy virtio device
>   - Supports Conventional PCI buses only, because
>     it has a PIO BAR
> - virtio-*-pci-1.0-transitional: virtio-1.0 device supporting legacy driv=
ers
>   - Supports Conventional PCI buses only, because
>     it has a PIO BAR
> - virtio-*-pci-1.0: modern-only
>   - Supports both Conventional PCI and PCI Express buses

If new device types are being created, is it time to decouple the VIRTIO
PCI transport from the actual VIRTIO device (blk, net, scsi) like we
already have with virtio-mmio?

  -device virtio-pci-1.0,id=3Dvirtio-pci-0
  -device virtio-blk,bus=3Dvirtio-pci-0,drive=3Ddrive0,serial=3Dmydisk

That way we avoid lots of boilerplate code and an explosion of new
device types.

Stefan

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxv9dAAoJEJykq7OBq3PI/asH/0wv1QFCviN/XhRUBTtNiLPx
LRj+lHu6X0s0KIvNI3KHcphLJdL2g5lF74VRRg/GKlbUUfFHdK/9Qaxc5OoIzYNp
5lj4sjGJNX/t9cBvNZVorRAMR+fEG6mh8by2XuYbUyrQodzKPeOlqmCGF9sJsO1U
ygIeUEtgt/8P4tyzcq8ISrVlA0BDJ6El8B2KZkCesSr7SRG/dGgpmt8Xq4iy64vK
WIljpvmOsfiXNvb4tFabg7qbOlRgf3d9vqH1430/Dwu5ThnjfcqD3jtjEhgt+mkj
REOQ3TCYwQIou1s53Szk2i7x0C3nUzCKlSiMpbIoM++Tui9pWT1bHvfGm7VA6+0=
=HbZ3
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
