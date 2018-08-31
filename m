Received: from eggs.gnu.org ([2001:4830:134:3::10]:37089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fvXN7-000561-62
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fvX7p-0006zs-1j
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:17:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fvX7o-0006zL-NO
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:17:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id w11-v6so9582322wrc.5
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 17:17:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180830173657.22939-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5585867-f669-c58a-5f76-4b01ce9fb1e9@amsat.org>
Date: Thu, 30 Aug 2018 21:17:17 -0300
MIME-Version: 1.0
In-Reply-To: <20180830173657.22939-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: Fix uninitialised
 rdma_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, cohuck@redhat.com, jemmy858585@gmail.com

On 8/30/18 2:36 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Clang correctly errors out moaning that rdma_return_path
> is used uninitialised in the earlier error paths.
> Make it NULL so that the error path ignores it.
> 
> Fixes: 55cc1b5937a8e709e4c102e74b206281073aab82
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reprorted by: Cornelia Huck <cohuck@redhat.com>

"Reported-by"

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  migration/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index ae07515e83..9b2e7e10aa 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -4012,7 +4012,7 @@ static void rdma_accept_incoming_migration(void *opaque)
>  void rdma_start_incoming_migration(const char *host_port, Error **errp)
>  {
>      int ret;
> -    RDMAContext *rdma, *rdma_return_path;
> +    RDMAContext *rdma, *rdma_return_path = NULL;
>      Error *local_err = NULL;
>  
>      trace_rdma_start_incoming_migration();
> 
