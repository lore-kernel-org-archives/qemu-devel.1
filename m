Received: from eggs.gnu.org ([209.51.188.92]:51643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkW4X-0002ha-53
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkW4W-0006nk-Aj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkW4W-0006XS-0Q
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:28:40 -0500
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112410.3010-42-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6cb87d1-5378-de3d-8633-0ce07c8a55e6@redhat.com>
Date: Fri, 18 Jan 2019 16:28:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190118112410.3010-42-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 41/43] i386-softmmu.mak: remove all
 CONFIG_* except boards definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com

On 18/01/19 12:24, Yang Zhong wrote:
>  config ACPI_NVDIMM
>      bool
> +    default y
> +    depends on I440FX || Q35

This is "depends on PC".

>  config ACPI_VMGENID
>      bool
> +    default y
> +    depends on I440FX || Q35
> =20
>  config IPMI
>      bool

IPMI should have a "depends on PC" too.

Paolo
