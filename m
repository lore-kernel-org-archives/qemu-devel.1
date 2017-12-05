Received: from eggs.gnu.org ([2001:4830:134:3::10]:42705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eM1Zt-0004UN-OS
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 19:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eM1Zo-00016B-Ut
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 19:59:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eM1Zo-00015t-OG
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 19:59:12 -0500
Date: Tue, 5 Dec 2017 02:59:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171205025804-mutt-send-email-mst@kernel.org>
References: <20171201151538.6844-1-farman@linux.vnet.ibm.com>
	<20171201151538.6844-2-farman@linux.vnet.ibm.com>
	<77147a49-b8b3-d94d-80ab-5ab279fbc8b9@redhat.com>
	<4f6e5359-2aee-64c3-332f-b60bb1c9af1f@linux.vnet.ibm.com>
	<CAFEAcA-=+p=fYwU2byXhSG96Hnc5M4R4A-QK0Yivga81g1E2SQ@mail.gmail.com>
	<f6ca783b-bd13-8d5e-cdec-a3d7e00d9b20@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ca783b-bd13-8d5e-cdec-a3d7e00d9b20@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] vhost-scsi: add missing virtqueue_size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>

On Mon, Dec 04, 2017 at 03:00:45PM -0500, Eric Farman wrote:
> 
> 
> On 12/04/2017 01:05 PM, Peter Maydell wrote:
> > On 4 December 2017 at 17:52, Eric Farman <farman@linux.vnet.ibm.com> wrote:
> > > On 12/01/2017 10:16 AM, Paolo Bonzini wrote:
> > > > 
> > > > On 01/12/2017 16:15, Eric Farman wrote:
> > > > > diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> > > > > index cd4ab05233..9c1bea8ff3 100644
> > > > > --- a/hw/scsi/vhost-scsi.c
> > > > > +++ b/hw/scsi/vhost-scsi.c
> > > > > @@ -233,6 +233,8 @@ static Property vhost_scsi_properties[] = {
> > > > >        DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
> > > > >        DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt,
> > > > > 0),
> > > > >        DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
> > > > > 1),
> > > > > +    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon,
> > > > > conf.virtqueue_size,
> > > > > +                       128),
> > > > >        DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon,
> > > > > conf.max_sectors,
> > > > >                           0xFFFF),
> > > > >        DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon,
> > > > > conf.cmd_per_lun, 128),
> > 
> > > Wow, super quick, thank you!  Seeing conversations today, is this queued for
> > > -rc4, or 2.12 and backport to qemu-stable?
> > 
> > If people can come to a consensus on whether this is -rc4 material
> > by Tuesday 12:00 GMT that would be helpful.
> 
> I'd vote for -rc4, since it's a new guest crash since 2.10.

I think so too.

>  But I also
> won't complain if it waits for 2.11.1 since I was out of the office during
> the whole freeze period and no one else noticed it.
> 
>  - Eric
