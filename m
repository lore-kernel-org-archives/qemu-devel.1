Received: from eggs.gnu.org ([209.51.188.92]:45697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDQog-0003RG-Eh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDQoe-0007QN-GX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hDQoc-0007OH-Jj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id 4so13534699wmf.1
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:43:44 -0700 (PDT)
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-11-armbru@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <eebcf43e-a4d3-d8b1-1611-23b665ebbe6e@gmail.com>
Date: Mon, 8 Apr 2019 11:44:44 +0300
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 10/15] vl: Make -machine $TYPE,
 help and -accel help print to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

Hi Markus,

On 4/8/19 11:36 AM, Markus Armbruster wrote:
> Command line help help explicitly requested by the user should be
> printed to stdout, not stderr.  We do elsewhere.  Adjust -machine
> $TYPE,help and -accel help to match: use printf() instead of
> error_printf().
>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   vl.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index c696ad2a13..792ef36001 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1556,12 +1556,12 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
>               continue;
>           }
>   
> -        error_printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
> -                     prop->name, prop->type);
> +        printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
> +                    prop->name, prop->type);

Does the line above have an alignment issue?

Anyway,

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

>           if (prop->description) {
> -            error_printf(" (%s)\n", prop->description);
> +            printf(" (%s)\n", prop->description);
>           } else {
> -            error_printf("\n");
> +            printf("\n");
>           }
>       }
>   
> @@ -3643,7 +3643,7 @@ int main(int argc, char **argv, char **envp)
>                                                        optarg, true);
>                   optarg = qemu_opt_get(accel_opts, "accel");
>                   if (!optarg || is_help_option(optarg)) {
> -                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
> +                    printf("Possible accelerators: kvm, xen, hax, tcg\n");
>                       exit(0);
>                   }
>                   opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
