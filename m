Received: from eggs.gnu.org ([209.51.188.92]:52598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gmDfi-0000ag-WF
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gmDfh-00084i-HO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:14:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gmDfh-000817-58
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:14:05 -0500
Date: Wed, 23 Jan 2019 16:13:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190123081351.GB18231@xz-x1>
References: <20190122173111.29821-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122173111.29821-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: unegister fd handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, jemmy858585@gmail.com, quintela@redhat.com

On Tue, Jan 22, 2019 at 05:31:11PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Unregister the fd handler before we destroy the channel,
> otherwise we've got a race where we might land in the
> fd handler just as we're closing the device.
> 
> (The race is quite data dependent, you just have to have
> the right set of devices for it to trigger).
> 
> Corresponds to RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1666601
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(Could the crash happened because the same fd number is re-used after
 the RDMA channel was destroyed?  Then when the fd has an event, it'll
 be delivered to rdma_cm_poll_handler() while the fd is not really the
 RDMA channel handle any more)

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu
