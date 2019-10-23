Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC75CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201C1205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="hGVMmlx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201C1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=startmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNP8m-0004A4-8F
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hanetzer@startmail.com>) id 1iNONu-00037g-Ds
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hanetzer@startmail.com>) id 1iNONt-0005zu-8L
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:41:38 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:58771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hanetzer@startmail.com>)
 id 1iNONs-0005yu-Ul; Wed, 23 Oct 2019 17:41:37 -0400
Date: Wed, 23 Oct 2019 16:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2017-11; t=1571866894;
 bh=NVu410Rqm8Y1Z0YO84XtRCHbnckbehg1us4Kq4Q4FJA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hGVMmlx/9hHRPg5y4CGX9MOj+tVPjOo/fDBYzf6Pv7yBoO+G9XHIG6hlw3PI2zJVa
 UHATnnqWdo0Sp2JvTVEE66oT3Kf79sPw+RR9dvK6nFT+AmO+sPZkZFhSh1p+HRsoU/
 yMSO1QeNzbIlc1z54EFon/qHmB8LyZphp6s7cEH/on18kn5D5PlyZU5J98yppqbS/i
 JzaI6XaL+vCWWl/n5xDLZLPaaGZ3ClQVGDotSePmZFL/1TUHZ4j/ti/Xa0gTIdAFC5
 u7+eQzFtAoCxTKMmGVpP+YGUMHmBXw3XayvVWjsC45Jq2Il0NEBSUpUNsCP0ZvVb5R
 oQQOeU13+ZTGA==
From: "Marty E. Plummer" <hanetzer@startmail.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191023214126.gguy63n32wd5xtrp@proprietary-killer>
References: <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
 <20191020062842.GI1960@umbus.fritz.box>
 <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
 <20191021053439.GA6439@umbus.fritz.box>
 <f196a1a6-fcbf-f409-e7e7-95b42135c0be@kaod.org>
 <20191022003209.6ssq2ojiv57ixeyd@proprietary-killer>
 <cfc2186f-52e2-53e8-bc3a-9511428542d0@kaod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <cfc2186f-52e2-53e8-bc3a-9511428542d0@kaod.org>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 145.131.90.139
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 22, 2019 at 09:58:10AM +0200, C=E9dric Le Goater wrote:
> On 22/10/2019 02:32, Marty E. Plummer wrote:
> > On Mon, Oct 21, 2019 at 02:46:59PM +0200, C=E9dric Le Goater wrote:
> >> On 21/10/2019 07:34, David Gibson wrote:
> >>> On Sun, Oct 20, 2019 at 08:51:47AM +0200, C=E9dric Le Goater wrote:
> >>>> On 20/10/2019 08:28, David Gibson wrote:
> >>>>>
> >>>>> Ok.  Note that the qemu emulated machine doesn't model the hardwa=
re
> >>>>> right down to the level of hostboot.  That's wy we're just loadin=
g
> >>>>> skiboot and jumping straight into it usually.  I guess clg's stuf=
f to
> >>>>> load pnor images gets us a little closer to the hardware behaviou=
r,
> >>>>> but I think it's still only a rough approximation.
> >>>>
> > On that note, is qemu-ppc64 currently capable of running LE firmware?=
 My
> > coreboot port has currently reached a hitch in that part of the firmw=
are
> > headers mapping stuff out is saved in LE mode while the cpu (real or =
emu)
> > is running in BE mode (FMAP headers are saved LE but CBFS headers are
> > saved BE)
> >>>> It's really tied to the OpenPOWER firmwares using the HIOMAP proto=
col
> >>>> to discuss with the BMC and load the flash. We could loosen how QE=
MU=20
> >>>> interprets the MTD device and use a property to inform QEMU that t=
his
> >>>> is an OpenPOWER  PNOR file and that skiboot and can be loaded from=
 it.
> >>>> Something to discuss.
> >>>
> >>> Right.  I'm guessing one significant issue here is that to fully mo=
del
> >>> the BMC, with *its* firmware and comms channels with the main host
> >>> would be quite a lot of work, hence cheating a bit to bypass that.
> >>
> >> In fact, we are not cheating that much. We use the IPMI BT interface=
 of=20
> >> QEMU to handle the HIOMAP communication with the BMC and this model =
is=20
> >> quite precise.=20
> >>
> >> The mapping of the PNOR is simply mapped on the LPC FW address space=
.=20
> >> The underlying access are simplified because we don't have a LPC mod=
el
> >> but we could generate all the SPI transaction using the Aspeed model=
s.=20
> >> I had experiments in that sense for P8.=20
> >>
> > Honestly getting the coreboot.rom into the lpc fw addr space in the s=
ame
> > way you do pnor images would be a useful sim, as that's more or less =
how
> > its going to be done on existing hardware.
>=20
> That is covered by patch 'ppc/pnv: Add HIOMAP commands' in the series
> I sent.
>=20
Unless I'm mistaken I have that patch in my build (I assume you pulled
that right from your git branch powernv-4.2, which is what I built from)
and that it would still parse and look for the skiboot partition, and
run it. I need something akin to 'hey, shove this at the addr space and
start executing $bios (where bios is either the bottom of the flash in
that addr space or a provided -bios file on the command line).

The final intent after the first 'conversion' flash is that the coreboot
bootblock will reside in the seeprom, akin to current hostboot bootloader=
,
and then pull romstage from the flash over lpc into cache, then after
romstage initializes memory pull ramstage into from the flash over lpc
into ram and start executing that.
> C.=20

