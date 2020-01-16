Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA76C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4E72084D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4E72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruXD-0007xu-To
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>) id 1iruTk-0004Cp-NV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benh@kernel.crashing.org>) id 1iruTi-0007C3-SV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:01:48 -0500
Received: from kernel.crashing.org ([76.164.61.194]:55072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
 id 1iruTf-00078W-5u; Wed, 15 Jan 2020 21:01:43 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 00G21PXT024767
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Jan 2020 20:01:31 -0600
Message-ID: <5dabf7d9e2af43d6c01d2e7e51e466616d84a8df.camel@kernel.crashing.org>
Subject: Re: Semihosting, arm, riscv, ppc and common code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 13:01:23 +1100
In-Reply-To: <CAFEAcA8mphBky9Q2HTdOpQHiizd+5-o=yRnBbd_k1y6Uk-h8dA@mail.gmail.com>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <CAFEAcA-A_caQgwi5DzExdZChoTg-Qa73hq7Ho7dPLiN633Yj1Q@mail.gmail.com>
 <3ab2ca1f7a9b37b201a58f3a817edc5193e8b1f4.camel@kernel.crashing.org>
 <CAFEAcA8mphBky9Q2HTdOpQHiizd+5-o=yRnBbd_k1y6Uk-h8dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Packard <keithp@keithp.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-01-15 at 13:32 +0000, Peter Maydell wrote:
> On Wed, 15 Jan 2020 at 01:17, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2020-01-14 at 09:59 +0000, Peter Maydell wrote:
> > > Note that semihosting is not a "here's a handy QEMU feature"
> > > thing. It's an architecture-specific API and ABI, which should
> > > be defined somewhere in a standard external to QEMU.
> > 
> > There is no such standard for powerpc today that I know of.
> 
> So you need to write one down somewhere. You're proposing
> an ABI which will be implemented by multiple implementors
> and used by multiple consumers. That needs a spec, not
> just code. I don't want to see more semihosting implementations
> added to QEMU that don't have a specification written
> down somewhere.

That's ok, I can probably get openpower to put a link to the ARM one
somewhere :-)

> The point about the mistakes is that you can't easily fix
> them by adding extensions, because the core of the biggest
> mistake is "we didn't provide a good way to allow extensions to
> be added and probed for by the user". So we had to implement
> an ugly and hard to implement mechanism instead.
>  New
> architectures could mandate providing the good way from the start
> and avoid the painful-to-implement approach entirely.
> (I think RISCV has already missed this window of opportunity,
> which is a shame.)

It is done and so now we have two architectures using that standard, I
think the value in using the same overweight the value in fixing it but
yes, we should try to agree on a method of extending at least. Is it
really that hard ?

IE. We could add a new call for capabilities that takes a pointer to
a region which we pre-zero before calling in the client and if remains
zero after the call, then the new stuff isn't there for example. That
sort of stuff is easy, or am I missing something ?

Cheers,
Ben.



