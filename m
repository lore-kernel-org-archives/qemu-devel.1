Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F141FC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB932084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ALI/G32F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB932084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0ZZ-0000WY-0D
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iz0Yz-0008Pq-UI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iz0Yy-00020k-Kj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:56:33 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:44285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iz0Yy-0001qh-6t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=6J4HlvfNANCKQEl12O3+OiZsR6J8IwPgP8WjQbMTSkE=; b=ALI/G32Ffhppx8GrEdM/g62VAw
 5/Trxn0l7fkQG9arK5iCrXON4iIX857TonRrLP+rQRq3nL42ozsYjzc2zBzwbiVREBOZ7RYrnsnB7
 lwD0jEUjoxSzXPZ4w+5Ab3KrMkJsO7zhZ5dXpmgRIexrzDujquAr43HbhkQrFJAaToU3lgb2RnCTt
 sOTBZaBjXSdeOICEt1ul4M2dRHo7dZ5CZ1DcJK37LLGXKYr9lk1KRXC3GeevorRiD0DzmCYu7qNtE
 aipuM+SfcLTPpPc7GtO3XXXkGUOxk9EdSuivVfSQW51eURSefCj0Mn+m4BG5ageAXsJAyNnoq4Tt9
 1NqhZ5GOa0g6Uj39y9474oz46dbDQVxfPG0nq10Nn0GxE332PQ3CM/uL7ZNc/71DFxFQHRhPcCRuA
 vn6IAD9o9e+vAqD+1pnUHjYTEhK3jYPpiR115lmv+K2BuqrdGXGfue/h48CXN24BPFGUROHfssqpn
 +jzG3WRAgs0w3MPfkX1iju9KiJfgk+UlwyOOSR5HntASriz4mva42IwBE5OMaaAeZQhet5Ct5xUsg
 Hqb7e4o2zFpPcFdr3kQ1MCj19rF5RxAUnjmiS4nAQGwddqzT9981hDZ03y5XQH7nvYbn5qpxEAo3B
 iGArVKRIVD8zJsFbu17r1dFXNVfg8GEyFfDi2JSo8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, G 3 <programmingkidx@gmail.com>
Subject: Re: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX
Date: Tue, 04 Feb 2020 16:56:29 +0100
Message-ID: <4895939.vUebzJK3Km@silver>
In-Reply-To: <CAFEAcA9VnQCG3r28BOLr_qXLRM2V68r3oK4ZfY9+bVz2j1oSyA@mail.gmail.com>
References: <mailman.343.1580584897.2411.qemu-devel@nongnu.org>
 <15653420.4VsaQd57cB@silver>
 <CAFEAcA9VnQCG3r28BOLr_qXLRM2V68r3oK4ZfY9+bVz2j1oSyA@mail.gmail.com>
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

On Dienstag, 4. Februar 2020 14:13:35 CET Peter Maydell wrote:
> > How about handling this with an error message at configure stage instead?
> > Removing this code does not increase the chance for somebody going to fix
> > pre-10.12 support.
> 
> But is anybody actually going to fix pre-10.12 support? They've
> had six months so far... If we had a good sized body of developers
> taking active care of how well QEMU on OSX works, I would be
> entirely happy for them to decide amongst themselves what they
> thought was a reasonable version support policy for OSX. But
> we just don't.

No idea of course whether somebody will fix it. It's just that young people 
tend to have fairly old Macbooks (i.e. >= 10 years) since younger models in 
that universe are often outside of their budget.

> I wouldn't object to a configure check if anybody wanted to write
> a patch to add one.

Like I said, I don't care much, but if you want I can send a small configure 
script patch of course. That's not a big deal. So roughly you want a warning 
for pre-10.14 and error out on pre-10.12, right?

G3, if you want to take care about sending this patch instead, very much 
appreciated of course. :)

> > > "Last two versions only" is our support policy for OSX for a reason,
> > > and the reason is that there just aren't very many people running
> > > OSX and actively working on QEMU. Of those, even fewer will
> > > be still running OSX versions that are no longer being supported
> > > for security fixes by Apple.
> > 
> > Apple currently seems to maintain 4 macOS release branches with security
> > fixes (10.15.x, 10.14.x, 10.13.x, 10.12.x):
> > https://en.wikipedia.org/wiki/MacOS_Sierra#Release_history
> 
> Indeed, and none of those is the 10.11-and-earlier that this patch
> drops attempts to cater for. The patch does still keep 10.12 and
> 10.13 support alive, even though it's not strictly required by
> our support policy, because building for those host versions does
> in practice still work.

Sure, I just wanted to bring that to your attention. In fact security support 
policy by Apple is somewhat unpredictable. There is no official statement 
which branches are covered by security fixes. They simply decide on a case-to-
case basis whether or not to release updates for certain old release branches.

Best regards,
Christian Schoenebeck



