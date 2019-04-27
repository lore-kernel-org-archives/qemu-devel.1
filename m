Received: from eggs.gnu.org ([209.51.188.92]:40052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hKEtM-0004qY-N8
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 00:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hKEtL-0005wM-Na
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 00:24:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hKEtL-0005uz-Hc
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 00:24:47 -0400
Date: Sat, 27 Apr 2019 00:24:45 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <825292440.15675844.1556339085478.JavaMail.zimbra@redhat.com>
In-Reply-To: <7044D39A-8D7B-41F7-B8C3-DC2214E6826A@oracle.com>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<7044D39A-8D7B-41F7-B8C3-DC2214E6826A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org


> Thanks Stefan and Paolo for your response and advice!
> 
> Hi Paolo,
> 
> As to the virtio-scsi batch I/O submission feature in QEMU which you
> mentioned, is this feature turned on by default in QEMU 2.9 or there is a
> tunable parameters to turn on/off the feature?

Yes, it is available by default since 2.2.0.  It cannot be turned off, however
it is only possible to batch I/O with aio=native (and, since 2.12.0, with the NVMe
backend).

Paolo
