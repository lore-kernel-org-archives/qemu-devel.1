Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C74DC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6268A24125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6268A24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itnUq-0005YE-Gd
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 01:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1itnTq-0004ab-Ly
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1itnTp-0007oK-D8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:57:42 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:55775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1itnTp-0007nA-6I
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:57:41 -0500
Received: from player698.ha.ovh.net (unknown [10.108.35.215])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id DE4641C0485
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:57:38 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 38BC1E693F9C;
 Tue, 21 Jan 2020 06:57:32 +0000 (UTC)
Subject: Re: [PATCH] spapr: Migrate CAS reboot flag
To: David Gibson <david@gibson.dropbear.id.au>
References: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
 <6fb96fed-9590-aa7c-cf00-038ab776ccb5@kaod.org>
 <20200121034126.GB265522@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4997924c-305b-c3dd-b3ae-582119867ec3@kaod.org>
Date: Tue, 21 Jan 2020 07:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121034126.GB265522@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11592828394674948947
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudejgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
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
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 4:41 AM, David Gibson wrote:
> On Wed, Jan 15, 2020 at 07:10:47PM +0100, C=C3=A9dric Le Goater wrote:
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
>> Nice work ! That was quite complex to catch !
>=20
> It is a very nice analysis.  However, I'm disinclined to merge this
> for the time being.
>=20
> My preferred approach would be to just eliminate CAS reboots
> altogether, since that has other benefits.  I'm feeling like this
> isn't super-urgent, since CAS reboots are extremely rare in practice,
> now that we've eliminated the one for the irq switchover.

Yes. The possibility of a migration in the window between CAS and=20
CAS reboot must be even more rare.

C.

=20
> However, if it's not looking like we'll be ready to do that as the
> qemu-5.0 release approaches, then I'll be more than willing to
> reconsider this.




