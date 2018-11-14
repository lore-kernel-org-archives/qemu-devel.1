Received: from eggs.gnu.org ([2001:4830:134:3::10]:42022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMv0R-0005OF-4z
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMv0N-0000sG-R8
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:14:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMv0I-0000fe-18
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:14:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id b13so17215336wrx.6
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:14:37 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-26-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a68e5870-b2ff-a883-baac-05f6c92bde97@redhat.com>
Date: Wed, 14 Nov 2018 14:14:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 25/41] slirp: replace SIZEOF_CHAR_P
 with glib equivalent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On 14/11/18 13:36, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   slirp/ip.h           | 2 +-
>   slirp/slirp_config.h | 3 ---
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/slirp/ip.h b/slirp/ip.h
> index 83fc9cdfbf..243b6c8b24 100644
> --- a/slirp/ip.h
> +++ b/slirp/ip.h
> @@ -177,7 +177,7 @@ struct	ip_timestamp {
>   
>   #define	IP_MSS		576		/* default maximum segment size */
>   
> -#if SIZEOF_CHAR_P == 4
> +#if GLIB_SIZEOF_VOID_P == 4
>   struct mbuf_ptr {
>   	struct mbuf *mptr;
>   	uint32_t dummy;
> diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
> index b2def6d20c..7147e0de04 100644
> --- a/slirp/slirp_config.h
> +++ b/slirp/slirp_config.h
> @@ -10,6 +10,3 @@
>    * Autoconf defined configuration options
>    * You shouldn't need to touch any of these
>    */
> -
> -/* Define to sizeof(char *) */
> -#define SIZEOF_CHAR_P (HOST_LONG_BITS / 8)
> 
