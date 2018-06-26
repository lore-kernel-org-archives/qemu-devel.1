Received: from eggs.gnu.org ([2001:4830:134:3::10]:58544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXlso-0003Mb-1j
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXlsn-00049P-3q
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:11:37 -0400
Date: Tue, 26 Jun 2018 13:11:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180626111129.tkpu73y4bam3jddz@sirius.home.kraxel.org>
References: <20180625164239.13794-1-kwolf@redhat.com>
	<87h8lqkkrp.fsf@dusky.pond.sub.org>
	<424bb91d-a202-5c3b-1264-254cad0709d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424bb91d-a202-5c3b-1264-254cad0709d0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] usb-storage: Add rerror/werror properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, pkrempa@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Tue, Jun 26, 2018 at 10:48:10AM +0200, Paolo Bonzini wrote:
> On 26/06/2018 10:35, Markus Armbruster wrote:
> > We also want to deprecate usb-storage, but
> > I guess we're still not ready for that (it's a complicated story).
> > 
> > To deprecate -drive without also deprecating usb-storage, we need to
> > preserve features.
> 
> Patch looks good to me too, but indeed why can't we deprecate
> usb-storage in favor of usb-bot + scsi-disk?

I think we can.  One blocking issue was hotplug support, but that got fixed a
while ago, and I'm not aware of any other issue ...

cheers,
  Gerd

commit b78ecd0998094a8b7e0f14c4888f3a6b525d14ff
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Wed Jun 15 11:46:58 2016 +0200

    usb-bot: hotplug support
    
    This patch marks usb-bot as hot-pluggable device, makes attached
    property settable and turns off auto-attach in case the device
    was hotplugged.
    
    Hot-plugging a usb-bot device with one or more scsi devices can be
    done this way now:
    
      (1) device-add usb-bot,id=foo
      (2) device-add scsi-{hd,cd},bus=foo.0,lun=0
      (2b) optionally add more devices (luns 0 ... 15).
      (3) qom-set foo.attached = true
    
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
    Reviewed-by: Markus Armbruster <armbru@redhat.com>
    Message-id: 1465984019-28963-5-git-send-email-kraxel@redhat.com
