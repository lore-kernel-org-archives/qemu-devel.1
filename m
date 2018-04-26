Received: from eggs.gnu.org ([2001:4830:134:3::10]:36113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBg16-0006Ts-He
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBg12-00076w-B6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:28:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBg12-00076b-5h
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:28:48 -0400
Date: Thu, 26 Apr 2018 13:28:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180426122843.GD2631@work-vm>
References: <20180425200326.72337-1-dgilbert@redhat.com>
	<20180425200326.72337-7-dgilbert@redhat.com>
	<a9d3149c-f5a3-c220-a802-5ea7a4bffd90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d3149c-f5a3-c220-a802-5ea7a4bffd90@redhat.com>
Subject: Re: [Qemu-devel] [PULL 06/16] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

* Eric Blake (eblake@redhat.com) wrote:
> On 04/25/2018 03:03 PM, Dr. David Alan Gilbert (git) wrote:
> > From: Alexey Perevalov <a.perevalov@samsung.com>
> > 
> > Postcopy total blocktime is available on destination side only.
> > But query-migrate was possible only for source. This patch
> > adds ability to call query-migrate on destination.
> > To be able to see postcopy blocktime, need to request postcopy-blocktime
> > capability.
> 
> This prerequisite command...
> 
> 
> > +++ b/qapi/migration.json
> > @@ -155,6 +155,13 @@
> >  # @error-desc: the human readable error description string, when
> >  #              @status is 'failed'. Clients should not attempt to parse the
> >  #              error strings. (Since 2.7)
> > +#
> > +# @postcopy-blocktime: total time when all vCPU were blocked during postcopy
> > +#           live migration (Since 2.13)
> > +#
> > +# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (Since 2.13)
> 
> ... should be documented here (something along the lines of "This field
> is only present if the postcopy-blocktime migration capability was enabled")
> 
> > +#
> > +
> >  #
> 
> Why the blank line addition?  More to include in your followup cleanup
> patch.

Again I'll fix those up.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
