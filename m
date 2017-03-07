Received: from eggs.gnu.org ([2001:4830:134:3::10]:33043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clHy1-0003tw-D5
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clHxx-0004Xr-CL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:28:05 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clHxx-0004XD-72
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:28:01 -0500
Received: by mail-qk0-x244.google.com with SMTP id o135so2221714qke.2
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 08:28:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170307151627.27212-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6913fffa-cb23-2792-fbc7-5950c8e73993@amsat.org>
Date: Tue, 7 Mar 2017 13:27:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170307151627.27212-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] nbd/client: fix drop_sync
 [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com

On 03/07/2017 12:16 PM, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Comparison symbol is misused. It may lead to memory corruption.
> Introduced in commit 7d3123e.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
> [eblake: add CVE details, update conditional]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v2: use >= instead of >, fix R-b
> ---
>  nbd/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 5c9dee3..3dc2564 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t size)
>      char small[1024];
>      char *buffer;
>
> -    buffer = sizeof(small) < size ? small : g_malloc(MIN(65536, size));
> +    buffer = sizeof(small) >= size ? small : g_malloc(MIN(65536, size));
>      while (size > 0) {
>          ssize_t count = read_sync(ioc, buffer, MIN(65536, size));
>
