Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6FAC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 02:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CA720656
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 02:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjcMQaWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CA720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58189 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGDnG-0006jY-Po
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 22:25:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGDmT-0006Kj-UB
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGDmR-0008AH-SB
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:25:05 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1hGDmR-00089s-EZ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:25:03 -0400
Received: by mail-it1-x142.google.com with SMTP id w15so30166384itc.0
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 19:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=C4WY4+KH/Y32pUCUPCiLn9hS/Qlg5fDihtSALcM/5tY=;
	b=LjcMQaWwOGLYa6jiE+OOmmAMWq+xgLSSuhwM4JUf5nI4TaAILyZY34fJi1v+VTV0s9
	BbAbDwUVL7F5wbPHzSzWKFczeYBcZZtnmrzB9lWlfIDxqEqZCxEP95pO+WBEvfnqHqLo
	bzAvWkIDHMV+0E7G9+RiinOaKMzd5tR/IA5YgMiWaK6QtRqcJJT1qDSOsaxEeuAfzqzO
	W7ORK4CtFNSiMshCPFlFXFjy0JhInku8veCx4nzXRINBWgbdYZJCz1GmZySCYhZjIyij
	X20np6rP75NNMnCzZoYqMqUhB+OXx/KhkbUs68K641te1oekSk/Gxoj7hmXMgZuxjfai
	MpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=C4WY4+KH/Y32pUCUPCiLn9hS/Qlg5fDihtSALcM/5tY=;
	b=YBGSOnN4Z6+qG4NWPJEBqd/aJDVXd5uhtSPABqMVIsy+eEVcMoKVH3G0i+Gc5fRSOB
	sKkMOHMvQnSqJPwv3vB8t3mrqA7PSysykffQQwrb6IShIMAknAUcMBcYu4Nb7En/EHjf
	cq7jnke/47D3JU9Adw2T6dipI1CWNWkjJ1xxdrIrXAf+vXKZPSr4bm1/BNkIQ4jjzzRl
	38jJ4QgQ7nNFKXChgJLaIhLdyYwNFx6RH9lEBDd41EYPwqMPkmHUUWYtcoG6Rn2aDcrk
	EqsXiPb6SsjsH48/POdgHFg9SJ64SQxMuHOcPUeC12vu0lsFWfePJ+VSbdbxIcEGzL4Z
	iTCQ==
X-Gm-Message-State: APjAAAUbcZFj8bniXtIb0fNAAI4hEbF9CosDOavoviRM2ZJT/RH/CywU
	cUEOg6pKUiLW951h1aV8u/Sdv039/IqAhA+UTT8=
X-Google-Smtp-Source: APXvYqwDn3sdxFbCqbjkKGdlJutJqi9r6LYvsorY3AwS3DQDX1gRhFIGyPCkt0xOha7HCrRh+bN8EPqXVnT7iWfuWKM=
X-Received: by 2002:a24:9a86:: with SMTP id
	l128mr26394790ite.126.1555381501407; 
	Mon, 15 Apr 2019 19:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0mwatbu.fsf@dusky.pond.sub.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Apr 2019 19:24:49 -0700
Message-ID:
 <CAHQ1cqEDxNMeAGb5t4OrV9DWpq-VTn4GVhjQh4BePZv=JP8-Ow@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::142
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paul Burton <pburton@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Chubb <peter.chubb@nicta.com.au>,
	Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
	Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	David Hildenbrand <david@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Fabien Chouteau <chouteau@adacore.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Paul Durrant <paul.durrant@citrix.com>, Jan Kiszka <jan.kiszka@web.de>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	Stafford Horne <shorne@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>,
	Thomas Huth <huth@tuxfamily.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416022449.vbAA71Qkrto7-_PfJKSTCwCrlZ2Gzgino5Y21uOLlzs@z>

On Tue, Mar 12, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Dear board code maintainers,
>
> This is a (rather late) follow-up to the last QEMU summit.  Minutes[*]:
>
>  * Deprecating unmaintained features (devices, targets, backends) in QEMU
>
>    QEMU has a mechanism to deprecate features but there remains a lot of
>    old unmaintained code.  Refactoring is hindered by untested legacy
>    code, so there is a desire to deprecate unmaintained features more
>    often.
>
>    [...]
>
>    We should require at least a minimal test for each board; if nobody
>    cares enough to come up with one, that board should be deprecated.
>
>    [...]
>
>    Also see the qemu-devel discussion about deprecating code:
>    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html.
>
> That's a link to "Minutes of KVM Forum BoF on deprecating stuff".
> Quote:
>
>  * One obvious class of candidates for removal is machines we don't know
>    how to boot, or can't boot, say because we lack required firmware
>    and/or OS.
>
>    Of course, "can boot" should be an automated test.  As a first step
>    towards that, we should at least document how to boot each machine.
>    We're going to ask machine maintainers to do that.
>
> Let's get going on this.
>
> I gathered the machine types, mapped them to source files, which I fed
> to get_maintainer.pl.  Results are appended.  If you're cc'ed,
> MAINTAINERS fingers you for at least one machine type's source file.
> Please tell us for all of them how to to a "meaningful" boot test.
>
> For now, what's "meaningful" is entirely up to you.  Booting Linux
> certainly is.
>
> Make sure to include a complete QEMU command line.  If your QEMU command
> line requires resources beyond the QEMU source tree and what we build
> from it, please detail them, and provide download URLs as far as
> possible.
>
> Goals for this exercise:
>
> * Gather information we need to cover more machines in our automated
>   testing.
>
>   Related work:
>   [PATCH v4 00/19] Acceptance Tests: target architecture support
>   Message-Id: <20190312121150.8638-1-crosa@redhat.com>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg03881.html
>
> * Maybe identify a few machines we don't know how to boot anymore.
>
> Thanks in advance for your help!
>
>
>
> Machines with at least one maintainer:
>
>
>     = hw/arm/mcimx7d-sabre.c =
>     Peter Maydell <peter.maydell@linaro.org> (odd fixer:MCIMX7D SABRE / i...)
>     Andrey Smirnov <andrew.smirnov@gmail.com> (reviewer:MCIMX7D SABRE / i...)
>     qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...)
>

Sorry I am late to this party. I haven't used i.MX7 emulation in a
while and things didn't go smoothly out of the box, so I had to create
a number of fixes (submitted to the ML).

I use Linux kernel built using Buildroot for validation. Buildroot
should have a default i.MX7 Sabred SD configuration and that should
probably work. I usually change mine slightly to use compiled-in
rootfs to simplify storage setup.

In case this is helpful here's a number of commands I use to start my
test cases:

* PCIe (e1000 ethernet attached), USB (usb stick attached), SD:
arm-softmmu/qemu-system-arm -smp 2 -m 1024 -machine mcimx7d-sabre
-nographic -serial mon:stdio -kernel <path to zImage> -dtb <path to
DTB> -device e1000e,bus="dw-pcie",netdev=lan0 -netdev
tap,id=lan0,ifname=tap0,script=no,downscript=no -append
"console=ttymxc0,115200 noinitrd" -usb -drive
if=none,id=stick,file=<patch to USB stick image>,format=raw -device
usb-storage,bus=usb-bus.0,drive=stick -drive
id=sd1,if=sd,format=file,file=<path to SD1> -drive
id=sd2,if=sd,format=file,file=<path to SD2> -driv
eid=sd3,if=sd,format=file,file=<path to SD3>

* EHCI USB attached via PCIe with legacy interrupts, Ethernet
connected to built-in controller:
arm-softmmu/qemu-system-arm -smp 2 -m 1024 -machine mcimx7d-sabre
-nographic -serial mon:stdio -kernel <path to zImage> -dtb <path to
DTB> -device usb-ehci,id=ehci,bus="dw-pcie" -net
nic,model=imx.fec,netdev=lan0 -netdev
tap,id=lan0,ifname=tap0,script=no,downscript=no -append
"console=ttymxc0,115200 noinitrd pci=nomsi" -usb -drive
if=none,id=stick,file=<path to USB stick image>,format=raw

Also, I don't think anyone would try to do this, but just as a
warning, building QEMU with --enable-tcg-interpreter doesn't really
work that well (/init gets SIGKILLed every time), so I'd recommend
avoiding using that option.

Hopefully this is enough info, but if not, feel free to ask me more questions.

Thanks,
Andrey Smirnov

