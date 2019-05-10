Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A780C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 00:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA5E2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 00:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA5E2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34792 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOtqr-0008Ob-76
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 20:57:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hOtq4-00085s-Mh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 20:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hOtq3-00072z-Gp
	for qemu-devel@nongnu.org; Thu, 09 May 2019 20:56:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:7350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hOtq3-00063F-8Z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 20:56:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 May 2019 17:55:31 -0700
Received: from unknown (HELO [10.239.196.183]) ([10.239.196.183])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA;
	09 May 2019 17:55:28 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <1faa2ddf-2a52-07e7-00e3-ab1959d304f9@linux.intel.com>
Date: Fri, 10 May 2019 08:55:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v2 00/10] refactor cpu topo into machine
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair23@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/5/6 16:33, Like Xu wrote:
> This patch series make existing cores/threads/sockets into machine
> properties and get rid of global smp_* variables they use currently.
> 
> The purpose of getting rid of globals is disentangle layer violations and
> let's do it one step at a time by replacing the smp_foo with qdev_get_machine()
> as few calls as possible and delay other related refactoring efforts.
> 

It looks like the changelog is missing and here it is:

==changelog==

v2:
- pass MachineState via call chain with trivial fixups
- replace smp_cpus directly at places if it's only used once
- s/topo/smp/ and drop smp_ prefix inside CpuTopology structure
- add more commit messages to explaining what patch does
- fix Patchew build failure for xen usage
- use macs rather than ms in migration context for MigrationState
- cleanup unrelated and redundant changes
- spilt OpenRISC and RISC-V related patches

v1: https://patchwork.kernel.org/cover/10876667/

> Like Xu (10):
>    hw/boards: add struct CpuTopology to MachineState
>    cpu/topology: related call chains refactoring to pass MachineState
>    cpu/topology: replace global smp variables by MachineState in general path
>    cpu/topology: add uncommon arch support for smp machine properties
>    cpu/topology: add hw/ppc support for smp machine properties
>    cpu/topology: add hw/riscv support for smp machine properties
>    cpu/topology: add hw/s390x support for smp machine properties
>    cpu/topology: add hw/i386 support for smp machine properties
>    cpu/topology: add hw/arm support for smp machine properties
>    cpu/topology: replace smp global variables with smp machine properties
> 
>   accel/kvm/kvm-all.c          |  4 ++--
>   backends/hostmem.c           |  6 ++++--
>   cpus.c                       |  6 ++++--
>   exec.c                       |  3 ++-
>   gdbstub.c                    |  4 ++++
>   hw/alpha/dp264.c             |  1 +
>   hw/arm/fsl-imx6.c            |  6 +++++-
>   hw/arm/fsl-imx6ul.c          |  6 +++++-
>   hw/arm/fsl-imx7.c            |  7 +++++--
>   hw/arm/highbank.c            |  1 +
>   hw/arm/mcimx6ul-evk.c        |  2 +-
>   hw/arm/mcimx7d-sabre.c       |  2 +-
>   hw/arm/raspi.c               |  4 ++--
>   hw/arm/realview.c            |  1 +
>   hw/arm/sabrelite.c           |  2 +-
>   hw/arm/vexpress.c            | 16 ++++++++------
>   hw/arm/virt.c                | 10 +++++++--
>   hw/arm/xlnx-zynqmp.c         | 16 ++++++++------
>   hw/cpu/core.c                |  4 +++-
>   hw/hppa/machine.c            |  4 +++-
>   hw/i386/acpi-build.c         | 13 +++++++-----
>   hw/i386/kvmvapic.c           |  7 +++++--
>   hw/i386/pc.c                 | 33 ++++++++++++++++-------------
>   hw/i386/xen/xen-hvm.c        |  4 ++++
>   hw/mips/boston.c             |  2 +-
>   hw/mips/mips_malta.c         | 23 +++++++++++---------
>   hw/openrisc/openrisc_sim.c   |  1 +
>   hw/ppc/e500.c                |  3 +++
>   hw/ppc/mac_newworld.c        |  3 ++-
>   hw/ppc/mac_oldworld.c        |  3 ++-
>   hw/ppc/pnv.c                 |  9 ++++----
>   hw/ppc/prep.c                |  4 ++--
>   hw/ppc/spapr.c               | 37 +++++++++++++++++++++++---------
>   hw/ppc/spapr_rtas.c          |  4 +++-
>   hw/riscv/sifive_e.c          |  6 ++++--
>   hw/riscv/sifive_plic.c       |  3 +++
>   hw/riscv/sifive_u.c          |  6 ++++--
>   hw/riscv/spike.c             |  2 ++
>   hw/riscv/virt.c              |  1 +
>   hw/s390x/s390-virtio-ccw.c   |  9 ++++----
>   hw/s390x/sclp.c              |  2 +-
>   hw/smbios/smbios.c           | 26 +++++++++++++----------
>   hw/sparc/sun4m.c             |  2 ++
>   hw/sparc64/sun4u.c           |  4 ++--
>   hw/xtensa/sim.c              |  2 +-
>   hw/xtensa/xtfpga.c           |  1 +
>   include/hw/boards.h          | 19 +++++++++++++++--
>   include/hw/firmware/smbios.h |  5 +++--
>   include/hw/i386/pc.h         |  2 +-
>   migration/postcopy-ram.c     |  8 ++++++-
>   numa.c                       |  1 +
>   qmp.c                        |  2 +-
>   target/arm/cpu.c             |  8 ++++++-
>   target/i386/cpu.c            |  4 +++-
>   target/openrisc/sys_helper.c |  6 +++++-
>   target/s390x/cpu.c           |  3 +++
>   target/s390x/excp_helper.c   |  5 +++++
>   tcg/tcg.c                    | 13 +++++++++++-
>   vl.c                         | 50 ++++++++++++++++++++++++--------------------
>   59 files changed, 301 insertions(+), 140 deletions(-)
> 


