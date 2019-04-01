Received: from eggs.gnu.org ([209.51.188.92]:37083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hAsfk-0002Dj-9E
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 04:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hAsfj-0006Gw-AX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 04:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hAsfj-0006GL-2c
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 04:52:03 -0400
Date: Mon, 1 Apr 2019 09:51:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190401085154.GA2606@work-vm>
References: <20190326055726.10539-1-richardw.yang@linux.intel.com>
	<20190327202421.GH2636@work-vm> <20190401031034.GA4680@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401031034.GA4680@richard>
Subject: Re: [Qemu-devel] [PATCH] migration: remove not used field xfer_limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> On Wed, Mar 27, 2019 at 08:24:21PM +0000, Dr. David Alan Gilbert wrote:
> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> MigrationState->xfer_limit is only set to 0 in migrate_init().
> >> 
> >> Remove this unnecessary field.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >
> >Nice; I think that field has been unneeded since 1964a397063967
> >just over 5 years ago :-)
> >
> 
> Hi, David,
> 
> I found xfer_limit has an orphan brother, bytes_xfer.
> 
> Do you want me to send a separate patch or spin v2 to adopt these two
> together?

Either is fine;   since we're in 4.0 freeze at the moment, either way it
wont get merged for a few weeks.

Dave

> >
> >Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> >> ---
> >>  migration/migration.c | 1 -
> >>  migration/migration.h | 1 -
> >>  2 files changed, 2 deletions(-)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index e88acab53b..533c2102c7 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -1682,7 +1682,6 @@ void migrate_init(MigrationState *s)
> >>       * locks.
> >>       */
> >>      s->bytes_xfer = 0;
> >> -    s->xfer_limit = 0;
> >>      s->cleanup_bh = 0;
> >>      s->to_dst_file = NULL;
> >>      s->rp_state.from_dst_file = NULL;
> >> diff --git a/migration/migration.h b/migration/migration.h
> >> index 99e99e56bd..852eb3c4e9 100644
> >> --- a/migration/migration.h
> >> +++ b/migration/migration.h
> >> @@ -117,7 +117,6 @@ struct MigrationState
> >>  
> >>      /*< public >*/
> >>      size_t bytes_xfer;
> >> -    size_t xfer_limit;
> >>      QemuThread thread;
> >>      QEMUBH *cleanup_bh;
> >>      QEMUFile *to_dst_file;
> >> -- 
> >> 2.19.1
> >> 
> >--
> >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
