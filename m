Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF87C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D072053B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D072053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=units.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK1vA-0001fP-Gs
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 10:33:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1hK1uC-0000V7-FL
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1hK1uB-0005Lh-De
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:48 -0400
Received: from dschgrazlin2.univ.trieste.it ([140.105.55.81]:51258
	helo=dschgrazlin2.units.it) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1hK1uB-0005L1-49
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:47 -0400
Received: from dschgrazlin2.units.it (loopback [127.0.0.1])
	by dschgrazlin2.units.it (8.15.2/8.15.2) with ESMTP id x3QEWEEb001279; 
	Fri, 26 Apr 2019 16:32:14 +0200
To: antti@fennosys.fi
From: balducci@units.it
X-Mailer: MH-E 8.6+git; nmh 1.7.1; GNU Emacs 26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-ID: <1277.1556289158.1@dschgrazlin2.units.it>
Date: Fri, 26 Apr 2019 16:32:14 +0200
Message-ID: <1278.1556289158@dschgrazlin2.units.it>
X-Greylist: inspected by milter-greylist-4.6.2 (dschgrazlin2.units.it
	[0.0.0.0]);
	Fri, 26 Apr 2019 16:32:14 +0200 (CEST) for IP:'127.0.0.1'
	DOMAIN:'loopback' HELO:'dschgrazlin2.units.it'
	FROM:'balducci@units.it' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
	(dschgrazlin2.units.it [0.0.0.0]);
	Fri, 26 Apr 2019 16:32:14 +0200 (CEST)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 140.105.55.81
Subject: Re: [Qemu-devel] Using --enable-kvm fails with WindowsXP guest on
 an AMD host (works on Intel host)
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
Reply-To: balducci@units.it
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426143214.G5HBQtXuolJMVnuqvRgCPCtv8QHZSqo9Z_jDqUfzE30@z>

(apologies if this doesn't get properly threaded into:
http://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg03407.html)

> After upgrading host (Gentoo Linux) a Windows XP guest can't boot anymore.
>
> Some findings while testing:
>
> * XP image boots & works OK on an Intel machine (Gentoo Linux)
> ** qemu: 3.1.0-r4
> ** kernel: 5.0.7
> ** CPU: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
>
> * XP image FAILS to boot on an AMD machine (Gentoo Linux)
> ** qemu: 3.1.0-r4
> ** kernel: 4.19.34
> ** CPU: AMD FX-6300 Six-Core Processor
> ** image boots OK if NOT using --enable-kvm
>
> * XP image FAILS to boot on an AMD machine (Gentoo Linux)
> ** qemu: 3.1.0-r4 & 3.1.0-r1
> ** kernel: 4.19.34 & 5.0.7
> ** CPU: AMD Opteron(tm) Processor 4170 HE
> ** image boots OK if NOT using --enable-kvm
> ** The image worked OK on this machine with Qemu 2.12.1 & Kernel 4.18.20

Same here, on an AMD Athlon(tm) X4 860K Quad Core Processor

AFAICS, something has gone wrong starting with kernel-5.0.6

For me:
            GOOD      BAD
            4.20.14   5.0.6
            5.0.2     5.0.7
            5.0.3
            5.0.4
            5.0.5

Full details available in my earlier report here
https://bugzilla.kernel.org/show_bug.cgi?id=203327

I've updated my original report with a reference to this one.

ciao
-gabriele

