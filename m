Received: from eggs.gnu.org ([2001:4830:134:3::10]:39209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQ2a-0000Iw-8D
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQ2Z-0006Kw-EZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:59:04 -0500
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb503893-a9e0-2772-41f2-14934b199f8d@redhat.com>
Date: Fri, 9 Mar 2018 15:58:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, qemu-devel@nongnu.org

On 03/09/2018 03:46 PM, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to qcow, which
> enables image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json |  21 +++++-
>   block/qcow.c         | 196 ++++++++++++++++++++++++++++++++++-----------------
>   2 files changed, 150 insertions(+), 67 deletions(-)

Pre-review question: do we REALLY want to support creation of new qcow 
images from QMP?  Or are we at the point where we want to declare qcow a 
read-only format where we only support it to the extent that you can 
convert an existing qcow file into a better supported format like qcow2?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
