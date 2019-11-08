Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F2EFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71262178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYFbWGdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71262178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1RB-0005nu-IZ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iT1LS-0007BJ-Nn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iT1LR-0005Rl-K9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:18:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iT1LR-0005RV-Go
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573208301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFFCMFb69xArsIJgd6BH01swnt9YNo2N3r/jDMc3QbI=;
 b=AYFbWGdDLYwna8v9ExwmGDwD7fc+krN9q3ENwsZwYa+/UqAKKJc6flC4KA0sAbkK3wol4y
 kI4rrvXCVaaDFq2oqwLToVBAqoGKYGKTymsIpYEat26A6oNY1veFduPa3FV0UdoLXKvXxb
 dvlf5lJ1BAbLAu7T8eG62vgZ0xO6ccA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-1DZh-D_5NgWEmIyOvltyvQ-1; Fri, 08 Nov 2019 05:18:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A46A477;
 Fri,  8 Nov 2019 10:18:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F98E272A3;
 Fri,  8 Nov 2019 10:18:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7875C11AAA; Fri,  8 Nov 2019 11:18:15 +0100 (CET)
Date: Fri, 8 Nov 2019 11:18:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] Seabios 20191106 patches
Message-ID: <20191108101815.mmk53hibwxdmajrv@sirius.home.kraxel.org>
References: <20191106122524.5537-1-kraxel@redhat.com>
 <CAFEAcA8uHQUvWm2H_=Y46qtdpNLBtcYRHWsvvWf+CyjYdFdLag@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8uHQUvWm2H_=Y46qtdpNLBtcYRHWsvvWf+CyjYdFdLag@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1DZh-D_5NgWEmIyOvltyvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: seabios@seabios.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 11:56:03AM +0000, Peter Maydell wrote:
> On Wed, 6 Nov 2019 at 12:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > The following changes since commit 36609b4fa36f0ac934874371874416f7533a=
5408:
> >
> >   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4=
.2-sf1' into staging (2019-11-02 17:59:03 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kraxel.org/qemu tags/seabios-20191106-pull-request
> >
> > for you to fetch changes up to 58b16e57ded751e2e8be626124aad1d46a408a33=
:
> >
> >   seabios: update to pre-1.13 snapshot (2019-11-06 13:23:02 +0100)
> >
> > ----------------------------------------------------------------
> > seabios: update to pre-1.13 snapshot
> >
> > ----------------------------------------------------------------
> >
> > Gerd Hoffmann (1):
> >   seabios: update to pre-1.13 snapshot
>=20
> Hi; this fails 'make check' on at least
> aarch64, aarch32, FreeBSD, NetBSD, s390:
>=20
> ERROR:/home/linux1/qemu/tests/boot-sector.c:161:boot_sector_test:
> assertion failed (signature =3D=3D SIGNATURE): (0x00000000 =3D=3D 0x0000d=
ead)
> ERROR - Bail out!
> ERROR:/home/linux1/qemu/tests/boot-sector.c:161:boot_sector_test:
> assertion failed (signature =3D=3D SIGNATURE): (0x00000000 =3D=3D 0x0000d=
ead)
> PASS 9 bios-tables-test /x86_64/acpi/q35/bridge
> Aborted (core dumped)
> /home/linux1/qemu/tests/Makefile.include:916: recipe for target
> 'check-qtest-i386' failed
> make: *** [check-qtest-i386] Error 1
>=20
> the x86-64 bootsector tests seem to fail similarly.

[ full quote for seabios list ]

Re-ran test on x86-64 box -> works.
Tried on aarch64 machine -> fails.

Given the arch list above this pretty much looks like it is tcg-related,
even though a quick check with "qemu -accel tcg -cdrom /some/live/iso"
(on x86_64) doesn't show any obvious problems.

Recompiled seabios with gcc 4.8 instead of gcc 8
  -> Works on both x86-64 and aarch64.
  -> I'll redo the pull request with that.

I'll go try find the root cause next week.  On a quick glance this
looks like a bug in tcg or gcc.  In case anyone has hints what might
have caused this drop me a note.

thanks,
  Gerd


