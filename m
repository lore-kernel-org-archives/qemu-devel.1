Received: from eggs.gnu.org ([2001:4830:134:3::10]:45776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAwfN-0007T9-Uw
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAwfJ-0002TF-DU
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:03:25 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:45378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAwfJ-0002SW-5H
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:03:21 -0400
Received: from player774.ha.ovh.net (unknown [10.109.120.69])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 756D311DAB
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 14:03:19 +0200 (CEST)
References: <20180424113045.25687-1-clg@kaod.org>
	<20180424113045.25687-5-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f949a056-23c2-fcfa-d9e0-6a2cb1142051@kaod.org>
Date: Tue, 24 Apr 2018 14:03:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180424113045.25687-5-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/5] target/ppc: add hash MMU support
 for PowerNV POWER9 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env = &cpu->env;
> +
> +    /* We should not reach this routine on sPAPR machines */
> +    assert(!cpu->vhyp);
> +
> +    /* PowerNV machine */
> +    if (msr_hv) {
> +        if (env->mmu_model & POWERPC_MMU_3_00) {
> +            return ppc64_v3_get_patbe0(cpu);
> +        } else {
> +            return cpu->env.spr[SPR_SDR1];
> +        }
> +    } else {
> +        error_report("PowerNV guest support Unimplemented");
> +        exit(1);

I just noticed that this breaks 970 CPUs ...

C.


> +    }
> +}
