Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75E42071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75E42071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGhX-0002Rg-0a
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iuGgu-00021e-Ov
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iuGgt-0007Z8-Ip
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:09:08 -0500
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:42267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iuGgt-0007Se-D1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:09:07 -0500
Received: from player763.ha.ovh.net (unknown [10.109.146.131])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 56189268525
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 15:08:58 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id E9F33E7FEFD2;
 Wed, 22 Jan 2020 14:08:50 +0000 (UTC)
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
To: Greg Kurz <groug@kaod.org>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <6fb96fed-9590-aa7c-cf00-038ab776ccb5@kaod.org>
 <20200122134708.21a4cbb5@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <228649c9-caf1-20a6-46d9-e827f38bd7ac@kaod.org>
Date: Wed, 22 Jan 2020 15:08:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200122134708.21a4cbb5@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6303069157060545363
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeifedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.121.55.239
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
Cc: Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 1:47 PM, Greg Kurz wrote:
> On Wed, 15 Jan 2020 19:10:47 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 1/15/20 6:48 PM, Greg Kurz wrote:
>>> Migration can potentially race with CAS reboot. If the migration thre=
ad
>>> completes migration after CAS has set spapr->cas_reboot but before th=
e
>>> mainloop could pick up the reset request and reset the machine, the
>>> guest is migrated unrebooted and the destination doesn't reboot it
>>> either because it isn't aware a CAS reboot was needed (eg, because a
>>> device was added before CAS). This likely result in a broken or hung
>>> guest.
>>>
>>> Even if it is small, the window between CAS and CAS reboot is enough =
to
>>> re-qualify spapr->cas_reboot as state that we should migrate. Add a n=
ew
>>> subsection for that and always send it when a CAS reboot is pending.
>>> This may cause migration to older QEMUs to fail but it is still bette=
r
>>> than end up with a broken guest.
>>>
>>> The destination cannot honour the CAS reboot request from a post load
>>> handler because this must be done after the guest is fully restored.
>>> It is thus done from a VM change state handler.
>>>
>>> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>
>> C=C3=A9dric Le Goater <clg@kaod.org>
>>
>=20
> I guess you mean:
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Yes.

   Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Since keyconfig was disabled in thunderbird, I have been adding
tags manually ...

C.=20

