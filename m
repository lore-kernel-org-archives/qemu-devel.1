Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF473C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 06:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841722084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 06:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841722084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy91t-0000D9-LA
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 02:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1hy918-0008De-7J
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hy917-0007A4-3B
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hy916-00079r-UL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:13:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0F0780F83
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 06:13:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61B891001281;
 Thu, 15 Aug 2019 06:13:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8288516E32; Thu, 15 Aug 2019 08:13:40 +0200 (CEST)
Date: Thu, 15 Aug 2019 08:13:40 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190815061340.gryxnfwaaoswqqi7@sirius.home.kraxel.org>
References: <20190813133042.11683-1-stefanha@redhat.com>
 <39b21ab6-bf1b-69c1-bbea-fb6f1b637132@redhat.com>
 <20190814132306.GF23970@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814132306.GF23970@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 15 Aug 2019 06:13:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] usb: reword -usb command-line option and
 mention xHCI
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > > -Enable the USB driver (if it is not used by default yet).
> > > +Enable USB emulation on machine types with an on-board USB host controller (if
> > > +not enabled by default).  Note that on-board USB host controllers may not
> > > +support USB 3.0.  In this case -device nec-usb-xhci can be used instead on
> > 
> > Should we maybe rather recommend qemu-xhci instead?
> 
> I think nec-usb-xhci is preferred because there are Windows drivers.
> IIRC qemu-xhci works under Linux but not under Windows (just because the
> PCI Vendor/Device ID aren't covered by any driver).
> 
> Gerd: Can you confirm this?

That applies to windows 7 only, which is EOL next year.

win7 doesn't ship with xhci drivers, but you can download and use
nec/renesas drivers which require nec-usb-xhci.

win8+ ships with generic xhci drivers which works with all xhci
hardware, including qemu-xhci.

So it indeed makes sense to refer to qemu-xhci.

cheers,
  Gerd


