Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4181DC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 06:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156942075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 06:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156942075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iryjr-0007Vk-Df
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 01:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>) id 1iryjF-0006Ul-KU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 01:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benh@kernel.crashing.org>) id 1iryjE-00075G-L1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 01:34:05 -0500
Received: from kernel.crashing.org ([76.164.61.194]:55218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
 id 1iryjC-00071X-5g; Thu, 16 Jan 2020 01:34:02 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 00G6XiWk027019
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jan 2020 00:33:48 -0600
Message-ID: <15ba2e1f782eec69173fe9c0f85a4dcff1d57f14.camel@kernel.crashing.org>
Subject: Re: Semihosting, arm, riscv, ppc and common code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Date: Thu, 16 Jan 2020 17:33:41 +1100
In-Reply-To: <87wo9tkjxz.fsf@linaro.org>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
 <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
 <87sgkimkma.fsf@linaro.org>
 <1309ca0ab6405d88cfd949c73130ad0f2af944a6.camel@kernel.crashing.org>
 <87wo9tkjxz.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by kernel.crashing.org id
 00G6XiWk027019
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 76.164.61.194
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
Cc: Liviu Ionescu <ilg@livius.net>, keithp@keithp.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-01-15 at 12:01 +0000, Alex Benn=C3=A9e wrote:
>=20
> > There seem to be some linux-user stuff in there, I'm mostly consideri=
ng
> > whatever ARM does today but we can certainly extend later.
>=20
> Depends on if it is to be used. AFAIK the main users of arm linux user
> are compiler test cases for M-profile CPUs.=20

For microwatt I was going to implement HW support as well via JTAG
but the user linux-user bits are less obviously useful to me.

That said, most of that code can trivially be made arch neutral by
replacing the use of the arch specific CPU type with CPUState as
the first argument to most functions. There are only a handful of arch
specific helpers needed from there to extract the op & arg, set the
result etc..

> > The idea is to make sure ARM, RiscV and POWER use the same protocol a=
nd
> > code base to make picolibc (and others) life easier. Bug compatible
> > :-)
>=20
> Hmm, I'm not so sure. QEMU tries to emulate real HW although I
> appreciate that is a somewhat loose definition once you get to things
> like -M virt and other such SW like abstractions. Is semihosting even
> going to be a thing on real RiscV/Power silicon?

It will be on microwatt once I add support for it. We could probably
make it work on real power9 if the systems give access to the external
debug facilities of the processor as well. I'm no longer involved with
powerpc in a professional capacity but I can ask Anton or Paul to help
there.

Cheers,
Ben.



