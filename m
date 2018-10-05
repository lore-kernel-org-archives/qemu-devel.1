Received: from eggs.gnu.org ([2001:4830:134:3::10]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Q3w-0007RI-SC
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Q3t-0006Xy-I3
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:22:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8Q3t-0006Tm-Ao
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:22:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id z4-v6so13552591wrb.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:22:33 -0700 (PDT)
References: <20181005091934.12143-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37422acb-9fb7-5794-c9d7-183dc8de5ca3@redhat.com>
Date: Fri, 5 Oct 2018 15:22:30 +0200
MIME-Version: 1.0
In-Reply-To: <20181005091934.12143-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] edid: fix vendor default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 05/10/2018 11:19, Gerd Hoffmann wrote:
> "EMU" actually is "Emulex Corporation", so not a good idea to use that
> by default.  Lets use the Red Hat vendor id instead, which is in line
> with the pci ids which are allocated from Red Hat vendor ids too.
> 
> Vendor list is available from http://www.uefi.org/pnp_id_list
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/display/edid.h  | 2 +-
>  hw/display/edid-generate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
> index bd51d26916..bacf170889 100644
> --- a/include/hw/display/edid.h
> +++ b/include/hw/display/edid.h
> @@ -4,7 +4,7 @@
>  #include "hw/hw.h"
>  
>  typedef struct qemu_edid_info {
> -    const char *vendor;
> +    const char *vendor; /* http://www.uefi.org/pnp_id_list */
>      const char *name;
>      const char *serial;
>      uint32_t    dpi;
> diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
> index c80397ea96..37e60fe42a 100644
> --- a/hw/display/edid-generate.c
> +++ b/hw/display/edid-generate.c
> @@ -301,7 +301,7 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
>      /* =============== set defaults  =============== */
>  
>      if (!info->vendor || strlen(info->vendor) != 3) {
> -        info->vendor = "EMU";
> +        info->vendor = "RHT";
>      }
>      if (!info->name) {
>          info->name = "QEMU Monitor";
> 
