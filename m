Received: from eggs.gnu.org ([2001:4830:134:3::10]:40989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVzSt-00043w-10
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cVzSo-0005Il-EK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:40:43 -0500
Date: Tue, 24 Jan 2017 11:40:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170124114030.GB20224@work-vm>
References: <1484852453-12728-1-git-send-email-duanj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484852453-12728-1-git-send-email-duanj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [QEMU PATCH v17 0/4] migration: migrate QTAILQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jianjun Duan <duanj@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, dmitry@daynix.com, peter.maydell@linaro.org, kraxel@redhat.com, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, veroniabahaa@gmail.com, quintela@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, rth@twiddle.net, aurelien@aurel32.net, leon.alrae@imgtec.com, blauwirbel@gmail.com, mark.cave-ayland@ilande.co.uk, mdroth@linux.vnet.ibm.com

* Jianjun Duan (duanj@linux.vnet.ibm.com) wrote:
> Hi all,

Queued.

Dave

>     Comments are welcome.     
> 
> v17: - Fixed a type cast issue in test-vmstate.c.
> Previous versions are:
> 
> v16: - Moved a variable to global in test-vmstate.c following Dave's suggestion.
> (link: http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg01187.html)
> 
> v15: - Improved error messages.
> (link: http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg01059.html)
> 
> v14: - Fixed a return statement.
> (link: http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg04467.html)
> 
> v13: - Changed some QTAILQ related macro names to match existing ones. 
> (link: http://lists.nongnu.org/archive/html/qemu-ppc/2016-11/msg00226.html)
> 
> v12: - Fixed type for put_qtailq which caused build break.
> (link: http://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01328.html
> 
> v11: - Split error_report statements into a separate patch.
>      - Changed the signature of put. It now returns int type.
>      - Minor changes to QTAILQ macros. 
>          
> v10: - Fixed a typo.
> (link: http://lists.nongnu.org/archive/html/qemu-ppc/2016-10/msg01206.html)
> 
> v9: - No more hard encoding of QTAILQ layout information
> (link: http://lists.nongnu.org/archive/html/qemu-ppc/2016-10/msg01042.html)
> 
> v8: - Fixed a style issue. 
> (link: http://lists.nongnu.org/archive/html/qemu-ppc/2016-10/msg00874.html)
> 
> v7: - Fixed merge errors.
>     - Simplified macro definitions related to pointer arithmetic based QTAILQ access.
>     - Added test case for QTAILQ migration in tests/test-vmstate.c.
> (link: http://lists.nongnu.org/archive/html/qemu-ppc/2016-10/msg00711.html)
> 
> 
> v6: - Split from Power specific patches. 
>     - Dropped VMS_LINKED flag.
>     - Rebased to master.
>     - Added comments to clarify about put/get in VMStateInfo.  
> (link: http://lists.nongnu.org/archive/html/qemu-ppc/2016-10/msg00336.html)
> 
> v5: - Rebased to David's ppc-for-2.8. 
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-10/msg00270.html)
> 
> v4: - Introduce a way to set customized instance_id in SaveStateEntry. Use it
>       to set instance_id for DRC using its unique index to address David 
>       Gibson's concern.
>     - Rename VMS_CSTM to VMS_LINKED based on Paolo Bonzini's suggestions.
>     - Clean up qjson stuff in put_qtailq. 
>     - Add trace for put_qtailq and get_qtailq based on David Gilbert's 
>       suggestion.
>     - Based on David's ppc-for-2.7. 
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg07720.html)
> 
> v3: - Simplify overall design followng discussion with Paolo. No longer need
>       metadata to migrate QTAILQ.
>     - Extend VMStateInfo instead of adding similar fields to VMStateField.
>     - Clean up macros in qemu/queue.h.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg05695.html)
> 
> v2: - Introduce a general approach to migrate QTAILQ in qemu/queue.h.
>     - Migrate signalled field in the DRC state.
>     - Put the newly added migrating fields in subsections so that backward 
>       migration is not broken.  
>     - Set detach_cb field right after migration so that a migrated hot-unplug
>       event could finish its course.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg04188.html)
> 
> v1: - Inital version.
> (link: https://lists.nongnu.org/archive/html/qemu-devel/2016-04/msg02601.html)
> 
> To make guest device (PCI, CPU and memory) hotplug work together 
> with guest migration, spapr drc state needs be transmitted in
> migration. This patch defines the VMStateDescription struct for
> spapr drc state to enable it.
> 
> To fix the potential racing between hotplug events on guest and 
> guest migration, ccs_list and pending_events of spapr state need be 
> transmitted in migration. This patch also takes care of it.
> 
> Jianjun Duan (4):
>   migration: extend VMStateInfo
>   migration: migrate QTAILQ
>   tests/migration: Add test for QTAILQ migration
>   migration: add error_report
> 
>  hw/display/virtio-gpu.c     |   8 +-
>  hw/intc/s390_flic_kvm.c     |   8 +-
>  hw/net/vmxnet3.c            |  24 ++++--
>  hw/nvram/eeprom93xx.c       |   8 +-
>  hw/nvram/fw_cfg.c           |   8 +-
>  hw/pci/msix.c               |   8 +-
>  hw/pci/pci.c                |  16 +++-
>  hw/pci/shpc.c               |   7 +-
>  hw/scsi/scsi-bus.c          |   8 +-
>  hw/timer/twl92230.c         |   8 +-
>  hw/usb/redirect.c           |  26 ++++--
>  hw/virtio/virtio-pci.c      |   8 +-
>  hw/virtio/virtio.c          |  15 +++-
>  include/migration/vmstate.h |  39 +++++++--
>  include/qemu/queue.h        |  60 ++++++++++++++
>  migration/savevm.c          |   7 +-
>  migration/trace-events      |   4 +
>  migration/vmstate.c         | 188 +++++++++++++++++++++++++++++++++++---------
>  target-alpha/machine.c      |   6 +-
>  target-arm/machine.c        |  14 +++-
>  target-i386/machine.c       |  26 ++++--
>  target-mips/machine.c       |  14 +++-
>  target-ppc/machine.c        |  12 ++-
>  target-sparc/machine.c      |   6 +-
>  tests/test-vmstate.c        | 147 ++++++++++++++++++++++++++++++++++
>  25 files changed, 569 insertions(+), 106 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
