Received: from eggs.gnu.org ([209.51.188.92]:50392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLrzb-0003lv-Mm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLrzU-0001uQ-C9
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:21:56 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLrzT-0001NO-RU
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:21:51 -0400
Received: by mail-it1-x143.google.com with SMTP id k64so10563075itb.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:21:42 -0700 (PDT)
Date: Wed, 1 May 2019 12:21:39 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190501162139.GC21155@stefanha-x1.localdomain>
References: <20190425130939.29674-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20190425130939.29674-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio: clarify VirtioPCIDeviceTypeInfo
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, sebastien.boeuf@intel.com, ehabkost@redhat.com


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 02:09:39PM +0100, Stefan Hajnoczi wrote:
> How to use .base_name, .generic_name, .transitional_name, and
> .non_transitional_name can be confusing.
>=20
> Existing devices have .generic_name but its behavior is somewhat magic.
>=20
> Devices added to new versions of the VIRTIO specification should forego
> transitional mode completely and always operate in non-transitional mode
> because there are no existing drivers for them that require backwards
> compatibility.
>=20
> This patch adds comments that hopefully make it easier for developers to
> decide how to fill out VirtioPCIDeviceTypeInfo.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Drop incorrect mention of machine type compat properties [ehabkost]
> ---
>  hw/virtio/virtio-pci.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Michael: This patch is for your virtio tree.

> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 18581854ca..0bd1fff942 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -209,7 +209,8 @@ typedef struct VirtioPCIDeviceTypeInfo {
>       * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_=
PCI_DEVICE,
>       * but PCI Express is supported only in non-transitional mode.
>       *
> -     * The only type implemented by QEMU 3.1 and older.
> +     * The only type implemented by QEMU 3.1 and older.  This type is le=
ss
> +     * explicit than the transitional and non-transitional device types.
>       */
>      const char *generic_name;
>      /*
> @@ -222,6 +223,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
>       * The non-transitional device type.  Optional.
>       *
>       * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
> +     *
> +     * New virtio device types should only define this and base_name, th=
ereby
> +     * allowing only non-transitional mode.
>       */
>      const char *non_transitional_name;
> =20
> --=20
> 2.20.1
>=20
>=20

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJx5MACgkQnKSrs4Gr
c8i8JAgAmZzBk7ZKK6fEUinAh5beow8nxry9vAJIZ0zLNyAq/9/KobMQYMEN6ZXU
ovccev6BKR0qL9fvWpP69UoUaWM8RU6ZKwfyZPLo3Wv9N7xB0s2LLEf/9ooN+3Zj
XcMrhIYPPNX8eeHWAUJ29qjCnE/sLbZ2tL4rewfhT87Bp+hLn3h8tCpIqCAcgMCv
Hc15Esd58WeaBHRAOfP8xht+4q/8g3O0z/mLFbF0a0EHO2BOwOF0klS38Zi8vove
OCck4saLTWuMuiKRIO9EOSIM+neRWikpRzlw/J6nNUqOlTBk5TH/drnpnla/Mc+F
tD0WCw9+9fspovZkgqYuk4kgjG/J8w==
=PQT5
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
