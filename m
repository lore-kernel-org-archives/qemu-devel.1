Received: from eggs.gnu.org ([2001:4830:134:3::10]:51311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cFKOO-0003e8-9A
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cFKOH-0001mx-A3
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:35:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59890
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cFKOH-0001mY-4P
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:35:05 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB9CSZv6091398
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 07:35:04 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 277rtkc70p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:35:03 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 9 Dec 2016 05:35:03 -0700
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-11-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 9 Dec 2016 13:34:52 +0100
MIME-Version: 1.0
In-Reply-To: <1481285870-3396-11-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <ee391fa0-e931-4d50-5889-d4c388dcf525@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 10/20] s390x: Move CPU files to target/
 folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

On 12/09/2016 01:17 PM, Thomas Huth wrote:
> Signed-off-by: Thomas Huth <thuth@redhat.com>

grep does not seem to find any other place.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  MAINTAINERS                                       | 8 ++++----
>  Makefile.objs                                     | 2 +-
>  {target-s390x => target/s390x}/Makefile.objs      | 2 +-
>  {target-s390x => target/s390x}/arch_dump.c        | 0
>  {target-s390x => target/s390x}/cc_helper.c        | 0
>  {target-s390x => target/s390x}/cpu-qom.h          | 0
>  {target-s390x => target/s390x}/cpu.c              | 0
>  {target-s390x => target/s390x}/cpu.h              | 0
>  {target-s390x => target/s390x}/cpu_features.c     | 0
>  {target-s390x => target/s390x}/cpu_features.h     | 0
>  {target-s390x => target/s390x}/cpu_features_def.h | 0
>  {target-s390x => target/s390x}/cpu_models.c       | 0
>  {target-s390x => target/s390x}/cpu_models.h       | 0
>  {target-s390x => target/s390x}/fpu_helper.c       | 0
>  {target-s390x => target/s390x}/gdbstub.c          | 0
>  {target-s390x => target/s390x}/gen-features.c     | 0
>  {target-s390x => target/s390x}/helper.c           | 0
>  {target-s390x => target/s390x}/helper.h           | 0
>  {target-s390x => target/s390x}/insn-data.def      | 0
>  {target-s390x => target/s390x}/insn-format.def    | 0
>  {target-s390x => target/s390x}/int_helper.c       | 0
>  {target-s390x => target/s390x}/interrupt.c        | 0
>  {target-s390x => target/s390x}/ioinst.c           | 0
>  {target-s390x => target/s390x}/kvm.c              | 0
>  {target-s390x => target/s390x}/machine.c          | 0
>  {target-s390x => target/s390x}/mem_helper.c       | 0
>  {target-s390x => target/s390x}/misc_helper.c      | 0
>  {target-s390x => target/s390x}/mmu_helper.c       | 0
>  {target-s390x => target/s390x}/trace-events       | 8 ++++----
>  {target-s390x => target/s390x}/translate.c        | 0
>  30 files changed, 10 insertions(+), 10 deletions(-)
>  rename {target-s390x => target/s390x}/Makefile.objs (94%)
>  rename {target-s390x => target/s390x}/arch_dump.c (100%)
>  rename {target-s390x => target/s390x}/cc_helper.c (100%)
>  rename {target-s390x => target/s390x}/cpu-qom.h (100%)
>  rename {target-s390x => target/s390x}/cpu.c (100%)
>  rename {target-s390x => target/s390x}/cpu.h (100%)
>  rename {target-s390x => target/s390x}/cpu_features.c (100%)
>  rename {target-s390x => target/s390x}/cpu_features.h (100%)
>  rename {target-s390x => target/s390x}/cpu_features_def.h (100%)
>  rename {target-s390x => target/s390x}/cpu_models.c (100%)
>  rename {target-s390x => target/s390x}/cpu_models.h (100%)
>  rename {target-s390x => target/s390x}/fpu_helper.c (100%)
>  rename {target-s390x => target/s390x}/gdbstub.c (100%)
>  rename {target-s390x => target/s390x}/gen-features.c (100%)
>  rename {target-s390x => target/s390x}/helper.c (100%)
>  rename {target-s390x => target/s390x}/helper.h (100%)
>  rename {target-s390x => target/s390x}/insn-data.def (100%)
>  rename {target-s390x => target/s390x}/insn-format.def (100%)
>  rename {target-s390x => target/s390x}/int_helper.c (100%)
>  rename {target-s390x => target/s390x}/interrupt.c (100%)
>  rename {target-s390x => target/s390x}/ioinst.c (100%)
>  rename {target-s390x => target/s390x}/kvm.c (100%)
>  rename {target-s390x => target/s390x}/machine.c (100%)
>  rename {target-s390x => target/s390x}/mem_helper.c (100%)
>  rename {target-s390x => target/s390x}/misc_helper.c (100%)
>  rename {target-s390x => target/s390x}/mmu_helper.c (100%)
>  rename {target-s390x => target/s390x}/trace-events (91%)
>  rename {target-s390x => target/s390x}/translate.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb6c3a6..48b0a7b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -202,7 +202,7 @@ S390
>  M: Richard Henderson <rth@twiddle.net>
>  M: Alexander Graf <agraf@suse.de>
>  S: Maintained
> -F: target-s390x/
> +F: target/s390x/
>  F: hw/s390x/
>  F: disas/s390.c
> 
> @@ -286,9 +286,9 @@ M: Christian Borntraeger <borntraeger@de.ibm.com>
>  M: Cornelia Huck <cornelia.huck@de.ibm.com>
>  M: Alexander Graf <agraf@suse.de>
>  S: Maintained
> -F: target-s390x/kvm.c
> -F: target-s390x/ioinst.[ch]
> -F: target-s390x/machine.c
> +F: target/s390x/kvm.c
> +F: target/s390x/ioinst.[ch]
> +F: target/s390x/machine.c
>  F: hw/intc/s390_flic.c
>  F: hw/intc/s390_flic_kvm.c
>  F: include/hw/s390x/s390_flic.h
> diff --git a/Makefile.objs b/Makefile.objs
> index 91a24c5..c5ebb80 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -158,7 +158,7 @@ trace-events-y += net/trace-events
>  trace-events-y += target/arm/trace-events
>  trace-events-y += target/i386/trace-events
>  trace-events-y += target-sparc/trace-events
> -trace-events-y += target-s390x/trace-events
> +trace-events-y += target/s390x/trace-events
>  trace-events-y += target/ppc/trace-events
>  trace-events-y += qom/trace-events
>  trace-events-y += linux-user/trace-events
> diff --git a/target-s390x/Makefile.objs b/target/s390x/Makefile.objs
> similarity index 94%
> rename from target-s390x/Makefile.objs
> rename to target/s390x/Makefile.objs
> index 6b02b17..c573633 100644
> --- a/target-s390x/Makefile.objs
> +++ b/target/s390x/Makefile.objs
> @@ -5,7 +5,7 @@ obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o
>  obj-$(CONFIG_KVM) += kvm.o
> 
>  # build and run feature list generator
> -feat-src = $(SRC_PATH)/target-$(TARGET_BASE_ARCH)/
> +feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
>  feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
>  ifneq ($(MAKECMDGOALS),clean)
>  GENERATED_HEADERS += $(feat-dst)gen-features.h
> diff --git a/target-s390x/arch_dump.c b/target/s390x/arch_dump.c
> similarity index 100%
> rename from target-s390x/arch_dump.c
> rename to target/s390x/arch_dump.c
> diff --git a/target-s390x/cc_helper.c b/target/s390x/cc_helper.c
> similarity index 100%
> rename from target-s390x/cc_helper.c
> rename to target/s390x/cc_helper.c
> diff --git a/target-s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> similarity index 100%
> rename from target-s390x/cpu-qom.h
> rename to target/s390x/cpu-qom.h
> diff --git a/target-s390x/cpu.c b/target/s390x/cpu.c
> similarity index 100%
> rename from target-s390x/cpu.c
> rename to target/s390x/cpu.c
> diff --git a/target-s390x/cpu.h b/target/s390x/cpu.h
> similarity index 100%
> rename from target-s390x/cpu.h
> rename to target/s390x/cpu.h
> diff --git a/target-s390x/cpu_features.c b/target/s390x/cpu_features.c
> similarity index 100%
> rename from target-s390x/cpu_features.c
> rename to target/s390x/cpu_features.c
> diff --git a/target-s390x/cpu_features.h b/target/s390x/cpu_features.h
> similarity index 100%
> rename from target-s390x/cpu_features.h
> rename to target/s390x/cpu_features.h
> diff --git a/target-s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
> similarity index 100%
> rename from target-s390x/cpu_features_def.h
> rename to target/s390x/cpu_features_def.h
> diff --git a/target-s390x/cpu_models.c b/target/s390x/cpu_models.c
> similarity index 100%
> rename from target-s390x/cpu_models.c
> rename to target/s390x/cpu_models.c
> diff --git a/target-s390x/cpu_models.h b/target/s390x/cpu_models.h
> similarity index 100%
> rename from target-s390x/cpu_models.h
> rename to target/s390x/cpu_models.h
> diff --git a/target-s390x/fpu_helper.c b/target/s390x/fpu_helper.c
> similarity index 100%
> rename from target-s390x/fpu_helper.c
> rename to target/s390x/fpu_helper.c
> diff --git a/target-s390x/gdbstub.c b/target/s390x/gdbstub.c
> similarity index 100%
> rename from target-s390x/gdbstub.c
> rename to target/s390x/gdbstub.c
> diff --git a/target-s390x/gen-features.c b/target/s390x/gen-features.c
> similarity index 100%
> rename from target-s390x/gen-features.c
> rename to target/s390x/gen-features.c
> diff --git a/target-s390x/helper.c b/target/s390x/helper.c
> similarity index 100%
> rename from target-s390x/helper.c
> rename to target/s390x/helper.c
> diff --git a/target-s390x/helper.h b/target/s390x/helper.h
> similarity index 100%
> rename from target-s390x/helper.h
> rename to target/s390x/helper.h
> diff --git a/target-s390x/insn-data.def b/target/s390x/insn-data.def
> similarity index 100%
> rename from target-s390x/insn-data.def
> rename to target/s390x/insn-data.def
> diff --git a/target-s390x/insn-format.def b/target/s390x/insn-format.def
> similarity index 100%
> rename from target-s390x/insn-format.def
> rename to target/s390x/insn-format.def
> diff --git a/target-s390x/int_helper.c b/target/s390x/int_helper.c
> similarity index 100%
> rename from target-s390x/int_helper.c
> rename to target/s390x/int_helper.c
> diff --git a/target-s390x/interrupt.c b/target/s390x/interrupt.c
> similarity index 100%
> rename from target-s390x/interrupt.c
> rename to target/s390x/interrupt.c
> diff --git a/target-s390x/ioinst.c b/target/s390x/ioinst.c
> similarity index 100%
> rename from target-s390x/ioinst.c
> rename to target/s390x/ioinst.c
> diff --git a/target-s390x/kvm.c b/target/s390x/kvm.c
> similarity index 100%
> rename from target-s390x/kvm.c
> rename to target/s390x/kvm.c
> diff --git a/target-s390x/machine.c b/target/s390x/machine.c
> similarity index 100%
> rename from target-s390x/machine.c
> rename to target/s390x/machine.c
> diff --git a/target-s390x/mem_helper.c b/target/s390x/mem_helper.c
> similarity index 100%
> rename from target-s390x/mem_helper.c
> rename to target/s390x/mem_helper.c
> diff --git a/target-s390x/misc_helper.c b/target/s390x/misc_helper.c
> similarity index 100%
> rename from target-s390x/misc_helper.c
> rename to target/s390x/misc_helper.c
> diff --git a/target-s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> similarity index 100%
> rename from target-s390x/mmu_helper.c
> rename to target/s390x/mmu_helper.c
> diff --git a/target-s390x/trace-events b/target/s390x/trace-events
> similarity index 91%
> rename from target-s390x/trace-events
> rename to target/s390x/trace-events
> index df59f5f..1574033 100644
> --- a/target-s390x/trace-events
> +++ b/target/s390x/trace-events
> @@ -1,22 +1,22 @@
>  # See docs/tracing.txt for syntax documentation.
> 
> -# target-s390x/mmu_helper.c
> +# target/s390x/mmu_helper.c
>  get_skeys_nonzero(int rc) "SKEY: Call to get_skeys unexpectedly returned %d"
>  set_skeys_nonzero(int rc) "SKEY: Call to set_skeys unexpectedly returned %d"
> 
> -# target-s390x/ioinst.c
> +# target/s390x/ioinst.c
>  ioinst(const char *insn) "IOINST: %s"
>  ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
>  ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
>  ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %04x, len %04x"
> 
> -# target-s390x/kvm.c
> +# target/s390x/kvm.c
>  kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
>  kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
>  kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
>  kvm_sigp_finished(uint8_t order, int cpu_index, int dst_index, int cc) "SIGP: Finished order %u on cpu %d -> cpu %d with cc=%d"
> 
> -# target-s390x/cpu.c
> +# target/s390x/cpu.c
>  cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
>  cpu_halt(int cpu_index) "halting cpu %d"
>  cpu_unhalt(int cpu_index) "unhalting cpu %d"
> diff --git a/target-s390x/translate.c b/target/s390x/translate.c
> similarity index 100%
> rename from target-s390x/translate.c
> rename to target/s390x/translate.c
> 
