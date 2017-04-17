Received: from eggs.gnu.org ([2001:4830:134:3::10]:57785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1czxqY-0005Xg-BH
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 00:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1czxqX-0003II-ON
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 00:01:02 -0400
MIME-Version: 1.0
In-Reply-To: <20170417034925.GC6717@lemon.lan>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170414060015.GA12191@lemon>
	<CAOGPPbeUkBskJfFX9=Of62pDrt6U-KAjbFZ-r=yVNNeb+ceAuA@mail.gmail.com>
	<20170417034925.GC6717@lemon.lan>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 17 Apr 2017 12:00:58 +0800
Message-ID: <CAOGPPbd_Y6m42EpuedngTWfGzt+MDvOwbPSmwp-OG5hVpMNBkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Mon, Apr 17, 2017 at 11:49 AM, Fam Zheng <famz@redhat.com> wrote:
> On Fri, 04/14 14:30, 858585 jemmy wrote:
>> Do you know some other format which have very small cluster size?
>
> 64k is the default cluster size for qcow2 but it can be configured at image
> creation time, as 512 bytes, for example:
>
>     $ qemu-img create -f qcow2 test.qcow2 -o cluster_size=512 1G

Thanks, i will test the performance again.
>
> Fam
