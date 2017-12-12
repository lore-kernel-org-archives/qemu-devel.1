Received: from eggs.gnu.org ([2001:4830:134:3::10]:54925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOhg0-0008DQ-Bx
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOhfw-0002mJ-Kx
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:20:39 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:42109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eOhfw-0002ls-Dp
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:20:36 -0500
Received: by mail-wr0-x22f.google.com with SMTP id s66so20543766wrc.9
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 02:20:36 -0800 (PST)
Date: Tue, 12 Dec 2017 10:20:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171212102032.GC6985@stefanha-x1.localdomain>
References: <1512455239-8296-1-git-send-email-changpeng.liu@intel.com>
	<1512455239-8296-2-git-send-email-changpeng.liu@intel.com>
	<20171211133901.GA5962@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5E5373@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B5E5373@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2017 at 01:25:30AM +0000, Liu, Changpeng wrote:
> > The vhost-blk code should also check that
> > hdev->vhost_ops->vhost_set_config != NULL during realize.  This way
> > users see the error when adding the device instead of at runtime when
> > the function gets called.
> For vhost-blk, get_config is mandatory, but for set_config, it should depend
> on the feature bit: VIRTIO_BLK_F_CONFIG_WCE is enabled or not. Of course,
> migration should be another case. So running time error process should be
> okay.

Okay.

Stefan

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaL61wAAoJEJykq7OBq3PIC5sH+wcemmaRpvmMThNS1xbjHBZP
u2AxyXUSZj9dxktWlxkC0vrjlek4QxrcmITIkduR1rnMb/5xq0a7Ai3fscHhWgFB
zRHlYxpj2i9fbz28sRMVhk1fZEKnL7X8YtUS9KwSY7FpKQ+AVhzzPvu5Ea0ElwB1
3PMvM7elvq92LA9jV3+WRQeIM37k9Yi+79mZ7E8Y3ojUmZjyE/3UpVxgBhCQ9DAT
wI12RRahh7X2y1qYz8vTb36F70H37lZMDWQO5U13QdwCkExFYoyivvMgRllFtkL3
/7Xsw/LM5hgcvHEP/h8up2qWB2pC4vDRYQOrwQxqfY2vkVaB7QLpLTGuyogvikU=
=GQpV
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
