Received: from eggs.gnu.org ([2001:4830:134:3::10]:45877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgqyV-0007Lu-8T
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgqyU-00052b-5S
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:50:15 -0500
References: <20170223091845.18523-1-famz@redhat.com>
	<20170223104808.GB14175@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3f21946-e176-dbd2-3daf-49202e0bd85b@redhat.com>
Date: Thu, 23 Feb 2017 11:50:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170223104808.GB14175@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>



On 23/02/2017 11:48, Fam Zheng wrote:
>>
>> The first three patches add the driver, the others are to make qemu-img more
>> efficient with the new driver.
> Paolo, I wanted to also make ram_block_notifier_add notify existing ram blocks,
> so that hot plugging of nvme:// will work as expected, but I don't know how to
> write the code. Any suggestions? Or do you have a patch for that already?

I don't :) but it shouldn't be hard to do using qemu_ram_foreach_block:

typedef int (RAMBlockIterFunc)(const char *block_name, void *host_addr,
    ram_addr_t offset, ram_addr_t length, void *opaque);

int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);

Paolo
