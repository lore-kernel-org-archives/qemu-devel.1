Received: from eggs.gnu.org ([2001:4830:134:3::10]:52999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3BLn-0007gb-3q
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3BLm-0006dh-AR
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:07:07 -0400
Date: Mon, 2 Apr 2018 23:07:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180403020702.GJ5046@localhost.localdomain>
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231462116.69730.14119625999092384450.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152231462116.69730.14119625999092384450.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/3] sev/i386: fix memory leak in
 sev_guest_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Thu, Mar 29, 2018 at 11:10:21AM +0200, Greg Kurz wrote:
> The string returned by object_property_get_str() is dynamically allocated.
> 
> Fixes: d8575c6c0242b
> Signed-off-by: Greg Kurz <groug@kaod.org>

Queued, thanks.

-- 
Eduardo
