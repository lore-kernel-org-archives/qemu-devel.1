Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287AAC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009A920578
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009A920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MrK-0004IZ-B5
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1i3Mpf-0003Y8-OP
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1i3Mpe-0005iB-LC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:59:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>)
 id 1i3Mpb-0005dP-6i; Thu, 29 Aug 2019 11:59:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2F66A309B68B;
 Thu, 29 Aug 2019 15:59:25 +0000 (UTC)
Received: from ptitpuce (ovpn-116-165.ams2.redhat.com [10.36.116.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1180C60F88;
 Thu, 29 Aug 2019 15:59:16 +0000 (UTC)
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
Date: Thu, 29 Aug 2019 17:59:13 +0200
Message-ID: <m1mufsdktq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 29 Aug 2019 15:59:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com, armbru@redhat.com,
 mreitz@redhat.com, abologna@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow writes:
[...]
>
> This might be OK to do right away, though.
>
> I asked Markus this not too long ago; do we want to amend the QAPI
> schema specification to allow commands to return with "Warning" strings,
> or "Deprecated" stings to allow in-band deprecation notices for cases
> like these?
>
> example:
>
> { "return": {},
>   "deprecated": True,
>   "warning": "Omitting filter-node-name parameter is deprecated, it will
> be required in the future"
> }
>
> There's no "error" key, so this should be recognized as success by
> compatible clients, but they'll definitely see the extra information.
>
> Part of my motivation is to facilitate a more aggressive deprecation of
> legacy features by ensuring that we are able to rigorously notify users
> through any means that they need to adjust their scripts.

I like this approach even if there is no consumer today. It does not
hurt, and it is indeed a motivation to develop consumers that care.

I personally find this much easier to swallow than any kind of crash on
deprecation, which already at the BoF seemed like a really big hammer to
kill a fly.

CC'ing Andrea as well, because we discussed recently about how to deal
with error checking in general, and if a new error checking framework is
being put in place, adding deprecation to the thinking could be a good
idea.

--
Cheers,
Christophe de Dinechin (IRC c3d)

