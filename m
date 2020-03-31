Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A131C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7A420658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7A420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJB1S-0003RU-1t
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jJB0j-0002xG-9w
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jJB0h-0007Ux-M5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:08:33 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:37211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jJB0h-0007Tz-FL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:08:31 -0400
Received: from player718.ha.ovh.net (unknown [10.108.42.75])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 3B59899430
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 09:08:28 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id B796810DAF7DD;
 Tue, 31 Mar 2020 07:08:23 +0000 (UTC)
Date: Tue, 31 Mar 2020 09:08:22 +0200
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 0/4] spapr: Get rid of CAS reboot flag
Message-ID: <20200331090822.587e7ff2@bahia.lan>
In-Reply-To: <d1a3e718-a0da-51a6-3511-b9dbb1fc6bfe@ozlabs.ru>
References: <158514992409.478799.6718223069768660390.stgit@bahia.lan>
 <20200331004415.GC47772@umbus.fritz.box>
 <d1a3e718-a0da-51a6-3511-b9dbb1fc6bfe@ozlabs.ru>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17035991491367508469
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeiiedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedukedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.150
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 13:59:01 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> 
> 
> On 31/03/2020 11:44, David Gibson wrote:
> > On Wed, Mar 25, 2020 at 04:25:24PM +0100, Greg Kurz wrote:
> >> The CAS reboot flag was introduced in QEMU 2.10 to allow the guest
> >> to be presented a new boot-time device tree after CAS negotiation.
> >> CAS-generated resets rely on qemu_system_reset_request() which has
> >> the particularity of dropping the main loop lock at some point. This
> >> opens a window where migration can happen, hence promotting the CAS
> >> reboot flag to actual state that we should also migrate. In practice,
> >> this can't happen anymore since we have eliminated the scenario of
> >> the XICS/XIVE switch and the much less frequent scenario of device
> >> plug/unplug before CAS.
> >>
> >> We still have much of the CAS reboot bits around though. The full FDT
> >> rendering we do at CAS is enough to get rid of them once and far all.
> >>
> >> Some preliminary cleanup is made before going for the full removal,
> >> for easier reviewing. At some point I had the need to move some code
> >> around in CAS, and Alexey's patch from the "spapr: kill SLOF" (v8)
> >> series proved to be helpful so I've reused it in this patchset.
> >>
> >> This series applies cleanly on both ppc-for-5.0 and ppc-for-5.1.
> >> Since it doesn't fix any actual bug, I think this can be delayed
> >> to 5.1.
> > 
> > Applied to ppc-for-5.1.
> 
> 
> 
> Can you push it out please? The existing ppc-for-5.1 corrupts stack on
> my machine in qemu_init().
> 

Can you provide more details ?

