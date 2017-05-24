Received: from eggs.gnu.org ([2001:4830:134:3::10]:50251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDODu-0006j1-Si
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDODr-00053f-Qb
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:38 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:32858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDODr-00053O-LA
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:48:35 -0400
Received: by mail-oi0-x243.google.com with SMTP id h4so31003566oib.0
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 21:48:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
	<ec029a5251aeafccf051f27cdbf953b1ec563d4b.1495508197.git.maozy.fnst@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ffc75b65-932c-86e1-38ea-def2e2295697@amsat.org>
Date: Wed, 24 May 2017 01:48:32 -0300
MIME-Version: 1.0
In-Reply-To: <ec029a5251aeafccf051f27cdbf953b1ec563d4b.1495508197.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 4/4] net/rocker: Fix the unusual macro
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, jasowang@redhat.com, jiri@resnulli.us

On 05/23/2017 01:04 AM, Mao Zhongyi wrote:
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/rocker/rocker.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 2764529..f8a32f7 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -69,10 +69,10 @@ struct rocker {
>      QLIST_ENTRY(rocker) next;
>  };
>
> -#define ROCKER "rocker"
> +#define TYPE_ROCKER "rocker"
>
> -#define to_rocker(obj) \
> -    OBJECT_CHECK(Rocker, (obj), ROCKER)
> +#define ROCKER(obj) \
> +    OBJECT_CHECK(Rocker, (obj), TYPE_ROCKER)
>
>  static QLIST_HEAD(, rocker) rockers;
>
> @@ -1287,7 +1287,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
>
>  static void pci_rocker_realize(PCIDevice *dev, Error **errp)
>  {
> -    Rocker *r = to_rocker(dev);
> +    Rocker *r = ROCKER(dev);
>      const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
>      const MACAddr dflt = { .a = { 0x52, 0x54, 0x00, 0x12, 0x35, 0x01 } };
>      static int sw_index;
> @@ -1333,7 +1333,7 @@ static void pci_rocker_realize(PCIDevice *dev, Error **errp)
>      /* validate switch properties */
>
>      if (!r->name) {
> -        r->name = g_strdup(ROCKER);
> +        r->name = g_strdup(TYPE_ROCKER);
>      }
>
>      if (rocker_find(r->name)) {
> @@ -1429,7 +1429,7 @@ err_world_type_by_name:
>
>  static void pci_rocker_uninit(PCIDevice *dev)
>  {
> -    Rocker *r = to_rocker(dev);
> +    Rocker *r = ROCKER(dev);
>      int i;
>
>      QLIST_REMOVE(r, next);
> @@ -1462,7 +1462,7 @@ static void pci_rocker_uninit(PCIDevice *dev)
>
>  static void rocker_reset(DeviceState *dev)
>  {
> -    Rocker *r = to_rocker(dev);
> +    Rocker *r = ROCKER(dev);
>      int i;
>
>      for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
> @@ -1500,7 +1500,7 @@ static Property rocker_properties[] = {
>  };
>
>  static const VMStateDescription rocker_vmsd = {
> -    .name = ROCKER,
> +    .name = TYPE_ROCKER,
>      .unmigratable = 1,
>  };
>
> @@ -1523,7 +1523,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
>  }
>
>  static const TypeInfo rocker_info = {
> -    .name          = ROCKER,
> +    .name          = TYPE_ROCKER,
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(Rocker),
>      .class_init    = rocker_class_init,
>
