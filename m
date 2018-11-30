Received: from eggs.gnu.org ([2001:4830:134:3::10]:52364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSnNu-0007VN-Ci
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSnNo-0007jO-9Q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:19:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gSnNo-0007i4-25
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 13:19:20 -0500
Date: Fri, 30 Nov 2018 16:19:13 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181130181913.GP18284@habkost.net>
References: <20181130122844.29103-1-ehabkost@redhat.com>
	<5c35ebae-9ddf-c544-57d8-62f2e344c800@redhat.com>
	<87ftvie9gk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftvie9gk.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1? v2] hostmem: Validate host-nodes
 before setting bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

On Fri, Nov 30, 2018 at 06:55:39PM +0100, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 11/30/18 6:28 AM, Eduardo Habkost wrote:
> >> host_memory_backend_set_host_nodes() was not validating
> >> host-nodes before writing to backend->host_nodes, making QEMU
> >> write beyond the end of the bitmap.
> >>
> >> Fix the crash and add a simple regression test for the fix.
> >>
> >> While at it, fix memory leak of the list returned by
> >> visit_type_uint16List().
> >>
> >> Reported-by: Markus Armbruster <armbru@redhat.com>
> >> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >> ---
> >
> > Looks like we may have 3.1-rc4 due to some CVE fixes; is this worth
> > including in 3.1 as well?
> 
> You could conceivably crash a running VM with object-add.  On the other
> hand, the bug has been around for a while, and was only found by code
> inspection.

I think the fix would be appropriate for -rc2 or -rc3, but I
don't think it's critical enough for -rc4.

-- 
Eduardo
