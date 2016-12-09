Received: from eggs.gnu.org ([2001:4830:134:3::10]:47554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cFM5Q-0006X1-NU
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cFM5L-0005cb-RR
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:23:44 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cFM5L-0005X0-Ed
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:23:39 -0500
Received: by mail-lf0-f65.google.com with SMTP id p100so133117lfg.2
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 06:23:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACXAS8ACJpCDJ+Ti9xhY3hvYz4CWD+E2iWNQ5H+8r8oUggm-Yg@mail.gmail.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-12-git-send-email-thuth@redhat.com>
	<CACXAS8ACJpCDJ+Ti9xhY3hvYz4CWD+E2iWNQ5H+8r8oUggm-Yg@mail.gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 9 Dec 2016 15:21:56 +0100
Message-ID: <CACXAS8BpA_yVbg0EowrnS=bBPM0m9EEfdPdPZ6x7Sq46Pq0XGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 11/20] sparc: Move CPU files to target/
 folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>

Acked-By: Artyom Tarasenko <atar4qemu@gmail.com>

(Forgot to hit "Reply to all" in the previous mail)


> On Fri, Dec 9, 2016 at 1:17 PM, Thomas Huth <thuth@redhat.com> wrote:
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  MAINTAINERS                                   | 2 +-
>>  Makefile.objs                                 | 2 +-
>>  {target-sparc => target/sparc}/Makefile.objs  | 0
>>  {target-sparc => target/sparc}/TODO           | 0
>>  {target-sparc => target/sparc}/asi.h          | 0
>>  {target-sparc => target/sparc}/cc_helper.c    | 0
>>  {target-sparc => target/sparc}/cpu-qom.h      | 0
>>  {target-sparc => target/sparc}/cpu.c          | 0
>>  {target-sparc => target/sparc}/cpu.h          | 0
>>  {target-sparc => target/sparc}/fop_helper.c   | 0
>>  {target-sparc => target/sparc}/gdbstub.c      | 0
>>  {target-sparc => target/sparc}/helper.c       | 0
>>  {target-sparc => target/sparc}/helper.h       | 0
>>  {target-sparc => target/sparc}/int32_helper.c | 0
>>  {target-sparc => target/sparc}/int64_helper.c | 0
>>  {target-sparc => target/sparc}/ldst_helper.c  | 0
>>  {target-sparc => target/sparc}/machine.c      | 0
>>  {target-sparc => target/sparc}/mmu_helper.c   | 0
>>  {target-sparc => target/sparc}/monitor.c      | 0
>>  {target-sparc => target/sparc}/trace-events   | 8 ++++----
>>  {target-sparc => target/sparc}/translate.c    | 0
>>  {target-sparc => target/sparc}/vis_helper.c   | 0
>>  {target-sparc => target/sparc}/win_helper.c   | 0
>>  23 files changed, 6 insertions(+), 6 deletions(-)
>>  rename {target-sparc => target/sparc}/Makefile.objs (100%)
>>  rename {target-sparc => target/sparc}/TODO (100%)
>>  rename {target-sparc => target/sparc}/asi.h (100%)
>>  rename {target-sparc => target/sparc}/cc_helper.c (100%)
>>  rename {target-sparc => target/sparc}/cpu-qom.h (100%)
>>  rename {target-sparc => target/sparc}/cpu.c (100%)
>>  rename {target-sparc => target/sparc}/cpu.h (100%)
>>  rename {target-sparc => target/sparc}/fop_helper.c (100%)
>>  rename {target-sparc => target/sparc}/gdbstub.c (100%)
>>  rename {target-sparc => target/sparc}/helper.c (100%)
>>  rename {target-sparc => target/sparc}/helper.h (100%)
>>  rename {target-sparc => target/sparc}/int32_helper.c (100%)
>>  rename {target-sparc => target/sparc}/int64_helper.c (100%)
>>  rename {target-sparc => target/sparc}/ldst_helper.c (100%)
>>  rename {target-sparc => target/sparc}/machine.c (100%)
>>  rename {target-sparc => target/sparc}/mmu_helper.c (100%)
>>  rename {target-sparc => target/sparc}/monitor.c (100%)
>>  rename {target-sparc => target/sparc}/trace-events (94%)
>>  rename {target-sparc => target/sparc}/translate.c (100%)
>>  rename {target-sparc => target/sparc}/vis_helper.c (100%)
>>  rename {target-sparc => target/sparc}/win_helper.c (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 48b0a7b..f8959d8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -218,7 +218,7 @@ SPARC
>>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>>  S: Maintained
>> -F: target-sparc/
>> +F: target/sparc/
>>  F: hw/sparc/
>>  F: hw/sparc64/
>>  F: disas/sparc.c
>> diff --git a/Makefile.objs b/Makefile.objs
>> index c5ebb80..e59b979 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -157,7 +157,7 @@ trace-events-y += audio/trace-events
>>  trace-events-y += net/trace-events
>>  trace-events-y += target/arm/trace-events
>>  trace-events-y += target/i386/trace-events
>> -trace-events-y += target-sparc/trace-events
>> +trace-events-y += target/sparc/trace-events
>>  trace-events-y += target/s390x/trace-events
>>  trace-events-y += target/ppc/trace-events
>>  trace-events-y += qom/trace-events
>> diff --git a/target-sparc/Makefile.objs b/target/sparc/Makefile.objs
>> similarity index 100%
>> rename from target-sparc/Makefile.objs
>> rename to target/sparc/Makefile.objs
>> diff --git a/target-sparc/TODO b/target/sparc/TODO
>> similarity index 100%
>> rename from target-sparc/TODO
>> rename to target/sparc/TODO
>> diff --git a/target-sparc/asi.h b/target/sparc/asi.h
>> similarity index 100%
>> rename from target-sparc/asi.h
>> rename to target/sparc/asi.h
>> diff --git a/target-sparc/cc_helper.c b/target/sparc/cc_helper.c
>> similarity index 100%
>> rename from target-sparc/cc_helper.c
>> rename to target/sparc/cc_helper.c
>> diff --git a/target-sparc/cpu-qom.h b/target/sparc/cpu-qom.h
>> similarity index 100%
>> rename from target-sparc/cpu-qom.h
>> rename to target/sparc/cpu-qom.h
>> diff --git a/target-sparc/cpu.c b/target/sparc/cpu.c
>> similarity index 100%
>> rename from target-sparc/cpu.c
>> rename to target/sparc/cpu.c
>> diff --git a/target-sparc/cpu.h b/target/sparc/cpu.h
>> similarity index 100%
>> rename from target-sparc/cpu.h
>> rename to target/sparc/cpu.h
>> diff --git a/target-sparc/fop_helper.c b/target/sparc/fop_helper.c
>> similarity index 100%
>> rename from target-sparc/fop_helper.c
>> rename to target/sparc/fop_helper.c
>> diff --git a/target-sparc/gdbstub.c b/target/sparc/gdbstub.c
>> similarity index 100%
>> rename from target-sparc/gdbstub.c
>> rename to target/sparc/gdbstub.c
>> diff --git a/target-sparc/helper.c b/target/sparc/helper.c
>> similarity index 100%
>> rename from target-sparc/helper.c
>> rename to target/sparc/helper.c
>> diff --git a/target-sparc/helper.h b/target/sparc/helper.h
>> similarity index 100%
>> rename from target-sparc/helper.h
>> rename to target/sparc/helper.h
>> diff --git a/target-sparc/int32_helper.c b/target/sparc/int32_helper.c
>> similarity index 100%
>> rename from target-sparc/int32_helper.c
>> rename to target/sparc/int32_helper.c
>> diff --git a/target-sparc/int64_helper.c b/target/sparc/int64_helper.c
>> similarity index 100%
>> rename from target-sparc/int64_helper.c
>> rename to target/sparc/int64_helper.c
>> diff --git a/target-sparc/ldst_helper.c b/target/sparc/ldst_helper.c
>> similarity index 100%
>> rename from target-sparc/ldst_helper.c
>> rename to target/sparc/ldst_helper.c
>> diff --git a/target-sparc/machine.c b/target/sparc/machine.c
>> similarity index 100%
>> rename from target-sparc/machine.c
>> rename to target/sparc/machine.c
>> diff --git a/target-sparc/mmu_helper.c b/target/sparc/mmu_helper.c
>> similarity index 100%
>> rename from target-sparc/mmu_helper.c
>> rename to target/sparc/mmu_helper.c
>> diff --git a/target-sparc/monitor.c b/target/sparc/monitor.c
>> similarity index 100%
>> rename from target-sparc/monitor.c
>> rename to target/sparc/monitor.c
>> diff --git a/target-sparc/trace-events b/target/sparc/trace-events
>> similarity index 94%
>> rename from target-sparc/trace-events
>> rename to target/sparc/trace-events
>> index bf52d97..8df178a 100644
>> --- a/target-sparc/trace-events
>> +++ b/target/sparc/trace-events
>> @@ -1,6 +1,6 @@
>>  # See docs/tracing.txt for syntax documentation.
>>
>> -# target-sparc/mmu_helper.c
>> +# target/sparc/mmu_helper.c
>>  mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
>>  mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DPROT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
>>  mmu_helper_dmiss(uint64_t address, uint64_t context) "DMISS at %"PRIx64" context %"PRIx64
>> @@ -10,16 +10,16 @@ mmu_helper_get_phys_addr_code(uint32_t tl, int mmu_idx, uint64_t prim_context, u
>>  mmu_helper_get_phys_addr_data(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=%"PRIx64" secondary context=%"PRIx64" address=%"PRIx64
>>  mmu_helper_mmu_fault(uint64_t address, uint64_t paddr, int mmu_idx, uint32_t tl, uint64_t prim_context, uint64_t sec_context) "Translate at %"PRIx64" -> %"PRIx64", mmu_idx=%d tl=%d primary context=%"PRIx64" secondary context=%"PRIx64
>>
>> -# target-sparc/int64_helper.c
>> +# target/sparc/int64_helper.c
>>  int_helper_set_softint(uint32_t softint) "new %08x"
>>  int_helper_clear_softint(uint32_t softint) "new %08x"
>>  int_helper_write_softint(uint32_t softint) "new %08x"
>>
>> -# target-sparc/int32_helper.c
>> +# target/sparc/int32_helper.c
>>  int_helper_icache_freeze(void) "Instruction cache: freeze"
>>  int_helper_dcache_freeze(void) "Data cache: freeze"
>>
>> -# target-sparc/win_helper.c
>> +# target/sparc/win_helper.c
>>  win_helper_gregset_error(uint32_t pstate) "ERROR in get_gregset: active pstate bits=%x"
>>  win_helper_switch_pstate(uint32_t pstate_regs, uint32_t new_pstate_regs) "change_pstate: switching regs old=%x new=%x"
>>  win_helper_no_switch_pstate(uint32_t new_pstate_regs) "change_pstate: regs new=%x (unchanged)"
>> diff --git a/target-sparc/translate.c b/target/sparc/translate.c
>> similarity index 100%
>> rename from target-sparc/translate.c
>> rename to target/sparc/translate.c
>> diff --git a/target-sparc/vis_helper.c b/target/sparc/vis_helper.c
>> similarity index 100%
>> rename from target-sparc/vis_helper.c
>> rename to target/sparc/vis_helper.c
>> diff --git a/target-sparc/win_helper.c b/target/sparc/win_helper.c
>> similarity index 100%
>> rename from target-sparc/win_helper.c
>> rename to target/sparc/win_helper.c
>> --
>> 1.8.3.1
>>
>
>
>
> --
> Regards,
> Artyom Tarasenko
>
> SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
