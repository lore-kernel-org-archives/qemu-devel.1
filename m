Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7E6C46460
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6BF20862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6BF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43115 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTC8-0004k2-GR
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 04:53:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQTBI-0004Qj-Eq
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQTBH-0002KP-HZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:53:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hQTBH-0002FA-A1
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:53:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B04799C4B;
	Tue, 14 May 2019 08:52:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2FC5D720;
	Tue, 14 May 2019 08:52:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 154A21747D; Tue, 14 May 2019 10:52:58 +0200 (CEST)
Date: Tue, 14 May 2019 10:52:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190514085258.l6fxusydyu6hrt35@sirius.home.kraxel.org>
References: <155619222209.13917.4120344041326080857.malonedeb@gac.canonical.com>
	<155678383044.13902.634296520708639219.malone@wampee.canonical.com>
	<CAL9cFfOxjfmhx+E6Z8ha4ySk+o+dg6nHdY8KdHzbm6ttehBL0Q@mail.gmail.com>
	<20190514080414.ecsz7u5o2dozs27w@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514080414.ecsz7u5o2dozs27w@steredhat>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 14 May 2019 08:52:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Bug 1826393] Re: QEMU 3.1.0 stuck waiting for
 800ms (5 times slower) in pre-bios phase
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
Cc: Bug 1826393 <1826393@bugs.launchpad.net>,
	qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 10:04:14AM +0200, Stefano Garzarella wrote:
> On Mon, May 06, 2019 at 05:40:05PM -0000, Waldemar Kozaczuk wrote:
> > The last bios indeed helped. It knows runs under 200ms.
> > 
> > Do you anticipate doing minor release of 3.1.0 with updated bios to address
> > this issue? Or users are expected to upgrade to QEMU 4.0.0?
> 
> CCing Gerd
> 
> I'm not sure we will release SeaBIOS 1.12.1 with a minor release of QEMU
> 3.1.0, so upgrading to QEMU 4.0 should be the way to address this issue.

I think with the 4.0 release 3.1 is EOL and there will be no more 3.1.x
stable releases ...

cheers,
  Gerd


