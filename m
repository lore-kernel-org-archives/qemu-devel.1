Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTRe1-0005bm-ET
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTRdy-0003yj-Ae
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:41:57 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTRdy-0003yA-4y
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:41:54 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so3917952qkq.1
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 04:41:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<9d26b170ca9768d20b4e7b70ce5d93d8063818c3.1499381754.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9fbdbe04-075b-97f7-6bb4-36bfa5f2c500@amsat.org>
Date: Fri, 7 Jul 2017 08:41:49 -0300
MIME-Version: 1.0
In-Reply-To: <9d26b170ca9768d20b4e7b70ce5d93d8063818c3.1499381754.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 6/6] Convert error_report*_err() to
 warn_report*_err()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi Francis,

On 07/06/2017 08:49 PM, Alistair Francis wrote:
> Convert all uses of error_report*_err("[Ww]arning:"... to use

this is not the regex you used, maybe just use "Warning:"...

> warn_report*_err() instead. This helps standardise on a single

standardize? "Enforce single method ..."?

> method of printing warnings to the user.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> ---
> 
>   hw/core/qdev-properties.c | 2 +-
>   hw/i386/pc.c              | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index f5983c83da..3d0bba21a2 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1169,7 +1169,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
>                   error_propagate(prop->errp, err);
>               } else {
>                   assert(prop->user_provided);
> -                error_reportf_err(err, "Warning: ");
> +                warn_report_err(err);
>               }
>           }
>       }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 58f8a4f4a5..5c2cc3f836 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1320,8 +1320,7 @@ void pc_acpi_init(const char *default_dsdt)
>   
>           acpi_table_add_builtin(opts, &err);
>           if (err) {
> -            error_reportf_err(err, "WARNING: failed to load %s: ",
> -                              filename);
> +            warn_reportf_err(err, "failed to load %s: ", filename);
>           }
>           g_free(filename);
>       }
> 
