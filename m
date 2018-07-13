Received: from eggs.gnu.org ([2001:4830:134:3::10]:40663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdvkQ-00014M-6e
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdvkN-0000fL-61
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:56:26 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:44190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fdvkN-0000f1-0b
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:56:23 -0400
Received: by mail-io0-x242.google.com with SMTP id q19-v6so30943145ioh.11
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 03:56:22 -0700 (PDT)
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <453b2e89-9fa5-6bbf-9fdb-32f144949dd1@linaro.org>
Date: Fri, 13 Jul 2018 05:56:16 -0500
MIME-Version: 1.0
In-Reply-To: <1531470464-21522-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Fix crashes with introspection of
 ARM devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/13/2018 03:27 AM, Thomas Huth wrote:
> v2:
>  - Updated the first patch according to the review feedback from v1
>  - Added more patches with additional fixes
> 
> Thomas Huth (16):
>   qom/object: Add a new function object_initialize_child()
>   hw/core/sysbus: Add a function for creating and attaching an object
>   hw/arm/bcm2836: Fix crash with device_add bcm2837 on unsupported
>     machines
>   hw/arm/armv7: Fix crash when introspecting the "iotkit" device
>   hw/cpu/a15mpcore: Fix introspection problem with the a15mpcore_priv
>     device
>   hw/display/xlnx_dp: Move problematic code from instance_init to
>     realize
>   hw/arm/xlnx-zynqmp: Fix crash when introspecting the "xlnx,zynqmp"
>     device
>   hw/arm/msf2-soc: Fix introspection problem with the "msf2-soc" device
>   hw/cpu/a9mpcore: Fix introspection problems with the "a9mpcore_priv"
>     device
>   hw/arm/fsl-imx6: Fix introspection problems with the "fsl,imx6" device
>   hw/arm/fsl-imx7: Fix introspection problems with the "fsl,imx7" device
>   hw/arm/fsl-imx25: Fix introspection problem with the "fsl,imx25"
>     device
>   hw/arm/fsl-imx31: Fix introspection problem with the "fsl,imx31"
>     device
>   hw/cpu/arm11mpcore: Fix introspection problem with 'arm11mpcore_priv'
>   hw/*/realview: Fix introspection problem with 'realview_mpcore' &
>     'realview_gic'
>   hw/arm/allwinner-a10: Fix introspection problem with 'allwinner-a10'

That is a great cleanup.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
