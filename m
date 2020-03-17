Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98573C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6652220658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6652220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9oW-0000Js-JC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jE9lF-0004B7-Tl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jE9lE-0004A7-Ma
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:47:49 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:45495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jE9lE-0003th-F3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:47:48 -0400
Received: from player168.ha.ovh.net (unknown [10.110.208.62])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1115B1B524E
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 11:47:45 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 01D83107A8D52;
 Tue, 17 Mar 2020 10:47:32 +0000 (UTC)
Subject: Re: [PATCH v2 6/8] target/ppc: allow ppc_cpu_do_system_reset to take
 an alternate vector
To: David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-7-npiggin@gmail.com>
 <85cfff63-88e3-b5a5-75e3-aa29ac13ff60@kaod.org>
 <1584401195.r6knelt82x.astroid@bobo.none>
 <20200316233407.GK20264@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <097148e5-78be-a294-236d-160fb5c29d4a@kaod.org>
Date: Tue, 17 Mar 2020 11:47:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316233407.GK20264@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 12308619259802454848
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefhedgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduieekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.48.29
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 12:34 AM, David Gibson wrote:
> On Tue, Mar 17, 2020 at 09:28:24AM +1000, Nicholas Piggin wrote:
>> C=E9dric Le Goater's on March 17, 2020 4:15 am:
>>> On 3/16/20 3:26 PM, Nicholas Piggin wrote:
>>>> Provide for an alternate delivery location, -1 defaults to the
>>>> architected address.
>>>
>>> I don't know what is the best approach, to override the vector addr
>>> computed by powerpc_excp() or use a machine class handler with=20
>>> cpu->vhyp.
>>
>> Yeah it's getting a bit ad hoc and inconsistent with machine check
>> etc, I just figured get something minimal in there now. The whole
>> exception delivery needs a spring clean though.
>=20
> Yeah, there's a huge amount of cruft in nearly all the softmmu code.

The MMU emulation is not that bad to read. However, the exception model=20
is hideous as one would say. powerpc_excp() is my favorite.=20

> It's such a big task that I don't really have any plans to tackle it
> specifically.  Instead I've been cleaning up little pieces as they
> impinge on things I actually care about.

Maybe we should extract book3s to start with.

C.


