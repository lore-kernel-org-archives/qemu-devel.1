Received: from eggs.gnu.org ([209.51.188.92]:51642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggp6e-0008My-7p
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggp6d-0006pm-Ii
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:59:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:35293)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggp6d-0006ak-A1
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:59:35 -0500
Date: Tue, 8 Jan 2019 18:55:54 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108105554.GI27840@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-24-yang.zhong@intel.com>
	<d3192ec2-bb58-0fdf-a100-7e885f8d8916@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3192ec2-bb58-0fdf-a100-7e885f8d8916@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 23/25] x86_64-softmmu.mak: remove
 i386-softmmu.mak include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, yang.zhong@intel.com

On Fri, Jan 04, 2019 at 08:58:09PM +0100, Thomas Huth wrote:
> On 2018-12-27 07:34, Yang Zhong wrote:
> > Only keep same boards definitions as i386-softmmu.mak in
> > x86_64-softmmu.mak.
> > 
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  default-configs/x86_64-softmmu.mak | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
> > index 64b2ee2960..0c69c2930c 100644
> > --- a/default-configs/x86_64-softmmu.mak
> > +++ b/default-configs/x86_64-softmmu.mak
> > @@ -1,3 +1,7 @@
> >  # Default configuration for x86_64-softmmu
> >  
> > -include i386-softmmu.mak
> > +# Boards:
> > +#
> > +CONFIG_ISAPC=y
> > +CONFIG_I440FX=y
> > +CONFIG_Q35=y
> 
> Not sure whether this patch is really necessary since the two configs
> are currently really the same. Anyway, in case you want to keep the patch:
> 
  Thanks for comments, yes, it seems this patch is not useful, i will remove
  this patch in next version.

  Regards,

  Yang 

> Reviewed-by: Thomas Huth <thuth@redhat.com>
