Received: from eggs.gnu.org ([2001:4830:134:3::10]:56377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dwrvB-0002VT-EH
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dwrvA-0006Un-Jh
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:37:17 -0400
Date: Tue, 26 Sep 2017 17:37:05 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170926153705.365mvhaf6rj65rvl@kamzik.brq.redhat.com>
References: <1506088275-31734-1-git-send-email-wei@redhat.com>
	<20170926105422.vfaalzzmhufvrk34@kamzik.brq.redhat.com>
	<CAFEAcA_Wk5U89QAUHx0tsJR57LLASgnKwtMQk9-PY7sBZAm+hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Wk5U89QAUHx0tsJR57LLASgnKwtMQk9-PY7sBZAm+hg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Set VM's SMBIOS system
 version to mc->name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, eric.auger@redhat.com

On Tue, Sep 26, 2017 at 04:28:03PM +0100, Peter Maydell wrote:
> On 26 September 2017 at 11:54, Andrew Jones <drjones@redhat.com> wrote:
> > On Fri, Sep 22, 2017 at 08:51:15AM -0500, Wei Huang wrote:
> >> Instead of using "1.0" as the system version of SMBIOS, we should use
> >> mc->name for mach-virt machine type. This matches with x86 code and
> >> prevents the smbios_table.machine_type test of Avocado from failing.
> >>
> >> Signed-off-by: Wei Huang <wei@redhat.com>
> >> ---
> >>  hw/arm/virt.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index 9e18b41..8d0c6a9 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -1189,6 +1189,7 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
> >>
> >>  static void virt_build_smbios(VirtMachineState *vms)
> >>  {
> >> +    MachineClass *mc = MACHINE_GET_CLASS(vms);
> >>      uint8_t *smbios_tables, *smbios_anchor;
> >>      size_t smbios_tables_len, smbios_anchor_len;
> >>      const char *product = "QEMU Virtual Machine";
> >> @@ -1202,7 +1203,7 @@ static void virt_build_smbios(VirtMachineState *vms)
> >>      }
> >>
> >>      smbios_set_defaults("QEMU", product,
> >> -                        "1.0", false, true, SMBIOS_ENTRY_POINT_30);
> >> +                        mc->name, false, true, SMBIOS_ENTRY_POINT_30);
> >>
> >>      smbios_get_tables(NULL, 0, &smbios_tables, &smbios_tables_len,
> >>                        &smbios_anchor, &smbios_anchor_len);
> >> --
> >> 2.7.5
> >>
> >>
> >
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> 
> Are we OK to change this without having to tie it to the machine
> version number?

Let's tie it to be safe. Eric has a 2.11 machine version patch in his
virtio-iommu series, but, like for 2.10, he or Wei should probably just
post that independently to make sure it gets in.

Wei, will you post the 2.11 version patch?

Thanks,
drew
