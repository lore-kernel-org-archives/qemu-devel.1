Received: from eggs.gnu.org ([209.51.188.92]:36143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkWqI-0001nH-SO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkWqI-00084j-AF
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:18:02 -0500
Date: Fri, 18 Jan 2019 17:17:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190118161746.GG4530@dhcp-200-176.str.redhat.com>
References: <20181210112649.11581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210112649.11581-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] block: fix last
 address-of-packed-member warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>

Am 10.12.2018 um 12:26 hat Peter Maydell geschrieben:
> This patchset fixes the remaining clang warnings in the block/ code
> about taking the address of a packed struct member, which are all
> in block/vpc and block/vdi code handling UUIDs. Mostly I fix
> these by copying the unaligned field to/from a local variable.
> In the case of qemu_uuid_bswap() I opted to change the API to
> take and return the QemuUUID rather than taking a pointer to it,
> which makes almost all the callsites simpler. This does mean
> a struct copy but the struct is only 16 bytes and I didn't
> judge any of the callsites performance-sensitive enough to care
> about a struct copy of that size.
> 
> As usual, tested with "make check" only.

Thanks, applied to the block branch.

Kevin
