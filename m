Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EBDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A2620730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="WT1xv8A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A2620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyxsC-0002Ho-9l
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iyxrZ-0001qm-74
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iyxrX-0000iN-Qi
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:03:33 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:60583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iyxrX-0000Qz-Dx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=bP92Q+Sp0bo9a+vHJ/n2UjgDm3fp5guSdUP4LPCXkag=; b=WT1xv8A1HrenlE9a6Ht+9h/tfC
 OJX6JgMmlNIJ1cfyJ8w/PnTxBqdvapqkUtzW+tRM2DwbC4Z/V1xZIj/ay36HjROTPYMOdWW4iA4gh
 7HlIjwQhmN6mMDUyKA9IiyeeyIH7sXozt/LFU/fTuOpdgYKnCrDvobmSayfbeTNPDJiVu2r5I29sM
 +23JyQ4sST+ovBlHPAKueVgEPVCM9osFrXF3AR7ib24YiwRnsSkLVo4hArGDK8mE9XZ8zY//+tI/M
 LCohvD0+LW+/iGqPH3+MzaBVTaGFAhhWAy60L7agxDXbDkxIqIVtSncBkSFdbEmZ9OUaI6Oo83SQo
 TuhBUIOOP33ZqSEfBchzFhFGNyrRV605VxFOLDZOfPql36uVpaEw0YNY1incWbqA95cUmtR/eofq6
 nZgsH0f6Z6XFznyM9YtPuyDmwRz2UWBdBkrA5XrYmkxDhvVbug5cP1nV07tUQJ9aEo82PDBlQy1H6
 Te9xJAYH35WPJ3ozCCxtam9mXdZA9U3V0tUk4ItbxdVoFVvwuhidyMMkUFvrr524ZpFEDbT+xsMkA
 cVXAR9Zpc5f1gZvBZZLc6LL07iEdz/VLjKpv2oCmyePpoo6PtCu9J723nncdf+zv/Wo1RHf1k07SA
 Up4GENk2VcdurcRIttNYiNQ0qamqUm02h/f3BfwX8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, G 3 <programmingkidx@gmail.com>
Subject: Re: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX
Date: Tue, 04 Feb 2020 14:03:27 +0100
Message-ID: <15653420.4VsaQd57cB@silver>
In-Reply-To: <CAFEAcA8c6_ESiGCY5somH7LiDYGhW37QCAJDAUZ545b+VDoJSQ@mail.gmail.com>
References: <mailman.343.1580584897.2411.qemu-devel@nongnu.org>
 <CAKyx-3NZ9Tne+WKkA7wAtyFqZ6roN_gS7rF59ZRjECCkx0qKaQ@mail.gmail.com>
 <CAFEAcA8c6_ESiGCY5somH7LiDYGhW37QCAJDAUZ545b+VDoJSQ@mail.gmail.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 4. Februar 2020 11:15:36 CET Peter Maydell wrote:
> On Mon, 3 Feb 2020 at 19:59, G 3 <programmingkidx@gmail.com> wrote:
> >> Our official OSX support policy covers the last two released versions.
> >> Currently that is 10.14 and 10.15.  We also may work on older versions,
> >> but
> >> don't guarantee it.
> >> 
> >> In commit 50290c002c045280f8d in mid-2019 we introduced some uses of
> >> CLOCK_MONOTONIC which incidentally broke compilation for pre-10.12 OSX
> >> versions (see LP:1861551). We don't intend to fix that, so we might
> >> as well drop the code in ui/cocoa.m which caters for pre-10.12
> >> versions as well. (For reference, 10.11 fell out of Apple extended
> >> security support in September 2018.)
> >> 
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >> The bug report is recent, but this was also pointed out on
> >> the mailing list back in June 2019. Since nobody has cared
> >> to try to fix it, we clearly don't care about 10.11 in
> >> practice as well as in theory.]
> > 
> > Why would you want to inconvenience the Mac users? This is unacceptable.
> > I and many other Mac users would not be able to use the newer versions of
> > QEMU anymore. Keeping Mac OS 10.10 and up support doesn't seem like a
> > burden. This patch should not be applied.

Not that I really care, but I also wonder whether that would be an appropriate 
action to remove this code, as it does not seem to impose anything negative to 
retain it.

> The rationale is in the commit message -- QEMU *already* does not
> build on 10.11, and it has not done so for more than six months, and
> none of these Mac users has submitted a patch to try to fix it.

How about handling this with an error message at configure stage instead? 
Removing this code does not increase the chance for somebody going to fix 
pre-10.12 support.

> "Last two versions only" is our support policy for OSX for a reason,
> and the reason is that there just aren't very many people running
> OSX and actively working on QEMU. Of those, even fewer will
> be still running OSX versions that are no longer being supported
> for security fixes by Apple.

Apple currently seems to maintain 4 macOS release branches with security fixes 
(10.15.x, 10.14.x, 10.13.x, 10.12.x):
https://en.wikipedia.org/wiki/MacOS_Sierra#Release_history

Best regards,
Christian Schoenebeck



