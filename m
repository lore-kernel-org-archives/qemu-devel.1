Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D1C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B382084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 13:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iTr/m2tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B382084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41683 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDqd9-0006eb-U9
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 09:17:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDqcD-0006LM-O4
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDqcC-00076s-NA
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:16:41 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:45359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hDqcC-00075P-2W; Tue, 09 Apr 2019 09:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=khh24DBBe31RNLdmwVzNKdx4raS+0aUQ9moOTrUzAmU=; 
	b=iTr/m2tbGFzgjejw6YnCi4VeOV06XEyX0O6dB7uHqfEHRuWhASoO6OudoK7OiMRCBrej64JZVeGT3SLmmlnSEIUVxYUOymtFQT3eKhRH7nlL/hvS4Gghw38cm/Sinjceobk+uF8ifDv2K72lPMEF+CzX97QS6HascXj4m9VkKDhX6XB75oQyNXAX23tFRIqSx7j1YNprccV8GGxVkabx3KstUx901Ah2e3KlX/CFRePIcabYgTyyNluU0WX+R/KtDTxU++ebF8qhtzLi2Bkb6T/dvD3X4CprWZD31twuC4XzOYgyMnhfNSO0p5kJPyI2g7n4CVma75B8W4DVwZN/kQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hDqc7-0000j4-1P; Tue, 09 Apr 2019 15:16:35 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hDqc6-0000mO-V8; Tue, 09 Apr 2019 15:16:34 +0200
From: Alberto Garcia <berto@igalia.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
In-Reply-To: <1554747741-918964-4-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-4-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Tue, 09 Apr 2019 15:16:34 +0200
Message-ID: <w51bm1f48ul.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v4 3/3] block/stream: introduce a bottom
 node
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409131634.YVFo0xvtXXC4sDaNSqmseq8bjG_TAxCSZ2fdyMJCWTw@z>

On Mon 08 Apr 2019 08:22:21 PM CEST, Andrey Shinkevich wrote:
> The bottom node is the intermediate block device that has the base as its
> backing image. It is used instead of the base node while a block stream
> job is running to avoid dependency on the base that may change due to the
> parallel jobs. The change may take place due to a filter node as well that
> is inserted between the base and the intermediate bottom node. It occurs
> when the base node is the top one for another commit or stream job.
> After the introduction of the bottom node, don't freeze its backing child,
> that's the base, anymore.
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

