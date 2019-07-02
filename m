Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED042C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98DA206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sLNuyJvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98DA206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJQI-0003ck-2A
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hiJNI-0001wq-Mc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hiJNA-0004rQ-97
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:03:07 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:35547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hiJMs-0004OR-Dc; Tue, 02 Jul 2019 10:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=WvdPChE9kg7W94tREuy/qRNeRC6hXf6GOi9gE4gqVNc=; 
 b=sLNuyJvmbQyvYKnb+Qorr+b93hoK0DewNBvF8jiCv9bGpHjnRzxevY8rpPm1T1DB7dwBABMWf5fVFt7JIzf3IR8OzMyB5IXzkyCg5yh3gnC2PqpSwVHznUHzS/1rfZeesZiajbLnDaYBQLBdY0ebCC4XLh66lPMz6sd6IQTTl5Iru9II3QJdfhEsFN57c7HhW8hv3nxTwRYhsxyTaR/7MXvrbx0vQky/ZO56p5iUZHHSQAoSGLSMp50G1WPUbcFih4t/sTuzuqvB9AaOCl+tFc2+A9sfAImKNHEGhnqDCdKnkbVk+07FerfOngXOQO3VB2BR8ySDFEza9nOOs1iueg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hiJMl-0007Jy-Jn; Tue, 02 Jul 2019 16:02:39 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hiJMl-0007ry-H6; Tue, 02 Jul 2019 16:02:39 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190627223255.3789-2-mreitz@redhat.com>
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-2-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 02 Jul 2019 16:02:39 +0200
Message-ID: <w51v9wk5ybk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH 1/5] block: Add BDS.never_freeze
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 28 Jun 2019 12:32:51 AM CEST, Max Reitz wrote:
> @@ -4416,6 +4416,14 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
>          return -EPERM;
>      }
>  
> +    for (i = bs; i != base; i = backing_bs(i)) {
> +        if (i->backing && backing_bs(i)->never_freeze) {
> +            error_setg(errp, "Cannot freeze '%s' link to '%s'",
> +                       i->backing->name, backing_bs(i)->node_name);
> +            return -EPERM;
> +        }
> +    }

How about adding this to bdrv_is_backing_chain_frozen() instead?

Berto

