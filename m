Received: from eggs.gnu.org ([2001:4830:134:3::10]:49473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exw4V-0004vr-Ch
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exw4Q-0004Xv-Qp
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:47:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58192 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exw4Q-0004XO-Lp
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:47:30 -0400
References: <20180316144047.30904-1-nia.alarie@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a89c0265-53a0-a708-11fd-1096b565776b@redhat.com>
Date: Mon, 19 Mar 2018 09:47:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180316144047.30904-1-nia.alarie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] audio: Convert use of atoi to qemu_strtoi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, kraxel@redhat.com

On 03/16/2018 09:40 AM, Nia Alarie wrote:
> If qemu_strtoi indicates an error, return the default value.

Would it be better to diagnose the error instead of silently returning a 
default value?

> 
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> ---
>   audio/audio.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 6eccdb17ee..d6e91901aa 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -335,9 +335,8 @@ static int audio_get_conf_int (const char *key, int defval, int *defaultp)
>       char *strval;
>   
>       strval = getenv (key);
> -    if (strval) {
> +    if (strval && !qemu_strtoi(strval, NULL, 10, &val)) {
>           *defaultp = 0;
> -        val = atoi (strval);
>           return val;
>       }
>       else {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
