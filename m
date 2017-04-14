Received: from eggs.gnu.org ([2001:4830:134:3::10]:48216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cz38S-0007yj-OF
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 11:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cz38P-0007OW-KR
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 11:27:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170413203401.3213-1-mreitz@redhat.com>
	<20170413203401.3213-2-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e8e1a96e-56f7-b154-08f5-3a184369c95c@amsat.org>
Date: Fri, 14 Apr 2017 12:27:36 -0300
MIME-Version: 1.0
In-Reply-To: <20170413203401.3213-2-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/3] qemu-img/convert: Always set
 ret < 0 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, qemu-devel@nongnu.org

On 04/13/2017 05:33 PM, Max Reitz wrote:
> Otherwise the qemu-img process will exit with EXIT_SUCCESS instead of
> EXIT_FAILURE.
>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qemu-img.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index 37c2894678..f2809e1ab4 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2069,6 +2069,7 @@ static int img_convert(int argc, char **argv)
>              opts = qemu_opts_parse_noisily(&qemu_object_opts,
>                                             optarg, true);
>              if (!opts) {
> +                ret = -1;
>                  goto fail_getopt;
>              }
>              break;
> @@ -2081,6 +2082,7 @@ static int img_convert(int argc, char **argv)
>      if (qemu_opts_foreach(&qemu_object_opts,
>                            user_creatable_add_opts_foreach,
>                            NULL, NULL)) {
> +        ret = -1;
>          goto fail_getopt;
>      }
>
>
