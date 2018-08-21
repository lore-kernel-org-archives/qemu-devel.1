Received: from eggs.gnu.org ([2001:4830:134:3::10]:38370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsBON-0005de-EY
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsBFX-0004Fu-AH
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:19:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fsBFW-0004F2-Kg
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:19:27 -0400
References: <20180821172324.29331-1-r.bolshakov@yadro.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2d01789-8e3f-3e5b-6d46-f9dc9650bca4@redhat.com>
Date: Tue, 21 Aug 2018 13:19:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180821172324.29331-1-r.bolshakov@yadro.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char: Enable build of pty on macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 08/21/2018 12:23 PM, Roman Bolshakov wrote:
> For some reason __APPLE__ was not checked in pty code. pty chardev
> should be available on macOS, according to man page.
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>   chardev/char-pty.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 68fd4e20c3..cb00257ebe 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -33,7 +33,7 @@
>   
>   #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
>       || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
> -    || defined(__GLIBC__)
> +    || defined(__GLIBC__) || defined(__APPLE__)
> 

Rather than maintaining an ever-growing fragile list of platforms, could 
we instead replace this whole mess with a single define determined at 
configure time based on a feature test?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
