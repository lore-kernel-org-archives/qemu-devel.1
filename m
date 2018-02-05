Received: from eggs.gnu.org ([2001:4830:134:3::10]:46462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eijap-0006u8-NK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eijak-0005VC-Oc
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:26:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eijak-0005SB-Gf
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:26:02 -0500
Date: Mon, 5 Feb 2018 16:25:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180205162549.GH28241@stefanha-x1.localdomain>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
	<20180126144429.GD17788@stefanha-x1.localdomain>
	<5A70606F.3030307@intel.com>
	<20180201190712-mutt-send-email-mst@kernel.org>
	<5A7462DC.1020904@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FLPM4o+7JoHGki3m"
Content-Disposition: inline
In-Reply-To: <5A7462DC.1020904@intel.com>
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com, Wei Wang <wei.w.wang@intel.com>


--FLPM4o+7JoHGki3m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 09:08:44PM +0800, Wei Wang wrote:
> On 02/02/2018 01:08 AM, Michael S. Tsirkin wrote:
> > On Tue, Jan 30, 2018 at 08:09:19PM +0800, Wei Wang wrote:
> > > Issues:
> > > Suppose we have both the vhost and virtio-net set up, and vhost pmd <=
->
> > > virtio-net pmd communication works well. Now, vhost pmd exits (virtio=
-net
> > > pmd is still there). Some time later, we re-run vhost pmd, the vhost =
pmd
> > > doesn't know the virtqueue addresses of the virtio-net pmd, unless the
> > > virtio-net pmd reloads to start the 2nd phase of the vhost-user proto=
col. So
> > > the second run of the vhost pmd won't work.
> > >=20
> > > Any thoughts?
> > >=20
> > > Best,
> > > Wei
> > So vhost in qemu must resend all configuration on reconnect.
> > Does this address the issues?
> >=20
>=20
> Yes, but the issues are
> 1) there is no reconnecting when a pmd exits (the socket connection seems
> still on at the device layer);

This is how real hardware works too.  If the driver suddenly stops
running then the device remains operational.  When the driver is started
again it resets the device and initializes it.

> 2) If we find a way to break the QEMU layer socket connection when pmd ex=
its
> and get it reconnect, virtio-net device still won't send all the configure
> when reconnecting, because socket connecting only triggers phase 1 of
> vhost-user negotiation (i.e. vhost_user_init). Phase 2 is triggered after
> the driver loads (i.e. vhost_net_start). If the virtio-net pmd doesn't
> reload, there are no phase 2 messages (like virtqueue addresses which are
> allocated by the pmd). I think we need to think more about this before
> moving forward.

Marc-Andr=E9: How does vhost-user reconnect work when the master goes away
and a new master comes online?  Wei found that the QEMU slave
implementation only does partial vhost-user initialization upon
reconnect, so the new master doesn't get the virtqueue address and
related information.  Is this a QEMU bug?

Stefan

--FLPM4o+7JoHGki3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeIWNAAoJEJykq7OBq3PIuL4IAKrLCHyns4sghP8oxSkE7JJq
DGvvIvuY57JEOHPuDHr80mcw3VSFlhpz2+GSS+ily3FEqoJr+WbMyN1zekB1+wUt
Cfb2xFrhNMdBWr+LGZZpEqocsoNZSBxVug8Z8SNwbwpp6eSSIPBoYjjt5JtHX+QL
zMZGmddpk+pMt4CIncDBfeaWzWZ5hi3On+eke8C13oV2Klc95qal+a2Gq/GheqtW
PxUaddQKvdb/9lIDBhSaPzJnKnkkCB5fU+6AVWxF465H/R62wLF8IlOVMOkdPJ7I
r/gazASqZWvwVJrRo4I0Rha3updsAuVJZt2OrP8TJM6v/Sy7nG89VKg+jFFxfzI=
=p4xE
-----END PGP SIGNATURE-----

--FLPM4o+7JoHGki3m--
