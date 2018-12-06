Received: from eggs.gnu.org ([2001:4830:134:3::10]:54675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUme9-0001o6-3u
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUme4-0006j4-UV
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:56:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15887
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUme4-0006gY-GV
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:56:20 -0500
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-6-marcandre.lureau@redhat.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <0d8d3906-ed21-3100-f38f-6b0a077641d0@cn.fujitsu.com>
Date: Thu, 6 Dec 2018 13:56:15 +0800
MIME-Version: 1.0
In-Reply-To: <20181205203737.9011-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 5/7] colo: check chardev can
 switch context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 12/06/2018 04:37 AM, Marc-André Lureau wrote:
> COLO uses a worker context (iothread) to drive the chardev. All
> backends are not able to switch the context, let's report an error in
> this case.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Li Zhijian <lizhiian@cn.fujitsu.com>


> ---
>   net/colo-compare.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index a39191d522..9156ab3349 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -957,6 +957,12 @@ static int find_and_check_chardev(Chardev **chr,
>           return 1;
>       }
>   
> +    if (!qemu_chr_has_feature(*chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
> +        error_setg(errp, "chardev \"%s\" cannot switch context",
> +                   chr_name);
> +        return 1;
> +    }
> +
>       return 0;
>   }
>   
>
