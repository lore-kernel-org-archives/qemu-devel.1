Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F09CC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052AD20989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052AD20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42263 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvXa-0001ls-Bi
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:33:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvWd-0001Ky-PW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvWc-0007uC-Nm
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:32:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hNvWW-0007rG-7A; Tue, 07 May 2019 04:32:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C719033025B;
	Tue,  7 May 2019 08:32:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2E6860BEC;
	Tue,  7 May 2019 08:32:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C817D11AA3; Tue,  7 May 2019 10:32:18 +0200 (CEST)
Date: Tue, 7 May 2019 10:32:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190507083218.lrjuab4gp5bexf3e@sirius.home.kraxel.org>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-5-thuth@redhat.com>
	<f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
	<0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
	<13ecf357-d43c-ecc6-012e-bed62008677d@redhat.com>
	<c6080cb1-b48f-028f-e774-ca0e7b94369d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6080cb1-b48f-028f-e774-ca0e7b94369d@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 07 May 2019 08:32:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Update *BSD images with gnu-sed and bash (was:
 [PATCH 4/6] cirrus / travis: Add gnu-sed and bash for macOS and FreeBSD)
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	Laszlo Ersek <lersek@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
	Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> >> D'oh! Does anybody know what are the correct steps to update these images?
> > 
> > (1) make the OPENBSD subsystem maintainer care
> > 
> > (2) update <https://wiki.qemu.org/Hosts/BSD>
> > 
> > (3) download the image from download.patchew.org, boot it and update it
> > 
> > (4) upload the image to download.patchew.org
> > 
> > (5) update the "tests/vm/openbsd" script in the QEMU tree in sync
> > (checksums, commands etc)
> 
>  Ed, Li-Wen,
> 
> any chance you could help with updating the FreeBSD image and the
> tests/vm/freebsd script, so that we get more test covarage here?
> 
>  Kamil,
> 
> could you maybe help with the NetBSD image and the tests/vm/netbsd script?
> 
>  Brad,
> 
> could you please help with the OpenBSD image and the tests/vm/openbsd
> script?
> 
> I think it would also be good to update the images to the latest
> released versions, too...

FYI:  I'm working on revamping the tests/vm setup, creating the images
scripted on the developer machine.  That'll take download.patchew.org
out of the loop and makes adding packages as easy as patching a docker
script.

Going slower than I want due to /me being busy with other stuff.
Sneak preview at:
	https://git.kraxel.org/cgit/qemu/log/?h=sirius/test-vm-install

cheers,
  Gerd


