Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3E0C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3472A2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="IPC0MD9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3472A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChGO-0002dK-Cr
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iChA8-0000kY-UQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iChA6-0006dp-Kj
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:31:12 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:55461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iChA6-0006dJ-3k
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=B5zWF0zV/SItj5b9EyKGgdCoRTe/3+py+UlNEnItMWk=; b=IPC0MD9+E1OAQcgfoWnakDHivf
 o6C54TbauKLLslhSL33GGAfSZ7Ue8FXlFCG9v6hvFELQi70Idv88RsJjvZxlg+uuWfYprvEloanLJ
 xKAhmvIWi47BZzCe8ME0C2fG7R2xF0w9nM0jQF1WG9adPXSa9N17VDFg9NX4TDcktP6PnXHWcH7XT
 d1YrctRB+pmV75lkMAaZI8J7rJkawwTpNz605lPIJhQx/QHszc/EFnlzCZHdUdjSeMTi6FRAxKH4X
 N80bOFvQBVVIGbKAEbGiISG57MCbexqo/IReCps7fXi8kqKDOhKQF3HYbrk4YtHiJz3rcXYMZzNlN
 VHPNMG0MaTUoGO7Xh6x1MLgVpMSRIDR7fGbECSwALoBU1kOBVcemALWwNkAUvqysJuiD2kYpL8bKx
 WUiC7bfhEym7j1LacjJ4ST3sfIdZWLZtkWo78f7LLcMbgZJc0C/vc0pItqFj5G3zXoTOzYHzemzKb
 IOq47L+Rfh0DVrUIeq5IMBzieKC1otnTwIvS/zVERulIQh5ugg6gAVhrq68RaXgHzHkHzji7dQbmC
 dXzlya/GbxLLPMrUSQAlXURKsRaAdYA7rTCAbodb8gFf7qv39D39710eJHBY8WUPncOqIAD8FMp8b
 quHsTwsVp8NMD3CCQRsF61vUbfOs10JBayRpYpLgU=;
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Date: Tue, 24 Sep 2019 11:31:06 +0200
Message-ID: <1590425.yRI6RxI3rl@silver>
In-Reply-To: <20190923185012.06131248@bahia.lan>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <7439377.rdf1oF7g69@silver> <20190923185012.06131248@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Christian Schoenebeck <qemu_oss@crudebyte.com>
From: Christian Schoenebeck via <qemu-devel@nongnu.org>

On Montag, 23. September 2019 18:50:12 CEST Greg Kurz wrote:
> > > > If yes, and since that would mean I was the only person ever having
> > > > tested
> > > > the actual fix, shouldn't --multidevs=remap|forbid better be marked as
> > > > experimental (docs and runtime warning) for now? Maybe that would also
> > > > anticipate receiving feedback from people actually using it later on.
> > > 
> > > Makes sense. I don't think it is worth having a runtime warning,
> > > but I'll turn remap to x-remap and amend the docs.
> > 
> > Mwa, I would like to veto against your "x-remap" plan though. Keep in mind
> > I also have to send out a patch for libvirt for this fix. Even I would
> > not have read "x" to stand for "experimental". So I would definitely
> > favor a runtime warning instead of renaming that parameter.
> 
> Hmmm... I don't see the point in adding a warning for a feature that
> is only active if the user explicitly asks for it. 

Because many people might be using this option without ever reading the docs, 
e.g. because of being suggested by copy & paste tutorials or any stack*.com 
forum.

> And, anyway, this
> still is an experimental feature, right ? 

No, it is not a feature. It is still a fix. :) I cannot use 9p without this 
fix at all, so it is not some optional "feature" for me.

x-remap would just make things unnecessarily more complicated without adding 
anything useful.

A warning/info log could be used to motivate people providing feedback and 
make them clearly aware about their current version still being an 
experimental fix in their specific qemu version. That warning/info is just a 
one line change that can easily be dropped at some point in future after this 
qid fix proofed to be reliable (i.e. from users' feedback and test cases).

> Not sure it is time to have
> libvirt to support it yet.

Most people are using libvirt xml configs instead of calling qemu directly 
with command line options. So of course I will suggest a libvirt patch as soon 
as this patch set is pulled on qemu side.




