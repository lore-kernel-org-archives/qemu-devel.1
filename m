Received: from eggs.gnu.org ([2001:4830:134:3::10]:39980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHsqr-0001Z1-C3
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dHsqq-0006tT-FD
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:19:25 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4365718-b8b9-4968-fa1f-c8608752dd65@amsat.org>
Date: Mon, 5 Jun 2017 11:19:14 -0300
MIME-Version: 1.0
In-Reply-To: <1496670954-664-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block/qcow.c: Fix memory leak in
 qcow_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, patches@linaro.org

On 06/05/2017 10:55 AM, Peter Maydell wrote:
> Coverity points out that the code path in qcow_create() for
> the magic "fat:" backing file name leaks the memory used to
> store the filename (CID 1307771). Free the memory before
> we overwrite the pointer.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/qcow.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/qcow.c b/block/qcow.c
> index 95ab123..7bd94dc 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -852,6 +852,7 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
>              header_size += backing_filename_len;
>          } else {
>              /* special backing file for vvfat */
> +            g_free(backing_file);
>              backing_file = NULL;
>          }
>          header.cluster_bits = 9; /* 512 byte cluster to avoid copying
>
