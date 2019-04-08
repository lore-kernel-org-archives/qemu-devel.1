Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B680C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B0A21473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jT/+8JEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B0A21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVsY-00058q-0z
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:08:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDVol-0002kw-7H
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDVoe-0003sN-K4
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:04:13 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:40949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hDVob-0003Ym-PG; Mon, 08 Apr 2019 11:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=PE/B9l/kjxy2jOyu6aBRTzNIywu67Hmy09FUHLz/5Wo=; 
	b=jT/+8JEisVx9byez0xIgxoI5a8aRDs8B2oQiHf0JIpE11wO4yZFW44VzGkJm7IMhPnIXPHaM9PAEZY72+bcFhJFoql/bf8y0/BPhGOU6auklll+rSXQR4c+pNNKM6MSidKOqUwIPEW9tmeh4SivgvPILONaTx75GdfubGK5n9pCE4elioOvhUfJB1eT3UtJ0IVGeh01P2cGP1f6vopUFVLx+RI5Y1PtNBbqvam31nnN0/V31LSEpu+R/AHM1wZmTYNIDRm55WFLXIvaMnFLRZz6yczmIGPaDx7V2C7C6sAeLGice9FDH3jOX3QCFvL8xUl/tpI+b1cic61KR3dSnOg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hDVoH-0007Ef-2v; Mon, 08 Apr 2019 17:03:45 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hDVoH-0007FJ-0P; Mon, 08 Apr 2019 17:03:45 +0200
From: Alberto Garcia <berto@igalia.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
In-Reply-To: <1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Mon, 08 Apr 2019 17:03:44 +0200
Message-ID: <w517ec4y1wv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block: include base when checking
 image chain for block allocation
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
Message-ID: <20190408150344.4aRXrpNi9ZO4Ab6PitJqrN0Eb8NrIBM0Rs7xn-1hS18@z>

On Fri 05 Apr 2019 06:56:17 PM CEST, Andrey Shinkevich wrote:
> +int bdrv_is_allocated_above(BlockDriverState *top,
> +                            BlockDriverState *base,
> +                            int64_t offset, int64_t bytes, int64_t *pnum)
> +{
> +    return bdrv_do_is_allocated_above(top, base, false, offset, bytes, pnum);
> +}
> +
> +int bdrv_is_allocated_above_inclusive(BlockDriverState *top,
> +                                      BlockDriverState *base,
> +                                      int64_t offset, int64_t bytes,
> +                                      int64_t *pnum)
> +{
> +    return bdrv_do_is_allocated_above(top, base, true, offset, bytes, pnum);
> +}

Instead of having these two, isn't it simpler to add an 'include_base'
parameter to the original function?

Another alternative (I haven't checked this one so it could be more
cumbersome): change the semantics of the function to always include the
base and modify the callers.

Berto

