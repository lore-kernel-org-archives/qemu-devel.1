Received: from eggs.gnu.org ([2001:4830:134:3::10]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euJNk-0007tI-CC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euJNj-0000uE-Ld
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:52:28 -0500
References: <20180309141107.13964-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1369fd5-edfe-8483-ba58-eb0b0612f294@redhat.com>
Date: Fri, 9 Mar 2018 08:52:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180309141107.13964-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/09/2018 08:11 AM, Alberto Garcia wrote:
> The QMP version of this command can take a qdev ID since 7a9877a02635,
> but the HMP version is still using the deprecated block device name so
> there's no way to refer to a block device added like this:
> 
>    -blockdev node-name=disk0,driver=qcow2,file.driver=file,file.filename=hd.qcow2
>    -device virtio-blk-pci,id=virtio-blk-pci0,drive=disk0
> 
> This patch works around this problem by using the specified name as a
> qdev ID if the block device name is not found.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   hmp-commands.hx |  3 ++-
>   hmp.c           | 14 ++++++++++++--
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
