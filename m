Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74DFC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8694920830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n3oN6Xd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8694920830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDrbU-0008H2-ND
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:20:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDraB-0007fR-PU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDraA-0002r1-OB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:18:39 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:60034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hDraA-0002lL-3r; Tue, 09 Apr 2019 10:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=k+bbSN+CPBueCfqMGW2c7JqbyqbqeFJ3nYFAL3XaR4A=; 
	b=n3oN6Xd/49vr/YYXiIbXm5C8UXtAni/XBF8/FnW5Hg2lv9ZWOxfNxB0CVxjL8B4lHsrkXBa6s+l7hkrP7h9Xp4TKIx93pHT1Qvb7G+MwePifIcYAYUhLaB1Vx/YzwhaPYXGs1Gz9qrDVGBR9auV29WHruVOwNSYVX8hksQsDgSZdUHnaEMzisu303uCAntqJivOZfwiBvwWEfTJnpsNOTX0W+/xX5nbGMsi9+2pYY0PwwyYgmVAsTCPvtzcGZqTp9u5vsKUyzPpvfO935RGk47p+0hNaJxilLofHzQPZcNnEqU5AsnqrgCNqXdnP/ip8dme70g5d0I8eJv93ayaVNQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hDra4-0002eP-KI; Tue, 09 Apr 2019 16:18:32 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hDra4-0007MF-HA; Tue, 09 Apr 2019 16:18:32 +0200
From: Alberto Garcia <berto@igalia.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
In-Reply-To: <1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Tue, 09 Apr 2019 16:18:32 +0200
Message-ID: <w517ec345zb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block: include base when checking
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
Message-ID: <20190409141832.hNpObKp5XTQDwGTLHSGQbmKnIB6AxHgEKeX1SmvFUYI@z>

On Mon 08 Apr 2019 08:22:19 PM CEST, Andrey Shinkevich wrote:
>   * Return true if (a prefix of) the given range is allocated in any image
> - * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
> + * between BASE and TOP (TOP included). To check the BASE image, set the
> + * 'include_base' to 'true'. The BASE can be NULL to check if the given
>   * offset is allocated in any image of the chain.  Return false otherwise,
>   * or negative errno on failure.

I'm not a native speaker but that sounds a bit odd to me.

Alternative: 

  * Return true if (a prefix of) the given range is allocated in any image
  * between BASE and TOP (BASE is only included if include_base is set).
  * BASE can be NULL to check if the given offset is allocated in any
  * image of the chain.  Return false otherwise, or negative errno on
  * failure.

> -    while (intermediate && intermediate != base) {
> +    while (include_base || intermediate != base) {
>          int64_t pnum_inter;
>          int64_t size_inter;
>  
> @@ -2360,6 +2364,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>              n = pnum_inter;
>          }
>  
> +        if (intermediate == base) {
> +            break;
> +        }
> +
>          intermediate = backing_bs(intermediate);

I find that the new condition + the break make things a bit less
readable. I think it would be simpler with something like this:

   BlockDriverState *stop_at = include_base ? backing_bs(base) : base;

   while (intermediate != stop_at) {
      ...
   }

(stop_at is a terrible name, but I can't think of anything better at the
moment)

Berto

