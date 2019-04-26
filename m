Received: from eggs.gnu.org ([209.51.188.92]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hKA5j-0002Rj-Bs
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 19:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hK9rE-0004c4-AX
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 19:02:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hK9rC-0004Pi-8g
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 19:02:14 -0400
Date: Fri, 26 Apr 2019 16:02:01 -0700
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <7044D39A-8D7B-41F7-B8C3-DC2214E6826A@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
In-Reply-To: <44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org

Thanks Stefan and Paolo for your response and advice!

Hi Paolo,

As to the virtio-scsi batch I/O submission feature in QEMU which you mentio=
ned, is this feature turned on by default in QEMU 2.9 or there is a tunable =
parameters to turn on/off the feature?

Thanks,
Wei

=EF=BB=BFOn 4/26/19, 1:14 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

    On 23/04/19 14:04, Stefan Hajnoczi wrote:
    >>In addition, does Virtio-scsi support Batch I/O Submission feature
    >>which may be able to increase the IOPS via reducing the number of
    >>system calls?
    >
    >I don't see obvious batching support in drivers/scsi/virtio_scsi.c.
    >The Linux block layer supports batching but I'm not sure if the SCSI
    >layer does.
   =20
    I think he's referring to QEMU, in which case yes, virtio-scsi does
    batch I/O submission.  See virtio_scsi_handle_cmd_req_prepare and
    virtio_scsi_handle_cmd_req_submit in hw/scsi/virtio-scsi.c, they do
    blk_io_plug and blk_io_unplug in order to batch I/O requests from QEMU
    to the host kernel.
