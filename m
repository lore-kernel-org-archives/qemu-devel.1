Received: from eggs.gnu.org ([2001:4830:134:3::10]:35498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCrAG-000175-18
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCrAF-0005G8-FO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:07:28 -0400
References: <20181017164200.22344-1-kwolf@redhat.com>
	<20181017164200.22344-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81ffbfc4-f1f0-3d8c-350e-bb27c121bff7@redhat.com>
Date: Wed, 17 Oct 2018 14:07:04 -0500
MIME-Version: 1.0
In-Reply-To: <20181017164200.22344-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/9] file-posix: Support auto-read-only
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/17/18 11:41 AM, Kevin Wolf wrote:
> If read-only=off, but auto-read-only=on is given, open the file
> read-write if we have the permissions, but instead of erroring out for
> read-only files, just degrade to read-only.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/file-posix.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
