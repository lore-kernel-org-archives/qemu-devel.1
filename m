Received: from eggs.gnu.org ([209.51.188.92]:46431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hMcf7-000272-Nz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hMcf6-0001sv-R2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:11:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hMcf6-0001rP-HS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:11:56 -0400
Date: Fri, 03 May 2019 11:11:50 -0700
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <C4E4C87E-7CFC-4262-BA3F-251090C57AEF@oracle.com>
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
	<20190501163650.GF21155@stefanha-x1.localdomain>
	<1823F9C3-8092-4B75-87AA-A05325032F48@oracle.com>
	<428e3ee5-28b0-7895-8a17-9178354c9406@redhat.com>
In-Reply-To: <428e3ee5-28b0-7895-8a17-9178354c9406@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org

Hi Paolo,

That will be great, I would like to hear more details about the design and =
implementation once you get those ready.=20

Thanks a lot,
Wei

=EF=BB=BFOn 5/3/19, 11:05 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

    On 03/05/19 10:21, Wei Li wrote:
    > Got it, thanks Stefan for your clarification!
   =20
    Hi Wei,
   =20
    Stefan and I should be posting a patch to add Linux SCSI driver
    batching, and an implementation for virtio-scsi.
   =20
    Paolo
   =20
    > Wei
    >=20
    > =EF=BB=BFOn 5/1/19, 9:36 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
    >=20
    >     On Mon, Apr 29, 2019 at 10:56:31AM -0700, Wei Li wrote:
    >     >Does this mean the performance could be improved via adding Batc=
h I/O submission support in Guest driver side which will be able to reduce t=
he number of virtqueue kicks?
    >    =20
    >     Yes, I think so.  It's not obvious to me how a Linux SCSI driver =
is
    >     supposed to implement batching though.  The .queuecommand API doe=
sn't
    >     seem to include information relevant to batching.
    >    =20
    >     Stefan
    >    =20
    >    =20
    >=20
    >=20
   =20
   =20
