Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10ABC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7BF20815
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="wxow9pLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7BF20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoGY-00048t-L5
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iHoFI-0002wo-9P
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iHoFD-0005M4-2C
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:05:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:33475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iHoFC-0005Ku-JI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=8x7D2i/I/VzEYDxJRiut0agxqOb/XsYbPtTKpeEGluc=; b=wxow9pLyhRqWfxrKaVj8anBsme
 b+cUgHmmK+NtAp30mszEU/Wb5bfqaiCbFDQ/eKNJ66crwzWm/I5i3BLKOek3evaFTUSXKaWI6u3Cm
 rdc5BEeJR6l4KFNh0DwS+usVidXJ7UPvHv0TKEU8bs4N51F8Peh683fBwKlIYQBH0uqwkgFf34ubS
 UO0OkjINk6hl9pzvxYtkr1oo7GjhFkBpGb7T0hZowsoKekMzdODHv9M/0rY62Nqb88rUF4rYwE0RC
 IQPf5E3IgCrtaLBGYj2J7CvCjK9YTPogl8NTURYQRMToBOSjp1/qTYhF7CN+1IyWz+fEDJyZEBUBi
 llNmiaLcinElm9ZsHF/dFhRTNsIqFZeSADnFn3jQ6/Eoo9J9DPIGqptoPIpl1UD5OsF/TELOUAIP2
 ymdxtiSIw1fwbnWsYdrIjo7iKzip+8yqOF3cud8LbykiDiDqMrx1KzJ1qSxS+WviryZV3jWHDKz6n
 af7IIsH5W9yIiUrqDhBLvH8U/9nNqRJyq2InoeK8p7tLeNKCOn1ReNpELcd7QX7excNev2DV5SK+G
 maULnUiijCW8epYKyVGTnoVLsel4IPjL1sEzDy+1BacbUv2PVdn+aHLeDukVeFmNpAaH9XcjTRg2C
 HDiMskQ5d16y97WEdCQYr/G2zVhgKkko4bY2CQSLs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Date: Tue, 08 Oct 2019 14:05:28 +0200
Message-ID: <2456208.kOTvEbKLdM@silver>
In-Reply-To: <20191008111459.048e659f@bahia.lan>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <1590425.yRI6RxI3rl@silver> <20191008111459.048e659f@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 8. Oktober 2019 11:14:59 CEST Greg Kurz wrote:
> > No, it is not a feature. It is still a fix. :) I cannot use 9p without
> > this
> > fix at all, so it is not some optional "feature" for me.
> 
> I understand your need but this is still arguable. The 9p device has
> a limitation with cross-device setups. The actual bug is to silently
> cause inode number collisions in the guest. This is partly fixed by the
> "9p: Treat multiple devices on one export as an error" patch. Thinking
> again, it would even make sense to move "remap" from "9p: Added virtfs
> option 'multidevs=remap|forbid|warn'" to its own patch. We could then
> consider that the bug is fully fixed with "multidevs=forbid|warn".
> 
> Then comes the "remap" feature which is expected to lift the limitation
> with cross-device setups, with a "not yet determined" performance cost
> and light reviewing of the code.

Are these patch transfer requests addressed at me to be done?

> Also, I strongly recommend you try out "virtio-fs" which is
> going to be soon the production grade way of sharing files
> between host and guest.
> 
> https://www.mail-archive.com/libvir-list@redhat.com/msg182457.html

Yes I know, I am following the development of virtio-fs already of course. 
However for me it is far too early to actually use it in a production 
environment. It e.g. seems to require bleeding edge kernel versions. And the 
real argument for switching from 9p to virtio-fs would be a significant 
performance increase. However so far (correct me if I am wrong) I have not 
seen benchmarks that would show that this was already the case (yet).

I wonder though whether virtio-fs suffers from the same file ID collisions 
problem when sharing multiple file systems.

What is your long-term plan for 9p? Will it be dropped completely after 
virtio-fs became stable?

Best regards,
Christian Schoenebeck



