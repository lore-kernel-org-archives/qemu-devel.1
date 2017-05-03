Received: from eggs.gnu.org ([2001:4830:134:3::10]:58955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5rnC-0002KY-Lr
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5rnB-00035a-To
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:45:58 -0400
References: <20170503103023.9247-1-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <07e55441-853f-f60c-c306-c61ec23a181b@redhat.com>
Date: Wed, 3 May 2017 12:45:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170503103023.9247-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] MAINTAINERS: Update paths
 for AioContext implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On 03/05/2017 12:30, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46cf4870f9..62d62a6675 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1177,8 +1177,8 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
>  M: Fam Zheng <famz@redhat.com>
>  L: qemu-block@nongnu.org
>  S: Supported
> -F: async.c
> -F: aio-*.c
> +F: util/async.c
> +F: util/aio-*.c
>  F: block/io.c
>  F: migration/block*
>  F: include/block/aio.h
> 

Moved by c2b38b2
("block: move AioContext, QEMUTimer, main-loop to libqemuutil")

main-loop.c and qemu-timer.c have been also moved by this commit,
perhaps you can update them too?

Thanks,
Laurent
