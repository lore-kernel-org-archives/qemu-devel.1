Received: from eggs.gnu.org ([209.51.188.92]:35800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gonec-0004xj-CZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1goneb-0006Cl-GB
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:03:38 -0500
Date: Wed, 30 Jan 2019 18:59:46 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190130105946.GA3384@yangzhon-Virtual>
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548841387-7670-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Kconfig dependencies for ppc
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, yang.zhong@intel.com

On Wed, Jan 30, 2019 at 10:43:02AM +0100, Thomas Huth wrote:
> Here's now my stab at expressing the ppc machine dependencies with
> Kconfig. I've carefully stepped through the dependencies and tried to
> built each machine separately (which should be possible now, apart
> from some few quirks like the RTAS dependency in qtest.c which I will
> address later).
> 
> Yang, unless there are complaints, could you please add these patches
> to your Kconfig series? Thanks!
>
  Yes, i will send Kconfig v6 after chinese new year holiday(one week + 2 days vocation). 
  before this holiday, i need send out non-RFC patch 1-27 as Paolo's mentioned in v5.

  Regards,

  Yang 
 
> Thomas Huth (5):
>   ppc64: Express dependencies of 'pseries' and 'powernv' machines with
>     kconfig
>   ppc: Express dependencies of the 'prep' and '40p' machines with
>     kconfig
>   ppc: Express dependencies of the Mac machines with kconfig
>   ppc: Express dependencies of the Sam460EX machines with kconfig
>   ppc: Express dependencies of the embedded machines with kconfig
> 
>  default-configs/ppc-softmmu.mak   | 51 +++------------------------------------
>  default-configs/ppc64-softmmu.mak |  7 ------
>  hw/display/Kconfig                |  1 +
>  hw/intc/Kconfig                   |  4 +--
>  hw/mem/Kconfig                    |  1 +
>  hw/misc/Kconfig                   |  8 ++++++
>  hw/net/Kconfig                    |  2 ++
>  hw/pci-host/Kconfig               |  4 ++-
>  hw/ppc/Kconfig                    | 48 ++++++++++++++++++++++++++++++++++++
>  hw/usb/Kconfig                    |  2 +-
>  10 files changed, 69 insertions(+), 59 deletions(-)
> 
> -- 
> 1.8.3.1
