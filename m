Received: from eggs.gnu.org ([2001:4830:134:3::10]:42464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drMXo-0004eU-AF
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drMXk-0005ti-9u
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:06:24 -0400
Date: Mon, 11 Sep 2017 12:06:15 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170911110615.GK21444@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170911110037.6567-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170911110037.6567-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hmp: fix "dump-quest-memory" segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Mon, Sep 11, 2017 at 01:00:37PM +0200, Laurent Vivier wrote:
> Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
> fixes the problem for i386, do the same for ppc.

What about all the other targets QEMU supports ?  Have you checked if they
are similarly affected, as we don't want to wait another 6 months to get a
bug report that s390 or aarch64 crash in exactly the same way too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
