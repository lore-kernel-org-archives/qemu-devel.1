Received: from eggs.gnu.org ([2001:4830:134:3::10]:52773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBJbW-0002Nk-Ik
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBJbR-0000Ia-JZ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 08:32:58 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-3-lersek@redhat.com>
	<a1cd9e50-9379-1523-c5c8-9b6a29e01491@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dae1e8aa-a767-eb35-0870-cbda1ada76a6@redhat.com>
Date: Wed, 25 Apr 2018 14:32:42 +0200
MIME-Version: 1.0
In-Reply-To: <a1cd9e50-9379-1523-c5c8-9b6a29e01491@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] qapi: handle the riscv CpuInfoArch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-stable@nongnu.org

On 04/25/18 00:32, Eric Blake wrote:
> On 04/24/2018 04:45 PM, Laszlo Ersek wrote:
>> Commit 25fa194b7b11 added the @riscv enum constant to @CpuInfoArch (used
>> in both @CpuInfo and @CpuInfoFast -- the return types of the @query-cpus
>> and @query-cpus-fast commands, respectively), and assigned, in both return
>> structures, the @CpuInfoRISCV sub-structure to the new enum value.
>>
>> However, qmp_query_cpus_fast() would not populate either the @arch field
>> or the @CpuInfoRISCV sub-structure, when TARGET_RISCV was defined; only
>> qmp_query_cpus() would.
>>
>> In theory, there are two ways to fix this:
>>
>> (a) Fill in both the @arch field and the @CpuInfoRISCV sub-structure in
>>     qmp_query_cpus_fast(), by copying the logic from qmp_query_cpus().
>>
>> (b) Assign @CpuInfoOther to the @riscv enum constant in @CpuInfoFast, and
>>     populate only the @arch field in qmp_query_cpus_fast().
>>
>> Approach (b) seems more robust, because:
>>
>> - clearly there has never been an attempt to get actual RISV CPU state
>>   from qmp_query_cpus_fast(), so its lack of RISCV support is not actually
>>   a problem,
>>
>> - getting CPU state without interrupting KVM looks like an exceptional
>>   thing to do (only S390X does it currently).
>>
> ...
>> Cc: qemu-stable@nongnu.org
>> Fixes: 25fa194b7b11901561532e435beb83d046899f7a
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks Eric, I'll fuse your R-b's from #1 and #2 into one R-b for the
squashed variant. Hope that's OK. (Please do check the upcoming commit
message for more garblage.)

Thanks!
Laszlo
