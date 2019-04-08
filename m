Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A33DC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5604121473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5604121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53135 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDUIz-000874-Lw
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:27:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDUI2-0007lc-T7
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDUI1-0001QM-Qb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:26:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hDUI1-0001PJ-Bs; Mon, 08 Apr 2019 09:26:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66C3D307D962;
	Mon,  8 Apr 2019 13:26:20 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 122C45D71F;
	Mon,  8 Apr 2019 13:26:18 +0000 (UTC)
Date: Mon, 8 Apr 2019 15:26:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190408152614.0bdf3cfd@redhat.com>
In-Reply-To: <7b902f2b-64b9-9c73-eeb0-1be33f1f2b07@linux.intel.com>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<20190329112152.0c7ad147@redhat.com>
	<7b902f2b-64b9-9c73-eeb0-1be33f1f2b07@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 08 Apr 2019 13:26:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/9] refactor cpu topo into machine
 properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, like.xu@intel.com,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408132614.XMIz4XZJEkbw6_KcBkpNgcsMWebwaAWeBQpzaUjDTMo@z>

On Thu, 4 Apr 2019 11:26:09 +0800
Like Xu <like.xu@linux.intel.com> wrote:

> On 2019/3/29 18:21, Igor Mammedov wrote:
> > On Fri, 29 Mar 2019 16:48:36 +0800
> > Like Xu <like.xu@linux.intel.com> wrote:
> >   
> >> This patch series make existing cores/threads/sockets into machine
> >> properties and get rid of global variables they use currently.  
> > Thanks for looking into it!
> > Its long overdue and rather desired conversion (albeit naive one,
> > but this series is a good starting point). I'll go over your patches
> > next week with comments and concrete suggestions how to implement
> > particular things.  
> 
> Hi Igor, any comments and suggestions on smp machine properties
> in this patch considering we may add die topology for PCMachine as an 
> extension?

I've looked at several patches and that it for this series.
The most comments apply to the patches I've not reviewed as well.

> >   
> >> Like Xu (9):
> >>    cpu/topology: add struct CpuTopology to MachineState
> >>    cpu/topology: add general support for machine properties
> >>    cpu/topology: add uncommon arch support for smp machine properties
> >>    cpu/topology: add ARM support for smp machine properties
> >>    cpu/topology: add i386 support for smp machine properties
> >>    cpu/topology: add PPC support for smp machine properties
> >>    cpu/topology: add riscv support for smp machine properties
> >>    cpu/topology: add s390x support for smp machine properties
> >>    cpu/topology: replace smp global variables with machine propertie
> >>
> >>   accel/kvm/kvm-all.c          |  3 +++
> >>   backends/hostmem.c           |  4 ++++
> >>   cpus.c                       |  4 ++++
> >>   exec.c                       |  2 ++
> >>   gdbstub.c                    |  7 ++++++-
> >>   hw/alpha/dp264.c             |  1 +
> >>   hw/arm/fsl-imx6.c            |  5 +++++
> >>   hw/arm/fsl-imx6ul.c          |  5 +++++
> >>   hw/arm/fsl-imx7.c            |  5 +++++
> >>   hw/arm/highbank.c            |  1 +
> >>   hw/arm/mcimx6ul-evk.c        |  1 +
> >>   hw/arm/mcimx7d-sabre.c       |  3 +++
> >>   hw/arm/raspi.c               |  2 ++
> >>   hw/arm/realview.c            |  1 +
> >>   hw/arm/sabrelite.c           |  1 +
> >>   hw/arm/vexpress.c            |  3 +++
> >>   hw/arm/virt.c                |  7 +++++++
> >>   hw/arm/xlnx-zynqmp.c         |  7 +++++++
> >>   hw/cpu/core.c                |  3 +++
> >>   hw/hppa/machine.c            |  4 ++++
> >>   hw/i386/acpi-build.c         |  3 +++
> >>   hw/i386/kvmvapic.c           |  5 +++++
> >>   hw/i386/pc.c                 | 12 +++++++++++
> >>   hw/mips/boston.c             |  1 +
> >>   hw/mips/mips_malta.c         |  9 +++++++++
> >>   hw/openrisc/openrisc_sim.c   |  1 +
> >>   hw/ppc/e500.c                |  3 +++
> >>   hw/ppc/mac_newworld.c        |  2 ++
> >>   hw/ppc/mac_oldworld.c        |  2 ++
> >>   hw/ppc/pnv.c                 |  3 +++
> >>   hw/ppc/prep.c                |  2 ++
> >>   hw/ppc/spapr.c               | 29 ++++++++++++++++++++++++++
> >>   hw/ppc/spapr_rtas.c          |  3 +++
> >>   hw/riscv/sifive_e.c          |  4 ++++
> >>   hw/riscv/sifive_plic.c       |  3 +++
> >>   hw/riscv/sifive_u.c          |  4 ++++
> >>   hw/riscv/spike.c             |  2 ++
> >>   hw/riscv/virt.c              |  1 +
> >>   hw/s390x/s390-virtio-ccw.c   |  2 ++
> >>   hw/s390x/sclp.c              |  1 +
> >>   hw/smbios/smbios.c           | 11 ++++++++++
> >>   hw/sparc/sun4m.c             |  2 ++
> >>   hw/sparc64/sun4u.c           |  2 ++
> >>   hw/xtensa/sim.c              |  1 +
> >>   hw/xtensa/xtfpga.c           |  1 +
> >>   include/hw/arm/virt.h        |  2 +-
> >>   include/hw/boards.h          |  8 ++++++++
> >>   include/sysemu/sysemu.h      |  2 +-
> >>   migration/postcopy-ram.c     |  7 +++++++
> >>   numa.c                       |  1 +
> >>   target/arm/cpu.c             |  7 +++++++
> >>   target/i386/cpu.c            |  4 ++++
> >>   target/openrisc/sys_helper.c |  5 +++++
> >>   target/s390x/cpu.c           |  3 +++
> >>   target/s390x/excp_helper.c   |  6 ++++++
> >>   tcg/tcg.c                    | 15 ++++++++++++++
> >>   vl.c                         | 48 ++++++++++++++++++++++++--------------------
> >>   57 files changed, 261 insertions(+), 25 deletions(-)
> >>  
> > 
> > 
> >   
> 
> 


