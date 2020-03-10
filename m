Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297EC18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B2D24673
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7mGDSnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B2D24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaSG-0006zc-39
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBaRO-0005dt-4l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBaRK-0005Ef-8x
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:40:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBaRK-0005DT-2p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eL++fHJNJBn9UkXcjxdTRK6OFnfKTM53Nr9tWjRcnLQ=;
 b=Z7mGDSnlLRgUQCiFZFLoDAN5ndtdhlxs9bwHJ+GDQ7Aa1Carf8SUqJSn4SsSwvdb7844WL
 wHN3DREd1szSHFTic9cHwuKdfwsx41KTLeLCU7kmqmkmQX5yS/9Y7U9sSlq1ovXkGErbHk
 y3L3DCjoNkk1JnoZ2AbI6Do+B6Y1lZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-ObDqhq_9NIuLDs8vSuPFMA-1; Tue, 10 Mar 2020 04:40:33 -0400
X-MC-Unique: ObDqhq_9NIuLDs8vSuPFMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB2411005514;
 Tue, 10 Mar 2020 08:40:32 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFE205D9E2;
 Tue, 10 Mar 2020 08:40:28 +0000 (UTC)
Date: Tue, 10 Mar 2020 09:40:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 00/16] APIC ID fixes for AMD EPYC CPU model
Message-ID: <20200310094027.48738e0e@redhat.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Mar 2020 13:56:51 -0600
Babu Moger <babu.moger@amd.com> wrote:

> This series fixes APIC ID encoding problem reported on AMD EPYC cpu model=
s.
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166
>=20
> Currently, the APIC ID is decoded based on the sequence
> sockets->dies->cores->threads. This works for most standard AMD and other
> vendors' configurations, but this decoding sequence does not follow that =
of
> AMD's APIC ID enumeration strictly. In some cases this can cause CPU topo=
logy
> inconsistency.  When booting a guest VM, the kernel tries to validate the
> topology, and finds it inconsistent with the enumeration of EPYC cpu mode=
ls.
>=20
> To fix the problem we need to build the topology as per the Processor
> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> Processors. The documentation is available from the bugzilla Link below.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>=20
> Here is the text from the PPR.
> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSize=
], the
> number of least significant bits in the Initial APIC ID that indicate cor=
e ID
> within a processor, in constructing per-core CPUID masks.
> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of cor=
es
> (MNC) that the processor could theoretically support, not the actual numb=
er of
> cores that are actually implemented or enabled on the processor, as indic=
ated
> by Core::X86::Cpuid::SizeId[NC].
> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> =E2=80=A2 ApicId[6] =3D Socket ID.
> =E2=80=A2 ApicId[5:4] =3D Node ID.
> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,Lo=
gicalCoreID[1:0]}
>=20
> v5:
>  Generated the patches on top of git://github.com/ehabkost/qemu.git (x86-=
next).
>  Changes from v4.
>  1. Re-arranged the patches 2 and 4 as suggested by Igor.
>  2. Kept the apicid handler functions inside X86MachineState as discussed=
.
>     These handlers are loaded from X86CPUDefinitions.
>  3. Removed unnecessary X86CPUstate initialization from x86_cpu_new. Sugg=
ested
>     by Igor.
>  4. And other minor changes related to patch format.
>=20
> v4:
>  https://lore.kernel.org/qemu-devel/158161767653.48948.105780644828783995=
56.stgit@naples-babu.amd.com/
>  Changes from v3.
>  1. Moved the arch_id calculation inside the function x86_cpus_init. With=
 this change,
>     we dont need to change common numa code.(suggested by Igor)
>  2. Introduced the model specific handlers inside X86CPUDefinitions.
>     These handlers are loaded into X86MachineState during the init.
>  3. Removed llc_id from x86CPU.
>  4. Removed init_apicid_fn hanlder from MachineClass. Kept all the code c=
hanges
>     inside the x86.
>  5. Added new handler function apicid_pkg_offset for pkg_offset calculati=
on.
>  6. And some Other minor changes.
>=20
> v3:
>   https://lore.kernel.org/qemu-devel/157541968844.46157.17994918142533791=
313.stgit@naples-babu.amd.com/=20
>   1. Consolidated the topology information in structure X86CPUTopoInfo.
>   2. Changed the ccx_id to llc_id as commented by upstream.
>   3. Generalized the apic id decoding. It is mostly similar to current ap=
ic id
>      except that it adds new field llc_id when numa configured. Removes a=
ll the
>      hardcoded values.
>   4. Removed the earlier parse_numa split. And moved the numa node initia=
lization
>      inside the numa_complete_configuration. This is bit cleaner as comme=
nted by=20
>      Eduardo.
>   5. Added new function init_apicid_fn inside machine_class structure. Th=
is
>      will be used to update the apic id handler specific to cpu model.
>   6. Updated the cpuid unit tests.
>   7. TODO : Need to figure out how to dynamically update the handlers usi=
ng cpu models.
>      I might some guidance on that.
>=20
> v2:
>   https://lore.kernel.org/qemu-devel/156779689013.21957.16315515729506762=
12.stgit@localhost.localdomain/
>   1. Introduced the new property epyc to enable new epyc mode.
>   2. Separated the epyc mode and non epyc mode function.
>   3. Introduced function pointers in PCMachineState to handle the
>      differences.
>   4. Mildly tested different combinations to make things are working as e=
xpected.
>   5. TODO : Setting the epyc feature bit needs to be worked out. This fea=
ture is
>      supported only on AMD EPYC models. I may need some guidance on that.
>=20
> v1:
>   https://lore.kernel.org/qemu-devel/20190731232032.51786-1-babu.moger@am=
d.com/

There will be soft freeze soon,
if you respin it soon, I'll review it ASAP.
I hope there won't be anything to amend, so
we could try merging it this week (otherwise
it will be postponed till next release).

I guess it should go via Eduardo's tree.

>=20
> ---
>=20
> Babu Moger (16):
>       hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
>       hw/i386: Introduce X86CPUTopoInfo to contain topology info
>       hw/i386: Consolidate topology functions
>       machine: Add SMP Sockets in CpuTopology
>       hw/i386: Remove unnecessary initialization in x86_cpu_new
>       hw/i386: Update structures to save the number of nodes per package
>       hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids
>       hw/386: Add EPYC mode topology decoding functions
>       target/i386: Cleanup and use the EPYC mode topology functions
>       hw/i386: Introduce apicid functions inside X86MachineState
>       target/i386: Load apicid model specific handlers from X86CPUDefinit=
ion
>       hw/i386: Use the apicid handlers from X86MachineState
>       target/i386: Add EPYC model specific handlers
>       hw/i386: Move arch_id decode inside x86_cpus_init
>       i386: Fix pkg_id offset for EPYC cpu models
>       tests: Update the Unit tests
>=20
>=20
>  hw/core/machine.c          |    1=20
>  hw/i386/pc.c               |   54 ++++++-----
>  hw/i386/x86.c              |   72 ++++++++++----
>  include/hw/boards.h        |    2=20
>  include/hw/i386/topology.h |  215 ++++++++++++++++++++++++++++++--------=
----
>  include/hw/i386/x86.h      |   12 ++
>  target/i386/cpu.c          |  224 +++++++++++++++++---------------------=
------
>  target/i386/cpu.h          |    3 +
>  tests/test-x86-cpuid.c     |  115 +++++++++++++----------
>  vl.c                       |    1=20
>  10 files changed, 403 insertions(+), 296 deletions(-)
>=20
> --
> Signature
>=20


