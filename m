Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268DC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086E820865
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 17:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086E820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG5JF-0002iY-Ub
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 13:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iG5I8-00021p-1H
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iG5I6-0001l9-J2
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:53:27 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:37078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iG5I6-0001kK-Cx
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 13:53:26 -0400
Received: from player731.ha.ovh.net (unknown [10.109.146.168])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 9886711B818
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 19:53:23 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id D179CA5D8184;
 Thu,  3 Oct 2019 17:53:17 +0000 (UTC)
Subject: Re: [PATCH 4/4] xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-5-david@gibson.dropbear.id.au>
 <9636ac3a-f0db-7fb8-cb5d-a4a2b83479b5@kaod.org>
 <20190924114124.GC17405@umbus>
 <5dca1aae-65d9-c972-e8a8-9d5b8f016c75@kaod.org>
 <20190925014653.GK17405@umbus>
 <13b43747-1082-c803-a998-5b3d49418dc3@kaod.org>
Message-ID: <822e270e-482e-a32a-6479-93e3c3bb92ce@kaod.org>
Date: Thu, 3 Oct 2019 19:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <13b43747-1082-c803-a998-5b3d49418dc3@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 3860429308508343075
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.148
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, gkurz@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/2019 08:04, C=E9dric Le Goater wrote:
> On 25/09/2019 03:46, David Gibson wrote:
>> On Tue, Sep 24, 2019 at 04:06:02PM +0200, C=E9dric Le Goater wrote:
>>> On 24/09/2019 13:41, David Gibson wrote:
>>>> On Tue, Sep 24, 2019 at 07:31:44AM +0200, C=E9dric Le Goater wrote:
>>>>> On 24/09/2019 06:59, David Gibson wrote:
>>>>>> TYPE_ICS_SIMPLE is the only subtype of TYPE_ICS_BASE that's ever
>>>>>> instantiated, and the only one we're ever likely to want.  The
>>>>>> existence of different classes is just a hang over from when we
>>>>>> (misguidedly) had separate subtypes for the KVM and non-KVM versio=
n of
>>>>>> the device.
>>>>>>
>>>>>> So, collapse the two classes together into just TYPE_ICS.
>>>>>
>>>>>
>>>>> Well, I have been maintaining another subclass for the PHB3 MSI=20
>>>>> but it has never been merged and it will require some rework.
>>>>
>>>> Well, if you did do this again, is there an actual need for it to be=
 a
>>>> subclass of ICS_BASE, and not ICS_SIMPLE?  AFAICT the merged ICS cla=
ss
>>>> should be fine for pnv as well.
>>>
>>> the reject resend handlers might be an issue. Anyhow, let's merge thi=
s=20
>>> cleanup. PHB3 has been out of tree for too long.
>>
>> Hrm, are you sure.  I remember thinking the other day "whatever
>> happened to that PHB3 patchset?".  Is it actually broken,
>=20
> It is not broken.=20
>=20
> PowerNV machines can boot rather complex PCI layouts on P8 (XICS)=20
> and P9 (XIVE). See the complex configuration examples here :
>=20
>   https://github.com/legoater/qemu/wiki/PowerNV
>=20
>> or has it just been a long time since it was posted, and therefore=20
>> been forgotten by me.
>=20
> It hasn't been posted in a long time (+1 year). Here are the latest
> exchanges we had in November:=20
>=20
>   http://patchwork.ozlabs.org/patch/951227/
>=20
> Nothing really worrying :=20
>=20
>   - some XICS infrastructure are needed (currently being removed)
>   - check if we need a separate source model for the MSI/LSI=20
>   - rework the PBCQ modeling to some extent.
>   - misc cleanups.
>=20
> I have been quite busy this last year. I would appreciate if someone=20
> could take ownership of the PHB part.=20


Recent XICS changes have made support of PHB3 complex and I don't have=20
time to keep it alive anymore.

I am dropping the patch from my tree. In case someone wants to take=20
over, it's here :=20

    https://github.com/legoater/qemu/commits/powernv-4.2-p8

Focus is on P9 and P10 now.

Cheers,

C.

