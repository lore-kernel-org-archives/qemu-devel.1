Received: from eggs.gnu.org ([2001:4830:134:3::10]:54807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMYOL-00045o-M5
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMYOG-0003xr-NU
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:01:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMYOG-0003xT-DP
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:01:28 -0500
Date: Wed, 6 Dec 2017 12:01:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171206120121.GC12584@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
	<20171205145950.GF31150@stefanha-x1.localdomain>
	<5A27C3B7.7010109@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <5A27C3B7.7010109@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 2/7] vhost-pci-net: add
 vhost-pci-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com, felipe@nutanix.com, changpeng.liu@intel.com


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 06:17:27PM +0800, Wei Wang wrote:
> On 12/05/2017 10:59 PM, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 11:33:11AM +0800, Wei Wang wrote:
> > > Add the vhost-pci-net device emulation. The device uses bar 2 to expo=
se
> > > the remote VM's memory to the guest. The first 4KB of the the bar area
> > > stores the metadata which describes the remote memory and vring info.
> > This device looks like the beginning of a new "vhost-pci" virtio device
> > type.  There are layering violations:
> >=20
> > 1. This has nothing to do with virtio-net or networking, it's purely
> >     vhost-pci.  Why is it called vhost-pci-net instead of vhost-pci?
>=20
> Here are a few things that are specific to vhost-pci-net here:
>=20
> 1) The device category here is set to NETWORK.
> 2) vhost-pci-net related features (e.g. future MQ feature) will be added =
to
> the property here.
>=20
> Right now, we only have vhost-pci-net. How about all focusing on the
> vhost-pci-net, and ignore vhost-pci for now? When future other types of
> devices are addded, we can abstract out a common vhost-pci layer?

That won't work well for a new device.  It would be fine if this code
was internal to QEMU, but it's a guest interface and changing it is
relatively costly.  Once this code ships the hardware interface is fixed
and drivers depend on it.  Changing the hardware interface requires
driver upgrades inside the guest.

All information needed to design vhost-pci for multiple device types is
already available.  The VIRTIO specification defines the device model
and vhost-user supports at least virtio-net, virtio-scsi, and virtio-blk
(in development).

I have CCed Felipe (vhost-user-scsi) and Changpeng (vhost-user-blk) to
see if they are interested in vhost-pci.

Stefan

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJ9wRAAoJEJykq7OBq3PIlWEH/AqcQdh52W+8W/69ARfXz+wB
n8gq2SpL6JwLbk0BpLMw+Wy+0Jqr2r39vcXf8cDfjQY3TEUV9oRoRp6e+ByVoHp+
t3pZJ4Rf2BdtOXxDnT+87+YVuMkNABprcu53wZPt7rVbPdX7MsHbtSsI/yQ21xcO
qhKC7zFk9BVPfObLkjLuvJiLhvGwZ1EEktWJIpUDjxRTYfbrQo2ea3Ho/G+wjP6l
HoknPpmZ7VBuYQzlpIqcmyssKstqKtJz5psk2UgRENTn16+M7Z7TrN30hNPIdYCo
MO9Q97JHpy/Qw1O4pxKmzsd5CENNpLDicNawGufNP74ycbMQokBKXYyCGLjB39E=
=wjEx
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
