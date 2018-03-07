Received: from eggs.gnu.org ([2001:4830:134:3::10]:60871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eteTA-0005Jk-Ou
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eteT9-0002Dg-Pb
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:11:20 -0500
References: <cover.1520352600.git.berto@igalia.com>
	<483061de4af377793c1de733d1160dc6655496f8.1520352600.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <957f2a9a-f619-25fc-c32e-8d5ad6dd1d9a@redhat.com>
Date: Wed, 7 Mar 2018 13:10:58 -0600
MIME-Version: 1.0
In-Reply-To: <483061de4af377793c1de733d1160dc6655496f8.1520352600.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] qcow2: Check snapshot L1 table in
 qcow2_snapshot_goto()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 03/06/2018 10:14 AM, Alberto Garcia wrote:
> This function copies a snapshot's L1 table into the active one without
> validating it first.
> 
> We now have a function to take care of this, so let's use it.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Cc: Eric Blake <eblake@redhat.com>
> ---
>   block/qcow2-snapshot.c     | 9 +++++++++
>   tests/qemu-iotests/080     | 2 ++
>   tests/qemu-iotests/080.out | 4 ++++
>   3 files changed, 15 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
