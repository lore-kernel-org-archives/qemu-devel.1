Received: from eggs.gnu.org ([208.118.235.92]:33444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf3mq-0004Cd-LD
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf3mm-0003Kd-CW
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:15:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gf3mm-0003Jh-4E
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:15:48 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-2-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5bd93d20-08a3-e382-94a1-bf6529a5944c@redhat.com>
Date: Thu, 3 Jan 2019 15:15:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-2-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/25] build: actually use CONFIG_PAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, "Daniel P. Berrange" <berrange@redhat.com>

 Hi,

On 2018-12-27 07:33, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Do not link it unconditionally into all binaries.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/pci-host/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index 6d6597c065..9d7e7cd1b8 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-y += pam.o
> +common-obj-$(CONFIG_PAM) += pam.o

CONFIG_PAM has been removed in the default-configs with commit

  a3b6e2bb71e6495a44f24e2296ab4feb4b6d4818
   default-configs: remove CONFIG_PAM

... so if you want to use it now, you've got to revert that commit, too.

 Thomas
