Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F38C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 21:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F101D20853
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 21:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="grixiZ3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F101D20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqk9s-0001AN-U0
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 17:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqk6d-0008FJ-3b; Wed, 01 Jul 2020 17:17:23 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:41700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqk6W-0001M5-JY; Wed, 01 Jul 2020 17:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=Z0F1FoMw07MRBs4TFFYc15TdWGR8Z2Lh8OSzx7M2xdc=; b=grixiZ3fgcWVh9JSM7tVCkKvyW
 yF44wZmjWmDWTe6Jmns9gUxaDn0tUJexaKkxhuAMyjKVwESPAFq8mRZVB+VfRT6SAtO22YPxEwMch
 ruvTTWyk98PwbFdlf+ngNJ9XOCqvonLGLOv9S+R/wkXZW879Ls5mUrn4vJumMNXfQh8nfmqEAcS6L
 8xjI03ljRCH5Pi/vKJKm/qo9kLlwns7165lMVkW2ni36uJU3SDrdawkt6ja48ew+lQWyJ5PRDfikn
 o8sYJyR3x33Ucaqaf17dTE8vf+1g5o9oaMrKShTh7DenR6II8InQ8J8QiRvZz3M2aok4bU1onOfFF
 kBdV6Vkg==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1jqk6L-0006Oq-Qn; Wed, 01 Jul 2020 23:17:05 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
 (envelope-from <aurelien@aurel32.net>)
 id 1jqk6J-004cau-DK; Wed, 01 Jul 2020 23:17:03 +0200
Date: Wed, 1 Jul 2020 23:17:03 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v3 0/5] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
Message-ID: <20200701211703.GB1093119@aurel32.net>
References: <20200630195723.1359-1-f4bug@amsat.org>
 <CAHiYmc6d3Q2A237qVqp6s0MagXqgy11aX9r_LuJsGkoJxRhfQw@mail.gmail.com>
 <20200701173944.GA1090525@aurel32.net>
 <CAHiYmc5Y6_OcjYS8zR=hKGFeeL9zJ2g+CX8jeNyZdyMnH6uO+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHiYmc5Y6_OcjYS8zR=hKGFeeL9zJ2g+CX8jeNyZdyMnH6uO+g@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Received-SPF: none client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org,
 Yunqiang Su <ysu@wavecomp.com>, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar,

On 2020-07-01 20:51, Aleksandar Markovic wrote:
> On Wed, Jul 1, 2020 at 7:39 PM Aurelien Jarno <aurelien@aurel32.net> wrot=
e:
> >
> > Aleksandar,
> >
> > On 2020-06-30 23:54, Aleksandar Markovic wrote:
> > > As, in a very clear way, evidenced from the previous versions of this
> > > series, this series real goal was not not to create some new
> > > "malta-strict" machine, but to prepare path to creation of some
> > > imagined "malta-unleashed" machine which will, to the contrary of
> > > proclaimed goal, create a machine that could never exist in reality.
> > > That is why I can't accept this series.
> >
> > I do not understand your opposition to this, and why it is an issue to
> > support more than 2GiB of RAM for such a board. Supporting more than 2G=
iB
> > of memory doesn't prevent people to emulate a real Malta board with less
> > memory.
> >
> > In addition to that, the Malta board in QEMU has been supporting for
> > many years more than the maximum 256MiB that is possible on a physical
> > board. The QEMU version also supports way more than CPU variants than
> > the physical board. In other word the existing malta machine in QEMU is
> > already a "malta-unleashed".
> >
>=20
> Aurelien,
>=20
> Glad to see you again. I am really sorry you were absent for so long.

I assumed that since haven't dramatically changes in QEMU since I left,
however if I missed some recent discussions that goes again what I am
saying below, please feel free to point me to them.

> Those (what you described in the paragraphs above) were mistakes from
> the past. At some point, we needed to stop doing it, and finally
> returned to the root QEMU principles of emulating systems as
> faithfully as possible.

I think there is a big misunderstanding here. The root QEMU principle is
to emulate each *device* or *feature* as faithfully as possible. The
*default* system that is emulated should also match as much as possible
the real hardware, but QEMU also gives users the possibility to create a
system as they want. And the amount of memory is one them.  That's
actually all the beauty of QEMU. Remember that QEMU solely exists
because it has users, and that the possibility to extend the RAM of the
Malta board to 2GB and to select various CPUs is widely used by users.

So overall there are plenty of counter examples to your "root QEMU
principles". Daniel P. Berrang=E9 mentioned the memory support on the
i440fx x86 hardware. As other examples you can also add AMD 3D Now
instructions to an Intel CPU, or add an AC97 sound device to a SH4
machine. Virtio is another example.

> Knowing the needs like you described exist, my vision is that, just
> for occasions you described, we create a virtual board that would have
> very wide set of feature, unconstrained by real world. That way we
> would avoid situations to "lie" in our emulations.

Adding a "virt" machine like it has been done on some other
architectures is probably a good idea to give users even more
possibilities. Now I do not believe its a reason to not allow users to
slightly extend an existing system.

In addition to that, creating a new virt machine and getting it fully
usable is a multi year project. In addition to the QEMU changes, you
also need to get kernel and bootloader support. And then it has to reach
the distributions.

> If you needed something more that is currently provided, you should
> have issued a feature request through regular channels, and that would
> have the people the chance to develop a solid solution, not some quick
> fixes that pushes us further and further in wring direction.

QEMU doesn't have an upstream bug tracker, so I guess that regular
channels basically mean the mailing list. I therefore express the need
for a MIPS "virt" machine that supports more than 2GB. Please ping me
when it's ready.

Best regards,
Aurelien

> Why didn't you respond on my mail from the other day? Do you plan to resp=
ond?

I just responded to it, overall in less than 12 hours.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

