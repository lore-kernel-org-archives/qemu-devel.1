Received: from eggs.gnu.org ([2001:4830:134:3::10]:60641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1chGA0-00055P-M6
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1chG9z-0001Pu-N7
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:43:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1chG9z-0001Pk-Gg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:43:47 -0500
Date: Fri, 24 Feb 2017 13:43:45 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170224134345.GE13825@redhat.com>
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<20170223200747.GO2778@thinpad.lan.raisama.net>
	<20170223215740.GD13825@redhat.com>
	<20170224122630.GQ2778@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170224122630.GQ2778@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] i386: Add "max" CPU model to TCG
 and KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Feb 24, 2017 at 09:26:30AM -0300, Eduardo Habkost wrote:
> On Thu, Feb 23, 2017 at 09:57:41PM +0000, Richard W.M. Jones wrote:
> > On Thu, Feb 23, 2017 at 05:07:47PM -0300, Eduardo Habkost wrote:
> > > Ping?
> > > 
> > > As v1 was sitting on the list since Jan 19, if there are no
> > > objections I will merge this and include in my next pull request
> > > before soft freeze.
> > 
> > Do you have a copy which applies on top of current HEAD?  I get
> > loads of conflicts.
> 
> It is based on my x86-next branch. See cover letter for git URLs:
> 
> ] * Rebased on top of my x86-next branch:
> ]   https://github.com/ehabkost/qemu x86-next
> ]
> ] Git branch for testing:
> ]   https://github.com/ehabkost/qemu-hacks work/x86-cpu-max-tcg

OK I've tried it now, and it works in both TCG and KVM cases.
If you want you can add:

 Tested-by: Richard W.M. Jones <rjones@redhat.com>

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
