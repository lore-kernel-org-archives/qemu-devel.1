Received: from eggs.gnu.org ([2001:4830:134:3::10]:37618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8iwl-0005v8-U0
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8iwh-000322-Rn
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8iwh-00031N-MN
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:55:35 -0400
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
	<1494356693-13190-2-git-send-email-sstabellini@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a2b87b82-8ae2-20bf-dc08-aa32a8fda23f@redhat.com>
Date: Thu, 11 May 2017 09:55:29 +0200
MIME-Version: 1.0
In-Reply-To: <1494356693-13190-2-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] Check the return value of fcntl in
 qemu_set_cloexec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, groug@kaod.org, Eric Blake <eblake@redhat.com>



On 09/05/2017 21:04, Stefano Stabellini wrote:
> Assert that the return value is not an error. This issue was found by
> Coverity.
> 
> CID: 1374831
> 
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> CC: groug@kaod.org
> CC: pbonzini@redhat.com
> CC: Eric Blake <eblake@redhat.com>

Queued, thanks.

Paolo

> ---
>  util/oslib-posix.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4d9189e..16894ad 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -182,7 +182,9 @@ void qemu_set_cloexec(int fd)
>  {
>      int f;
>      f = fcntl(fd, F_GETFD);
> -    fcntl(fd, F_SETFD, f | FD_CLOEXEC);
> +    assert(f != -1);
> +    f = fcntl(fd, F_SETFD, f | FD_CLOEXEC);
> +    assert(f != -1);
>  }
>  
>  /*
> 
