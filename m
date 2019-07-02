Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D9CC46478
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF09B206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF09B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiDqv-000356-1Z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hiDpg-0002Yf-Mu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hiDpe-0001NS-Oo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hiDpc-00014X-PZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:08:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 821F6C057F2F;
 Tue,  2 Jul 2019 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-50.ams2.redhat.com
 [10.36.117.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B5495D9D6;
 Tue,  2 Jul 2019 08:07:36 +0000 (UTC)
Date: Tue, 2 Jul 2019 10:07:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190702080735.GA7894@localhost.localdomain>
References: <1563421561999343@sas2-ae5b5c0d8595.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563421561999343@sas2-ae5b5c0d8595.qloud-c.yandex.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 08:07:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Question about bdrv_co_invalidate_cache
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.07.2019 um 18:42 hat Yury Kotov geschrieben:
> Hi,
> 
> I just want to clarify the purpose of bdrv_co_invalidate_cache callback.
> IIUC on of the purposes of this callback is to "activate" BDRV (opposite of the
> bdrv_inactivate callback) on migration end, right?
> 
> E.g, if we have a custom BDRV which is backed by some network block storage with
> exclusive mount then on migration end bdrv_inactivate callback have to unmount
> this storage and bdrv_co_invalidate_cache have to mount it.
> 
> I'm not sure because of the name of bdrv_co_invalidate_cache callback. It looks
> like something that can be called in very different context, not only migration
> (may be not now, but in the future).
> 
> If there is another approach for my example, tell me about it, please.
> We have such custom BDRV with exclusive mount and want to realize migration
> support correctly.

Yes, you can consider bdrv_co_invalidate_cache/bdrv_co_inactivate a pair
of functions to activate/inactivate images. I think all of their callers
are related to migration currently, but it shouldn't make a difference
for you.

The name .bdrv_co_invalidate_cache hints at what usually needs to be
done on migration completion: Any previously read (meta)data must be
invalidated because the migration source (or more genereally: a second
process where the image was activated) may still have written to the
image.

Kevin

