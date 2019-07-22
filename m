Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50337C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE6221901
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE6221901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpczo-00005H-GL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 14:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40509)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hpcze-00082p-EX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hpczd-0001fe-Aj
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:25:02 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:38395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hpczd-0001er-3o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:25:01 -0400
Received: from player799.ha.ovh.net (unknown [10.108.57.245])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 89F2E1FDC8D
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 20:24:59 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 40E1B82D98B3;
 Mon, 22 Jul 2019 18:24:55 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190718054218.9581-1-joel@jms.id.au>
 <20190718061628.GM8468@umbus.fritz.box>
 <215c832d-779c-1597-02af-3a3a52e19f01@kaod.org>
 <20190722083238.GC25073@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <358f8d9e-4de4-5fcf-3d82-4fce9126b7a4@kaod.org>
Date: Mon, 22 Jul 2019 20:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722083238.GC25073@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 18409307905825803072
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrjeeggdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.29
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: update skiboot to v6.4
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
Cc: qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/2019 10:32, David Gibson wrote:
> On Thu, Jul 18, 2019 at 03:03:09PM +0200, C=E9dric Le Goater wrote:
>> On 18/07/2019 08:16, David Gibson wrote:
>>> On Thu, Jul 18, 2019 at 03:12:17PM +0930, Joel Stanley wrote:
>>>> Currently we fail to boot a qemu powernv machine with a Power9
>>>> processor:
>>>>
>>>>  PLAT: Detected generic platform
>>>>  PLAT: Detected BMC platform generic
>>>>  CPU: All 1 processors called in...
>>>>  CHIPTOD: Unknown TOD type !
>>>>  CHIPTOD: Failed ChipTOD detection !
>>>>  Aborting!
>>>>
>>>> With v6.4 we can boot both a Power8 and Power9 powernv machine.
>>>>
>>>> Built from submodule with powerpc64le-linux-gnu-gcc (Debian 8.3.0-2)=
.
>>>>
>>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> Applied to ppc-for-4.2, thanks.
>>>
>>> If you could add both POWER8 and POWER9 smoke tests to
>>> boot-serial-test that would be even better.
>>
>> There is one for POWER8 and adding an extra for POWER9 results
>> in a test conflict. So I came up with the patch below. Would that
>> be OK ?
>=20
> Ugh.  This name mangling is pretty ugly.  It would be neater to extend
> the table format to have cpu explicitly and base the test names on
> that, rather than special casing powernv.
>=20
> But...
>=20
> It occurs to me the reason we're hitting this is that for the other
> systems represented here, the exact cpu model is really just a
> detail.  It's not for us, because the whole system is substantially
> different for the two cpus.
>=20
> Which says to me that tbe POWER8 and POWER9 systems should really be
> different machine types, not lumped together in "powernv" which then
> has a heap of conditionals on the cpu family.  If we do that, the
> problem here goes away.


Yes. I just sent a patch for it.

Thanks,

C.=20

