Received: from eggs.gnu.org ([2001:4830:134:3::10]:50577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fIEV8-0003bP-RH
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fIEV7-0000oE-RC
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:30:58 -0400
MIME-Version: 1.0
References: <1526053004-12268-1-git-send-email-ivanren@tencent.com>
	<20180511172901.GC5016@localhost.localdomain>
	<CA+6E1==PkxLdnEGWMe5X0eKSPeGsVk3VQQ+fNs5+b_CDAcPMGg@mail.gmail.com>
	<20180514062343.GA6665@localhost.localdomain>
In-Reply-To: <20180514062343.GA6665@localhost.localdomain>
From: Ivan Ren <renyime@gmail.com>
Date: Mon, 14 May 2018 22:30:38 +0800
Message-ID: <CA+6E1=nvsCBO-T2nAq2uUi0AKhNFZ1GkCgB2kedgyoXQMP-5nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] qcow2: fix preallocation with metadata
 on bare block device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

> Oh, yes, there is no doubt that the result will be correct. My point is
> that people aren't usually interested so much in the physical layout of
> the clusters, but more about the fact that no metadata updates and no
> COW is necessary when you write to a cluster for the first time (i.e.
> because preallocation brings some performance improvements).
>
> Do you have a use case where the layout is more important? If there
> are good reasons for either option, maybe we need two different
> preallocation modes.

Yes, in my opinion, there are two advantages for preallocated metadata:
1. No metadata update.
2. The qcow2 cluster offset keep the same continuity with the guest offset,
and this is good for performance.

The second point is good if underlying media is bare block device without
filesystem, it means the continuous blocks in guest also keep continuity on
host.
The second point may not always be true if the qcow2 underlying media is a
regular file, in this case, the offset in qcow2 metadat is just the file's
offset but not the underlying block device.

Thanks.
