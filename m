Received: from eggs.gnu.org ([2001:4830:134:3::10]:45469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgqwb-0006NA-73
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgqwa-0004XM-A1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:48:17 -0500
Date: Thu, 23 Feb 2017 18:48:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170223104808.GB14175@lemon.lan>
References: <20170223091845.18523-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170223091845.18523-1-famz@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

On Thu, 02/23 17:18, Fam Zheng wrote:
> This is a refresh of the NVMe VFIO driver patches.
> 
> The first three patches add the driver, the others are to make qemu-img more
> efficient with the new driver.

Paolo, I wanted to also make ram_block_notifier_add notify existing ram blocks,
so that hot plugging of nvme:// will work as expected, but I don't know how to
write the code. Any suggestions? Or do you have a patch for that already?

Fam
