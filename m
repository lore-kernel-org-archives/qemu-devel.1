Received: from eggs.gnu.org ([2001:4830:134:3::10]:46472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gKnTA-0005wY-Qs
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gKnTA-0007JU-5s
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:47:48 -0500
Date: Thu, 8 Nov 2018 11:47:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181108114640-mutt-send-email-mst@kernel.org>
References: <20181105205641.17862-1-v.mayatskih@gmail.com>
	<20181105205641.17862-2-v.mayatskih@gmail.com>
	<d96db69e-1276-b4d5-e8a1-e9cdf8bda567@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d96db69e-1276-b4d5-e8a1-e9cdf8bda567@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 1/1 V2] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Vitaly Mayatskikh <v.mayatskih@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Nov 08, 2018 at 10:09:00PM +0800, Dongli Zhang wrote:
> It looks the kernel space vhost-blk can only process raw image.
> 
> How about to verify that only raw image is used in the drive command line when
> vhost-blk-pci is paired with it?
> 
> Otherwise, vhost-blk-pci might be working with qcow2 image without any warning
> on qemu side.
> 
> Dongli Zhang

raw being raw can you really verify that?
