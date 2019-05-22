Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EFBC46470
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE5420881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE5420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTQ9-0002Mj-LD
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:44:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTM9-0007Yy-V6
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTT7o-0002qQ-CB
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:25:53 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTT7m-0001lp-3q; Wed, 22 May 2019 11:25:50 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MmU1H-1glIXQ3zBR-00iXHu; Wed, 22 May 2019 17:24:58 +0200
To: Li Qiang <liq3ea@163.com>, alex.williamson@redhat.com, lvivier@redhat.com
References: <20190521151543.92274-1-liq3ea@163.com>
	<20190521151543.92274-2-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <95569030-88c3-bc93-3ca2-0df3cacfa87c@vivier.eu>
Date: Wed, 22 May 2019 17:24:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190521151543.92274-2-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YYxbT559wrmEiZSJXIiVTlz4XEHXiwJmOK1UTWuFTaGOwN+1KFO
	wNgJvJ99l5T0GEnNhNmdJW8bEmz0/dxMjwQ/h7qeH9kZG+FZmz1K4KlFEq72bmNCQGfvkC8
	hSBxou2f6cf8w/EupdmuzMP3USpf0tH7LuVxybJGcuJQVoWSfZLQNd0dbzz0jlq96OGUXsP
	jBQ5TZj3o6J9mwRictxKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QdWpZOooA34=:lbNjkF3IW9KFWZMyR9kbre
	T9GuLeL69crLGUMqYDeGYRNNupR6jun7L4fmAohQhw4v/PhE1MudV1i17RM1k8j6LxC2VJI1A
	Zv0qaGsx/wlDx9PPfze4v1v8TFZ2Xn1Z0UXEuOP/BOxclRQVMeyeUbQIEPtsIxziHoToEoVfu
	mv8HwlO4z6+IqgAPioUxpSmPKoHmDCJdgTOOaEcvyVI7tQLDC2324QLYKOltHGqUhJM8wl6Uv
	6ntE/juQXxzhz0kjqZkL+lFZhhegEo9vS1CFtrMeLZx86PBTCE7upKV3bZyrv8uKTUbhUNh5c
	xmy1fCHEjHJ/HDM8uV+/dLTcjXcEgsJIp+Zc3S+EVouL2P5aGghea81PLTbd1sHcr/WQ61SDQ
	jX3tq9EzzmTF6HX3QO2CYvBW7VsNi7d9WOQzjeKkKMDYE7l26Uc5JvwzRAQQqln4kGbxf88FB
	2KR/ACmHS0MrYSIEF4JrUSaxkUZC3hjwAowv4Otuf1KOW60ApLkRQdP2aXJYcD93SFYyZ8RCb
	U4S6rBjPTNYojMXv6lKCSLssFoBNZhQI0s7gjYHD8YSfJjXut8fSwA/ooN0FyeQbAHhXxwizH
	bFderINdVIstOr73JHrZX/SgkVeQAgEp49PYE7EDqonKp6HBgnI8QpS1yXahilSKaI+/kd+T/
	3YXVtn/j5nsYM1qPCQVgRp+tS3zK6frZoO+BosCsUxHZPbeL/jJxNH2s8Cbao7qAY36ddP/Zj
	skQEF4cVCdBcaSpkHR84rf4agpm1X7pYzN02s2HDVSmjbxtIQNZEatEvmxc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 1/4] vfio: pci: make
 "vfio-pci-nohotplug" as MACRO
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, liq3ea@gmail.com, philmd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/2019 17:15, Li Qiang wrote:
> The QOMConventions recommends we should use TYPE_FOO
> for a TypeInfo's name. Though "vfio-pci-nohotplug" is not
> used in other parts, for consistency we should make this change.
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   hw/vfio/pci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8cecb53d5c..08729e5875 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -40,6 +40,8 @@
>   #define TYPE_VFIO_PCI "vfio-pci"
>   #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
>   
> +#define TYPE_VIFO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> +
>   static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>   
> @@ -3304,8 +3306,8 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>   }
>   
>   static const TypeInfo vfio_pci_nohotplug_dev_info = {
> -    .name = "vfio-pci-nohotplug",
> -    .parent = "vfio-pci",
> +    .name = TYPE_VIFO_PCI_NOHOTPLUG,
> +    .parent = TYPE_VFIO_PCI,
>       .instance_size = sizeof(VFIOPCIDevice),
>       .class_init = vfio_pci_nohotplug_dev_class_init,
>   };
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

