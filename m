Received: from eggs.gnu.org ([209.51.188.92]:33639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hL6Wc-0005pX-M7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hL6Wb-0001Rj-QJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hL6Wb-0001Qi-7r
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:53 -0400
Date: Mon, 29 Apr 2019 09:40:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190429134048.GH7587@stefanha-x1.localdomain>
References: <2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline
In-Reply-To: <44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wei Li <wei.d.li@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 10:14:16AM +0200, Paolo Bonzini wrote:
> On 23/04/19 14:04, Stefan Hajnoczi wrote:
> >> In addition, does Virtio-scsi support Batch I/O Submission feature
> >> which may be able to increase the IOPS via reducing the number of
> >> system calls?
> >
> > I don't see obvious batching support in drivers/scsi/virtio_scsi.c.
> > The Linux block layer supports batching but I'm not sure if the SCSI
> > layer does.
>=20
> I think he's referring to QEMU, in which case yes, virtio-scsi does
> batch I/O submission.  See virtio_scsi_handle_cmd_req_prepare and
> virtio_scsi_handle_cmd_req_submit in hw/scsi/virtio-scsi.c, they do
> blk_io_plug and blk_io_unplug in order to batch I/O requests from QEMU
> to the host kernel.

This isn't fully effective since the guest driver kicks once per
request.  Therefore QEMU-level batching you mentioned only works if QEMU
is slower at handling virtqueue kicks than the guest is at submitting
requests.

I wonder if this is something that can be improved.

Stefan

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxv7gAAoJEJykq7OBq3PIGJMH/11HaW7TKkiLS/WkH9plEatc
XT1tQc7TGjCq8G4p1HDCAgmc+hZTUbNFeLtpKRa4dor+OJAmNKjb+SJlW+PqD/9i
Cb8FuMPAgCmN0cthmcnpBZlW1ZK9pZuCfw+eeuSfTx7CfHvMAxN6keLXpHz2XeQz
1EJ2le/UWKALE9PnpdnVmSUgL3TsBmVAj85MXyaZKyNnyw1vzZ+QAzKTRUELaxxU
mBz0BbDuP+pizTNcxg2nLylAn39rpykwDTjPwKIbjPR+CNJAkYAxO+4rR2n457bR
vnuY/xVpcr0W51a5JwAKJUn7tbfCPzkb2VHpLjxIlIE2Ro2OPX1mq5d/VuL4IYQ=
=QQc2
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--
