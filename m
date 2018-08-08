Received: from eggs.gnu.org ([2001:4830:134:3::10]:49926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fnBvX-0005rJ-6Q
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 20:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fnBvU-0006LU-3s
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 20:02:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fnBvT-0006Kt-UN
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 20:02:08 -0400
Date: Wed, 8 Aug 2018 03:02:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180808025009-mutt-send-email-mst@kernel.org>
References: <20180807193125.30378-1-alex.williamson@redhat.com>
	<20180807224033-mutt-send-email-mst@kernel.org>
	<20180807135303.3938b3a2@t450s.home>
	<20180808004929-mutt-send-email-mst@kernel.org>
	<20180807164033.575b5ff8@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807164033.575b5ff8@t450s.home>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Balloon inhibit enhancements,
 vfio restriction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, david@redhat.com

On Tue, Aug 07, 2018 at 04:40:33PM -0600, Alex Williamson wrote:
> Maybe some of these will evolve over time, SVA efforts are working on
> some of these interfaces, but apparently device assignment users have
> been getting along just fine without ballooning for many years.

But not any more I think.  It takes all the running you can do, to keep
in the same place.

Overcommit with device specific drivers is one of the things that
containers do better than VMs. If VMs had a better overcommit story with
PT devices, it would be interesting IMHO.

> With
> physical devices, or even modern VFs, it seems hard to push density
> beyond what we can handle with memory hotplug.  Perhaps as we get into
> scalable IOV type approaches we can opt-in more mediated devices by
> default.

I'm not sure what does mediated have to do with it though.  It seems
weird to fix internal Linux or even system call interfaces being
inadequate with custom hardware.

> It seems like we're just going around in circles here though,
> anything more than preventing QEMU from shooting itself is a long term
> goal touching multiple levels of the stack.

It's just QEMU and the kernel, I don't see why any other levels would be
involved. And it looks like we both agree it is a bug in the current VTD
emulation even though current guests do not trigger it.

I agree it's more work than just blocking things out, I am not making an
argument for nacking this specific patch, but I do hope this thread
motivates someone to look into it.

-- 
MST
