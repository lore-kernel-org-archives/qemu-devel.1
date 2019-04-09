Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40241C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092702064B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EpZ2MK/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092702064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42730 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDs45-0007uM-3d
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:49:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDs2y-0007K3-36
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDs2x-0002e6-9O
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:48:24 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:39194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hDs2w-0002aU-JX; Tue, 09 Apr 2019 10:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=XhTAqjAJUo/n5OIbPeRjaAmmxG/4TL62kJWkaM5PBZU=; 
	b=EpZ2MK/DwXSk7CvBV3QovNFlEhP4fER5Mp4KOOxpC56HBIftatUQl4DkEvZH3mRxv9ltD6prgqzUWL1DDJKN5Tczz6QFwFevXaYcqiXjDKy7MBlzuftViDCU6nPWygslNDh0p3SsO8umvIY9iiWL9OZlz07DwW6saoilYJBvtF/bYvT3EgEU/aaWhv9gfpiY6OgGFGJaBE7MqfRZspJWhqbrLiaeltWHZiUu1IapdQaEEpm82JVPudu9kbbo+K+kotZx13vQ/Cbp6hYNEhC8f4HeISawTUbxTpX6zIufFP1YpQr4OyFP2eu51L+nvx5D+QB6vVwV7iy8yfRtngifAA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hDs2s-0007RX-90; Tue, 09 Apr 2019 16:48:18 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hDs2s-0006iE-67; Tue, 09 Apr 2019 16:48:18 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel\@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block\@nongnu.org" <qemu-block@nongnu.org>
In-Reply-To: <e27a15f8-c299-7a08-3594-680aa1342b2b@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec345zb.fsf@maestria.local.igalia.com>
	<e27a15f8-c299-7a08-3594-680aa1342b2b@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Tue, 09 Apr 2019 16:48:18 +0200
Message-ID: <w514l7744lp.fsf@maestria.local.igalia.com>
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409144818.gNSBF9jIrODUvHlp_dRrbdWdmhDn5pjDdFqG7HxegAs@z>

On Tue 09 Apr 2019 04:43:12 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> -    while (intermediate && intermediate != base) {
>>> +    while (include_base || intermediate != base) {
>>>           int64_t pnum_inter;
>>>           int64_t size_inter;
>>>   
>>> @@ -2360,6 +2364,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
>>>               n = pnum_inter;
>>>           }
>>>   
>>> +        if (intermediate == base) {
>>> +            break;
>>> +        }
>>> +
>>>           intermediate = backing_bs(intermediate);
>> 
>> I find that the new condition + the break make things a bit less
>> readable. I think it would be simpler with something like this:
>> 
>>     BlockDriverState *stop_at = include_base ? backing_bs(base) : base;
>> 
>>     while (intermediate != stop_at) {
>>        ...
>>     }
>> 
>
> But in this way you return back dependence on base, which we don't
> freeze and which may disappear on some iteration. We should not touch
> backing_bs(base) in any way.

Ok, I see.

Reviewed-by: Alberto Garcia <berto@igalia.com>

(feel free to edit the comment with my suggestion, or leave it as it is
if you prefer)

Berto

