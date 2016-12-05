Received: from eggs.gnu.org ([2001:4830:134:3::10]:35905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cDv5x-0002ux-AN
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cDv5u-0000ZC-8A
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:22:21 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cDv5t-0000Yc-VJ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:22:18 -0500
Date: Mon, 5 Dec 2016 10:22:12 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1637153950.1453448.1480951332566.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161205144615.GE30434@stefanha-x1.localdomain>
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161201192652.9509-5-stefanha@redhat.com>
	<20161205005459.GA21702@lemon>
	<20161205101452.GB22443@stefanha-x1.localdomain>
	<1548288582.1411113.1480935595505.JavaMail.zimbra@redhat.com>
	<20161205144615.GE30434@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/13] virtio: poll virtqueues for new
 buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, borntraeger@de.ibm.com, Karl Rister <krister@redhat.com>, qemu-devel@nongnu.org, v maffione <v.maffione@gmail.com>

> Anyway, I'm glad the polling series on its own is already showing good
> performance results.  I'd like to merge it at the beginning of QEMU 2.9
> so we can work on further improvements that build on top of it.

Yes, it would be great if you can stage the infrastructure bits, so that
I can rebase my lockcnt patches on top.

Paolo
