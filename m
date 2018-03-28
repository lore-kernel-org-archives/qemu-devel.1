Received: from eggs.gnu.org ([2001:4830:134:3::10]:41014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f18BS-0005gY-1g
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f18BO-0000Ej-Ma
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:19:57 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:45854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f18BO-0000DE-GX
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:19:54 -0400
Received: from player688.ha.ovh.net (unknown [10.109.122.88])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id A2B5BB65CD
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 12:19:45 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-12-david@gibson.dropbear.id.au>
	<f3c7bb1c-f4b9-3ffe-aeeb-bcedba620283@kaod.org>
	<05dd7870-11ba-7be8-ce45-6c9aba653226@kaod.org>
	<20180328084720.GI3510@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1e220d03-11cf-2c8d-d3ba-b816741fa4e3@kaod.org>
Date: Wed, 28 Mar 2018 12:19:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180328084720.GI3510@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, groug@kaod.org, agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com

On 03/28/2018 10:47 AM, David Gibson wrote:
> On Wed, Mar 28, 2018 at 09:49:25AM +0200, C=E9dric Le Goater wrote:
>> On 03/28/2018 09:43 AM, C=E9dric Le Goater wrote:
>>> On 03/27/2018 06:37 AM, David Gibson wrote:
>>>> The only place we test this flag is in conjunction with
>>>> ppc64_use_proc_tbl().  That checks for the LPCR_UPRT bit, which we a=
lready
>>>> ensure can't be set except on a machine with a v3 MMU (i.e. POWER9).
>>>
>>> hmm, ok, but what will I use for the PowerNV hash MMU support then ?=20
>>
>> That will be POWERPC_MMU_3_00.
>=20
> You could check for that explicitly, or you could just check for
> presence of non-NULL hash64_opts.  The idea is that will always be the
> case for cpus capable of using the hash MMU.

ok. I will rebase when your patchset is merged.
=20
> I'm also considering adding a similar radix_opts with radix specific
> details. =20

yes. It looks a bit unbalanced now.

> POWER9 would have both, since it can support either mode.
>=20
>> I didn't realize mmu_model was so=20
>> crowded ..
>=20
> It's not so that it's short of space.  It's more that the mix of enum
> like pieces and bitflag like pieces like bits makes it confusing to
> know whether it should be tested with simple equality or with &.  And
> if testing with equality which bits should be masked for a sensible
> comparison.
>=20
> Additionally, I'd like to get options that are strictly related to the
> hash mmu out of the general structures.

which are ? vrma_slb, rmls ?

C.=20
