Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FA9C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AFA214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AFA214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfgcC-0002jD-VX
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48431)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hfgaL-0001VQ-SX
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hfgaK-0000YN-UL
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hfgaA-0000Ju-1H; Tue, 25 Jun 2019 04:13:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37803308626C;
 Tue, 25 Jun 2019 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-23.ams2.redhat.com
 [10.36.117.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6495A1001B00;
 Tue, 25 Jun 2019 08:13:33 +0000 (UTC)
Date: Tue, 25 Jun 2019 10:13:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190625081331.GB5187@localhost.localdomain>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190617114544.GE7397@linux.fritz.box>
 <09632364-3d1d-9e5c-a050-f48f76d2e38c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09632364-3d1d-9e5c-a050-f48f76d2e38c@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 25 Jun 2019 08:13:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: new file to suppress
 Valgrind errors
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.06.2019 um 18:55 hat Andrey Shinkevich geschrieben:
> 
> 
> On 17/06/2019 14:45, Kevin Wolf wrote:
> > Am 11.06.2019 um 20:02 hat Andrey Shinkevich geschrieben:
> >> The Valgrind tool reports about an uninitialised memory usage when the
> >> initialization is actually not needed. For example, the buffer 'buf'
> >> instantiated on a stack of the function guess_disk_lchs().
> > 
> > I would be careful with calling initialisation "not needed". It means
> > that the test case may not behave entirely determinstic because the
> > uninitialised memory can vary between runs.\
> 
> I am going to amend the comment.
> 
> Andrey
> 
> > 
> > In this specific case, I assume that guess_disk_lchs() is called for a
> > null block node, for which .bdrv_co_preadv by default returns without
> > actually writing to the buffer. Instead of ignoring the valgrind error,
> > we could instead pass read-zeroes=on to the null block driver to make
> > the test deterministic.
> 
> The buffer that the Valgrind complains of is initialized by the 
> following function call blk_pread_unthrottled() that reads the first 
> BDRV_SECTOR_SIZE bytes form a disk "to guess the disk logical geometry". 
> The Valgrind does not recognize that way of initialization. I believe we 
> do not need to zero the buffer instantiated on the stack just to make 
> the Valgrind silent there.

My point is that blk_pread_unthrottled() with null-co/null-aio leaves
the buffer untouched if read-zeroes=off (which is the default). So yes,
valgrind is right, this memory is still uninitialised after
blk_pread_unthrottled().

Kevin

