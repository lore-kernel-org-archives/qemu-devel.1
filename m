Received: from eggs.gnu.org ([2001:4830:134:3::10]:36750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ciQWz-0006T7-9x
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ciQWv-0003dB-EW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:00:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ciQWv-0003cy-97
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:00:17 -0500
Date: Mon, 27 Feb 2017 19:00:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170227190012.GC3226@work-vm>
References: <20170222160119.52771-1-pasic@linux.vnet.ibm.com>
	<20170222160119.52771-4-pasic@linux.vnet.ibm.com>
	<20170224122954.GA8830@work-vm>
	<fb8ac151-a375-9c2b-a241-fbff879c3492@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8ac151-a375-9c2b-a241-fbff879c3492@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration/vmstate: fix array of ptr
 with nullptrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 02/24/2017 01:29 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >> Make VMS_ARRAY_OF_POINTER cope with null pointers. Previously the
> >> reward for trying to migrate an array with some null pointers in it was
> >> an illegal memory access, that is a swift and painless death of the
> >> process.  Let's make vmstate cope with this scenario.
> >>
> >> The general approach is, when we encounter a null pointer (element),
> >> instead of following the pointer to save/load the data behind it, we
> >> save/load a placeholder. This way we can detect if we expected a null
> >> pointer at the load side but not null data was saved instead.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> 
> Thanks! Seems there are no further objections. Is the series going in
> via your tree (softfreeze starting 28.02, me worried)?

I'm ok with that; and there will be a migration pull tomorrow.
So lets see what we can do.

Dave

> 
> Regards,
> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
