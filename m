Received: from eggs.gnu.org ([2001:4830:134:3::10]:52089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgrRB-0007U7-52
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgrRA-0004zb-A6
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:19:53 -0500
Date: Thu, 23 Feb 2017 19:19:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170223111942.GC14175@lemon.lan>
References: <20170223091845.18523-1-famz@redhat.com>
	<20170223104808.GB14175@lemon.lan>
	<a3f21946-e176-dbd2-3daf-49202e0bd85b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f21946-e176-dbd2-3daf-49202e0bd85b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: Add VFIO based driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

On Thu, 02/23 11:50, Paolo Bonzini wrote:
> 
> 
> On 23/02/2017 11:48, Fam Zheng wrote:
> >>
> >> The first three patches add the driver, the others are to make qemu-img more
> >> efficient with the new driver.
> > Paolo, I wanted to also make ram_block_notifier_add notify existing ram blocks,
> > so that hot plugging of nvme:// will work as expected, but I don't know how to
> > write the code. Any suggestions? Or do you have a patch for that already?
> 
> I don't :) but it shouldn't be hard to do using qemu_ram_foreach_block:
> 
> typedef int (RAMBlockIterFunc)(const char *block_name, void *host_addr,
>     ram_addr_t offset, ram_addr_t length, void *opaque);
> 
> int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
> 

Cool, I'll add that in v3.

Fam
