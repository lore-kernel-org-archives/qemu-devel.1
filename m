Received: from eggs.gnu.org ([2001:4830:134:3::10]:43238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dACK2-0007hd-2q
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dACJx-0008Cg-64
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:29:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dACJw-0008CH-W2
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:29:41 -0400
Date: Mon, 15 May 2017 17:29:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170515092933.GB10415@pxdev.xzpeter.org>
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<1494838260-30439-4-git-send-email-peterx@redhat.com>
	<8ed64684-6594-6533-491f-ccb4ea398d08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ed64684-6594-6533-491f-ccb4ea398d08@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] exec: further use is_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

On Mon, May 15, 2017 at 11:04:52AM +0200, Paolo Bonzini wrote:
> 
> 
> On 15/05/2017 10:50, Peter Xu wrote:
> > This is MMIO-specific tunes on the size. Let's skip it for non-MMIO
> > translations.
> 
> Can you explain this better?  This is not specific to MMIO, in fact it's
> for RAM...

Yes, I misread the codes and comments, sorry...

Please ignore this patch.

-- 
Peter Xu
