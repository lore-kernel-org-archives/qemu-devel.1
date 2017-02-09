Received: from eggs.gnu.org ([2001:4830:134:3::10]:52372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxeG-0002xr-52
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxeC-0005y0-8m
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:57:08 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxeC-0005xt-58
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:57:04 -0500
Received: by mail-qt0-x242.google.com with SMTP id n13so2524387qtc.0
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 14:57:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
	<1485531620-121182-5-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <917c2656-d8ba-ab57-3462-14c0171ea4b9@amsat.org>
Date: Thu, 9 Feb 2017 19:57:01 -0300
MIME-Version: 1.0
In-Reply-To: <1485531620-121182-5-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/9] exec: make address_space_cache_destroy
 idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 01/27/2017 12:40 PM, Paolo Bonzini wrote:
> Clear cache->mr so that address_space_cache_destroy does nothing
> the second time it is called.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/exec.c b/exec.c
> index f2bed92..5de15cf 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3165,6 +3165,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
>          xen_invalidate_map_cache_entry(cache->ptr);
>      }
>      memory_region_unref(cache->mr);
> +    cache->mr = NULL;
>  }
>
>  /* Called from RCU critical section.  This function has the same
>
