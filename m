Received: from eggs.gnu.org ([2001:4830:134:3::10]:39482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOToC-0000b7-7O
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOTo9-0007Ue-3i
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:04:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOTo8-0007UE-Vl
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:04:25 -0400
References: <20180531195258.22795-1-samuel.thibault@ens-lyon.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca22fcdb-33c2-7273-fbcb-dde0bb0fcffb@redhat.com>
Date: Thu, 31 May 2018 15:04:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180531195258.22795-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] slirp: fix domainname version availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 05/31/2018 02:52 PM, Samuel Thibault wrote:
> The change missed the 2.12 deadline.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>   qapi/net.json | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/net.json b/qapi/net.json
> index 32681a1af7..6b7d93cb59 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -161,7 +161,7 @@
>   #             to the guest
>   #
>   # @domainname: guest-visible domain name of the virtual nameserver
> -#              (since 2.12)
> +#              (since 3.0)
>   #
>   # @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
>   #               2.6). The network prefix is given in the usual
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
