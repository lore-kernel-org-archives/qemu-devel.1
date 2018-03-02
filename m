Received: from eggs.gnu.org ([2001:4830:134:3::10]:33028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZdP-0003zz-8h
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZdO-0008EQ-F6
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:37:19 -0500
References: <cover.1519921268.git.berto@igalia.com>
	<ab74e13d0484aad82a8d36e962835aa2f68e1172.1519921268.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a10d9926-55e4-3070-7501-1280958f1111@redhat.com>
Date: Thu, 1 Mar 2018 19:37:10 -0600
MIME-Version: 1.0
In-Reply-To: <ab74e13d0484aad82a8d36e962835aa2f68e1172.1519921268.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] qcow2: Make qemu-img check detect
 corrupted L1 tables in snapshots
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
> 'qemu-img check' cannot detect if a snapshot's L1 table is corrupted.
> This patch checks the table's offset and size and reports corruption
> if the values are not valid.
> 
> This patch doesn't add code to fix that corruption yet, only to detect
> and report it.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-refcount.c     | 14 ++++++++++++++
>   tests/qemu-iotests/080     |  2 ++
>   tests/qemu-iotests/080.out | 20 ++++++++++++++++++++
>   3 files changed, 36 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
