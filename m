Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8771C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B15121019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B15121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOm4Y-0003wy-SG
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:39:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1hOm21-0002JZ-NQ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1hOm1z-00072S-IV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:36:29 -0400
Received: from smtp.vivo.cz ([185.219.166.8]:52982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1hOm1z-0006vf-7Z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:36:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.vivo.cz (Postfix) with ESMTP id D71B31401E1F;
	Thu,  9 May 2019 18:36:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vivo.cz
Received: from smtp.vivo.cz ([127.0.0.1])
	by localhost (smtp.vivo.cz [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8ccxHw4urqYW; Thu,  9 May 2019 18:36:16 +0200 (CEST)
Received: from orkuz.int.mamuti.net (185-219-164-37-static.vivo.cz
	[185.219.164.37])
	by smtp.vivo.cz (Postfix) with ESMTPS id DBFF91843359;
	Thu,  9 May 2019 18:36:16 +0200 (CEST)
Received: by orkuz.int.mamuti.net (Postfix, from userid 500)
	id E2C632A2A4B; Thu,  9 May 2019 18:36:18 +0200 (CEST)
Date: Thu, 9 May 2019 18:36:18 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190509163618.GN7181@orkuz.int.mamuti.net>
References: <20190422234742.15780-1-ehabkost@redhat.com>
	<20190509133537.GK7181@orkuz.int.mamuti.net>
	<20190509135617.GH4189@habkost.net>
	<20190509180603.424c8277@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509180603.424c8277@Igors-MacBook-Pro>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.219.166.8
Subject: Re: [Qemu-devel] [PATCH 0/2] i386: "unavailable-features" QOM
 property
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 18:06:03 +0200, Igor Mammedov wrote:
> On Thu, 9 May 2019 10:56:17 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Thu, May 09, 2019 at 03:35:37PM +0200, Jiri Denemark wrote:
> > > Would this unavailable-features property contain only canonical names of
> > > the features or all possible aliases of all features? For example,
> > > "tsc-adjust" can also be spelled as "tsc_adjust". When calling
> > > query-cpu-model-expansion, we have a way to request all variants by
> > > running full expansion on the result of a previous static expansion. Can
> > > we get something like this for unavailable-features too?
> > 
> > I'd like to avoid that, and refer only to the canonical names.
> 
> Can we deprecate aliases to avoid confusion in future?
> (there aren't that many of them that used pre-QOM name format)

If you come up with a way libvirt could use to detect which name it
should use when talking to QEMU...

Jirka

