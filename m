Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1379C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4642148E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FROKc3lf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4642148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54813 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDW8B-0007KG-O0
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:24:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDW6y-0006bK-0k
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDW6w-0000he-S6
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:23:03 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:45570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hDW6w-0000ea-9E; Mon, 08 Apr 2019 11:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=yZq6odYyvlrMScNrbk+/5i597Dw4Rg+TqU1ajGEGMeA=; 
	b=FROKc3lfI0BPBuqgLGil25SPCjhf8suQnAzpI+P3rAOMrMah28E8RnRgYy8DzaxSckLcA+CXmOUwBulETVE+YUxcqn62UjF5zCVMVza0OpFQy6qgNixzzfFXa0lIwq6F01aFkljs9da3rOYBk13bFhFenWGfVlzisBWZfo6cLydLm3eYaCZ3qp7XGNDtasMjLggwLM6UWE5tBxuqG90UhIMQjicR2cM/VtRIh8VoK7ueshcJSQZgAMilJpqIgck96WdE4LAmIqxipAFqnCYyApdJReN67WqKPGeWvBxCKrl4lYR1sgrw7NSMVZVbDDk8UCBKeZ5ROv9MpJswBGPu/Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hDW6s-0001jF-Ad; Mon, 08 Apr 2019 17:22:58 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hDW6s-0003e7-81; Mon, 08 Apr 2019 17:22:58 +0200
From: Alberto Garcia <berto@igalia.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel\@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block\@nongnu.org" <qemu-block@nongnu.org>
In-Reply-To: <3e489e51-79c7-54ec-7018-e7424d2c6f40@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec4y1wv.fsf@maestria.local.igalia.com>
	<3e489e51-79c7-54ec-7018-e7424d2c6f40@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Mon, 08 Apr 2019 17:22:58 +0200
Message-ID: <w514l78y10t.fsf@maestria.local.igalia.com>
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408152258.jcHcokhjbwl1r-o2EI17mtDRSjTeBiNF3hgb_QfOvI0@z>

On Mon 08 Apr 2019 05:16:22 PM CEST, Andrey Shinkevich wrote:
> On 08/04/2019 18:03, Alberto Garcia wrote:
>> On Fri 05 Apr 2019 06:56:17 PM CEST, Andrey Shinkevich wrote:
>>> +int bdrv_is_allocated_above(BlockDriverState *top,
>>> +                            BlockDriverState *base,
>>> +                            int64_t offset, int64_t bytes, int64_t *pnum)
>>> +{
>>> +    return bdrv_do_is_allocated_above(top, base, false, offset, bytes, pnum);
>>> +}
>>> +
>>> +int bdrv_is_allocated_above_inclusive(BlockDriverState *top,
>>> +                                      BlockDriverState *base,
>>> +                                      int64_t offset, int64_t bytes,
>>> +                                      int64_t *pnum)
>>> +{
>>> +    return bdrv_do_is_allocated_above(top, base, true, offset, bytes, pnum);
>>> +}
>> 
>> Instead of having these two, isn't it simpler to add an 'include_base'
>> parameter to the original function?
>> 
>> Another alternative (I haven't checked this one so it could be more
>> cumbersome): change the semantics of the function to always include the
>> base and modify the callers.
>
> The idea behind those two functions was to keep the rest of the code
> unmodified. Currently, we have the issue with the block-stream
> parallel jobs. What if we manage this case first and then, when proved
> to be robust, take care of the rest?

Sure, that makes sense if you need to do significant changes to the
other callers, but if you just need to pass an extra 'false'
parameter...

It's not a big deal, I just think you'd have a simpler patch.

Berto

