Received: from eggs.gnu.org ([208.118.235.92]:54607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPZU-00075q-5h
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gfPZR-000265-0P
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:31:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gfPZP-00022U-D7
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:31:27 -0500
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-13-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <af35eca8-9c8e-1dc8-2de7-fa654da85089@redhat.com>
Date: Fri, 4 Jan 2019 14:31:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-13-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 12/25] build: convert usb.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org

On 2018-12-27 07:34, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Instead of including the same list of devices for each target,
> let the host controllers select CONFIG_USB and make the devices
> default to present whenever USB is available.
> 
> Done with the following script:
>   while read i; do
>      i=${i%=y}; i=${i#CONFIG_}
>      sed -i -e'/^config '$i'$/!b' -en \
>             -e'a\' -e'    default y\' -e'    depends on USB' \
>           `grep -lw $i hw/*/Kconfig`
>   done < default-configs/usb.mak
> 
> followed by adding "select USB" on the host controllers.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak |  1 -
>  default-configs/usb.mak          | 11 -----------
>  hw/usb/Kconfig                   | 26 ++++++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 12 deletions(-)
>  delete mode 100644 default-configs/usb.mak

Reviewed-by: Thomas Huth <thuth@redhat.com>
