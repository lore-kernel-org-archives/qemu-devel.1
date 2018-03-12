Received: from eggs.gnu.org ([2001:4830:134:3::10]:43813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1evSG1-0006Al-Ga
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1evSFy-0004JV-4Z
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:33:13 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:54161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1evSFx-0004Ip-Ue
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:33:10 -0400
Received: from player746.ha.ovh.net (unknown [10.109.108.103])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4C3DBA244F
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 19:33:08 +0100 (CET)
References: <20180216084504.24958-1-clg@kaod.org>
	<20180216084504.24958-3-clg@kaod.org>
	<20180219003326.GD1109@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1ebf8cbd-f807-fb38-88bc-ab5597f0256a@kaod.org>
Date: Mon, 12 Mar 2018 19:33:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180219003326.GD1109@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] target/ppc: add hash MMU support on
 POWER9 for PowerNV only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

>>  
>> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env = &cpu->env;
>> +
>> +    if (env->mmu_model & POWERPC_MMU_V3) {
>> +        if (msr_hv) {
>> +            return ppc64_v3_get_patbe0(cpu);
> 
> This is the only caller, I think you might as well just open-code the
> load here.

It is used in patch 3/3.

Thanks,

C.
