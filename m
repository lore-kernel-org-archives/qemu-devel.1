Received: from eggs.gnu.org ([2001:4830:134:3::10]:39732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddWxn-0005Jo-VZ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddWxk-0001VG-IU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddWxk-0001UJ-Di
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:24:00 -0400
Date: Fri, 4 Aug 2017 15:23:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804072354.GK5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-25-git-send-email-peterx@redhat.com>
	<20170803112141.GF2076@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803112141.GF2076@work-vm>
Subject: Re: [Qemu-devel] [RFC 24/29] migration: new message
 MIG_RP_MSG_RESUME_ACK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Aug 03, 2017 at 12:21:41PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > +static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
> > +{
> > +    trace_source_return_path_thread_resume_ack(value);
> > +
> > +    /*
> > +     * Currently value will always be one. It can be used in the
> > +     * future to notify source that destination cannot continue.
> > +     */
> > +    assert(value == 1);
> 
> Again I prefer the routine to fail than to assert.
> Maybe it's worth having a constant rather than the magic 1.

Will do.  Thanks,

-- 
Peter Xu
