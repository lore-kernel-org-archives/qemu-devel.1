Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57716C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F61B21874
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F61B21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3N4E-0000Sp-Bn
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1i3N3R-0008Ny-FO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1i3N3Q-00019A-8u
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1i3N3Q-00018B-3V
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:13:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD9F73175298;
 Thu, 29 Aug 2019 16:13:42 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FCBA5C28C;
 Thu, 29 Aug 2019 16:13:35 +0000 (UTC)
Message-ID: <3fce8d5a5fcccbff8f27f681eb685167d2c0845f.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jeff@codyprime.org>
Date: Thu, 29 Aug 2019 18:13:34 +0200
In-Reply-To: <20190829154851.GA26717@stefanha-x1.localdomain>
References: <20190829154851.GA26717@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 29 Aug 2019 16:13:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] git.qemu.org gitweb misrenders on git/ URLs
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
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-29 at 16:48 +0100, Stefan Hajnoczi wrote:
> Hi Jeff,
> Philippe noticed that the git HTTPS clone URL
> https://git.qemu.org/git/libslirp.git renders a gitweb page that looks
> right but has broken links.  The correct gitweb URL listed on
> https://git.qemu.org/ is https://git.qemu.org/?p=libslirp.git;a=summary,
> but there's a chance that people will open the HTTPS clone URL in their
> browser and expect to see gitweb working.
> 
> Is it possible to tweak the Apache configuration so that
> https://git.qemu.org/git/libslirp.git[/] redirects to the working gitweb
> URL?
> 
> The tricky part is not breaking HTTPS git clone, which accesses URLs
> below https://git.qemu.org/git/libslirp.git/ :).

I know that's not quite the answer to your question, but if you look
for example at

  https://git.zx2c4.com/cgit

you'll see that the same URL can be used both for viewing with a
browser *and* cloning.

Basically with cgit all requests go through the CGI script, and an
advantage of that is that you don't even need to call

  git update-server-info

to make the repository accessible via HTTPs. It's also pretty fast
and extremely easy to setup. Maybe consider switching from gitweb
to it?

-- 
Andrea Bolognani / Red Hat / Virtualization


