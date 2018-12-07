Received: from eggs.gnu.org ([2001:4830:134:3::10]:53232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVD9X-0002Tw-W5
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVD9U-0003QZ-Qo
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:14:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVD9U-0003QL-KZ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:14:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so3251632wrw.5
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:14:32 -0800 (PST)
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6c9f6267-fec2-d8f1-0c47-6a8dba114159@redhat.com>
Date: Fri, 7 Dec 2018 11:14:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181206232333.22408-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu/queue.h: do not access tqe_prev
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 12/7/18 12:23 AM, Paolo Bonzini wrote:
> Use the QTAILQ_IN_USE macro instead, it does the same thing but the next
> patch will change it to a different definition.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  blockdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 81f95d920b..7604b2183b 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -4259,7 +4259,7 @@ void qmp_blockdev_del(const char *node_name, Error **errp)
>          goto out;
>      }
>  
> -    if (!bs->monitor_list.tqe_prev) {
> +    if (!QTAILQ_IN_USE(bs, monitor_list)) {
>          error_setg(errp, "Node %s is not owned by the monitor",
>                     bs->node_name);
>          goto out;
> 
