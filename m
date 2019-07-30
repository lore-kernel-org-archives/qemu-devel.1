Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E9C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE833206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE833206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsPtJ-0002hQ-4g
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hsPsb-0002BW-6S
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hsPsZ-0003rY-SZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:01:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hsPsZ-0003rE-L0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5802F3003A49;
 Tue, 30 Jul 2019 11:01:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEE3010013A7;
 Tue, 30 Jul 2019 11:01:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F30C1138619; Tue, 30 Jul 2019 13:01:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net>
Date: Tue, 30 Jul 2019 13:01:12 +0200
In-Reply-To: <20190729194414.GG4313@habkost.net> (Eduardo Habkost's message of
 "Mon, 29 Jul 2019 16:44:14 -0300")
Message-ID: <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 30 Jul 2019 11:01:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] When to use qemu/typedefs.h (was: [PATCH 23/28] numa:
 Don't include hw/boards.h into sysemu/numa.h)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing a few more people who might be interested.

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Jul 26, 2019 at 02:05:37PM +0200, Markus Armbruster wrote:
>> sysemu/numa.h includes hw/boards.h just for the CPUArchId typedef, at
>> the cost of pulling in more than two dozen extra headers indirectly.
>> 
>> I could move the typedef from hw/boards.h to qemu/typedefs.h.  But
>> it's used in just two headers: boards.h and numa.h.
>> 
>> I could move it to another header both its users include.
>> exec/cpu-common.h seems to be the least bad fit.
>> 
>> But I'm keeping this simple & stupid: declare the struct tag in
>> numa.h.
>> 
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  exec.c                     | 1 +
>>  hw/core/machine-qmp-cmds.c | 1 +
>>  hw/core/machine.c          | 1 +
>>  hw/mem/pc-dimm.c           | 1 +
>>  include/hw/boards.h        | 2 +-
>>  include/sysemu/numa.h      | 9 +++++++--
>>  6 files changed, 12 insertions(+), 3 deletions(-)
>> 
>> diff --git a/exec.c b/exec.c
>> index 6d60fdfb1f..4d9e146c79 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -41,6 +41,7 @@
>>  #if defined(CONFIG_USER_ONLY)
>>  #include "qemu.h"
>>  #else /* !CONFIG_USER_ONLY */
>> +#include "hw/boards.h"
>>  #include "exec/memory.h"
>>  #include "exec/ioport.h"
>>  #include "sysemu/dma.h"
>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> index c83e8954e1..d8284671f0 100644
>> --- a/hw/core/machine-qmp-cmds.c
>> +++ b/hw/core/machine-qmp-cmds.c
>> @@ -9,6 +9,7 @@
>>  
>>  #include "qemu/osdep.h"
>>  #include "cpu.h"
>> +#include "hw/boards.h"
>>  #include "qapi/error.h"
>>  #include "qapi/qapi-commands-machine.h"
>>  #include "qapi/qmp/qerror.h"
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 2c9c93983a..901f3fa905 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -23,6 +23,7 @@
>>  #include "sysemu/numa.h"
>>  #include "qemu/error-report.h"
>>  #include "sysemu/qtest.h"
>> +#include "hw/boards.h"
>>  #include "hw/pci/pci.h"
>>  #include "hw/mem/nvdimm.h"
>>  
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index 0c83dcd61e..fa90d4fc6c 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -19,6 +19,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "hw/boards.h"
>>  #include "hw/mem/pc-dimm.h"
>>  #include "hw/qdev-properties.h"
>>  #include "migration/vmstate.h"
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 67e551636a..739d109fe1 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -86,7 +86,7 @@ void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type);
>>   * @props - CPU object properties, initialized by board
>>   * #vcpus_count - number of threads provided by @cpu object
>>   */
>> -typedef struct {
>> +typedef struct CPUArchId {
>>      uint64_t arch_id;
>>      int64_t vcpus_count;
>>      CpuInstanceProperties props;
>> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
>> index 01a263eba2..4c4c1dee9b 100644
>> --- a/include/sysemu/numa.h
>> +++ b/include/sysemu/numa.h
>> @@ -4,7 +4,10 @@
>>  #include "qemu/bitmap.h"
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/hostmem.h"
>> -#include "hw/boards.h"
>> +#include "qapi/qapi-types-machine.h"
>
> This seems to be needed because of NodeInfo.

NumaOptions, actually.

>> +#include "exec/cpu-common.h"
>
> This seems to be needed because of ram_addr_t.

Correct.

> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
>
>> +
>> +struct CPUArchId;
>>  
>
> I wonder if we should do the same for other struct types like
> NodeInfo.

NumaOptions, I think.

> Why is it bad to require the inclusion of hw/boards.h just
> because of CPUArchId, but acceptable to require the inclusion of
> qapi-types-machine.h just to be able to write "NodeInfo *nodes"
> instead of "struct NodeInfo *nodes" below?

hw/boards.h is worse.  Both headers pull in qapi/qapi-builtin-types.h
and qapi/qapi-types-common.h, but hw/boards.h pulls in ~60 more.

That doesn't mean including qapi/qapi-types-common.h is good.

For better or worse[*], our coding style mandates typedefs.

We generally declare a typedef name in exactly one place.  The obvious
place is together with the type it denotes.

Non-local users of the type then need to include the header that
declares the typedef name.

This can lead to inclusion cycles, in particular for complete struct and
union types that need more types for their members.

We move typedefs to qemu/typedefs.h to break such cycles.

We also do it to include less, for less frequent recompilation.  As this
series demonstrates, we're not very good at that.  When to put a typedef
in qemu/typedefs.h for this purpose is not obvious.  If we simply put
all of them there, we'd recompile the world every time we add a typedef,
which is pretty much exactly what we're trying to avoid.

Some of qemu/typedefs.h's typedefs are used in dozens or even hundreds
of other headers.  Quite a few only in one.  The latter likely should
not be there.

We occasionally give up and use types directly rather than their typedef
names, flouting the coding style.  This patch does.  Trades messing with
qemu/typedefs.h for having to write 'struct' a few times.

Should we give up more?  Or not at all?

Can we have some guidelines on proper use of qemu/typedefs.h?

>>  extern int nb_numa_nodes;   /* Number of NUMA nodes */
>>  extern bool have_numa_distance;
>> @@ -32,5 +35,7 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>>                                   int nb_nodes, ram_addr_t size);
>>  void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>>                                    int nb_nodes, ram_addr_t size);
>> -void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp);
>> +void numa_cpu_pre_plug(const struct CPUArchId *slot, DeviceState *dev,
>> +                       Error **errp);
>> +
>>  #endif
>> -- 
>> 2.21.0
>> 


[*] Worse if you ask me.

