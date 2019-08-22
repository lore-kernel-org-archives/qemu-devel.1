Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFB5C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E804C2342E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E804C2342E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0iYl-0000tx-3p
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0iWH-0007yd-Gb
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0iWG-0008Lu-CB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:32:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0iWG-0008LB-6o
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:32:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DE37882F5;
 Thu, 22 Aug 2019 08:32:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EE5F5D9D3;
 Thu, 22 Aug 2019 08:32:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C205511AAF; Thu, 22 Aug 2019 10:32:26 +0200 (CEST)
Date: Thu, 22 Aug 2019 10:32:26 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20190822083225.iy5o7l4du4hty67u@sirius.home.kraxel.org>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
 <7f6e8a5c-8262-ae39-333a-e8f18b3174f0@redhat.com>
 <20190821064208.eckikvttpdc3zjmd@sirius.home.kraxel.org>
 <20190821133148.GA20226@morn.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821133148.GA20226@morn.lan>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 22 Aug 2019 08:32:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [SeaBIOS] Re: Regression with floppy drive
 controller
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
Cc: Alex <coderain@sdf.org>, Paolo Bonzini <pbonzini@redhat.com>,
 seabios@seabios.org, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 09:31:48AM -0400, Kevin O'Connor wrote:
> On Wed, Aug 21, 2019 at 08:42:08AM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > Using the default QEMU config, we build SeaBIOS to use the TSC timer:
> > > 
> > > builds/seabios-128k/.config:CONFIG_TSC_TIMER=y
> > > builds/seabios-256k/.config:CONFIG_TSC_TIMER=y
> > 
> > > Do we need a cpu with TSC support to run SeaBIOS?
> > 
> > Hmm.  seabios uses pmtimer if available.  isapc has no pmtimer though,
> > so it uses TSC instead.
> 
> But, SeaBIOS should have automatically detected no TSC and then fallen
> back to the PIT.  And the check does work correctly with "-cpu 486" in
> my tests.
> 
> Is the PIT not working for some reason in the original setup?  (Any
> time I attempt to run with "-M isapc" I just get an "Unable to unlock
> ram - bridge not found" error.)

Yep, that should be no problem, with isapc the ram is not locked in
the first place.

> The PIT seems to work okay in my
> setup.

Using the floppy image from
  https://winworldpc.com/download/49c380c2-a9c3-af25-c389-11c3a6e28094

qemu-system-x86_64 -cpu 486 -M isapc -fda win98se.raw         => fails
qemu-system-x86_64 -cpu 486,+tsc -M isapc -fda win98se.raw    => works

cheers,
  Gerd


