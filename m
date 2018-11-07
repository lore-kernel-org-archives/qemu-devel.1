Received: from eggs.gnu.org ([2001:4830:134:3::10]:36783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKKXD-00041s-Jm
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKKX5-0001ho-S7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:54:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKKX5-0001eq-Eg
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:53:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15-v6so13048926wrv.4
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 01:53:55 -0800 (PST)
References: <20181106102335.20027-1-kraxel@redhat.com>
	<20181106102335.20027-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <16d255bb-49be-551b-59b6-71d7d74472c6@redhat.com>
Date: Wed, 7 Nov 2018 10:53:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181106102335.20027-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] move ObjectClass to typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 6/11/18 11:23, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   include/qemu/typedefs.h | 1 +
>   include/qom/object.h    | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 3ec0e13a96..fed53f6de2 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -62,6 +62,7 @@ typedef struct NetClientState NetClientState;
>   typedef struct NetFilterState NetFilterState;
>   typedef struct NICInfo NICInfo;
>   typedef struct NumaNodeMem NumaNodeMem;
> +typedef struct ObjectClass ObjectClass;
>   typedef struct PCIBridge PCIBridge;
>   typedef struct PCIBus PCIBus;
>   typedef struct PCIDevice PCIDevice;
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f0b0bf39cc..499e1fd8b7 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -20,7 +20,6 @@
>   struct TypeImpl;
>   typedef struct TypeImpl *Type;
>   
> -typedef struct ObjectClass ObjectClass;
>   typedef struct Object Object;
>   
>   typedef struct TypeInfo TypeInfo;
> 
