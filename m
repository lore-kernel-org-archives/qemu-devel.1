Received: from eggs.gnu.org ([209.51.188.92]:34094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gzPTE-0000dU-KX
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gzPJJ-000407-Ak
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:17:31 -0500
Date: Thu, 28 Feb 2019 14:17:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190228171706.GC4925@habkost.net>
References: <20190228122849.4296-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228122849.4296-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qdev: Hotplug handler chaining
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Pankaj Gupta <pagupta@redhat.com>

On Thu, Feb 28, 2019 at 01:28:46PM +0100, David Hildenbrand wrote:
> Can somebody please pick this up in the near future? (@Eduardo, @MST,
> @Paolo, @David - I have no idea who the right person is :) )
> 
> The longer we wait, the more likely it is that some stuff gets upstreamed
> that conflicts with patch 1 and will break unnoticed. (e.g. spapr PHB
> hotplug was just upstreamed and required a fixup, luckily I was CC'ed on
> that one).

I'm queueing it on machine-next, thanks!

-- 
Eduardo
