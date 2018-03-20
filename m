Received: from eggs.gnu.org ([2001:4830:134:3::10]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLxe-00048G-Jp
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLxd-0008NA-ON
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:26:14 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6c689e0-d5e8-a826-eda6-f4a50f4685b5@redhat.com>
Date: Tue, 20 Mar 2018 13:26:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 05/12] luks: Turn another invalid
 assertion into check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> Commit e39e959e fixed an invalid assertion in the .bdrv_length
> implementation, but left a similar assertion in place for
> .bdrv_truncate. Instead of crashing when the user requests a too large
> image size, fail gracefully.
> 
> A file size of exactly INT64_MAX caused failure before, but is actually
> legal.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/crypto.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
