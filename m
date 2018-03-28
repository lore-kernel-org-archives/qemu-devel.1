Received: from eggs.gnu.org ([2001:4830:134:3::10]:42668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15pz-0004X7-K8
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f15pv-0008Vk-OI
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:49:39 -0400
Received: from 2.mo7.mail-out.ovh.net ([87.98.143.68]:45779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f15pv-0008UD-I3
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 03:49:35 -0400
Received: from player688.ha.ovh.net (unknown [10.109.105.5])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id E231C99464
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:49:33 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-12-david@gibson.dropbear.id.au>
	<f3c7bb1c-f4b9-3ffe-aeeb-bcedba620283@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <05dd7870-11ba-7be8-ce45-6c9aba653226@kaod.org>
Date: Wed, 28 Mar 2018 09:49:25 +0200
MIME-Version: 1.0
In-Reply-To: <f3c7bb1c-f4b9-3ffe-aeeb-bcedba620283@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 11/12] target/ppc: Remove
 unnecessary POWERPC_MMU_V3 flag from mmu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, groug@kaod.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com

On 03/28/2018 09:43 AM, C=C3=A9dric Le Goater wrote:
> On 03/27/2018 06:37 AM, David Gibson wrote:
>> The only place we test this flag is in conjunction with
>> ppc64_use_proc_tbl().  That checks for the LPCR_UPRT bit, which we alr=
eady
>> ensure can't be set except on a machine with a v3 MMU (i.e. POWER9).
>=20
> hmm, ok, but what will I use for the PowerNV hash MMU support then ?=20

That will be POWERPC_MMU_3_00. I didn't realize mmu_model was so=20
crowded ..

C.=20
