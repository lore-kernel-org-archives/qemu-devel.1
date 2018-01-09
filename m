Received: from eggs.gnu.org ([2001:4830:134:3::10]:38614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eYwyM-0001vS-Vu
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eYwyI-0006cP-1S
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:41:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eYwyH-0006ap-Qc
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:41:53 -0500
Date: Tue, 9 Jan 2018 16:41:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180109164144.GB2708@work-vm>
References: <20171218201340.27583-1-dgilbert@redhat.com>
	<20171218201340.27583-6-dgilbert@redhat.com>
	<20171227141903.4e158a36@igors-macbook-pro.local>
	<20171228140323.25dbd2d4@igors-macbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171228140323.25dbd2d4@igors-macbook-pro.local>
Subject: Re: [Qemu-devel] [PATCH v5 5/7] vhost: Regenerate region list from
 changed sections list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: pbonzini@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, groug@kaod.org

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Wed, 27 Dec 2017 14:19:03 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Mon, 18 Dec 2017 20:13:38 +0000
> > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > 
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Compare the sections list that's just been generated, and if it's
> > > different from the old one regenerate the region list.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> [...]
> > 
> > > +    if (!dev->started) {
> > also why memmap is generated this early and not right before first use?
> > here we might generate memap but not actually use it.
> I retract question, as commit + follow up set_mem_table could happen before
> device is started. Having a comment here explaining it would be nice as
> the call flow is obvious.

Yes, and I think I've seen that.  I'll add a comment.

Dave

> 
> > >          goto out;
> > >      }
> > >  
> > 
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
