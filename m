Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlac-0002Il-H4
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlaY-0006Yl-1j
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFlaX-0006Xf-Sa
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:14:21 -0400
Date: Mon, 7 May 2018 16:14:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507191413.GC13350@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-5-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-5-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/9] i386: Add new property to control
 cache info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, Apr 26, 2018 at 11:26:44AM -0500, Babu Moger wrote:
> This will be used to control the cache information.
> By default new information will be displayed. If user
> passes "-cpu legacy-cache" then older information will
> be displayed even if the hardware supports new information.
> It will be "on" for machine type "pc-q35-2.10" for compatibility.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  include/hw/i386/pc.h | 4 ++++
>  target/i386/cpu.c    | 1 +
>  target/i386/cpu.h    | 5 +++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ffee841..d904a3c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -327,6 +327,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = "q35-pcihost",\
>          .property = "x-pci-hole64-fix",\
>          .value    = "off",\
> +    },{\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "legacy-cache",\
> +        .value    = "on",\
>      },
>  

Looks good, except that we now need pc-*-2.13 machines, and this
should be moved to PC_COMPAT_2_12.

Also, I suggest squashing this with patch 5/9, and applying it
before patch 3/9.

-- 
Eduardo
