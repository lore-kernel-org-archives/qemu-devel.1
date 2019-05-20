Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B7BC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D518E2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D518E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hScOq-0006Pr-3V
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 03:07:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hScNz-000639-D6
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hScNy-00060S-26
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:07:03 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:47843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hScNx-0005yT-GH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:07:01 -0400
Received: from player696.ha.ovh.net (unknown [10.109.159.7])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9CF7419A72D
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:06:58 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player696.ha.ovh.net (Postfix) with ESMTPSA id 72169601F086;
	Mon, 20 May 2019 07:06:52 +0000 (UTC)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190513084245.25755-2-clg@kaod.org>
	<20190520062552.389-1-clg@kaod.org>
	<20190520090312.780ab6e4.cohuck@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <19c54540-d1f2-24a1-f66a-51d1ca5552ad@kaod.org>
Date: Mon, 20 May 2019 09:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520090312.780ab6e4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5913789262947716070
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.75
Subject: Re: [Qemu-devel] [PATCH] linux-headers: Update linux headers to
 5.2-rc1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 9:03 AM, Cornelia Huck wrote:
> On Mon, 20 May 2019 08:25:52 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Update the QEMU copy of the Linux headers to upstream 5.2-rc1 (linux
>> commit a188339ca5a3).
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> FWIW, I have a headers update queued in my s390-next branch as well,
> and I plan to send a pull req soonish.

That's perfect.=20

I have sent a patchset to David and the KVM definitions are the gating=20
factor. If your PR goes first, we can drop the first patch of my series.=20

Thanks,

C.



