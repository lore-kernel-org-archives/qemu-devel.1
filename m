Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C650CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 18:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC05A21925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 18:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="VVIsko+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC05A21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=startmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLtq4-000130-3Q
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 14:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hanetzer@startmail.com>) id 1iLtpB-0000Sx-2k
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 14:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hanetzer@startmail.com>) id 1iLtp9-0007Sz-U0
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 14:51:36 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:41604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hanetzer@startmail.com>)
 id 1iLtp9-0007Rg-N4; Sat, 19 Oct 2019 14:51:35 -0400
Date: Sat, 19 Oct 2019 13:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2017-11; t=1571511093;
 bh=Gl5j5LRTfp0jAe8emUAtJiAA1572oRRSEPGnl8r9oWo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VVIsko+1d6br60B2jM8LO+kp0QlQ2zkMTQ6co25kV5xQyicGUXuF6R5srpHi8p4vJ
 EEI2xYy5VnSakP3/Pe0PKULxk0PD7vzWbuHO49sM+14zx5HgdpiF9aikAgtGXYxpJm
 xSCblQYlTXormwnSiisBv2dJwT9SxkvHskw5e8UmV8uLptN9bEv2JnYnTTjwl9da+W
 DuCGzVk7v4GJhj1OsU36731EhXMXjSTflw4Mi/JMtDON1szsypCK9IaQbLHU5/wBXi
 GhfboyMsop16YYfZd1I4ISZwWpcYk0PFsAcmgzDMETuuXaIrjAnqhhqDytdj2JPOEu
 XXW1Ah+9cwsJA==
From: "Marty E. Plummer" <hanetzer@startmail.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191019185128.g7pea3thtp3enhfi@proprietary-killer>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 145.131.90.155
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

On Sat, Oct 19, 2019 at 05:53:12PM +0200, C=E9dric Le Goater wrote:
> On 19/10/2019 17:31, Marty E. Plummer wrote:
> > On Sat, Oct 19, 2019 at 03:46:59PM +0200, C=E9dric Le Goater wrote:
> >> On 18/10/2019 19:28, Marty E. Plummer wrote:
> >>> Hello,
> >>>
> >>> First off, thank you for the work you've done on the ppc64 support,=
 it
> >>> has been very useful. I'm currently working on a coreboot port for =
the
> >>> talos ii line of systems (which means more ppc64 support, support
> >>> specifically for the power9 sforza chip, and specific mainboard sup=
port.
> >>> My plate is very full lol) and have been using qemu to debug the
> >>> bootblock.
> >>>
> >>> It has been very useful for that, but I'm now at the point where I =
need
> >>> to jump to romstage, and that's where it gets tricky. qemu parses t=
he rom
> >>> image and looks for a ffs header, locates skiboot on it, and jumps =
straight
> >>> to that. Not exactly ideal for debugging something not produced fro=
m op-build.
> >>
> >> yes. I suppose you are using my branch powernv-4.2 which adds PNOR s=
upport
> >> and a way to boot directly from PNOR. In that case, QEMU parses the =
PNOR
> >> file to extract the PAYLOAD partition (skiboot). skiboot also detect=
s the
> >> flash and extract the kernel and initramfs from the PNOR.
> >>
> >> However, you can bypass all this internal boot process by simply pas=
sing
> >> a -bios option and not passing a MTD device.
> >>
> > Doing so gives me the following error:
> > qemu-system-ppc64: Could not load OPAL firmware 'build/coreboot.rom'
> > (this is after I patched the 4mb size limit up)
>=20
> Could you make that rom available ?=20
>=20
Sent it, but the ml kicked back a 'hey, that's not a normal text file'
error, could you confirm if you personally got it?
> Thanks,
>=20
> C.=20

