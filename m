Received: from eggs.gnu.org ([209.51.188.92]:44376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h2Jgk-0000tN-Bt
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h2Jgj-0003tG-LS
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:53:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h2Jgj-0003t0-En
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:53:41 -0500
Date: Fri, 8 Mar 2019 14:53:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190308175336.GF8899@habkost.net>
References: <20190214031004.32522-1-stefanha@redhat.com>
	<20190214031004.32522-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214031004.32522-3-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hostmem-file: reject invalid pmem
 file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

On Thu, Feb 14, 2019 at 11:10:04AM +0800, Stefan Hajnoczi wrote:
> Guests started with NVDIMMs larger than the underlying host file produce
> confusing errors inside the guest.  This happens because the guest
> accesses pages beyond the end of the file.
> 
> Check the pmem file size on startup and print a clear error message if
> the size is invalid.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1669053
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Zhang Yi <yi.z.zhang@linux.intel.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

I've just noticed this wasn't picked up on my previous pull
request.  I'm queueing this on machine-next, now.

-- 
Eduardo
