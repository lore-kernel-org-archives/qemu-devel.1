Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D79EC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544D3216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544D3216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiD1U-0001nj-9n
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59900)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hiC3I-0001nQ-Ks
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hiC3H-0005w8-7b
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:14:04 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:48615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hiC3F-0005oO-88
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:14:02 -0400
Received: from player794.ha.ovh.net (unknown [10.108.54.217])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 716B4102018
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 08:13:50 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id 5CAF87708778;
 Tue,  2 Jul 2019 06:13:37 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
 <20190310082703.1245-58-david@gibson.dropbear.id.au>
 <20190312150115.6zuaid43gr7hklt5@unused>
 <58de43c6-31d5-a0a3-b443-54a33f11d75a@kaod.org>
 <20190312191409.vxnpscrephtk6otv@dhcp-17-165.bos.redhat.com>
 <1746025955.7399905.1552419034356.JavaMail.zimbra@redhat.com>
 <154364d7-fe5b-4f40-b976-b85ff9060ee0@kaod.org>
 <dc6578eb-569b-477e-9a74-2925de8ac204@redhat.com>
 <20190701050426.GI2138@umbus.fritz.box>
 <28cf8405-b049-6874-2cf3-e5f45615714c@redhat.com>
 <20190702001422.GF6779@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <be89dd63-d9ac-0f9c-cbb4-85edc9a65975@kaod.org>
Date: Tue, 2 Jul 2019 08:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702001422.GF6779@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 17734330909179808595
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdejgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.172
Subject: Re: [Qemu-devel] [PULL 57/60] target/ppc: add HV support for POWER9
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
Cc: lvivier@redhat.com, peter maydell <peter.maydell@linaro.org>,
 groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/2019 02:14, David Gibson wrote:
> On Mon, Jul 01, 2019 at 11:45:23AM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
>> On 7/1/19 7:04 AM, David Gibson wrote:
>>> On Fri, Jun 28, 2019 at 03:20:32PM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
>>>> Hi,
>>>>
>>>> On 3/12/19 8:58 PM, C=E9dric Le Goater wrote:
>>>>> On 3/12/19 8:30 PM, Cleber Rosa wrote:
>>>>>>> From: "Cleber Rosa" <crosa@redhat.com>
>>>>>>> Sent: Tuesday, March 12, 2019 3:14:09 PM
>>>>>>> Subject: Re: [Qemu-devel] [PULL 57/60] target/ppc: add HV support=
 for POWER9
>>>>>>>
>>>>>>> On Tue, Mar 12, 2019 at 07:34:04PM +0100, C=E9dric Le Goater wrot=
e:
>>>>>>>> On 3/12/19 4:01 PM, Cleber Rosa wrote:
>>>>>>>>> On Sun, Mar 10, 2019 at 07:27:00PM +1100, David Gibson wrote:
>>>>>>>>>> From: C=E9dric Le Goater <clg@kaod.org>
>>>>>>>>>>
>>>>>>>>>> We now have enough support to boot a PowerNV machine with a PO=
WER9
>>>>>>>>>> processor. Allow HV mode on POWER9.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>>>>>> Message-Id: <20190307223548.20516-16-clg@kaod.org>
>>>>>>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>>>>>>>> ---
>>>>>>>>>>  target/ppc/translate_init.inc.c | 3 ++-
>>>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/target/ppc/translate_init.inc.c
>>>>>>>>>> b/target/ppc/translate_init.inc.c
>>>>>>>>>> index af70a3b78c..0bd555eb19 100644
>>>>>>>>>> --- a/target/ppc/translate_init.inc.c
>>>>>>>>>> +++ b/target/ppc/translate_init.inc.c
>>>>>>>>>> @@ -8895,7 +8895,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, =
void
>>>>>>>>>> *data)
>>>>>>>>>>                         PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE=
_DCBZ |
>>>>>>>>>>                         PPC_MEM_SYNC | PPC_MEM_EIEIO |
>>>>>>>>>>                         PPC_MEM_TLBSYNC |
>>>>>>>>>> -                       PPC_64B | PPC_64BX | PPC_ALTIVEC |
>>>>>>>>>> +                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALT=
IVEC |
>>>>>>>>>>                         PPC_SEGMENT_64B | PPC_SLBI |
>>>>>>>>>>                         PPC_POPCNTB | PPC_POPCNTWD |
>>>>>>>>>>                         PPC_CILDST;
>>>>>>>>>> @@ -8907,6 +8907,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, =
void
>>>>>>>>>> *data)
>>>>>>>>>>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_=
CVT_S64 |
>>>>>>>>>>                          PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
>>>>>>>>>>      pcc->msr_mask =3D (1ull << MSR_SF) |
>>>>>>>>>> +                    (1ull << MSR_SHV) |
>>>>>>>>>>                      (1ull << MSR_TM) |
>>>>>>>>>>                      (1ull << MSR_VR) |
>>>>>>>>>>                      (1ull << MSR_VSX) |
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This change prevents a Fedora 29 kernel[1] from booting... is t=
his
>>>>>>>>> intended or a known limitation of the Fedora 29 kernel?
>>>>>>>>
>>>>>>>> The default CPU is still power8_v2.0. This is curious.
>>>>>>>>
>>>>>>>
>>>>>>> Are you sure?  I'm getting:
>>>>>>>
>>>>>>>  $ git rev-parse HEAD
>>>>>>>  cfc3fef6b4e493bf1a7ee16790ad584e20dfbbd1
>>>>>>>  $ ./ppc64-softmmu/qemu-system-ppc64 -qmp unix:/tmp/qmp-sock,serv=
er
>>>>>>>  $ ./scripts/qmp/qom-get -s /tmp/qmp-sock /machine/unattached/dev=
ice[0].type
>>>>>>>  power9_v2.0-spapr-cpu-core
>>>>>
>>>>> That's a pseries machine, not a powernv machine. pseries should use=
 P9
>>>>> processor by default but the patch above should not impact f29 on p=
series.=20
>>>>> If it does, then we have a bug.=20
>>>>> =20
>>>>>> Looks like the overall default is "power9_v2.0", and then on pseri=
es-3.1 and
>>>>>> lower, it's "power8_v2.0", as per 34a6b015a98.
>>>>>
>>>>> I was looking at pnv_machine_class_init() which sets the default CP=
U :
>>>>>
>>>>>     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>>>>
>>>> I found this thread while trying auto-bisection for LP#1834613:
>>>> https://bugs.launchpad.net/bugs/1834613
>>>>
>>>> When trying the options suggested by Laurent here:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06209.html
>>>>
>>>> this one hangs:
>>>>
>>>> $ qemu-system-ppc64 \
>>>>  -kernel vmlinuz-vanilla \
>>>>  -nographic -append "console=3Dhvc0" \
>>>>  -M cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken
>>>>
>>>> but this one works:
>>>>
>>>> $ qemu-system-ppc64 \
>>>>  -kernel vmlinuz-vanilla \
>>>>  -nographic -append "console=3Dhvc0" \
>>>>  -M pseries-3.1
>>>
>>> Sorry, I missed most of this thread while on holidays.  What's the
>>> actual bug here?
>>
>> I don't think there is a bug, this seems the result of adding a new fe=
ature.
>> The commit message is not obvious that old kernels won't work on the
>> default machine type, and we have to add the extra '-M pseries-3.1'
>> command line option to run such images.
>=20
> Hm, except apparently turning off the Spectre options doesn't change
> that, so I wonder what change in the newer machine type is causing the
> breakage.
>=20

I don't see such an issue on David's ppc-for-4.1 branch.

C.

