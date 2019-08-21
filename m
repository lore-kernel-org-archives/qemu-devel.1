Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81306C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572CA206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572CA206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0R9w-0003Aw-Fi
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0R9G-0002ii-91
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0R9E-0002p1-4w
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i0R9D-0002oZ-Vz
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:59:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75112307D90D;
 Wed, 21 Aug 2019 13:59:34 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71FB960600;
 Wed, 21 Aug 2019 13:59:33 +0000 (UTC)
Message-ID: <51d9225a35fa87339a2045029a05f4dda8bfb837.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, Bug 1819289
 <1819289@bugs.launchpad.net>
Date: Wed, 21 Aug 2019 16:59:32 +0300
In-Reply-To: <CAL1e-=gp6ZEP8GeseG9hPJbP7=ma4+GkV7RLrV8ttqQvnUQJxA@mail.gmail.com>
References: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
 <156633742863.16769.2783105280357246181.malone@wampee.canonical.com>
 <CAL1e-=gp6ZEP8GeseG9hPJbP7=ma4+GkV7RLrV8ttqQvnUQJxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 21 Aug 2019 13:59:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Bug 1819289] Re: Windows 95 and Windows 98 will
 not install or run
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-21 at 00:31 +0200, Aleksandar Markovic wrote:
> 20.08.2019. 23.56, "Brad Parker" <1819289@bugs.launchpad.net> =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >=20
> > So it looks like even though that commit fixed it, it seems to break
> > again (differently) in 3.0.0, so I'll need to do another bisect betwe=
en
> > cfcca36 and v3.0.0 then I guess. And keep working my way up to master=
 as
> > well.
> >=20
> > --
>=20
> At least you will have an interesting debugging story to tell afterward=
s. I
> wish you luck!

Does disabling the boot logo help? I do have a working win98 VM here=20
(nostaligia reasons, that was my first and last primary OS prior to me
switching to Linux) and what you describe seems to be the hang during the
win98 boot logo?

If it is disabled (logo=3D0 in msdos.sys, under [Options])
or if you quickly press escape while the logo just showed up, the vm won'=
t hang,
and work normally.

The funniest thing is that when _KVM_ is disabled (that is TCG is used in=
stead), the bug doesn't happen,
so it might instruction emulation bug in KVM. Or something timing related=
.

I also usually see even a message from the in-kernel instruction decoder =
about
'cmpchg decoded as nop' or something like that, but don't seem to see it =
anymore on current kernel.

I just verified these claims with qemu-4.1.0, kernel 5.3.0-rc4, and an wi=
n98 (although I only booted it with and without logo few times,
and didn't do an install)

Speaking of other issue you will face with win98 is that it doesn't detec=
t the PnP bios by default, so it doesn't see any devices qemu exposes
on the PCI bus. Thankfully this can be fixed by explicitly overriding the=
 driver
http://computernewb.com/wiki/Install_QEMU_Tablet_Driver_on_Windows_98

For other hardware I had luck with pcnet network card, AC97 sound (SB16 w=
orks too but it tends to block mouse during the sound,
probably some PIO/interrupt whatever stuff that is very emulation heavy. =
For AC97 it was really hard to find a working driver,
but eventually I found some Win95 old style driver (not the newer WDM dri=
vers that just don't work).

It was really fun weekend, few months ago when I set the thing up :-)

Best regards,
	Maxim Levitsky


