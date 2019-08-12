Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF1EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6264320842
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6264320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCMV-0004zO-MR
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45275)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hxCLy-0004XI-PD
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hxCLx-0006Hj-8E
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hxCLx-0006HC-0E
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:35:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F2CB30832DC;
 Mon, 12 Aug 2019 15:35:20 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E7725C1B5;
 Mon, 12 Aug 2019 15:35:11 +0000 (UTC)
Date: Mon, 12 Aug 2019 09:35:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190812093510.1b85cac8@x1.home>
In-Reply-To: <CAFEAcA-3bFuy2DDG8=-_Y3JO4HWpCW80EcsGWWN8toxiMpafBA@mail.gmail.com>
References: <20190812065221.20907-1-kraxel@redhat.com>
 <aec51679-b766-5773-86cb-9ebd06a8cb49@redhat.com>
 <c4b30dfe-83d7-f1e0-d868-82791d56d6b6@redhat.com>
 <CAFEAcA-3bFuy2DDG8=-_Y3JO4HWpCW80EcsGWWN8toxiMpafBA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 12 Aug 2019 15:35:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/1] display/bochs: fix pcie support (qemu
 security issue)
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Prasad J Pandit <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 14:39:53 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 12 Aug 2019 at 13:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
> >
> > On 8/12/19 2:45 PM, Paolo Bonzini wrote: =20
> > > On 12/08/19 08:52, Gerd Hoffmann wrote: =20
> > >> Just found while investigating
> > >>   https://bugzilla.redhat.com/show_bug.cgi?id=3D1707118
> > >>
> > >> Found PCIe extended config space filled with random crap due to
> > >> allocation being too small (conventional pci config space only).
> > >> =20
> >
> > Can you amend this information to the commit description?
> >
> > <...
> > =20
> > >> PCI(e) config space is guest writable.  Writes are limited by
> > >> write mask (which probably is also filled with random stuff), =20
> > >
> > > Yes, it is also allocated with 256 bytes only.
> > > =20
> > >> so the guest can only flip enabled bits.  But I suspect it
> > >> still might be exploitable, so rather serious because it might
> > >> be a host escape for the guest.  On the other hand the device
> > >> is probably not yet in widespread use. =20
> > =20
> > ...> =20
>=20
> I can add to the commit this paragraph of the cover letter,
> and I think also the 'mitigation' note might as well go in.
>=20
> I've also put the cc:stable into the commit message.
>=20
> Updated commit, ready to apply to master if we're OK with it:
>=20
> https://git.linaro.org/people/peter.maydell/qemu-arm.git/commit/?h=3Dstag=
ing&id=3Dc075b5f318a8be628ab8edf93be33f5a93a4aacd

Quoting new commit log:

	This makes sure the pci config space allocation is big enough,
	so accessing the PCIe extended config space doesn't overflow
	the pci config space buffer.

	PCI(e) config space is guest writable.  Writes are limited
	bywrite mask (which probably is also filled with random stuff),
	so the guest can only flip enabled bits.  But I suspect it
	still might be exploitable, so rather serious because it might
	be a host escape for the guest.  On the other hand the device
	is probably not yet in widespread use.

	Mitigation: use "-device bochs-display" as conventional pci
	device only.

Is it clear to others that this mitigation remark seems to be
referencing an alternative configuration constraint to avoid the issue
rather than what's actually implemented in this patch?  IOW, if we
never place the bochs-display device into a PCIe hierarchy, then
extended config space is never accessible to the guest anyway, and
there is no issue.  I think this was meant to be an alternative to the
patch but the enforcement of that would happen above QEMU, probably why
it was mentioned in the cover letter rather than the original commit
log.  Thanks,

Alex

