Received: from eggs.gnu.org ([2001:4830:134:3::10]:50741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDvmY-0003r4-Mq
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDvmU-00029T-PQ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fDvmU-00028i-I3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:43:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0F333003A38
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 17:43:03 +0000 (UTC)
Date: Wed, 2 May 2018 11:42:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180502114257.54564d60@w520.home>
In-Reply-To: <CAMwc25p+3ugAHz14shv_Dyo8LmJzf=dNJXH53RMyS4kAD0qvag@mail.gmail.com>
References: <20180501161509.28517.344.stgit@gimli.home>
	<CAMwc25p+3ugAHz14shv_Dyo8LmJzf=dNJXH53RMyS4kAD0qvag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Update linux-headers to v4.17-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Airlie <airlied@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com

On Wed, 2 May 2018 06:25:16 +1000
David Airlie <airlied@redhat.com> wrote:

> On Wed, May 2, 2018 at 2:25 AM, Alex Williamson <alex.williamson@redhat.com>
> wrote:
> 
> > This series is based on Michael's series moving kvm_para.h out to
> > standard headers, which resolves the conflict in definitions of
> > KVM_HINTS_DEDICATED between QEMU and kernel.
> >
> > Additionally, this series moves the definition of
> > VIRTIO_GPU_CAPSET_VIRGL2 into QEMU code as the definition does not
> > exist in the upstream header and it seems unreasonable to expect
> > anyone wanting to update headers should manually resolve this
> > conflict.
> >  
> 
> I thought the headers went qemu->linux which is why I never pushed this to
> Linux.
> 
> Happy to have a patch in the kernel that adds this.

Yea, it's the other direction, the file in QEMU is updated from the
uapi header in the kernel.  I'd submit a kernel patch, but I have no
idea what VIRTIO_GPU_CAPSET_VIRGL2 signifies, so it's probably best
that it be submitted by someone who can write a meaningful commitlog.
Thanks,

Alex
