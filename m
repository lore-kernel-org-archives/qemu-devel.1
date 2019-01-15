Received: from eggs.gnu.org ([209.51.188.92]:36172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjXrC-0002CW-6I
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjXrB-0001Su-A4
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:10:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjXrB-0001R7-0o
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:10:53 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-8-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcc7208f-d00e-bf26-33ff-d244b34a1cad@redhat.com>
Date: Wed, 16 Jan 2019 00:10:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-8-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/37] hw/ppc/Makefile.objs: Build
 all boards conditinally with CONFIG_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>

On 15/01/19 15:10, Yang Zhong wrote:
>  CONFIG_PCSPK=y
>  CONFIG_IDE_ISA=y
>  CONFIG_CS4231A=y
> +
> +CONFIG_PPC405=y
> +CONFIG_PPC440=y
> +CONFIG_MAC_OLDWORLD=y
> +CONFIG_MAC_NEWWORLD=y
> +CONFIG_VIRTEX=

CONFIG_XILINX is "y", so CONFIG_VIRTEX should too.

Paolo

> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
