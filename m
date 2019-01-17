Received: from eggs.gnu.org ([209.51.188.92]:55162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk5zQ-0001tW-3I
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk5zM-0007jh-3U
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:37:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:40248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gk5zK-0007ek-2u
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:37:36 -0500
Date: Thu, 17 Jan 2019 19:33:50 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190117113350.GE11760@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-5-yang.zhong@intel.com>
	<99cdf618-d63c-3362-9143-513cbad2febc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99cdf618-d63c-3362-9143-513cbad2febc@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/37] hw/m68k/Makefile.objs:
 Conditionally build boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, =?iso-8859-1?Q?=E1kos_Kov=E1cs?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com

On Wed, Jan 16, 2019 at 08:15:23AM +0100, Thomas Huth wrote:
> On 2019-01-15 15:10, Yang Zhong wrote:
[...] 
> The naming of the files is a little bit unfortunate, but
> there are only two Coldfire boards: an5206 and mcf5208evb.
> mcf5206.c belongs to the an5206 board.
> So may I suggest to only use two CONFIG switches like this:
> 
> obj-$(CONFIG_AN5206) += an5206.o mcf5206.o
> obj-$(CONFIG_MCF5208EVB) += mcf5208.o mcf_intc.o
> 
  Yes, thanks Thomas, i will change this.  
  
  Regards,
  Yang
> ?
> 
>  Thanks,
>   Thomas
