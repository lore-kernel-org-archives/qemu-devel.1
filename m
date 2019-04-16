Received: from eggs.gnu.org ([209.51.188.92]:49656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOec-0002AI-Tl
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOeY-0001Jn-2y
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGOeX-0001J4-Hq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:01:37 -0400
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<C0F977FC-A960-4FA5-B2DF-BBD9DA664F8A@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c0f2d54-2b94-e278-cbce-b7175ba29cc8@redhat.com>
Date: Tue, 16 Apr 2019 16:01:29 +0200
MIME-Version: 1.0
In-Reply-To: <C0F977FC-A960-4FA5-B2DF-BBD9DA664F8A@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Wei Li <wei.d.li@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On 05/04/19 23:09, Wei Li wrote:
> Thanks Stefan for your quick response!
> 
> Hi Paolo, Could you please send us a link related to the multiqueue
> feature which you are working on so that we could start getting some
> details about the feature.

I have never gotten to the point of multiqueue, a prerequisite for that
was to make the block layer thread safe.

The latest state of the work is at github.com/bonzini/qemu, branch
dataplane7.

Paolo
