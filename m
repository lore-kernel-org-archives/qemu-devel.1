Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CAC76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 20:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BA32190F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 20:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BA32190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqjuE-0002mj-Fe
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 16:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hqju4-0002GZ-FM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 15:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hqju0-0007c7-Um
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 15:59:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hqju0-0007b4-Oh
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 15:59:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DDE9E4ACDF;
 Thu, 25 Jul 2019 19:59:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-30.ams2.redhat.com
 [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2032D5D71A;
 Thu, 25 Jul 2019 19:59:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81107113865F; Thu, 25 Jul 2019 21:59:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190725094937.32454-1-vsementsov@virtuozzo.com>
 <877e86gmof.fsf@dusky.pond.sub.org>
 <5579a1f8-2518-0cd3-3b0c-47cb4adcee73@redhat.com>
Date: Thu, 25 Jul 2019 21:59:42 +0200
In-Reply-To: <5579a1f8-2518-0cd3-3b0c-47cb4adcee73@redhat.com> (Eric Blake's
 message of "Thu, 25 Jul 2019 11:38:56 -0500")
Message-ID: <87wog5evgx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 25 Jul 2019 19:59:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] qapi: Add InetSocketAddress member
 keep-alive
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
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 berrange@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 7/25/19 10:26 AM, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> 
>>> It's needed to provide keepalive for nbd client to track server
>>> availability.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> 
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> It looks like this could go in any number of ways (Markus since it
> touches qapi, Dan since it touches sockets, or me since it was written
> for use with NBD); but unless anyone complains, I'm happy to queue this
> through my NBD tree for 4.2.

Go right ahead.

