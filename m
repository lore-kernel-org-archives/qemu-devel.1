Received: from eggs.gnu.org ([2001:4830:134:3::10]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdH5-0004E3-EL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdH0-000090-Gq
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:57:35 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmdH0-00008i-9c
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:57:30 -0400
Received: by mail-wm0-x244.google.com with SMTP id e204so435660wma.2
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:57:30 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:57:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829095726.GL25960@stefanha-x1.localdomain>
References: <20170827233033.7afa49b9@fiorina>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170827233033.7afa49b9@fiorina>
Subject: Re: [Qemu-devel] [RFC] Buffers/caches in VirtIO Balloon driver stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>

On Sun, Aug 27, 2017 at 11:30:33PM +0200, Tomáš Golembiovský wrote:
> Hi,

I have CCed the relevant mailing lists and people most recently involved
in virtio-balloon discussions.  Hopefully this will help get the right
people to see your questions.

> We'd like to include information about reclaimable memory into the
> statistics in VirtiO Balloon driver. Namely, we'd like to include
> counters for bufferes and caches of Linux kernel. The patch itself is
> pretty trivial -- no problem there. But before we do that I'd like to
> get some input from the QEMU community.
> 
> 1) Is there any reason not to have the stats there?
> 
> 2) Considering the balloon device is multiplatform (Linux, BSD,
> Windows), is there a problem with including buffers/caches? These seem
> to be specific to the Linux virtual memory subsystem. Of course, other
> OSes could just report zeros. Are there some internal stats on those
> OSes that could be filled in? I don't now if such or similar statistic
> are available on BSD. On Windows only SystemCache stat looks like
> something relevant. Anyone familiar with those OSes has any suggestions?
> 
>     Tomas
> 
> -- 
> Tomáš Golembiovský <tgolembi@redhat.com>
> 
