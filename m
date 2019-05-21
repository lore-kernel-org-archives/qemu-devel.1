Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDBBC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E960321019
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E960321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55964 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT76m-0001eD-VY
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:55:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hT762-0001Jl-KL
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hT760-00064U-GP
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:54:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hT75y-0005sS-Nd
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E027A3092656;
	Tue, 21 May 2019 15:54:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CEA96015E;
	Tue, 21 May 2019 15:54:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AFE7611AB8; Tue, 21 May 2019 17:53:58 +0200 (CEST)
Date: Tue, 21 May 2019 17:53:58 +0200
From: "kraxel@redhat.com" <kraxel@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190521155358.bjxpi3dpilq3qtnx@sirius.home.kraxel.org>
References: <c2a0ab8b-8229-29be-3658-1a2c52df65ad@virtuozzo.com>
	<502cc23b-3c83-9f05-098c-7193085ce9ca@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502cc23b-3c83-9f05-098c-7193085ce9ca@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 21 May 2019 15:54:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qemu vga crash
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
Cc: Denis Lunev <den@virtuozzo.com>,
	"ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
	qemu-devel <qemu-devel@nongnu.org>,
	"pjp@fedoraproject.org" <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 01:52:31PM +0000, Vladimir Sementsov-Ogievskiy wrote:
> Could anybody help?

How about doing your homework properly?

> > Hi Gerd!
> > 
> > Writing to you, as you were the last one who committed to vga_draw_graphic, hope you can help.
> > 
> > We faced the following crash in 2.12-based Qemu, but code seems not really changed:

Pretty lame excuse for not testing a more recent release or git master.

And you are wrong.  The code *has* changed,
and the bug has been fixed a year ago already.

commit a89fe6c329799e47aaa1663650f076b28808e186
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Mon May 14 12:31:17 2018 +0200

    vga: catch depth 0
    
    depth == 0 is used to indicate 256 color modes.  Our region calculation
    goes wrong in that case.  So detect that and just take the safe code
    path we already have for the wraparound case.
    
    While being at it also catch depth == 15 (where our region size
    calculation goes wrong too).  And make the comment more verbose,
    explaining what is going on here.
    
    Without this windows guest install might trigger an assert due to trying
    to check dirty bitmap outside the snapshot region.
    
    Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1575541
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
    Message-id: 20180514103117.21059-1-kraxel@redhat.com

cheers,
  Gerd


