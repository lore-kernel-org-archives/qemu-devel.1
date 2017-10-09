Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1e1Yvm-0007jQ-N4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1e1Yvj-0004Aa-E5
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:21:18 -0400
Date: Mon, 9 Oct 2017 10:21:10 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Message-ID: <20171009142109.GD8968@hedwig.ini.cmu.edu>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-50-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171006235023.11952-50-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 49/88] hw/misc: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

On Fri, Oct 06, 2017 at 08:49:44PM -0300, Philippe Mathieu-Daudé wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> [PMD: added hw/misc/pvpanic.c]
> ---
>  hw/misc/applesmc.c | 2 +-
>  hw/misc/pvpanic.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 7be8b5f13c..12e32b107e 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -252,7 +252,7 @@ static void applesmc_add_key(AppleSMCState *s, const char *key,
>  {
>      struct AppleSMCData *def;
>  
> -    def = g_malloc0(sizeof(struct AppleSMCData));
> +    def = g_new0(struct AppleSMCData, 1);
>      def->key = key;
>      def->len = len;
>      def->data = data;
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index 2b1e9a6450..dc51e4386c 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -95,7 +95,7 @@ static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    pvpanic_port = g_malloc(sizeof(*pvpanic_port));
> +    pvpanic_port = g_new(uint16_t, 1);
>      *pvpanic_port = cpu_to_le16(s->ioport);
>      fw_cfg_add_file(fw_cfg, "etc/pvpanic-port", pvpanic_port,
>                      sizeof(*pvpanic_port));
> -- 
> 2.14.2
> 
