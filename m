Received: from eggs.gnu.org ([2001:4830:134:3::10]:41062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etewf-00061K-4Z
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etewe-0005bP-BM
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:41:49 -0500
References: <20180307185946.29366-1-kwolf@redhat.com>
	<20180307185946.29366-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <730ec8bb-07ec-0e5c-d6c5-c3a5cc6bf15d@redhat.com>
Date: Wed, 7 Mar 2018 13:41:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180307185946.29366-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/37] qcow2: Pass BlockdevCreateOptions
 to qcow2_co_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 03/07/2018 12:59 PM, Kevin Wolf wrote:
> All of the simple options are now passed to qcow2_co_create() in a
> BlockdevCreateOptions object. Still missing: node-name and the
> encryption options.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2.c | 189 ++++++++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 151 insertions(+), 38 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
