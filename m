Received: from eggs.gnu.org ([2001:4830:134:3::10]:47001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dkxSS-0003gE-Kr
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dkxSP-0007bl-AT
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:06:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dkxSP-0007bV-1a
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:06:21 -0400
References: <150360081780.16351.6836234147404830593@loki>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1a05478e-b75d-c149-eaf3-b00b4cf4a4e2@redhat.com>
Date: Thu, 24 Aug 2017 21:06:17 +0200
MIME-Version: 1.0
In-Reply-To: <150360081780.16351.6836234147404830593@loki>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 2.10.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.de>

On 08/24/17 20:53, Michael Roth wrote:
> Hello,
> 
> On behalf of the QEMU Team, I'd like to announce the availability of the
> fifth release candidate for the QEMU 2.10 release.  This release is meant
> for testing purposes and should not be used in a production environment.
> 
>   http://download.qemu-project.org/qemu-2.10.0-rc4.tar.xz
>   http://download.qemu-project.org/qemu-2.10.0-rc4.tar.xz.sig
> 
> A note from the maintainer:
> 
>   This release contains last minute fixes for some bugs affecting
>   PowerPC hosts and also for bugs in the QEMU network block device code.
>   Any final testing should therefore be concentrated on these areas.
>   We plan to make the final release of QEMU 2.10 on Wednesday 30th
>   August.
>   
>   (30th August happens to be my birthday, but this is purely
>   coincidental :-))
> 
> You can help improve the quality of the QEMU 2.10 release by testing this
> release and reporting bugs on Launchpad:
> 
>   https://bugs.launchpad.net/qemu/
> 
> The release plan, as well a documented known issues for release
> candidates, are available at:
> 
>   http://wiki.qemu.org/Planning/2.10
> 
> Please add entries to the ChangeLog for the 2.10 release below:
> 
>   http://wiki.qemu.org/ChangeLog/2.10
> 
> Changes since rc3:
> 
> 248b237: Update version for v2.10.0-rc4 release (Peter Maydell)
> 40f4a21: nbd-client: avoid spurious qio_channel_yield() re-entry (Stefan Hajnoczi)
> 12314f2: qemu-iotests: add 194 non-shared storage migration test (Stefan Hajnoczi)
> 7d5b526: block: Update open_flags after ->inactivate() callback (Stefan Hajnoczi)
> 045a2f8: mirror: Mark target BB as "force allow inactivate" (Fam Zheng)
> ca2e214: block-backend: Allow more "can inactivate" cases (Fam Zheng)
> c16de8f: block-backend: Refactor inactivate check (Fam Zheng)
> 3da2bd8: numa: Move numa_legacy_auto_assign_ram to pc-i440fx-2.9 (Eduardo Habkost)
> d0a1801: fix build failure in nbd_read_reply_entry() (Igor Mammedov)
> 1f98e55: hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" device (Thomas Huth)
> 8ccccff: hw/ppc/spapr_rtc: Mark the RTC device with user_creatable = false (Thomas Huth)
> 0479097: hw/ppc/spapr: Fix segfault when instantiating a 'pc-dimm' without 'memdev' (Thomas Huth)
> 188bfe1: spapr: Allow configure-connector to be called multiple times (Bharata B Rao)
> 5dfaa53: ppc: fix ppc_set_compat() with KVM PR (Greg Kurz)
> c363a37: target/ppc: 'PVR != host PVR' in KVM_SET_SREGS workaround (Daniel Henrique Barboza)
> b96919d: boot-serial-test: prefer tcg accelerator (Cornelia Huck)

Has it not been the intent to include the following patch in 2.10:

  [PATCH] scsi-bus: correct responses for INQUIRY and REQUEST SENSE
  http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03351.html
  Message-Id: <1503049022-14749-1-git-send-email-hare@suse.de>

Paolo CC'd it to stable.

Apologies if I misunderstood.

Thanks,
Laszlo
