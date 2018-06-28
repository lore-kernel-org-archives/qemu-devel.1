Received: from eggs.gnu.org ([2001:4830:134:3::10]:39652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYZFN-0005jN-5H
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYZFM-0006uy-32
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:54:13 -0400
Date: Thu, 28 Jun 2018 16:54:04 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180628155404.GF1455@redhat.com>
References: <20180628132211.8795-1-rjones@redhat.com>
	<20180628132211.8795-2-rjones@redhat.com>
	<cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, qemu-block@nongnu.org

On Thu, Jun 28, 2018 at 09:42:18AM -0500, Eric Blake wrote:
> On 06/28/2018 08:22 AM, Richard W.M. Jones wrote:
> >+    while (fgets(line, sizeof line, fp) != NULL) {
> >+        if (strncmp(line, username, ulen) == 0 && line[ulen] == ':') {
> 
> ...can't this misbehave if the user accidentally points to some
> other file (rather than one produced by psktool)?  I'm wondering if
> a getline() loop would be smarter than trying to use a fixed-length
> buffer.

I would definitely have used getline, but after examining the qemu
source I wasn't sure if it was permitted.  It's only used in qga now.
Is it available on Win32 for example?

Thanks for the rest of the comments.  I'll modify those where required
in the next version.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
