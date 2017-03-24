Received: from eggs.gnu.org ([2001:4830:134:3::10]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1crRQs-0000aJ-Ce
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1crRQr-0001PZ-Je
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:47:18 -0400
MIME-Version: 1.0
References: <1490365705-2912-1-git-send-email-sochin@aliyun.com>
In-Reply-To: <1490365705-2912-1-git-send-email-sochin@aliyun.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Mar 2017 15:47:04 +0000
Message-ID: <CAJ+F1CJPqHqGZ7r-hQ2E2P7-S8KqGyRbzOhijtet-cCHy4BXtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] channel-file: fix wrong parameter comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin@aliyun.com>, berrange@redhat.com
Cc: QEMU <qemu-devel@nongnu.org>, sochin.jiang@huawei.com, qemu trival <qemu-trivial@nongnu.org>

On Fri, Mar 24, 2017 at 7:32 PM sochin.jiang <sochin@aliyun.com> wrote:

> From: "sochin.jiang" <sochin@aliyun.com>
>
>     fix wrong parameter comments in channel-file.h.
>
> Signed-off-by: sochin.jiang <sochin@aliyun.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  include/io/channel-file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/io/channel-file.h b/include/io/channel-file.h
> index d2462c2..79245f1 100644
> --- a/include/io/channel-file.h
> +++ b/include/io/channel-file.h
> @@ -71,7 +71,7 @@ qio_channel_file_new_fd(int fd);
>
>  /**
>   * qio_channel_file_new_path:
> - * @fd: the file descriptor
> + * @path: the file path
>   * @flags: the open flags (O_RDONLY|O_WRONLY|O_RDWR, etc)
>   * @mode: the file creation mode if O_WRONLY is set in @flags
>   * @errp: pointer to initialized error object
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
