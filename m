Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0937C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 11:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B614C21582
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 11:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B614C21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io3du-0001T7-T4
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 06:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1io3dD-00012g-Ij
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 05:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1io3dB-0001al-Kg
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 05:59:38 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:27099)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1io3dB-0001TJ-ER
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 05:59:37 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 69E22748DCB;
 Sun,  5 Jan 2020 11:59:25 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 442CE748DCA; Sun,  5 Jan 2020 11:59:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 41D437482CA;
 Sun,  5 Jan 2020 11:59:25 +0100 (CET)
Date: Sun, 5 Jan 2020 11:59:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [Qemu-devel] What should a virtual board emulate?
In-Reply-To: <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001051138080.92636@zero.eik.bme.hu>
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
 <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1407236395-1578221965=:92636"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1407236395-1578221965=:92636
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Jan 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> I insist this patch is incorrect for the particular case of the Fuloong=
2e=20
> board. I plan to revert it when I post the test.

I can only repeat my comment from when it last came up:

On Wed, 20 Mar 2019, BALATON Zoltan wrote:
> Thanks, I did not know about this variable. Although the real hardware=20
> has the GPU soldered on the mainboard it makes sense to allow it to be=20
> disabled in QEMU especially at this stage when Linux kernel has some=20
> problem with it so this is a good idea.

I think the option is useful to boot Linux now until we improve rv100=20
emulation enough to work with the Linux DRM driver so either way you'll=20
have a problem: with -vga none not disabling soldered chip you can't boot=
=20
normal Linux CDs without patching them, with -vga none obeyed you can't=20
use PMON. But since PMON is not bundled in QEMU (we don't have the source=
=20
of the actual board firmware, only a binary) it may be less of a problem=20
than Linux install CDs not working. After install you could change Linux=20
to use radeon framebuffer driver which probably works better. (Although=20
I'm not sure if anyone actually tried to do that.)

But I don't really mind either way, go with what you prefer. I only care=20
about the chip emulations used by this board not going away as I plan to=20
use them for pegasos2 emulation but not the fulong board itself apart fro=
m=20
using it for cross checking changes. I know about one problem with the=20
via-ide part that I could reproduce with both:

https://osdn.net/projects/qmiga/ticket/38949

but I'm still not sure it's not missing irq emulation in my Marvel=20
Discovery II emulation that's causing problem on pegasos2.

> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>=20
> When changing it you could also replace the -1 in pci_create with=20
> PCI_DEVFN(FULONG2E_ATI_SLOT, 0) to match the address the board has or=20
> should that be a separate patch?

Looks like this above comment was not considered last time, maybe if you=20
change it now this could be fixed as well.

Regards,
BALATON Zoltan
--3866299591-1407236395-1578221965=:92636--

