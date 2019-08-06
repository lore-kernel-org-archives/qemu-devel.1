Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBAC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 09:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33D22089E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 09:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33D22089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59961 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huw8A-0006w4-3G
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 05:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1huw7f-0006S7-3t
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1huw7e-0003ql-5x
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:51:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1huw7c-0003pe-0t; Tue, 06 Aug 2019 05:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 558843082B15;
 Tue,  6 Aug 2019 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-113.ams2.redhat.com
 [10.36.117.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49EA95D6D0;
 Tue,  6 Aug 2019 09:51:07 +0000 (UTC)
Date: Tue, 6 Aug 2019 11:51:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190806095106.GA5849@localhost.localdomain>
References: <20190801151744.798-1-kwolf@redhat.com>
 <20190801151744.798-3-kwolf@redhat.com>
 <976a878d-0344-8cb6-aa4b-d8e540bb1eaf@redhat.com>
 <20190802140727.GD6379@localhost.localdomain>
 <730161d3-4ed9-d213-9801-9cf38ce47446@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <730161d3-4ed9-d213-9801-9cf38ce47446@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 06 Aug 2019 09:51:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: Enable -d for Python
 non-unittest tests
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.08.2019 um 00:19 hat John Snow geschrieben:
> 
> 
> On 8/2/19 10:07 AM, Kevin Wolf wrote:
> > Am 01.08.2019 um 19:57 hat Max Reitz geschrieben:
> >> On 01.08.19 17:17, Kevin Wolf wrote:
> >>> The part of iotests.main() that is related to the implementation of the
> >>> debug option -d and enables QEMU and QMP logging is not only useful in
> >>> tests that use the Python unittest framework, but also in tests that
> >>> work by comparing with a reference output.
> >>>
> >>> Factor these parts out into iotests.init() and call it from the test
> >>> cases that currently lack support for debug output.
> >>
> >> How does this relate to
> >> https://lists.nongnu.org/archive/html/qemu-block/2019-07/msg01212.html ?
> > 
> > Hm, no idea? :-)
> > 
> > Looks like John's patch depends on some other patches which would then
> > conflict with mine, too, so maybe I'll just drop my patch and wait what
> > happens?
> > 
> > John, any opinion?
> > 
> > Kevin
> > 
> 
> My patches do roughly the same plus a little more. If you don't mind
> waiting, I can take care of this for you when the tree reopens?

Okay, I'll drop my patch then.

Kevin

