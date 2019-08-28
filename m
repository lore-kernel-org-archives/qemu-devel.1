Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9277F205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9277F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2u0u-00031X-LR
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2u0D-0002Xm-8B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2u0C-0003sQ-4a
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i2u0B-0003s4-Vl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:12:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 011F518C8905;
 Wed, 28 Aug 2019 09:12:27 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73E33600D1;
 Wed, 28 Aug 2019 09:12:22 +0000 (UTC)
Message-ID: <af80ef9c250e9ff87fe7b2d8e5cd496dac9c90c3.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Zolt=C3=A1n_K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Date: Wed, 28 Aug 2019 12:12:21 +0300
In-Reply-To: <20190828073327.ysojya4vp73ayjr2@sirius.home.kraxel.org>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <43076a2afeb0439b607b0631e0bfff77d55bc0cc.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827054223.nuiz7fz27tld3hpt@sirius.home.kraxel.org>
 <2fdc616c-0690-a898-0247-765f90153903@gmail.com>
 <20190828073327.ysojya4vp73ayjr2@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 28 Aug 2019 09:12:27 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-28 at 09:33 +0200, Gerd Hoffmann wrote:
> > > Hmm, can we create an useful name automatically, without yet another
> > > config option?
> > > 
> > > Useful choices could be the device name (usb-audio, ...) or the device
> > > id (whatever -device id=xxx was specified on the command line).
> > 
> > I'm afraid this is not going to work with the current architecture: due
> > to mixeng even if you have multiple devices, they'll be mixed to a
> > single stream and the audio backend will only see this one mixed stream.
> >  As a workaround we could do something like concat all device names or
> > ids, but I don't like that idea.
> > 
> > Alternatively we could use the id of the audiodev instead, and no more
> > problems with mixeng.  However, with mixeng off (implemented in my next
> > patch series) suddenly soundcards will have suddenly end up as different
> > streams.  (This can be worked around by creating multiple audiodevs,
> > like what you have to use now to get multiple streams from pa, so this
> > is probably a smaller problem.)
> > 
> > Currently I'm leaning for the audiodev's id option, unless someone
> > proposes something better.
> 
> Hmm, maybe just wait and see if we really need that?
> 
> If we use the vm name for the pa connection I suspect most use cases are
> covered ...

My personal opinion would be, to use vm name for the connection (will cover
use case of distinguishing between VMs)
and using audiodev derived name for stream names, which will at least
partially cover the use case of having more that one guestn's soundcard,
and assigning each to different host sound card dynamically,
that is  using pavucontrol, which is what I wanted to do in first place.
This is also should be the easiest to do probably.

Best regards,
	Maxim Levitsky




