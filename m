Received: from eggs.gnu.org ([2001:4830:134:3::10]:43646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d41fV-00014W-Gg
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d41fR-0001gf-Jo
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:54:25 -0400
Date: Fri, 28 Apr 2017 09:54:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170428085407.GC23819@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170428022329.30726-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170428022329.30726-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Ignore another built executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, thuth@redhat.com, dgilbert@redhat.com, famz@redhat.com

On Thu, Apr 27, 2017 at 09:23:29PM -0500, Eric Blake wrote:
> Commit 78f86a2b7 added a new test, but forgot to exclude the built
> binary from version control.

CC Fam

I wonder if the patchew test system could be made to report an error
if git identifies built files that are not ignored.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
