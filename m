Received: from eggs.gnu.org ([2001:4830:134:3::10]:36128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZhc3-0003H2-Rq
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cZhc2-0002fF-PM
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:25:31 -0500
Date: Fri, 3 Feb 2017 17:25:20 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170203172520.GA13825@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org

On Thu, Feb 02, 2017 at 08:42:33PM +0100, Markus Armbruster wrote:
> There's also the -drive file=json:... syntax.  It's a bad fit for
> QemuOpts, because QemuOpts and JSON fight for the comma.  I'd show you
> if I could get it to work.

I think this refers to the json: syntax for qemu URIs?

Anyway we're using this in virt-v2v
(https://github.com/libguestfs/libguestfs/blob/master/v2v/input_libvirt_xen_ssh.ml)

It's very useful, please try not to break it!

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
