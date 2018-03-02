Received: from eggs.gnu.org ([2001:4830:134:3::10]:60020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZbJ-0002MG-7F
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZbI-0006Xf-BQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:35:09 -0500
References: <cover.1519921268.git.berto@igalia.com>
	<a5c2c91b884746e6222844bb1110debe665e63ff.1519921268.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c7c95d2-690e-8f00-dfcc-f2c6afce86dd@redhat.com>
Date: Thu, 1 Mar 2018 19:35:04 -0600
MIME-Version: 1.0
In-Reply-To: <a5c2c91b884746e6222844bb1110debe665e63ff.1519921268.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] qcow2: Check snapshot L1 table in
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 03/01/2018 10:27 AM, Alberto Garcia wrote:
> This function copies a snapshot's L1 table into the active one without
> validating it first.
> 
> We now have a function to take care of this, so let's use it.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-snapshot.c     | 6 ++++++
>   tests/qemu-iotests/080     | 2 ++
>   tests/qemu-iotests/080.out | 2 ++
>   3 files changed, 10 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
