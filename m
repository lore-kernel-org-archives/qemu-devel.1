Received: from eggs.gnu.org ([2001:4830:134:3::10]:52278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZNy-0005kQ-TE
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZNy-0007tX-0u
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:21:22 -0500
References: <cover.1519921268.git.berto@igalia.com>
	<39f9a5666cc50c3733d01d4d01fb514a5a5da9a5.1519921268.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61384245-cef1-c55d-58e9-19ea9eb8974d@redhat.com>
Date: Thu, 1 Mar 2018 19:20:59 -0600
MIME-Version: 1.0
In-Reply-To: <39f9a5666cc50c3733d01d4d01fb514a5a5da9a5.1519921268.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] qcow2: Check snapshot L1 tables in
 qcow2_check_metadata_overlap()
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
> The inactive-l2 overlap check iterates uses the L1 tables from all
> snapshots, but it does not validate them first.
> 
> We now have a function to take care of this, so let's use it.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-refcount.c     | 10 +++++++++-
>   tests/qemu-iotests/080     |  4 ++++
>   tests/qemu-iotests/080.out |  4 ++++
>   3 files changed, 17 insertions(+), 1 deletion(-)
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
