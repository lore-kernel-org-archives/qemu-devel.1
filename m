Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F7C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CD82080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CD82080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir5qc-0004eW-2B
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 14:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ir5pm-00047h-A7
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ir5pk-0002TE-WF
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:57:10 -0500
Received: from 14.mo1.mail-out.ovh.net ([178.32.97.215]:40185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ir5pk-0002Rr-Q4
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:57:08 -0500
Received: from player690.ha.ovh.net (unknown [10.109.143.209])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 844201A80DA
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 20:57:06 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id 60868E0C300C;
 Mon, 13 Jan 2020 19:57:00 +0000 (UTC)
Date: Mon, 13 Jan 2020 20:56:58 +0100
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v1 12/59] virtfs-proxy-helper.c: remove 'err_out' label
 in setugid()
Message-ID: <20200113205658.11fc5a78@bahia.lan>
In-Reply-To: <c0bb2a92-7361-9ff3-42c2-022906b6dcad@vivier.eu>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-13-danielhb413@gmail.com>
 <20200107105113.7a443d51@bahia.lan>
 <87wo9vxu9n.fsf@dusky.pond.sub.org>
 <c0bb2a92-7361-9ff3-42c2-022906b6dcad@vivier.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14668786937680730584
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejtddguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.97.215
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jan 2020 17:32:31 +0100
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 13/01/2020 =C3=A0 16:15, Markus Armbruster a =C3=A9crit=C2=A0:
> > Greg Kurz <groug@kaod.org> writes:
> >=20
> >> On Mon,  6 Jan 2020 15:23:38 -0300
> >> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> >>
> >>> 'err_out' can be removed and be replaced by 'return -errno'
> >>> in its only instance in the function.
> >>>
> >>> CC: Greg Kurz <groug@kaod.org>
> >>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> >>> ---
> >>
> >> I don't really mind, but I confirm this doesn't change behavior.
> >>
> >> Acked-by: Greg Kurz <groug@kaod.org>
> >>
> >> What's the plan to get this and the other 9p related patches merged ?
> >> Through the trivial tree or each subsystem tree ?
> >=20
> > I guess qemu-trivial will eventually pick up whatever hasn't been merged
> > by maintainers.
> >=20
> > [...]
> >=20
>=20
> Yes, but the difficulty will be to sort which ones of the 59 patches
> series to collect...
>=20

Ok, less work for you then. I've applied both 12/59 and 45/59 to 9p-next.
I'm planning to send a PR later this week.

> Thanks,
> Laurent
>=20

Cheers,

--
Greg

