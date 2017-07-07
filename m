Received: from eggs.gnu.org ([2001:4830:134:3::10]:60774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTS2b-0000z3-SF
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTS2Y-0007no-Nq
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:07:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTS2Y-0007ne-I3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:07:18 -0400
Date: Fri, 7 Jul 2017 09:07:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170707120713.GR12152@localhost.localdomain>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<9d26b170ca9768d20b4e7b70ce5d93d8063818c3.1499381754.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d26b170ca9768d20b4e7b70ce5d93d8063818c3.1499381754.git.alistair.francis@xilinx.com>
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Jul 06, 2017 at 04:49:54PM -0700, Alistair Francis wrote:
> Convert all uses of error_report*_err("[Ww]arning:"... to use
> warn_report*_err() instead. This helps standardise on a single
> method of printing warnings to the user.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
> 
>  hw/core/qdev-properties.c | 2 +-
>  hw/i386/pc.c              | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index f5983c83da..3d0bba21a2 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1169,7 +1169,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
>                  error_propagate(prop->errp, err);
>              } else {
>                  assert(prop->user_provided);
> -                error_reportf_err(err, "Warning: ");
> +                warn_report_err(err);
>              }
>          }
>      }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 58f8a4f4a5..5c2cc3f836 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1320,8 +1320,7 @@ void pc_acpi_init(const char *default_dsdt)
>  
>          acpi_table_add_builtin(opts, &err);
>          if (err) {
> -            error_reportf_err(err, "WARNING: failed to load %s: ",
> -                              filename);
> +            warn_reportf_err(err, "failed to load %s: ", filename);
>          }
>          g_free(filename);
>      }
> -- 
> 2.11.0
> 

-- 
Eduardo
