Received: from eggs.gnu.org ([2001:4830:134:3::10]:49687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEL1t-0005vJ-2j
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEL1s-0003CC-9v
	for qemu-devel@nongnu.org; Fri, 26 May 2017 15:36:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170526101337.4096-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f4e0f032-0af1-0e0e-7b6a-5f5dde63babd@amsat.org>
Date: Fri, 26 May 2017 16:35:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170526101337.4096-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] qemu-ga: remove useless
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 05/26/2017 07:13 AM, Marc-André Lureau wrote:
> There is no need to duplicate a fixed string.
>
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qga/commands-posix.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 284ecc6d7e..d8e412275e 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2197,12 +2197,10 @@ static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
>          }
>      } else {
>          if (mem_blk->online != (strncmp(status, "online", 6) == 0)) {
> -            char *new_state = mem_blk->online ? g_strdup("online") :
> -                                                g_strdup("offline");
> +            const char *new_state = mem_blk->online ? "online" : "offline";
>
>              ga_write_sysfs_file(dirfd, "state", new_state, strlen(new_state),
>                                  &local_err);
> -            g_free(new_state);
>              if (local_err) {
>                  error_free(local_err);
>                  result->response =
>
