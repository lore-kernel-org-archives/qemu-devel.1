Received: from eggs.gnu.org ([2001:4830:134:3::10]:58141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eh2K2-0003Wy-Fz
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eh2Jx-0006kd-QD
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:01:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eh2Jx-0006kS-Jh
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:01:41 -0500
Date: Wed, 31 Jan 2018 17:01:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180131170137.698bdcc4@w520.home>
In-Reply-To: <237F54289DF84E4997F34151298ABEBC7C6B260A@SHSMSX101.ccr.corp.intel.com>
References: <20180131121217.13557-1-kraxel@redhat.com>
	<20180131121217.13557-5-kraxel@redhat.com>
	<237F54289DF84E4997F34151298ABEBC7C6B260A@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH v2 4/5] vfio/display: core & wireup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, Kirti Wankhede <kwankhede@nvidia.com>

On Wed, 31 Jan 2018 23:42:49 +0000
"Zhang, Tina" <tina.zhang@intel.com> wrote:
> > @@ -2977,6 +2984,8 @@ static void vfio_instance_init(Object *obj)  static
> > Property vfio_pci_dev_properties[] = {
> >      DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
> >      DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> > +    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> > +                            display, ON_OFF_AUTO_AUTO),  
> Not "x-display"?


x-display would mean that it's an unsupported, experimental option that
libvirt wouldn't enable and downstreams might consider unsupported.
Don't we want this to be a supported feature enabled through libvirt?
Thanks,

Alex
