Received: from eggs.gnu.org ([2001:4830:134:3::10]:53634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIeQO-0006mI-3M
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIeQJ-0004Xr-PX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 14:11:48 -0400
References: <20180515134950.3755-1-muriloo@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7abb9c3c-524d-16cb-4bbd-7a27c5c6e676@redhat.com>
Date: Tue, 15 May 2018 13:11:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180515134950.3755-1-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] HACKING: document preference for g_new
 instead of g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial <qemu-trivial@nongnu.org>

adding qemu-trivial as a potential tree for this to go through

On 05/15/2018 08:49 AM, Murilo Opsfelder Araujo wrote:
> This patch documents the preference for g_new instead of g_malloc. The
> reasons were adapted from commit b45c03f585ea9bb1af76c73e82195418c294919d.
> 
> Discussion in QEMU's mailing list:
>    http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg03238.html
> 
> Cc: qemu-devel@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>   HACKING | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/HACKING b/HACKING
> index 4125c97d8d..0fc3e0fc04 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -118,6 +118,15 @@ Please note that g_malloc will exit on allocation failure, so there
>   is no need to test for failure (as you would have to with malloc).
>   Calling g_malloc with a zero size is valid and will return NULL.
>   
> +Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
> +reasons:
> +
> +  a. It catches multiplication overflowing size_t;
> +  b. It returns T * instead of void *, letting compiler catch more type
> +     errors.
> +
> +Declarations like T *v = g_malloc(sizeof(*v)) are acceptable, though.
> +
>   Memory allocated by qemu_memalign or qemu_blockalign must be freed with
>   qemu_vfree, since breaking this will cause problems on Win32.
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
