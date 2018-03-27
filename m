Received: from eggs.gnu.org ([2001:4830:134:3::10]:34258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0okr-0000hi-AF
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f0okn-0001Tq-66
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:35:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:19117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f0okm-0001TG-R0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:35:09 -0400
Date: Tue, 27 Mar 2018 21:33:30 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180327133330.lmzpdmznpm6moms3@debian>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
	<20180319071537.28649-6-tiwei.bie@intel.com>
	<20180322171450-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180322171450-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v2 5/6] vfio: remove
 DPRINTF() definition from vfio-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Mar 22, 2018 at 05:15:30PM +0200, Michael S. Tsirkin wrote:
> On Mon, Mar 19, 2018 at 03:15:36PM +0800, Tiwei Bie wrote:
> > This macro isn't used by any VFIO code. And its name is
> > too generic. The vfio-common.h (in include/hw/vfio) can
> > be included by other modules in QEMU. It can introduce
> > conflicts.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> This one can go ahead immediately.
> Try posting as a separate patch.

Got it. Thanks!

Best regards,
Tiwei Bie

> 
> > ---
> >  include/hw/vfio/vfio-common.h | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > index b820f7984c..f6aa4ae959 100644
> > --- a/include/hw/vfio/vfio-common.h
> > +++ b/include/hw/vfio/vfio-common.h
> > @@ -34,15 +34,6 @@
> >  #define ERR_PREFIX "vfio error: %s: "
> >  #define WARN_PREFIX "vfio warning: %s: "
> >  
> > -/*#define DEBUG_VFIO*/
> > -#ifdef DEBUG_VFIO
> > -#define DPRINTF(fmt, ...) \
> > -    do { fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); } while (0)
> > -#else
> > -#define DPRINTF(fmt, ...) \
> > -    do { } while (0)
> > -#endif
> > -
> >  enum {
> >      VFIO_DEVICE_TYPE_PCI = 0,
> >      VFIO_DEVICE_TYPE_PLATFORM = 1,
> > -- 
> > 2.11.0
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
