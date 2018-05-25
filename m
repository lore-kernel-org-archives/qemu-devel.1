Received: from eggs.gnu.org ([2001:4830:134:3::10]:50721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHPE-0001FN-Qq
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHPD-0005G9-Vh
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:25:36 -0400
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-2-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c4e86c6-f032-7b2f-d748-3f98adcbdd2a@redhat.com>
Date: Fri, 25 May 2018 13:25:29 -0500
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-2-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/20] block: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org

On 05/25/2018 11:47 AM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as

s/as C/as the C/

> opposed to one in include/), we should use its relative path, without a
> directory.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   block/crypto.c         | 2 +-
>   block/nbd.c            | 2 +-
>   block/qcow.c           | 2 +-
>   block/qcow2-bitmap.c   | 2 +-
>   block/qcow2-cluster.c  | 2 +-
>   block/qcow2-refcount.c | 2 +-
>   block/qcow2-snapshot.c | 2 +-
>   block/qcow2.c          | 4 ++--
>   block/vhdx-endian.c    | 2 +-
>   block/vhdx-log.c       | 2 +-
>   block/vhdx.c           | 2 +-
>   11 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
