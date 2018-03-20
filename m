Received: from eggs.gnu.org ([2001:4830:134:3::10]:35900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLqY-0000ud-R7
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLqY-0002Rh-6O
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:18:54 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2729c71-af53-e25d-f0bf-425d56b696f3@redhat.com>
Date: Tue, 20 Mar 2018 13:18:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 02/12] vdi: Fix build with
 CONFIG_VDI_DEBUG
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
> Use qemu_uuid_unparse() instead of uuid_unparse() to make vdi.c compile
> again when CONFIG_VDI_DEBUG is set. In order to prevent future bitrot,
> replace '#ifdef CONFIG_VDI_DEBUG' by 'if (VDI_DEBUG)' so that the
> compiler always sees the code.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/vdi.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
