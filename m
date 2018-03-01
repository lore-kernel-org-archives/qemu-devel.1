Received: from eggs.gnu.org ([2001:4830:134:3::10]:53013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erXhC-0007a7-Ni
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 18:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erXhB-0006R8-Ss
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 18:33:06 -0500
References: <cover.1519921268.git.berto@igalia.com>
	<867f70a315f3b30aca22ab6ae90555bfa8e79c20.1519921268.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07b17643-e491-2215-82b9-8ccd018e7697@redhat.com>
Date: Thu, 1 Mar 2018 17:32:49 -0600
MIME-Version: 1.0
In-Reply-To: <867f70a315f3b30aca22ab6ae90555bfa8e79c20.1519921268.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] qcow2: Check L1 table offset in
 qcow2_snapshot_load_tmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 03/01/2018 10:27 AM, Alberto Garcia wrote:
> This function checks that the size of a snapshot's L1 table is not too
> large, but it doesn't validate the offset.
> 
> We now have a function to take care of this, so let's use it.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-snapshot.c     |  8 +++++---
>   tests/qemu-iotests/080     | 10 +++++++++-
>   tests/qemu-iotests/080.out |  8 +++++++-
>   3 files changed, 21 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
