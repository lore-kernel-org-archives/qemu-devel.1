Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4DC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CFF21835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="P+PA3jrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CFF21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuNZY-0006w7-5t
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 16:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iuNYu-0006Vv-LD
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iuNYs-00008x-Pf
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:29:20 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:39869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iuNYq-0008U3-V8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ZtMPVKaMIykc4lbQujZ+52Mx+fC2yvkExvTrpcXgFgA=; b=P+PA3jrgRO3YT6QR8O4K+H7Av3
 M5ApBsGkXHu/VLMA/Rpkw70DDVQ5Oh4mFpMFe6KOKQzG/A3LKxJPR8wrHIrv9tqh0xsjR2n+nEtzn
 Irh579025PjulGmETkYarQn7N0xyu6P7KTkeye9bY/iBomFbkFtVXpAdVe5aUzmzCj2C8f8OmiB/q
 vy0IDGMLOXReibPyGkYTD6SlCdFHvTMXmY1DLqQAhjPQx7szQXcFsE6KCJ7Y8DRh8j4iMTeyyVrDJ
 +LxqY43XWSZ6LzFr/WLiaLgHyUB+qTP/+v2nexHqlC4DVQCpJS6Suxo/53n8rtEgqYUWIVgDyGIGm
 zhm+q4gTkOFIqD40p4FgRFGGAMsbxUIavbd2w0UOtsMpQ8jxlnouK2pFwDfJiunXbNmDuJR0K5Ssc
 BvzhkAbnDxeY6U8qbZPOT+jpjnsx3ag8xemrmREcVCOCSXuJGUCCdmJ77w8kGbU/L/hMmvQNTkNUg
 OkyIssGjtlEmkYBHac9MPAzt+bcRqHLfVFkFZVffaZt24hI/2oIoE0GYB8ctR4fsD2NLqa8wsanqA
 6K32/NHuo5XLapZ/zm+2gj1Uxqln/9EscLeJjvaBrBo17Snb/56mous+0pVryzg7ZGbWjai5ZRP77
 I8bt6xL1Bnn1fmvdczptXj2Ov90BoPlk4P47LIdBg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 06/11] tests/virtio-9p: added splitted readdir test
Date: Wed, 22 Jan 2020 22:29:12 +0100
Message-ID: <35106419.zRHx49BoVS@silver>
In-Reply-To: <5dac4bf8-64aa-708e-d546-1eaea85bd792@redhat.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <f6394833fa66bf6a73d204db34302732a5f6b98a.1579567020.git.qemu_oss@crudebyte.com>
 <5dac4bf8-64aa-708e-d546-1eaea85bd792@redhat.com>
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

On Mittwoch, 22. Januar 2020 22:14:39 CET Eric Blake wrote:
> On 1/20/20 6:16 PM, Christian Schoenebeck wrote:
> > The previous, already existing readdir test simply used a 'count'
> > parameter big enough to retrieve all directory entries with a
> > single Treaddir request.
> > 
> > In this new 'splitted' readdir test, directory entries are
> 
> English is weird; the past tense of 'split' is 'split', not 'splitted'

Just an attempt to fix a language defect. You're right of course Eric.

Greg, should I resend that patch fixed or can you just awk it? Whatever is 
more comfortable to you.

Best regards,
Christian Schoenebeck



