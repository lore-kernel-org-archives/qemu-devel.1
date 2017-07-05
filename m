Received: from eggs.gnu.org ([2001:4830:134:3::10]:39569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dShzR-0002Dg-Le
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dShzM-0007EF-SB
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:57:01 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dShzM-0007Cl-M8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:56:56 -0400
Received: by mail-wr0-f182.google.com with SMTP id 77so261070407wrb.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 03:56:56 -0700 (PDT)
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-5-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f00c4251-ad8d-475b-5c3c-653835791552@redhat.com>
Date: Wed, 5 Jul 2017 12:56:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170704220346.29244-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/35] coroutine: remove coroutine_fn from
 qemu_coroutine_self()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 05/07/2017 00:03, Marc-André Lureau wrote:
> The function may be safely called from non-coroutine context.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

It can, but it shouldn't...  What are the callers?

Paolo

> ---
>  include/qemu/coroutine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 35ff394f51..ec55fe295c 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -121,7 +121,7 @@ void coroutine_fn qemu_coroutine_yield(void);
>  /**
>   * Get the currently executing coroutine
>   */
> -Coroutine *coroutine_fn qemu_coroutine_self(void);
> +Coroutine *qemu_coroutine_self(void);
>  
>  /**
>   * Return whether or not currently inside a coroutine
> 
