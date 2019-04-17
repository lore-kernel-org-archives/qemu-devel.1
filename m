Received: from eggs.gnu.org ([209.51.188.92]:47334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hGZXR-0005dy-Px
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hGZXQ-0005dU-Su
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:39:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hGZXQ-0005cY-Fc
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:39:00 -0400
Date: Tue, 16 Apr 2019 18:38:49 -0700
From: Wei Li <wei.d.li@oracle.com>
Message-ID: <85DF2701-24E2-4159-94F5-CB9C60D333BE@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<C0F977FC-A960-4FA5-B2DF-BBD9DA664F8A@oracle.com>
	<0c0f2d54-2b94-e278-cbce-b7175ba29cc8@redhat.com>
In-Reply-To: <0c0f2d54-2b94-e278-cbce-b7175ba29cc8@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

Thanks Paolo for your response and clarification.=20

Btw, is there any rough schedule about when are you planning to start worki=
ng on the multi queue feature?  Once you start working on the feature, I wou=
ld like to hear more details about the design and better understand how this=
 feature will benefit the performance of virtio-scsi.

Thanks again,
Wei

=EF=BB=BFOn 4/16/19, 7:01 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

    On 05/04/19 23:09, Wei Li wrote:
    > Thanks Stefan for your quick response!
    >=20
    > Hi Paolo, Could you please send us a link related to the multiqueue
    > feature which you are working on so that we could start getting some
    > details about the feature.
   =20
    I have never gotten to the point of multiqueue, a prerequisite for that
    was to make the block layer thread safe.
   =20
    The latest state of the work is at github.com/bonzini/qemu, branch
    dataplane7.
   =20
    Paolo
   =20
