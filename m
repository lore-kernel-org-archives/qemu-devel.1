Received: from eggs.gnu.org ([2001:4830:134:3::10]:40939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eb1Ke-0001Rd-Bj
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eb1Kb-0004ZH-AK
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:45:32 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eb1Ka-0004Yq-W5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:45:29 -0500
References: <20180114020412.26160-1-f4bug@amsat.org>
	<20180114020412.26160-2-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1f39fe23-a693-c164-3417-061648e2b2b4@vivier.eu>
Date: Mon, 15 Jan 2018 10:45:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180114020412.26160-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] qdev: rename typedef
 qdev_resetfn() -> DeviceReset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Le 14/01/2018 à 03:04, Philippe Mathieu-Daudé a écrit :
> following the DeviceRealize and DeviceUnrealize typedefs,
> this unify a bit the new QOM API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/qdev-core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 0a71bf83f0..83db53b3f5 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -32,9 +32,9 @@ typedef enum DeviceCategory {
>  
>  typedef int (*qdev_initfn)(DeviceState *dev);
>  typedef int (*qdev_event)(DeviceState *dev);
> -typedef void (*qdev_resetfn)(DeviceState *dev);
>  typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
>  typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
> +typedef void (*DeviceReset)(DeviceState *dev);
>  typedef void (*BusRealize)(BusState *bus, Error **errp);
>  typedef void (*BusUnrealize)(BusState *bus, Error **errp);
>  
> @@ -117,7 +117,7 @@ typedef struct DeviceClass {
>      bool hotpluggable;
>  
>      /* callbacks */
> -    void (*reset)(DeviceState *dev);
> +    DeviceReset reset;
>      DeviceRealize realize;
>      DeviceUnrealize unrealize;
>  
> 
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
