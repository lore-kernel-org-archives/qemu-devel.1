Received: from eggs.gnu.org ([2001:4830:134:3::10]:51013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHRT-0002Vn-46
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHRQ-0005qO-0e
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:27:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fMHRP-0005qE-Sa
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:27:51 -0400
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-5-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <764a90d2-e7e2-e692-30fd-912fc0f24438@redhat.com>
Date: Fri, 25 May 2018 13:27:50 -0500
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-5-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/20] migration: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 05/25/2018 11:47 AM, Michael S. Tsirkin wrote:
> we just need a struct name, let's add a forward
> declaration instead of an include.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/migration/vmstate.h | 2 +-
>   migration/savevm.c          | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)

I'm okay with the patch as-is, but the commit message could possibly be 
improved:

In the vmstate.h file, we just need a struct name. Use a forward 
declaration instead of an include, then adjust the one affected .c file 
to include the file that is no longer implicit from the header.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
