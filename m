Received: from eggs.gnu.org ([209.51.188.92]:52334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggp99-00011G-4T
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggp93-0003fy-D8
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:02:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:28119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggp93-0003YZ-4y
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:02:05 -0500
Date: Tue, 8 Jan 2019 18:58:27 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108105827.GJ27840@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-24-yang.zhong@intel.com>
	<CAFEAcA9c3VRmcUiiHFZ-5BW6kQ3ACGkVE6ZLTyJ=KgA=YGws=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9c3VRmcUiiHFZ-5BW6kQ3ACGkVE6ZLTyJ=KgA=YGws=w@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com

On Sat, Jan 05, 2019 at 03:32:13PM +0000, Peter Maydell wrote:
> On Thu, 27 Dec 2018 at 06:35, Yang Zhong <yang.zhong@intel.com> wrote:
> >
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
> Could you explain the rationale for doing this? Now
> any new i386 board has to be added in two places,
> doesn't it?
> 
> thanks
> -- PMM

  Thanks Peter, you are right, i will remove this patch
  in next version, thanks!

  Regards,

  Yang
