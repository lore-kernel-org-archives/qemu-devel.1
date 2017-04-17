Received: from eggs.gnu.org ([2001:4830:134:3::10]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1czxfY-0001pL-JE
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1czxfX-0005sJ-T0
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:49:40 -0400
Date: Mon, 17 Apr 2017 11:49:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170417034925.GC6717@lemon.lan>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170414060015.GA12191@lemon>
	<CAOGPPbeUkBskJfFX9=Of62pDrt6U-KAjbFZ-r=yVNNeb+ceAuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGPPbeUkBskJfFX9=Of62pDrt6U-KAjbFZ-r=yVNNeb+ceAuA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Fri, 04/14 14:30, 858585 jemmy wrote:
> Do you know some other format which have very small cluster size?

64k is the default cluster size for qcow2 but it can be configured at image
creation time, as 512 bytes, for example:

    $ qemu-img create -f qcow2 test.qcow2 -o cluster_size=512 1G

Fam
