Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03A5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C687C20856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C687C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2twh-0000Sk-Vz
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i2tvq-00084d-H2
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i2tvp-0001N5-Fm
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i2tvp-0001MT-AW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:07:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 935D01027012;
 Wed, 28 Aug 2019 09:07:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18FB060CC0;
 Wed, 28 Aug 2019 09:07:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0DCEE1747D; Wed, 28 Aug 2019 11:07:53 +0200 (CEST)
Date: Wed, 28 Aug 2019 11:07:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190828090753.ho2stm7ppzej4zcb@sirius.home.kraxel.org>
References: <20190827192526.21780-1-laurent@vivier.eu>
 <20190828061103.u4l4inomwfvbodtn@sirius.home.kraxel.org>
 <79ea4476-f2ae-4b6f-1f65-48de3b0ffebd@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ea4476-f2ae-4b6f-1f65-48de3b0ffebd@vivier.eu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 28 Aug 2019 09:07:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC,Draft] ui: add an embedded Barrier client
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> >> +        p = write_short(ib, p, 1920); /* width */
> >> +        p = write_short(ib, p, 1080); /* height */
> > 
> > Hmm.
> > 
> > This is the screen size I guess?  Which you don't know ...
> > What this is used for?
> > Should we maybe use INPUT_EVENT_ABS_MAX here?
> > 
> 
> Yes, it's screen size but we can't use INPUT_EVENT_ABS_MAX.
> 
> In fact Barrier can manage more than 2 displays:
> 
>    0            x1           x2           x3
> 
> 0  +------------+------------+------------+---
>    |            |            |            |
>    |  localhost |    VM-1    |   VM-2     |
>    |            |            |            |
> y1 +------------+------------+------------+---
>    |            |            |            |
>    | remotehost |            |            |
>    |            |            |            |
> y2 +------------+------------+------------+---
>    |            |            |            |
> 
> So Barrier will send events to localhost while x(mouse) is between 0 and
> x1, to VM-1 while it is between x1 and x2, and to VM-2 between x2 and
> x3. So we need to know the size of the display to have x2.

Ok, I see.

> Normally when the barrier client runs into an OS it intercepts the
> screen resizing information and send them to the server. In our case we
> cannot (for instance if we use a vfio display)

Yes, for the vfio case we can't (unless it is a vgpu).

Otherwise looking up the DisplaySurface (via QemuConsole) and checking
the size should work.  Not a priority given that vfio is probably the
most interesting use case.

How does barrier send input events to physical machines btw?

> but I plan to add
> properties to the input-barrier object to provide the information at
> least statically.

Makes sense.

> The barrier server runs only on the machine with the mouse and the
> keyboard. Other machines have normally the barrier client daemon to
> inject the mouse and keyboard events in the OS.

Ok.

> I will try to add a keyboard remapping as we have with VNC because it
> doesn't work well with my french keyboard (AZERTY). Or perhaps I can use
> the "button" id instead of the keyid but I don't now how to map the
> value to a qcode.

Depends on how the button id is defined.  If it is one of the usual
keycodes it should be easy and should work better than reverse mapping.

cheers,
  Gerd


