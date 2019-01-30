Received: from eggs.gnu.org ([209.51.188.92]:48996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1goobC-0007YL-Dw
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1goobB-0001rq-Bg
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:04:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:60545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1goobB-0001pc-2q
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:04:09 -0500
Date: Wed, 30 Jan 2019 20:00:16 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190130120016.GB3384@yangzhon-Virtual>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
	<b6ac9950-4640-0eac-2bbe-0283b8b051f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ac9950-4640-0eac-2bbe-0283b8b051f6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 41/52] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, yang.zhong@intel.com

On Wed, Jan 30, 2019 at 12:58:23PM +0100, Thomas Huth wrote:
> On 2019-01-25 11:07, Paolo Bonzini wrote:
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > Message-Id: <20190123065618.3520-36-yang.zhong@intel.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> [...]
> > diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> > index d50e301..6d15720 100644
> > --- a/hw/net/Kconfig
> > +++ b/hw/net/Kconfig
> > @@ -48,6 +48,9 @@ config LAN9118
> >  
> >  config NE2000_ISA
> >      bool
> > +    default y
> > +    depends on ISA_BUS
> > +    depends on PCI # for NE2000State
> 
>  Yang,
> 
> for the time being, could you please change the last line into
> 
>  depends on NE2000_PCI
> 
> instead? Otherwise, it's still possible to enable NE2000_ISA while
> NE2000_PCI is disabled, and this will currently result in linking errors.
>
  Yes, i will use "depends on NE2000_PCI" to replace "depends on PCI # for NE2000State". thanks!

  Yang
 
> In the long run, we should likely put the common functions into a
> separate file, but that's future work, after your series has been
> merged, I think.
> 
>  Thanks,
>   Thomas
