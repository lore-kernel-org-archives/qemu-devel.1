Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B99C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4772087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4772087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQED-00031U-8W
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hsQDn-0002Vo-B6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hsQDm-00066L-D6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:23:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hsQDm-00065p-7u
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:23:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70B7C307D98D;
 Tue, 30 Jul 2019 11:23:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-54.ams2.redhat.com
 [10.36.116.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0095D600CC;
 Tue, 30 Jul 2019 11:23:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DB1DE11AB5; Tue, 30 Jul 2019 13:23:06 +0200 (CEST)
Date: Tue, 30 Jul 2019 13:23:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190730112306.75zb3rghqqwivwub@sirius.home.kraxel.org>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
 <20190409161009.6322-18-marcandre.lureau@redhat.com>
 <20190410084830.hiesbi6aumiwsdfk@sirius.home.kraxel.org>
 <CAJ+F1CL8jD9-Pu_G60uRr77QnLR5KhTJ4PfbN__A9pyYBCUpTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL8jD9-Pu_G60uRr77QnLR5KhTJ4PfbN__A9pyYBCUpTQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 30 Jul 2019 11:23:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 17/20] console: make screendump
 asynchronous
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > +        /*
> > > +         * FIXME: async save with coroutine? it would have to copy or
> > > +         * lock the surface.
> > > +         */
> > > +        ppm_save(dump->filename, surface, &err);
> >
> > DisplaySurface is just a thin layer above pixman images these days.
> > Pixman images are reference counted, so you can
> > pixman_image_ref(surface->image) to make sure it doesn't disappear
> > underneath you, then pass the pixman image to ppm_save.
> 
> ppm_save() is still synchronous. I suppose you suggested that for a
> future async version.

Yes.

> (note that in this case, ref the surface is
> probably not sufficient, as it could be mutated while it is being
> saved)

That can happen anyway.  The display surface / pixman image can be backed
by guest-writable memory (stdvga vram for example) and even when holding
the qemu lock the guest vcpu can write there ...

cheers,
  GerdY


