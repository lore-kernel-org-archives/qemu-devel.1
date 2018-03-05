Received: from eggs.gnu.org ([2001:4830:134:3::10]:51132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esu14-0001vy-J0
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esu13-0007tY-RQ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:35:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1esu13-0007tP-Ms
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:35:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 650A9402312B
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 17:35:10 +0000 (UTC)
Date: Mon, 5 Mar 2018 17:35:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180305173502.GQ3131@work-vm>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-10-dgilbert@redhat.com>
	<20180228083826.GW18962@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228083826.GW18962@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v3 09/29] postcopy: Allow registering of fd
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Feb 16, 2018 at 01:16:05PM +0000, Dr. David Alan Gilbert (git) wrote:
> 
> [...]
> 
> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> > index bee21d4401..4bda5aa509 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -141,4 +141,25 @@ void postcopy_remove_notifier(NotifierWithReturn *n);
> >  /* Call the notifier list set by postcopy_add_start_notifier */
> >  int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp);
> >  
> > +struct PostCopyFD;
> > +
> > +/* ufd is a pointer to the struct uffd_msg *TODO: more Portable! */
> > +typedef int (*pcfdhandler)(struct PostCopyFD *pcfd, void *ufd);
> > +
> > +struct PostCopyFD {
> > +    int fd;
> > +    /* Data to pass to handler */
> > +    void *data;
> > +    /* Handler to be called whenever we get a poll event */
> > +    pcfdhandler handler;
> > +    /* A string to use in error messages */
> > +    char *idstr;
> 
> This was changed to const char in next patch.  We can move it here?

Oops, yes, done.

> The patch is a big one, there are quite a lot of TODOs and I still
> think there can be some helper functions shared between fd handling
> for 0-1 and 2-N but it looks good to me for merging as a first version.

Yes, it feels like it should be possible.

> After we have confirmed the definition of PostCopyFD please add:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks.

Dave

> 
> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
