Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB569C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 04:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F0720989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 04:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F0720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOasD-0004GU-9F
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 00:41:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOarN-0003WN-2h
	for qemu-devel@nongnu.org; Thu, 09 May 2019 00:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOarM-0001yg-2h
	for qemu-devel@nongnu.org; Thu, 09 May 2019 00:40:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOarL-0001ty-OO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 00:40:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F36581DE9;
	Thu,  9 May 2019 04:40:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D0A71001E65;
	Thu,  9 May 2019 04:40:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3DA2611AAA; Thu,  9 May 2019 06:40:40 +0200 (CEST)
Date: Thu, 9 May 2019 06:40:40 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190509044040.bgrzbzczqonbn24q@sirius.home.kraxel.org>
References: <20190503004130.8285-1-ehabkost@redhat.com>
	<20190503004130.8285-11-ehabkost@redhat.com>
	<20190508102824.ysts2k4xesxzmh67@sirius.home.kraxel.org>
	<20190508143953.GA32662@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508143953.GA32662@localhost.localdomain>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 09 May 2019 04:40:41 +0000 (UTC)
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

> > Tests can also timeout due to slow downloads of test kernels.
> > Any chance to run the downloads without timeout?
> 
> I acknowledge this is an issue, and have thought about two possible
> ways to solve it:
> 
>  1) Downloading/caching/checking all the test assets in a job "pre-tests"
>     plugin.

>  2) Report the test phase (say, setUp()) to the test runner, which
>     would allow the runner to:

> I'm very much interested in your opinion so we can evolve the idea into
> implementation.

(1) is the better approach I think.  That way you can give better
feedback to the user, along the lines of "download 2 of 5 in progress".
Also it allows for better management of the assets, you can have tools
to list them / fetch them / copy them from one to another test machine
/ find & cleanup obsolete assets (i.e. Fedora 28 kernel after switching
tests to Fedora 29).

(2) is probably still useful, to report phases of longer running
tests and maybe have separate timeouts for each phase.  But for
assets I think approach (1) is better than a "download asset"
phase.

cheers,
  Gerd


