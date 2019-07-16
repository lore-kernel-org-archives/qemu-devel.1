Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9516CC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DA4205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DA4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnLas-0000zB-BT
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnLah-0000XA-Pw
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnLag-00019O-Rb
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnLae-00016p-RM; Tue, 16 Jul 2019 07:25:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5BF283F42;
 Tue, 16 Jul 2019 11:25:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-24.ams2.redhat.com [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04F99600C1;
 Tue, 16 Jul 2019 11:25:36 +0000 (UTC)
Date: Tue, 16 Jul 2019 13:25:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Message-ID: <20190716112535.GB7297@linux.fritz.box>
References: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
 <0bce1e99-fb98-6354-9426-391a3e9363f1@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bce1e99-fb98-6354-9426-391a3e9363f1@linux.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 16 Jul 2019 11:25:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [QEMU-SECURITY] ide: fix assertion in
 ide_dma_cb() to prevent qemu DoS from quest
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com, mdroth@linux.vnet.ibm.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.07.2019 um 13:24 hat Alexander Popov geschrieben:
> On 05.07.2019 17:07, Alexander Popov wrote:
> > This assertion was introduced in the commit a718978ed58a in July 2015.
> > It implies that the size of successful DMA transfers handled in
> > ide_dma_cb() should be multiple of 512 (the size of a sector).
> > 
> > But guest systems can initiate DMA transfers that don't fit this
> > requirement. Let's improve the assertion to prevent qemu DoS from quests.
> 
> Hello!
> 
> Just a friendly ping.
> 
> Could you have a look at this patch?

John, I think this is for you.

I haven't reviewed this yet, but if we put an assertion there that the
request is aligned, we probably rely on this fact somewhere in the code.
So I suspect that just changing the assertion without changing other
code, too, might not be enough.

Kevin

