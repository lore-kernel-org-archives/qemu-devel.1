Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5ABC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFC8204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFC8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37467 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOygh-0004Jw-Ux
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:07:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOyfs-00040Y-BU
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOyfr-0005bs-5H
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:06:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOyfq-0005b3-Qk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:06:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96AA83091755;
	Fri, 10 May 2019 06:06:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1ACEE6103B;
	Fri, 10 May 2019 06:06:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3CBC7A1E1; Fri, 10 May 2019 08:06:23 +0200 (CEST)
Date: Fri, 10 May 2019 08:06:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190510060623.jsrcuki3zvat35hg@sirius.home.kraxel.org>
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-11-ehabkost@redhat.com>
	<20190508102824.ysts2k4xesxzmh67@sirius.home.kraxel.org>
	<20190508143953.GA32662@localhost.localdomain>
	<20190509044040.bgrzbzczqonbn24q@sirius.home.kraxel.org>
	<20190509181242.GB25147@dhcp-17-231.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509181242.GB25147@dhcp-17-231.bos.redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 10 May 2019 06:06:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 10/19] tests/boot_linux_console: increase
 timeout
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> I also think that approach #1 is simpler and saner, but thinking about
> where we're going with the test runner development, I started to have
> doubts about it.  The reason is that we're adding parallel and multi
> environment (process, machine, container) execution capabilities to the
> runner. Dogfood version is here:
> 
>   https://github.com/avocado-framework/avocado/pull/3111
> 
> By doing all download/caching before any single test starts, we may be
> wasting a lot of CPU time that could be used for running tests, making
> the overall job execution much longer.

Well, if the internet link is the bottleneck running downloads in
parallel wouldn't speed up things ...

Also given that avocado caches the downloads the common case will
probably be to not download anything.

> FIY: one of the new runner planned features, is based on a question
> use case you mention, about how to run tests built into a minimal
> image, such as an initrd.

FYI: Here is what I did: https://git.kraxel.org/cgit/drminfo/tree/tests

cheers,
  Gerd


