Received: from eggs.gnu.org ([209.51.188.92]:43693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hG5Vn-0003FO-5l
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hG5Vl-0006Tf-8G
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:35:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hG5Ve-0006Nh-UW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:35:13 -0400
Date: Mon, 15 Apr 2019 10:34:56 -0700
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
In-Reply-To: <CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Hi @Paolo Bonzini & @Stefan Hajnoczi,

Would you please help confirm whether @Paolo Bonzini's multiqueue feature c=
hange will benefit virtio-scsi or not? Thanks!

@Stefan Hajnoczi,
I also spent some time on exploring the virtio-scsi multi-queue features vi=
a num_queues parameter as below, here are what we found:

1. Increase number of Queues from one to the same number as CPU will get be=
tter IOPS increase.
2. Increase number of Queues to the number (e.g. 8) larger than the number =
of vCPU (e.g. 2) can get even better IOPS increase.

In addition, It seems Qemu can get better IOPS while the attachment uses mo=
re queues than the number of vCPU, how could it possible? Could you please h=
elp us better understand the behavior? Thanks a lot!


Host CPU Configuration:
CPU(s):                2
Thread(s) per core:    2
Core(s) per socket:    1
Socket(s):             1

Commands for multi queue Setup:
(QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D1 id=3Dtest1
(QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D2 id=3Dtest2
(QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D4 id=3Dtest4
(QEMU)  device_add driver=3Dvirtio-scsi-pci num_queues=3D8 id=3Dtest8


Result:
	|  8 Queues   |  4 Queues     |      2 Queues    |      Single Queue
IOPS 	|   +29%         |      27%           |        11%           |      B=
aseline

Thanks,
Wei

=EF=BB=BFOn 4/5/19, 2:09 PM, "Wei Li" <wei.d.li@oracle.com> wrote:

    Thanks Stefan for your quick response!
   =20
    Hi Paolo,
    Could you please send us a link related to the multiqueue feature which=
 you are working on so that we could start getting some details about the fe=
ature.
   =20
    Thanks again,
    Wei=20
   =20
    =EF=BB=BFOn 4/1/19, 3:54 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
   =20
        On Fri, Mar 29, 2019 at 08:16:36AM -0700, Wei Li wrote:
        > Thanks Stefan for your reply and guidance!
        >=20
        > We spent some time on exploring the multiple I/O Threads approach=
 per your feedback. Based on the perf measurement data, we did see some IOPS=
 improvement for multiple volumes, which is great. :)
        >=20
        > In addition, IOPS for single Volume will still be a bottleneck, i=
t seems like multiqueue block layer feature which Paolo is working on may be=
 able to help improving the IOPS for single volume.
        >=20
        > @Paolo, @Stefan,=20
        > Would you mind sharing the multiqueue feature code branch with us=
? So that we could get some rough idea about this feature and maybe start do=
ing some exploration?=20
       =20
        Paolo last worked on this code, so he may be able to send you a lin=
k.
       =20
        Stefan
       =20
   =20
