Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA33C35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 05:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D67A20718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 05:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D67A20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ZMk-00087g-Bi
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 00:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1j3ZMD-0007gP-Qi
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 00:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1j3ZMC-00054B-LM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 00:54:13 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:59732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1j3ZMC-00052U-CG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 00:54:12 -0500
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 3C0FD12C4;
 Mon, 17 Feb 2020 06:54:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uWh8UyF5t0ee; Mon, 17 Feb 2020 06:54:09 +0100 (CET)
Received: from function (unknown [8.46.75.7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 1EF6DBD7;
 Mon, 17 Feb 2020 06:54:08 +0100 (CET)
Received: from samy by function with local (Exim 4.93)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1j3ZLP-002J0w-2D; Mon, 17 Feb 2020 06:53:23 +0100
Date: Sun, 16 Feb 2020 21:53:22 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 07/30] qapi/block-core.json: Use literal block for
 ascii art
Message-ID: <20200217055322.mokaho5ipyww6qqp@function>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-8-peter.maydell@linaro.org>
 <CAL1e-=iWXDGat9dVwNEKU1JUYTz1vc-wr2f1pTNiHP-e6zpPbA@mail.gmail.com>
 <CAAdtpL6JHhgPJOdwrMxs83qc8=9Q-1t6mrA0yJiyPjMkHSw3Lg@mail.gmail.com>
 <CAL1e-=hgrANvvPd2oaOUTf+3EuudcsZeBtj1yOCK4Pn37nxOJg@mail.gmail.com>
 <CAAdtpL6HmgdmV3f9g_K4ap48-DMe18_y88iVajMjctQdm+9URA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAdtpL6HmgdmV3f9g_K4ap48-DMe18_y88iVajMjctQdm+9URA@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Philippe Mathieu-Daud=C3=A9, le lun. 17 f=C3=A9vr. 2020 01:44:35 +0100, a=
 ecrit:
> On Sat, Feb 15, 2020 at 10:01 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> > 9:56 PM Sub, 15.02.2020. Philippe Mathieu-Daud=C3=A9 <philippe@mathie=
u-daude.net> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:
> > > On Fri, Feb 14, 2020 at 12:04 AM Aleksandar Markovic
> > > <aleksandar.m.mail@gmail.com> wrote:
> > > >
> > > > 6:59 PM =C4=8Cet, 13.02.2020. Peter Maydell <peter.maydell@linaro=
.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0=
:
> > > > >
> > > > > The ascii-art graph
> > > >
> > > > Just out of couriousity, are unicode characters allowed in rst fi=
les?
> > >
> > > I remember 2 years ago a blind developer thanked the QEMU community=
 to
> > > still restrict commits to 80 characters, because while 4K display a=
re
> > > available, he and other visually impaired developers cloud still
> > > browse the QEMU codebase with their refreshable Braille display (wh=
ich
> > > was 80 cels). I don't know how many visually impaired developers ar=
e
> > > following this project. A quick google returns " There is no concep=
t
> > > of Unicode in Braille. In that sense Braille is similar to old 8-bi=
t
> > > code pages which represented different symbols in different languag=
es
> > > for the same symbol code."
> > > (https://superuser.com/questions/629443/represent-unicode-character=
s-in-braille).
> > >
> > > (I'm Cc'ing Samuel who cares about Braille displays.)

Nowadays' screen reader do provide some translations for some unicode
fancies. But the analogy with codepage remains true: since there are
only 256 braille pattern, there will be ambiguity between representation
of plain text and representation of unicode fancies. Using plain ascii
avoids this issue, i.e. blind developers will know that '|' and '-' are
commonly used for drawing, and their Braille representations are not
ambiguous. So that's indeed better to keep them ascii.

More generally, ascii art is however hard to catch with a Braille device
anyway...

Samuel

