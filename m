Received: from eggs.gnu.org ([2001:4830:134:3::10]:40936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cvaBD-0001IQ-Vy
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 21:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cvaBA-0001gG-4K
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 21:56:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cvaB9-0001ft-UI
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 21:56:12 -0400
Date: Wed, 5 Apr 2017 09:56:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170405015607.GB7267@lemon>
References: <tencent_626816280E6377073CCDAC4F@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_626816280E6377073CCDAC4F@qq.com>
Subject: Re: [Qemu-devel] how to create threads like dataplane in qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: PERSIST <1554706732@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Sat, 04/01 11:54, PERSIST wrote:
> Hello!
>   I want to create a specific thread for each process in VM so that virtio block requests from each process can be sumbitted in the thread related to the process.
>   I tried to implement it by referring to dataplane,but I can not understand the source about dataplane.

There are multiple abstraction layers between guest process and QEMU threads, I
don't think the model you describe is practical. In dataplane, requests are
submitted to host through virtio ioeventfd, and handled by the per-virtual
device thread. What are you trying to achieve here?

Fam
