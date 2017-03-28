Received: from eggs.gnu.org ([2001:4830:134:3::10]:50485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ct0wJ-0008Sb-6q
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ct0wG-0006SS-3a
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:54:15 -0400
Received: from mail.kernel.org ([198.145.29.136]:47858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ct0wF-0006Qn-PZ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:54:12 -0400
Date: Tue, 28 Mar 2017 16:54:05 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <b0ef8967-302f-e308-4d2c-207299c250ef@suse.com>
Message-ID: <alpine.DEB.2.10.1703281653340.27589@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
	<1490033952-26735-1-git-send-email-sstabellini@kernel.org>
	<20170323140005.6b0853b3@bahia.lan>
	<15207674-c5cd-3874-7ac9-5b23cdac8888@suse.com>
	<28db5816-2ed9-0d92-a15d-af47b58a9da1@redhat.com>
	<alpine.DEB.2.10.1703230953120.8001@sstabellini-ThinkPad-X260>
	<3d94c0aa-6b18-5574-4034-110cc2cf4b90@suse.com>
	<alpine.DEB.2.10.1703241030391.8001@sstabellini-ThinkPad-X260>
	<d02897ba-88c6-f92e-ccf5-afab3c584f75@suse.com>
	<alpine.DEB.2.10.1703271537330.8001@sstabellini-ThinkPad-X260>
	<b0ef8967-302f-e308-4d2c-207299c250ef@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v4 1/8] xen: import ring.h from xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, xen-devel <xen-devel@lists.xenproject.org>

On Tue, 28 Mar 2017, Juergen Gross wrote:
> On 28/03/17 00:48, Stefano Stabellini wrote:
> > On Mon, 27 Mar 2017, Juergen Gross wrote:
> >> On 24/03/17 18:37, Stefano Stabellini wrote:
> >>> On Fri, 24 Mar 2017, Juergen Gross wrote:
> >>>> On 23/03/17 19:22, Stefano Stabellini wrote:
> >>>>> On Thu, 23 Mar 2017, Paolo Bonzini wrote:
> >>>>>> On 23/03/2017 14:55, Juergen Gross wrote:
> >>>>>>> On 23/03/17 14:00, Greg Kurz wrote:
> >>>>>>>> On Mon, 20 Mar 2017 11:19:05 -0700
> >>>>>>>> Stefano Stabellini <sstabellini@kernel.org> wrote:
> >>>>>>>>
> >>>>>>>>> Do not use the ring.h header installed on the system. Instead, import
> >>>>>>>>> the header into the QEMU codebase. This avoids problems when QEMU is
> >>>>>>>>> built against a Xen version too old to provide all the ring macros.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> >>>>>>>>> Reviewed-by: Greg Kurz <groug@kaod.org>
> >>>>>>>>> CC: anthony.perard@citrix.com
> >>>>>>>>> CC: jgross@suse.com
> >>>>>>>>> ---
> >>>>>>>>> NB: The new macros have not been committed to Xen yet. Do not apply this
> >>>>>>>>> patch until they do.
> >>>>>>>>> ---
> >>>>>>>>
> >>>>>>>> Looking at your other series for the kernel part of this feature:
> >>>>>>>>
> >>>>>>>> https://lkml.org/lkml/2017/3/22/761
> >>>>>>>>
> >>>>>>>> I realize that the ring.h header from Xen also exists in the kernel tree... 
> >>>>>>>>
> >>>>>>>> Shouldn't all the code that can be used in both kernel and userspace go to a
> >>>>>>>> header file under include/uapi in the kernel tree ? And then we would import
> >>>>>>>> it under include/standard-headers/linux in the QEMU tree and we could keep it
> >>>>>>>> in sync using scripts/update-linux-headers.sh.
> >>>>>>>>
> >>>>>>>> Cc'ing Paolo for insights.
> >>>>>>>
> >>>>>>> As Xen isn't part of the kernel we don't want that. You can use and/or
> >>>>>>> build qemu with xen-9pfs backend support on an old Linux kernel without
> >>>>>>> the related frontend.
> >>>>>>
> >>>>>> As long as the header changes rarely, I guess it's fine not to go
> >>>>>> through update-linux-headers.sh.
> >>>>>
> >>>>> Very rarely, last time ring.h was changed was 2015, and to introduce a
> >>>>> new macro (which we don't necessarily need in QEMU).
> >>>>>
> >>>>>
> >>>>>>> OTOH I don't see the advantage of not using the headers from Xen. This
> >>>>>>> is working for qdisk and pvusb backends and for all the Xen libraries.
> >>>>>>> Do you expect the 9pfs backend to be used for a qemu version built
> >>>>>>> against a Xen version not supporting that backend?
> >>>>>
> >>>>> Yes, I think that is entirely possible: Xen and QEMU versions can mix
> >>>>> and match.
> >>>>>
> >>>>> Keeping in mind that the 9pfs backend has actually no build dependencies
> >>>>> on Xen, except for these new ring.h macros, we have the following
> >>>>> options:
> >>>>>
> >>>>> 1) we build the 9pfs backend only for Xen >= 4.9, because of the new
> >>>>>    macros in ring.h that we need
> >>>>
> >>>> Right. You have sent 9pfs support patches for Xen tools. So obviously
> >>>> you need a proper Xen version to use 9pfs. Why not build qemu against
> >>>> it? Do you really expect a new Xen being used with an old qemu while
> >>>> wanting to use new features? That makes no sense for me.
> >>>  
> >>> Tools support is needed to setup the frontend/backend connection as
> >>> usual, but that's not a requirement for building the 9pfs backend. In
> >>> fact, the backend doesn't need any tools support for it to work. The
> >>> macro themselves are just a convenience - the backend would work just
> >>> fine without them. Why restrict the QEMU build gratuitously?
> >>
> >> You are duplicating a header without any real benefit I can see. This
> >> is adding future work for keeping both versions of the header in sync.
> >>
> >> In which scenario would you want qemu to support xen-9pfs without being
> >> built against a Xen version supporting xen-9pfs?
> >>
> >> I am not completely against copying the header, I just don't see an
> >> advantage for any distro or user in doing it.
> > 
> > I understand your point of view, and honestly it wouldn't be a problem
> > doing it the way you suggested either. However, I think that going
> > forward it will be less of a maintenance pain to keep ring.h in sync,
> > compared to maintaining a versioned build dependency between Xen and
> > QEMU for the compilation of one PV backend. We do have version checks
> > in QEMU for Xen compatibility, but not for PV backends or the xenpv
> > machine yet.
> 
> For the pvUSB backend I just used a mandatory macro from the header for
> the #ifdef. The backend will signal support when it was defined during
> build and will refuse initialization otherwise. Xen tools are able to
> recoginze qemu support of the backend by looking into Xenstore.


What do you think of the following:

diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
index cab5e94..42530b8 100644
--- a/hw/9pfs/Makefile.objs
+++ b/hw/9pfs/Makefile.objs
@@ -5,6 +5,8 @@ common-obj-y += coth.o cofs.o codir.o cofile.o
 common-obj-y += coxattr.o 9p-synth.o
 common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
 common-obj-y += 9p-proxy.o
-common-obj-$(CONFIG_XEN) += xen-9p-backend.o
+ifeq ($(shell test $(CONFIG_XEN_CTRL_INTERFACE_VERSION) -ge 40900; echo $$?),0)
+common-obj-y += xen-9p-backend.o
+endif
 
 obj-y += virtio-9p-device.o
diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index c85f163..defcbff 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -583,7 +583,7 @@ void xen_be_register_common(void)
     xen_be_register("console", &xen_console_ops);
     xen_be_register("vkbd", &xen_kbdmouse_ops);
     xen_be_register("qdisk", &xen_blkdev_ops);
-#ifdef CONFIG_VIRTFS
+#if defined(CONFIG_VIRTFS) && CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900
     xen_be_register("9pfs", &xen_9pfs_ops);
 #endif
 #ifdef CONFIG_USB_LIBUSB
