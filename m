Received: from eggs.gnu.org ([209.51.188.92]:45054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmccj-00027R-Rp
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmcch-0002jJ-S3
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:52:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gmccd-0002YI-Kc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:52:39 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-17-yang.zhong@intel.com>
	<133ee742-f121-91a3-e947-ed740f31a0b2@linaro.org>
	<0d456018-42a2-b45c-73d3-e94dbd5ad229@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df8770e7-677b-a3d2-06eb-1a1706543ce9@redhat.com>
Date: Thu, 24 Jan 2019 11:52:29 +0100
MIME-Version: 1.0
In-Reply-To: <0d456018-42a2-b45c-73d3-e94dbd5ad229@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 16/44] hw/alpha/Makefile.objs:
 Create CONFIG_* for alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com

On 24/01/19 10:09, Thomas Huth wrote:
> 2) Since this series is about adding a Kconfig-style system to QEMU,
> there might be other CONFIG switches that depend on this one later, e.g.
> for the x86 machines, a later patch adds:
> 
>  config ACPI_NVDIMM
>      bool
>      default y
>      depends on PC || Q35

Indeed, this is the main reason; it's cleaner.  For example, the
s390-specific VFIO backends depend on "LINUX && S390_VIRTIO_CCW".

Paolo

> Agreed, we do not have any "depends on DP264" in this series yet, but I
> think it's cleaner if we add a proper config switch for each machine
> right from the start.
