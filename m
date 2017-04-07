Received: from eggs.gnu.org ([2001:4830:134:3::10]:46558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwVaY-0003yA-4j
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwVaV-0002bX-Ee
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:14:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwVaV-0002bO-8D
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:14:11 -0400
Date: Fri, 7 Apr 2017 16:14:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407151405.GB2623@work-vm>
References: <20170407143254.22061-1-dgilbert@redhat.com>
	<a9e3490a-0a70-7b9d-53cb-0a2fd389c796@redhat.com>
	<20170407145634.GA2623@work-vm>
	<130e1495-72f5-7ab5-0f25-0e3cb65006dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <130e1495-72f5-7ab5-0f25-0e3cb65006dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] slirp/smb: Replace constant
 strings by glib string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, berrange@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 04/07/2017 09:56 AM, Dr. David Alan Gilbert wrote:
> 
> > 
> >> The cleanup is useful, and resolves one of the build issues I pointed
> >> out earlier on Rawhide (looks like it is now Fedora 26 in addition to
> >> Rawhide that have new-enough gcc).  In that thread, we argued that it's
> >> not going to be essential to get this in for 2.9, but as more and more
> >> people move to newer gcc, it will probably be a candidate for
> >> qemu-stable for 2.9.1 in addition to 2.10.
> > 
> > Ah which thread is that?
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/threads.html#04552
> in particular
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04567.html

Yep, feels about right.

> > I just posted:
> > https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg01294.html
> 
> Yes, I just saw that. And it is indeed hacky, but maybe it will spur
> some proper patches.

Yes, and some of those it might be best to see what the gcc people say
as to whether they'll fix them.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
