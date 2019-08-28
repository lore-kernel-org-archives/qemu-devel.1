Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CA0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 07:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD962189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 07:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD962189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2sTC-0001Zu-P2
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 03:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i2sSR-0001AM-40
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 03:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i2sSP-0005Z5-JK
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 03:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i2sSP-0005Ya-Dy
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 03:33:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD8F7C01DE0D;
 Wed, 28 Aug 2019 07:33:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63AB55D713;
 Wed, 28 Aug 2019 07:33:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9A4E811AB5; Wed, 28 Aug 2019 09:33:27 +0200 (CEST)
Date: Wed, 28 Aug 2019 09:33:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Message-ID: <20190828073327.ysojya4vp73ayjr2@sirius.home.kraxel.org>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <43076a2afeb0439b607b0631e0bfff77d55bc0cc.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
 <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 28 Aug 2019 07:33:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/4] audio: paaudio: ability to specify
 stream name
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > Hmm, can we create an useful name automatically, without yet another
> > config option?
> > 
> > Useful choices could be the device name (usb-audio, ...) or the device
> > id (whatever -device id=xxx was specified on the command line).
> 
> I'm afraid this is not going to work with the current architecture: due
> to mixeng even if you have multiple devices, they'll be mixed to a
> single stream and the audio backend will only see this one mixed stream.
>  As a workaround we could do something like concat all device names or
> ids, but I don't like that idea.
> 
> Alternatively we could use the id of the audiodev instead, and no more
> problems with mixeng.  However, with mixeng off (implemented in my next
> patch series) suddenly soundcards will have suddenly end up as different
> streams.  (This can be worked around by creating multiple audiodevs,
> like what you have to use now to get multiple streams from pa, so this
> is probably a smaller problem.)
> 
> Currently I'm leaning for the audiodev's id option, unless someone
> proposes something better.

Hmm, maybe just wait and see if we really need that?

If we use the vm name for the pa connection I suspect most use cases are
covered ...

cheers,
  Gerd


