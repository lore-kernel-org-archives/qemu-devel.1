Received: from eggs.gnu.org ([2001:4830:134:3::10]:58810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZZM-0000wZ-7t
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erZZL-00053W-Gb
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:33:08 -0500
References: <20180301163619.21072-1-pbonzini@redhat.com>
	<20180301163619.21072-4-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4bef681d-47fa-dbab-9db1-e67d89ec1ad2@redhat.com>
Date: Thu, 1 Mar 2018 19:33:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180301163619.21072-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] qcow2: introduce qcow2_write_caches
 and qcow2_flush_caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 03/01/2018 10:36 AM, Paolo Bonzini wrote:
> They will be used to avoid recursively taking s->lock during
> bdrv_open or bdrv_check.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1516279431-30424-7-git-send-email-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   block/qcow2-refcount.c | 28 ++++++++++++++++++++++++++++
>   block/qcow2.c          | 20 ++++----------------
>   block/qcow2.h          |  2 ++
>   3 files changed, 34 insertions(+), 16 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
