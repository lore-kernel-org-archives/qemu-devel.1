Received: from eggs.gnu.org ([2001:4830:134:3::10]:49302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccOoN-0003pg-4d
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 22:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccOoK-0004Uz-21
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 22:57:23 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
	<1486744104-15590-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6cf32b36-2efd-4f06-3a81-8eb00b88878f@amsat.org>
Date: Sat, 11 Feb 2017 00:57:12 -0300
MIME-Version: 1.0
In-Reply-To: <1486744104-15590-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Avoid setting ret to unused
 value in img_convert()
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

On 02/10/2017 01:28 PM, Peter Maydell wrote:
> Coverity points out that we assign the return value from
> bdrv_snapshot_load_tmp() to 'ret' in img_convert(), but then
> never use that variable. (We check for failure by looking
> at local_err instead.) Drop the unused assignment, bringing
> the call into line with the following call to
> bdrv_snapshot_laod_tmp_by_id_or_name().
>
> (Fixes CID 1247240.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qemu-img.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index aa71588..9227d3a 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1966,10 +1966,10 @@ static int img_convert(int argc, char **argv)
>      }
>
>      if (sn_opts) {
> -        ret = bdrv_snapshot_load_tmp(bs[0],
> -                                     qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
> -                                     qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
> -                                     &local_err);
> +        bdrv_snapshot_load_tmp(bs[0],
> +                               qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
> +                               qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
> +                               &local_err);
>      } else if (snapshot_name != NULL) {
>          if (bs_n > 1) {
>              error_report("No support for concatenating multiple snapshot");
>
