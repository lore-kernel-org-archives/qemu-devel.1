Received: from eggs.gnu.org ([209.51.188.92]:42549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gglvP-0005yx-HK
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 02:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gglvO-00028l-VT
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 02:35:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:26048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gglvO-0001vt-Ms
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 02:35:46 -0500
Date: Tue, 8 Jan 2019 15:32:08 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108073208.GA27840@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-14-yang.zhong@intel.com>
	<441bd501-6d1e-8b97-f275-75ad0ca66f25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441bd501-6d1e-8b97-f275-75ad0ca66f25@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 13/25] scsi: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com

On Fri, Jan 04, 2019 at 02:38:23PM +0100, Paolo Bonzini wrote:
> On 27/12/18 07:34, Yang Zhong wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > This lets you disable SCSI altogether with "CONFIG_SCSI=n".
> 
> USB_STORAGE_BOT and USB_STORAGE_UAS must also select SCSI.
> 
> Paolo

  Thanks for Paolo's reminder, i will add this.

  Regards,

  Yang 
