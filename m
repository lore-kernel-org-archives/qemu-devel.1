Received: from eggs.gnu.org ([209.51.188.92]:40853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk59y-0007Zo-UX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk4wG-0007Vn-3S
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:30:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk4wF-0007Uh-Q3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:30:20 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-31-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5fb6a343-b97e-a510-5947-98bd1b4116f0@redhat.com>
Date: Thu, 17 Jan 2019 11:30:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-31-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 30/37] i2c: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:11, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak | 1 -
>  hw/Makefile.objs                 | 2 +-
>  hw/audio/Kconfig                 | 1 +
>  hw/display/Kconfig               | 3 +++
>  hw/gpio/Kconfig                  | 1 +
>  hw/i2c/Kconfig                   | 6 ++++++
>  hw/i2c/Makefile.objs             | 3 ++-
>  hw/i386/Kconfig                  | 1 +
>  hw/input/Kconfig                 | 1 +
>  hw/isa/Kconfig                   | 1 +
>  hw/misc/Kconfig                  | 4 ++++
>  hw/timer/Kconfig                 | 3 +++
>  12 files changed, 24 insertions(+), 3 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>
