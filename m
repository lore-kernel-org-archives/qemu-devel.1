Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C752C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1891206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1891206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip6kj-0006u5-6S
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 03:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ip6ik-00052a-FB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ip6ij-0002E3-Cd
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:29:42 -0500
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:51634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ip6ij-0002Cj-6d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:29:41 -0500
Received: from player732.ha.ovh.net (unknown [10.109.146.132])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 48EDD1A6546
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 09:29:37 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id BDA23DDA0099;
 Wed,  8 Jan 2020 08:29:28 +0000 (UTC)
Subject: Re: [PATCH v2 09/10] target/ppc: Correct RMLS table
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-10-david@gibson.dropbear.id.au>
 <b4f4b0f9-759d-637d-9b40-d0fd3c0c21f6@kaod.org>
 <20200108010604.GI2137@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cd7393dd-01c5-4d1f-c140-2be14aa60708@kaod.org>
Date: Wed, 8 Jan 2020 09:29:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108010604.GI2137@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 10588244199030491942
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehjedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.162.229
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, paulus@samba.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 2:06 AM, David Gibson wrote:
> On Tue, Jan 07, 2020 at 03:21:42PM +0100, C=E9dric Le Goater wrote:
>> On 1/7/20 5:48 AM, David Gibson wrote:
>>> The table of RMA limits based on the LPCR[RMLS] field is slightly wro=
ng.
>>> We're missing the RMLS =3D=3D 0 =3D> 256 GiB RMA option, which is ava=
ilable on
>>> POWER8, so add that.
>>
>> Where is this defined ?
>=20
> It's in the Book4, so not easily available, unfortunately :(.

Ah yes. I always forget to check that one.

C.
=20

>>> The comment that goes with the table is much more wrong.  We *don't* =
filter
>>> invalid RMLS values when writing the LPCR, and there's not really a
>>> sensible way to do so.  Furthermore, while in theory the set of RMLS =
values
>>> is implementation dependent, it seems in practice the same set has be=
en
>>> available since around POWER4+ up until POWER8, the last model which
>>> supports RMLS at all.  So, correct that as well.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  target/ppc/mmu-hash64.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
>>> index bb9ebeaf48..e6f24be93e 100644
>>> --- a/target/ppc/mmu-hash64.c
>>> +++ b/target/ppc/mmu-hash64.c
>>> @@ -760,12 +760,12 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
>>>  {
>>>      CPUPPCState *env =3D &cpu->env;
>>>      /*
>>> -     * This is the full 4 bits encoding of POWER8. Previous
>>> -     * CPUs only support a subset of these but the filtering
>>> -     * is done when writing LPCR
>>> +     * In theory the meanings of RMLS values are implementation
>>> +     * dependent.  In practice, this seems to have been the set from
>>> +     * POWER4+..POWER8, and RMLS is no longer supported in POWER9.
>>>       */
>>>      const target_ulong rma_sizes[] =3D {
>>> -        [0] =3D 0,
>>> +        [0] =3D 256 * GiB,
>>>          [1] =3D 16 * GiB,
>>>          [2] =3D 1 * GiB,
>>>          [3] =3D 64 * MiB,
>>>
>>
>=20


