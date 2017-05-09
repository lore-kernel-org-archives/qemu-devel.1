Received: from eggs.gnu.org ([2001:4830:134:3::10]:48548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d87nE-0005JZ-HH
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d87nA-0000O3-Gb
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:15:20 -0400
Date: Tue, 9 May 2017 17:15:13 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170509161513.GU16511@redhat.com>
References: <20170509093549.25157-1-pbonzini@redhat.com>
	<20170509101506.GQ16511@redhat.com>
	<20170509160330.GB16494@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509160330.GB16494@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/4] curl: locking cleanups and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, May 09, 2017 at 12:03:30PM -0400, Jeff Cody wrote:
> On Tue, May 09, 2017 at 11:15:06AM +0100, Richard W.M. Jones wrote:
> > 
> > No I'm afraid this patch series does not fix the bug.
> > 
> > The stack trace is below.
> > 
> > Rich.
> > 
> 
> I'm looking through qemu-defel, and I'm not finding a reference to the bug
> mentioned.  Maybe I'm just missing it... can you describe the bug or point
> me to the relevant email thread?

Hi Jeff, the bug is:

https://bugzilla.redhat.com/show_bug.cgi?id=1447590

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
