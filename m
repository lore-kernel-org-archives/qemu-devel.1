Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C10CC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0140620679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0140620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVNZ-0007Sy-6t
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46243)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxVN4-00073A-Jx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxVN3-0006Uv-ER
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:53:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxVN3-0006UF-8x
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:53:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F42C30832DC;
 Tue, 13 Aug 2019 11:53:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D64B26FDB;
 Tue, 13 Aug 2019 11:53:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8518916E32; Tue, 13 Aug 2019 13:53:32 +0200 (CEST)
Date: Tue, 13 Aug 2019 13:53:32 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190813115332.yxbofiahissks6zm@sirius.home.kraxel.org>
References: <20190813111809.3141-1-kraxel@redhat.com>
 <CAFEAcA9QnntNxWQmNG7_oM=tOb0-xhxKA3JED8GhPOeDtjNJ4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9QnntNxWQmNG7_oM=tOb0-xhxKA3JED8GhPOeDtjNJ4Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 13 Aug 2019 11:53:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/15] Audio 20190813 patches
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Walle <michael@walle.cc>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 13, 2019 at 12:22:01PM +0100, Peter Maydell wrote:
> On Tue, 13 Aug 2019 at 12:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > The following changes since commit 5e7bcdcfe69ce0fad66012b2cfb2035003c37eef:
> >
> >   display/bochs: fix pcie support (2019-08-12 16:36:41 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kraxel.org/qemu tags/audio-20190813-pull-request
> >
> > for you to fetch changes up to 7f6f83e89de6967db66a87f7ceb7be3c02a24d56:
> >
> >   audio: Add missing fall through comments (2019-08-13 12:17:57 +0200)
> >
> > ----------------------------------------------------------------
> > audio: second batch of -audiodev support, adding support for multiple backends.
> >
> > ----------------------------------------------------------------
> 
> We're still in freeze for 4.1 and will be until at least Thursday...

Sure, I didn't expect it to be merged right away.  I just started
collecting the patches which have piled up during the freeze into
(post-freeze) pull requests.

cheers,
  Gerd


