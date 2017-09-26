Received: from eggs.gnu.org ([2001:4830:134:3::10]:54815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwlvf-0000eP-93
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwlvb-00022d-GD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwlvb-000222-B2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:13:19 -0400
Date: Tue, 26 Sep 2017 17:13:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170926091313.GD3828@pxdev.xzpeter.org>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-6-git-send-email-peterx@redhat.com>
	<20170921175137.GE3401@work-vm>
	<20170926084854.GA3828@pxdev.xzpeter.org>
	<20170926085344.GA2689@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170926085344.GA2689@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 05/33] migration: better error handling
 with QEMUFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Sep 26, 2017 at 09:53:44AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Sep 21, 2017 at 06:51:37PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > > > @@ -1969,6 +2002,10 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> > > >                  goto out;
> > > >              }
> > > >              break;
> > > > +        case QEMU_VM_EOF:
> > > > +            /* This is the end of migration */
> > > > +            goto out;
> > > > +            break;
> > > 
> > > You don't need the goto and the break (although it does no harm).
> > 
> > I still need the goto to break the loop? (I think a single break will
> > only break the select, but not the loop)
> > 
> > If I remove both "goto" and "break", it'll fall through to default, I
> > suppose that's not what we want?
> 
> No, but if you have the 'goto' you don't need the 'break'.

I see.  Let me remove the "break" after "goto" then.  Thanks,

-- 
Peter Xu
