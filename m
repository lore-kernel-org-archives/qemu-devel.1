Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00CBC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9A820665
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DMqqTyJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9A820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46305 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVG5y-000642-0c
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 09:55:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hVG4t-0005d4-9m
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hVG4s-0004PG-Dw
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:54:15 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:39210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hVG4o-0004JS-RI; Mon, 27 May 2019 09:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=g799s9PivlIJBRDt178wQzMnvAftF3Twta6USRV1MxA=; 
	b=DMqqTyJfL/o31P9jt1y+xiPTfFkx5veo89HsKEGcbx25rc6VBQweft4OCbWCi5PGhhXiFHg7n/H1rJkqyKULlkoO80028D/ZCYiFEF12o0NdWwc4d2wPM/RvIKWBKOWVr4N/2s/MPqmJXRgleg225dZBT2Kgo0zbZSieKYAt7XVgdWnGcTB7LayUKo11YAWP389ulQ64I9P58uK3sI6klJ+lUwXQPkOjnxfFKm4HTVJXQGmR//vIOY9nZnnnTuImH4Rda2BwtslsbFnaL0aFS5f6Qra32BZ6JUMJeAubKb8LiLyRDRkzoG6yx4knEIupO87WzdY2GC5MrLhfPWUK0Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hVG4d-0002Bi-Gc; Mon, 27 May 2019 15:53:59 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hVG4d-0002DB-Dk; Mon, 27 May 2019 15:53:59 +0200
From: Alberto Garcia <berto@igalia.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>,
	"qemu-block\@nongnu.org" <qemu-block@nongnu.org>
In-Reply-To: <80167166-a23a-6f10-c28b-a3a905f7ca6e@virtuozzo.com>
References: <20190524172812.27308-1-mreitz@redhat.com>
	<20190524172812.27308-2-mreitz@redhat.com>
	<w51ef4ljlt7.fsf@maestria.local.igalia.com>
	<66e86c16-c30c-5363-ef94-f01da8979872@redhat.com>
	<w515zpwrs30.fsf@maestria.local.igalia.com>
	<92b7c22d-06bb-f04a-0df1-7340c11be954@redhat.com>
	<80167166-a23a-6f10-c28b-a3a905f7ca6e@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Mon, 27 May 2019 15:53:59 +0200
Message-ID: <w51zhn880lk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [RFC 1/3] block: Add ImageRotationalInfo
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 27 May 2019 03:44:59 PM CEST, Anton Nefedov wrote:
>> I think in general optimizing for SSDs should probably be the
>> default.  HDDs are slow anyway, so whoever uses them probably doesn=E2=
=80=99t
>> care about performance too much anyway...?  Whereas people using SSDs
>> probably do.  But as I said, we can and should always make a separate
>> decision for each case.
>
> Overall it looks good to me but I wonder how do we ensure both
> variants are test covered? Need a blockdev option to enforce the mode?

Max talked about a 30% slowdown on HDDs so I suppose it makes sense to
have an option to change that even if we optimize for SSDs by default.

Berto

