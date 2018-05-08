Received: from eggs.gnu.org ([2001:4830:134:3::10]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fG1OL-0005IK-RD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fG1OH-0008S2-6T
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:06:49 -0400
Date: Tue, 8 May 2018 14:06:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180508120629.GB4065@localhost.localdomain>
References: <20180309141107.13964-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309141107.13964-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] hmp: Allow using a qdev id in
 block_set_io_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 09.03.2018 um 15:11 hat Alberto Garcia geschrieben:
> The QMP version of this command can take a qdev ID since 7a9877a02635,
> but the HMP version is still using the deprecated block device name so
> there's no way to refer to a block device added like this:
> 
>   -blockdev node-name=disk0,driver=qcow2,file.driver=file,file.filename=hd.qcow2
>   -device virtio-blk-pci,id=virtio-blk-pci0,drive=disk0
> 
> This patch works around this problem by using the specified name as a
> qdev ID if the block device name is not found.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
