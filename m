Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEBAC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DAB12078E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAB12078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJu7n-0005Ve-OC
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 03:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jJu7F-00055E-4F
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jJu7E-0001p6-2b
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:18:17 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:37347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jJu7D-0001oW-TG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:18:16 -0400
Received: from player763.ha.ovh.net (unknown [10.110.171.212])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id C078415D738
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 09:18:13 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id E937E1105D5F3;
 Thu,  2 Apr 2020 07:18:09 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Introduce common PNV_SETFIELD() and
 PNV_GETFIELD() macros
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200401152633.1375-1-clg@kaod.org>
 <20200402003118.GJ47772@umbus.fritz.box>
 <b7663796-c9ad-c91e-104a-dcf78e467607@kaod.org>
 <20200402065027.GM47772@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d58b2e61-8245-ecbb-6f0a-31b2ea64835f@kaod.org>
Date: Thu, 2 Apr 2020 09:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402065027.GM47772@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 10499298108296760128
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejieefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.167
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 8:50 AM, David Gibson wrote:
> On Thu, Apr 02, 2020 at 08:41:24AM +0200, C=E9dric Le Goater wrote:
>> On 4/2/20 2:31 AM, David Gibson wrote:
>>> On Wed, Apr 01, 2020 at 05:26:33PM +0200, C=E9dric Le Goater wrote:
>>>> Most of QEMU definitions of the register fields of the PowerNV machi=
ne
>>>> come from skiboot and the models duplicate a set of macros for this
>>>> purpose. Make them common under the pnv_utils.h file.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Hrm.  If we're touching these, would it make sense to rewrite them in
>>> terms of the cross-qemu generic extract64() and deposit64()?
>>
>> I won't do that because we will loose compatibility with skiboot.
>=20
> Uh.. how so?

What would be very nice is to use the QEMU FIELD() from "hw/registerfield=
s.h".

But that's a complete different approach from what skiboot does and it wo=
uld
mean rewriting all the register definitions we include in QEMU for the po=
wernv=20
models and the code using the fields. It is a major change and I would ra=
ther=20
have the same files on both side (without tabs on the QEMU side). I think
it is safer.

Using extract64() and deposit64() raises the same kind of problem AFAICT.=
=20
If we find a clean way to keep the register definition files the same, I =
am
OK with any changes.

C.

