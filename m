Received: from eggs.gnu.org ([2001:4830:134:3::10]:55070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1corrD-0002Iz-Uk
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1corrC-0003eb-TM
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:23:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170317104541.28979-1-stefanha@redhat.com>
	<20170317104541.28979-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5bb5dee0-a9e8-e31b-3abd-b310ac946a66@amsat.org>
Date: Fri, 17 Mar 2017 10:23:41 -0300
MIME-Version: 1.0
In-Reply-To: <20170317104541.28979-3-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qemu-img: fix switch indentation in
 img_amend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com

On 03/17/2017 07:45 AM, Stefan Hajnoczi wrote:
> QEMU coding style indents 'case' to the same level as the 'switch'
> statement:
>
>   switch (foo) {
>   case 1:
>
> Fix this coding style violation so checkpatch.pl doesn't complain about
> the next patch.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qemu-img.c | 82 +++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index ce293a4..c7ffabb 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3500,47 +3500,47 @@ static int img_amend(int argc, char **argv)
>          }
>
>          switch (c) {
> -            case 'h':
> -            case '?':
> -                help();
> -                break;
> -            case 'o':
> -                if (!is_valid_option_list(optarg)) {
> -                    error_report("Invalid option list: %s", optarg);
> -                    ret = -1;
> -                    goto out_no_progress;
> -                }
> -                if (!options) {
> -                    options = g_strdup(optarg);
> -                } else {
> -                    char *old_options = options;
> -                    options = g_strdup_printf("%s,%s", options, optarg);
> -                    g_free(old_options);
> -                }
> -                break;
> -            case 'f':
> -                fmt = optarg;
> -                break;
> -            case 't':
> -                cache = optarg;
> -                break;
> -            case 'p':
> -                progress = true;
> -                break;
> -            case 'q':
> -                quiet = true;
> -                break;
> -            case OPTION_OBJECT:
> -                opts = qemu_opts_parse_noisily(&qemu_object_opts,
> -                                               optarg, true);
> -                if (!opts) {
> -                    ret = -1;
> -                    goto out_no_progress;
> -                }
> -                break;
> -            case OPTION_IMAGE_OPTS:
> -                image_opts = true;
> -                break;
> +        case 'h':
> +        case '?':
> +            help();
> +            break;
> +        case 'o':
> +            if (!is_valid_option_list(optarg)) {
> +                error_report("Invalid option list: %s", optarg);
> +                ret = -1;
> +                goto out_no_progress;
> +            }
> +            if (!options) {
> +                options = g_strdup(optarg);
> +            } else {
> +                char *old_options = options;
> +                options = g_strdup_printf("%s,%s", options, optarg);
> +                g_free(old_options);
> +            }
> +            break;
> +        case 'f':
> +            fmt = optarg;
> +            break;
> +        case 't':
> +            cache = optarg;
> +            break;
> +        case 'p':
> +            progress = true;
> +            break;
> +        case 'q':
> +            quiet = true;
> +            break;
> +        case OPTION_OBJECT:
> +            opts = qemu_opts_parse_noisily(&qemu_object_opts,
> +                                           optarg, true);
> +            if (!opts) {
> +                ret = -1;
> +                goto out_no_progress;
> +            }
> +            break;
> +        case OPTION_IMAGE_OPTS:
> +            image_opts = true;
> +            break;
>          }
>      }
>
>
