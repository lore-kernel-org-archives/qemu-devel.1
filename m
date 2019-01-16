Received: from eggs.gnu.org ([209.51.188.92]:46954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjj1T-0004Fs-6O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjj1R-00047m-Id
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:06:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjj1Q-0003zv-UH
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:06:13 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-21-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8956c20d-173a-2c88-c7ba-a09acec7768e@redhat.com>
Date: Wed, 16 Jan 2019 12:05:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-21-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 20/37] build: switch to Kconfig
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

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> The make_device_config.sh script is replaced by minikconf, which
> is modified to support the same command line as its predecessor.
> 
> The roots of the parsing are default-configs/*.mak, Kconfig.host and
> hw/Kconfig.  One difference with make_device_config.sh is that all symbols
> have to be defined in a Kconfig file, including those coming from the
> configure script.  This is the reason for the Kconfig.host file introduced
> in the previous patch. Whenever a file in default-configs/*.mak used
> $(...) to refer to a config-host.mak symbol, this is replaced by a
> Kconfig dependency.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  Kconfig.host                     |  3 ++-
>  Makefile                         | 14 +++++++++++--
>  Makefile.target                  |  7 ++++++-
>  default-configs/i386-softmmu.mak |  3 ---
>  hw/display/Kconfig               |  2 ++
>  hw/i386/Kconfig                  |  6 ++++++
>  hw/intc/Kconfig                  |  8 ++++++++
>  hw/misc/Kconfig                  |  2 ++
>  hw/tpm/Kconfig                   |  1 +
>  rules.mak                        |  2 +-
>  scripts/make_device_config.sh    | 30 ---------------------------
>  scripts/minikconf.py             | 35 +++++++++++++++++++++++++++++---
>  12 files changed, 72 insertions(+), 41 deletions(-)
>  delete mode 100644 scripts/make_device_config.sh

Acked-by: Thomas Huth <thuth@redhat.com>
