Received: from eggs.gnu.org ([2001:4830:134:3::10]:53429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eSSmd-0005Zz-67
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eSSmZ-0005vj-7X
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:15:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eSSmZ-0005vO-1l
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 14:14:59 -0500
Date: Fri, 22 Dec 2017 20:14:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171222201439.139e4010@igors-macbook-pro.local>
In-Reply-To: <20171218201340.27583-7-dgilbert@redhat.com>
References: <20171218201340.27583-1-dgilbert@redhat.com>
	<20171218201340.27583-7-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 6/7] vhost: Clean out old
 vhost_set_memory and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, groug@kaod.org

On Mon, 18 Dec 2017 20:13:39 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Remove the old update mechanism, vhost_set_memory, and the functions
> and flags it used.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
[...]

> -
> -static void vhost_set_memory(MemoryListener *listener,
> -                             MemoryRegionSection *section,
> -                             bool add)
> -{
[...]

> -    used_memslots = dev->mem->nregions;
lost sheep?

pls,
see "[PATCH v2 0/2] vhost: two fixes" to get vague idea how used_memslots is used
