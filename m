Received: from eggs.gnu.org ([2001:4830:134:3::10]:35439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwARe-0003vJ-Kr
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwARZ-0001Bk-O3
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:39:38 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwARZ-0001BZ-Jv
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:39:33 -0400
Received: by mail-qk0-x244.google.com with SMTP id p68so6625034qke.1
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 09:39:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-2-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6d24f71f-24ee-045b-78ad-890a97ede1a1@amsat.org>
Date: Thu, 6 Apr 2017 13:39:29 -0300
MIME-Version: 1.0
In-Reply-To: <20170406131326.2418-2-quintela@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] qdev: qdev_hotplug is really a bool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 04/06/2017 10:13 AM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/core/qdev.c         | 4 ++--
>  include/hw/qdev-core.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 1e7fb33..6fa46b5 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -39,7 +39,7 @@
>  #include "qapi-event.h"
>  #include "migration/migration.h"
>
> -int qdev_hotplug = 0;
> +bool qdev_hotplug = false;
>  static bool qdev_hot_added = false;
>  static bool qdev_hot_removed = false;
>
> @@ -385,7 +385,7 @@ void qdev_machine_creation_done(void)
>       * ok, initial machine setup is done, starting from now we can
>       * only create hotpluggable devices
>       */
> -    qdev_hotplug = 1;
> +    qdev_hotplug = true;
>  }
>
>  bool qdev_machine_modified(void)
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index b44b476..a96a913 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -386,7 +386,7 @@ Object *qdev_get_machine(void);
>  /* FIXME: make this a link<> */
>  void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
>
> -extern int qdev_hotplug;
> +extern bool qdev_hotplug;
>
>  char *qdev_get_dev_path(DeviceState *dev);
>
>
