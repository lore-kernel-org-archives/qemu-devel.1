Received: from eggs.gnu.org ([2001:4830:134:3::10]:56890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7nxt-00074T-T6
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7ns1-0000OZ-Dh
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:35:46 -0400
References: <20181003180426.602765-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a6439e4c-a5ac-ed0a-0d6f-2dac91c0f93f@redhat.com>
Date: Wed, 3 Oct 2018 16:35:35 -0400
MIME-Version: 1.0
In-Reply-To: <20181003180426.602765-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-nbd: Document --tls-creds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, berrange@redhat.com, "open list:Network Block Dev..." <qemu-block@nongnu.org>



On 10/03/2018 02:04 PM, Eric Blake wrote:
> Commit 145614a1 introduced --tls-creds, but forgot to document
> it in 'qemu-nbd --help'.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> Sadly, 'git grep -i "qemu.nbd.*tls"' has no hits, making me wonder
> if our iotests are even covering this.
> 
> Noticed while writing my other patches for defaulting to newstyle.
> ---
>  qemu-nbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 51b9d38c727..66e023f7fa4 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -94,6 +94,7 @@ static void usage(const char *name)
>  "General purpose options:\n"
>  "  --object type,id=ID,...   define an object such as 'secret' for providing\n"
>  "                            passwords and/or encryption keys\n"
> +"  --tls-creds=ID            use id of an earlier --object to provide TLS\n"
>  "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
>  "                            specify tracing options\n"
>  "  --fork                    fork off the server process and exit the parent\n"
> 

Reviewed-by: John Snow <jsnow@redhat.com>

Do we have a manpage/texi that needs to update, too?
