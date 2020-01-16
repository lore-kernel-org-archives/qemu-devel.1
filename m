Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73522C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4763A2081E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4763A2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irucK-0007tk-E5
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>) id 1iruWd-0007p0-70
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benh@kernel.crashing.org>) id 1iruWb-0001Nz-4J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:04:46 -0500
Received: from kernel.crashing.org ([76.164.61.194]:55086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
 id 1iruWa-0001MI-Km; Wed, 15 Jan 2020 21:04:44 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 00G24M64024805
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Jan 2020 20:04:25 -0600
Message-ID: <1a1cecb5128134e681b9145b9c6bc10a8db00ea9.camel@kernel.crashing.org>
Subject: Re: Semihosting, arm, riscv, ppc and common code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liviu Ionescu <ilg@livius.net>, Richard Henderson
 <richard.henderson@linaro.org>
Date: Thu, 16 Jan 2020 13:04:20 +1100
In-Reply-To: <C4EE0480-C366-419B-84F1-3BEB794D1598@livius.net>
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
 <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
 <87sgkimkma.fsf@linaro.org>
 <1309ca0ab6405d88cfd949c73130ad0f2af944a6.camel@kernel.crashing.org>
 <87wo9tkjxz.fsf@linaro.org>
 <81f25a9e-a52c-ca8d-4d4b-ca36fcee73ed@linaro.org>
 <C4EE0480-C366-419B-84F1-3BEB794D1598@livius.net>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, keithp@keithp.com, qemu-arm@nongnu.org,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-01-16 at 00:02 +0200, Liviu Ionescu wrote:
> > ... they did have the opportunity to do better, and did not.
> 
> I don't know why you present Arm semihosting as a disaster. It is not
> perfect, but it is functional, and common unit tests use only a small
> subset of the calls.
> 
> And there is no 'window of opportunity', if the RISC-V guys will ever
> want to reinvent the wheel and come with an official 'RISC-V
> semihosting' specs, they can do it at any time, and this will have no
> impact on existing devices, everything will continue to work as
> before, only the debuggers/emulators will need to be upgraded.
> 
> But the only immediate effect such a move will have is that software
> efforts in test frameworks will be increased, to support another
> protocol, while the advantages will be minimal.

I agree, which is also why I want to use the same interface for
powerpc, it will simply make life easier for everybody. The calls
aren't perfect but they do work sufficiently well to be useful and I
haven't yet been convinced that it can't be extended if necessary.

Cheers,
Ben.



