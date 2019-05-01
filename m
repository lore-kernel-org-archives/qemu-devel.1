Received: from eggs.gnu.org ([209.51.188.92]:53982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsE5-0002rq-PV
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hLsE2-0003RQ-NX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:36:57 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hLsE2-0003Nx-GM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 12:36:54 -0400
Received: by mail-io1-xd42.google.com with SMTP id u12so15311912iop.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 09:36:54 -0700 (PDT)
Date: Wed, 1 May 2019 12:36:50 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190501163650.GF21155@stefanha-x1.localdomain>
References: <CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<20190429134048.GH7587@stefanha-x1.localdomain>
	<1A278B43-AA26-43B4-B6C2-17231E780BBE@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <1A278B43-AA26-43B4-B6C2-17231E780BBE@oracle.com>
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
To: Wei Li <wei.d.li@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2019 at 10:56:31AM -0700, Wei Li wrote:
> Does this mean the performance could be improved via adding Batch I/O submission support in Guest driver side which will be able to reduce the number of virtqueue kicks?

Yes, I think so.  It's not obvious to me how a Linux SCSI driver is
supposed to implement batching though.  The .queuecommand API doesn't
seem to include information relevant to batching.

Stefan

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJywoACgkQnKSrs4Gr
c8ibRQgApviIvzBkdGSYDCfxjvmfv9kjionlS8Vj63GB5PtcEok9fvOoaQlXHIni
syrKPmZxcBVTLKmie1H5QBecbOU6FFr/wfaIQd/VIe9E2/hDjEsJKYSfQyr2vqEh
lpKb9yNfiguVWQThCruqNkwRxh62sQL9w/okJjXt+igyjNlQmonxhRMLok/AOu6Z
36td6F3oCfkEPA3apaAEbtv9mvt3ztKJ7C9tuD4U9/vSgsKNUircByDBFaxYX2GO
3zFaFo5RP10Z6aRdtOlwRdRe3Kl9DfVidVTKDf2moYHiwyvBC7nlyfMMxT810Two
ii7c1hAReVJBmJaGtwmLUwRntZZnXA==
=GFKD
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
