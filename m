Received: from eggs.gnu.org ([2001:4830:134:3::10]:42056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmG2Q-0001RM-4w
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmG2M-0002gd-Qx
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:08:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmG2M-0002gN-K0
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:08:50 -0400
Date: Mon, 28 Aug 2017 17:08:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170828090845.GP14174@pxdev.xzpeter.org>
References: <20170825141940.20740-1-dgilbert@redhat.com>
	<20170825141940.20740-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825141940.20740-2-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: Reset rather than destroy
 main_thread_load_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, shorne@gmail.com, quintela@redhat.com, mreitz@redhat.com, lvivier@redhat.com

On Fri, Aug 25, 2017 at 03:19:39PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> migration_incoming_state_destroy doesn't really destroy, it cleans up.
> After a loadvm it's called, but the loadvm command can be run twice,
> and so destroying an init-once mutex breaks on the second loadvm.
> 
> Reported-by: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
