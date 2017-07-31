Received: from eggs.gnu.org ([2001:4830:134:3::10]:38981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcC37-0003nc-Ju
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcC34-0003yn-Db
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcC34-0003yd-3j
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:51:58 -0400
Date: Mon, 31 Jul 2017 15:51:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170731145141.GI11830@stefanha-x1.localdomain>
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
	<20170726103513.GB18489@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59C79E@SHSMSX103.ccr.corp.intel.com>
	<20170727094836.GB10129@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59CD56@SHSMSX103.ccr.corp.intel.com>
	<20170728103557.GB11097@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59D340@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B59D340@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "mst@redhat.com" <mst@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 29, 2017 at 03:21:16AM +0000, Liu, Changpeng wrote:
>=20
>=20
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > Sent: Friday, July 28, 2017 6:36 PM
> > To: Liu, Changpeng <changpeng.liu@intel.com>
> > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; felipe@nutanix.com;
> > mst@redhat.com
> > Subject: Re: [PATCH 1/2] vhost-user-blk: introduce a new vhost-user-blk=
 host device
> >=20
> > On Thu, Jul 27, 2017 at 10:08:49AM +0000, Liu, Changpeng wrote:
> > > > -----Original Message-----
> > > > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > > > Sent: Thursday, July 27, 2017 5:49 PM
> > > > To: Liu, Changpeng <changpeng.liu@intel.com>
> > > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; felipe@nutanix.com;
> > > > mst@redhat.com
> > > > Subject: Re: [PATCH 1/2] vhost-user-blk: introduce a new vhost-user=
-blk host
> > > > device
> > > >
> > > > On Thu, Jul 27, 2017 at 12:29:45AM +0000, Liu, Changpeng wrote:
> > > > > > > +    .fields =3D (VMStateField[]) {
> > > > > > > +        VMSTATE_VIRTIO_DEVICE,
> > > > > > > +        VMSTATE_END_OF_LIST()
> > > > > > > +    },
> > > > > > > +};
> > > > > > > +
> > > > > > > +static Property vhost_user_blk_properties[] =3D {
> > > > > > > +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > > > > > > +    DEFINE_BLOCK_PROPERTIES(VHostUserBlk, blkcfg),
> > > > > >
> > > > > > DEFINE_BLOCK_PROPERTIES cannot be used directly because it incl=
udes the
> > > > > > 'drive' (blkcfg.blk) parameter.  The command-line should not al=
low a
> > > > > > drive=3D parameter.
> > > > > >
> > > > > > Also, parameters like the discard granularity, optimal I/O size=
, logical
> > > > > > block size, etc can be initialized to sensible defaults by QEMU=
's block
> > > > > > layer when drive=3D is used.  Since you are bypassing QEMU's bl=
ock layer
> > > > > > there is no way for QEMU to set good defaults.
> > > > > >
> > > > > > Are you relying on the managment tools populating these paramet=
ers with
> > > > > > the correct values from the vhost-user-blk process?  Or did you=
 have
> > > > > > some other mechanism in mind?
> > > > > Actually for this part and your comments about block resize, I th=
ink maybe
> > add
> > > > several
> > > > > additional vhost user messages such like:
> > > > VHOST_USER_GET_BLK_CFG/VHOST_USER_SET_BLK_CFG
> > > > > makes the code more clear, I'm okay to add such messages.
> > > >
> > > > New messages for virtio config space read/write might be useful for
> > > > other devices besides virtio-blk.
> > > I mean all the block device information like: block_size/capacity are=
 stored in
> > another process,
> > > so add a new vhost user message to Qemu vhost-user-blk can get those
> > information when Qemu get
> > > started, once those messages stored to virtio_pci config space, we wi=
ll not
> > change it.
> >=20
> > No, I think updates are necessary:
> >=20
> > The virtio block device can do online disk resize, so it will be
> > necessary to change the capacity field from the vhost-user-blk process
> > at runtime and raise a config change notification interrupt.
> >=20
> > The virtio block device also has a config space field ("wce") that is
> > writable by the guest.  Supporting this feature also requires virtio
> > config space support in vhost-user.
> >=20
> > If you focus on adding generic virtio config space messages to
> > vhost-user then these virtio block features can be supported by
> > vhost-user-blk.
> >=20
> > Regarding the two approaches of adding "block device information" as you
> > have suggested versus adding generic virtio config space support as I'm
> > suggesting, from a protocol design perspective it's nicer to have
> > generic messages that are usable by all device types.  I'm not aware of
> > a reason why high-level "block device information" is needed since QEMU
> > will just put that into the config space but otherwise does not
> > interpret the information.
> Agreed, adding a vhost message  to get/set generic vitio_pci device confi=
g space=20
> is clear to me now, it's better than only for vhost-user-blk messages.
>=20
> Here I still have an concern about *resize* feature for vhost-user-blk, c=
urrently
> Qemu vhost-user-blk is the client for vhost user messages, does this means
> the I/O processing process must send a new vhost message back to Qemu
> vhost-user-blk driver that the capacity of the block device is changed? O=
r you
> have better idea to do this? Thanks.

A vhost-user process -> vhost-user master message is not necessary.  An
eventfd can be used to signal config changes instead.

I have CCed Marc-Andr=E9 because I don't know much about the vhost-user
protocol design.

Here is what I suggest for virtio config space:

typedef enum VhostUserRequest {
    ...

    /* Submitted by the vhost-user master when the guest writes to
     * virtio config space and also after live migration on the
     * destination host.
     */
    VHOST_USER_SET_CONFIG,

    /* Submitted by the vhost-user master to fetch the contents of the
     * virtio config space.  The vhost-user master may cache the
     * contents to avoid repeated VHOST_USER_GET_CONFIG calls.
     */
    VHOST_USER_GET_CONFIG,

    ...
};

struct VuDev {
    ...
    int config_change_fd;
    ...
};

/**
 * vu_config_change_notify:
 * @dev: a VuDev context
 *
 * Notify the vhost-user master that the device has updated virtio
 * config space.  The master must raise a config change interrupt in the
 * guest and invalidate any cached virtio config space contents so that
 * the next guest read results in a VHOST_USER_GET_CONFIG request.
 */
void vu_config_change_notify(VuDev *dev);

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZf0P9AAoJEJykq7OBq3PI9tsH/itTKYF+YneWflROAkEYTpRd
GhVWA1W4nZJ8idjFmehfPVyTMKNnG5CxzJz3V+gxBIEWUUa5LXh2tbpENA0noHpu
LKbLMyqKzKsk0c4UJdz8P42OJ7nbbJ6y1FQeR+ry/F90uEnUgfeRLOww29UwkpwB
ZucNf+GqIVEzHbyQVeZbubCCcgFTvdsMWT4GCMNvREELsf8KAWj1gQu/EQbKAVNv
S3T+gLBGGBiMDHvYHLuK5FQVN2Il26bxODlxC7wLLwixFTqt/JmeuF7GSsqVq+Jo
LpddZzAqNi4zxpU7ozrQ4bYH5VsYxOvxrm812q4JV3+OJNYFAJpFFR5OSDwMnNw=
=L/Pl
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--
