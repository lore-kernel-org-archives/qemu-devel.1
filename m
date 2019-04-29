Received: from eggs.gnu.org ([209.51.188.92]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hLAPN-0003h6-3X
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hLAPM-0002J4-9V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:49:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hLAPM-0002IH-0P
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:49:40 -0400
Date: Mon, 29 Apr 2019 10:49:31 -0700
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <F5614236-1B07-421B-8FE6-90129297014F@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<7044D39A-8D7B-41F7-B8C3-DC2214E6826A@oracle.com>
	<825292440.15675844.1556339085478.JavaMail.zimbra@redhat.com>
In-Reply-To: <825292440.15675844.1556339085478.JavaMail.zimbra@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org

Thanks Paolo for your clarification!

Just wanted to double confirm, does this mean batch I/O submission won't ap=
ply to aio=3Dthreads (which is the default mode)?

Thanks,
Wei


=EF=BB=BFOn 4/26/19, 9:25 PM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

   =20
    > Thanks Stefan and Paolo for your response and advice!
    >=20
    > Hi Paolo,
    >=20
    > As to the virtio-scsi batch I/O submission feature in QEMU which you
    > mentioned, is this feature turned on by default in QEMU 2.9 or there =
is a
    > tunable parameters to turn on/off the feature?
   =20
    Yes, it is available by default since 2.2.0.  It cannot be turned off, =
however
    it is only possible to batch I/O with aio=3Dnative (and, since 2.12.0, wi=
th the NVMe
    backend).
   =20
    Paolo
   =20
