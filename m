Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3BBC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC142089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC142089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7iBF-0007xc-Tr
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i7iAZ-0007Ss-NL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i7iAY-000215-OU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:35:03 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:56066
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i7iAY-0001yR-IQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:35:02 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i7iAU-00017f-BD; Tue, 10 Sep 2019 17:34:58 +0200
Message-ID: <f4d1a66f6ff407f9aaec77f1125effe5cf10467b.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 10 Sep 2019 17:34:57 +0200
In-Reply-To: <20190910112937-mutt-send-email-mst@kernel.org>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
 <20190909160039.GC20875@stefanha-x1.localdomain>
 <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
 <20190910150319.GB31674@stefanha-x1.localdomain>
 <e114b68dffecd9b4c4666327b15a28098c83f7ec.camel@sipsolutions.net>
 <20190910112937-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-09-10 at 11:33 -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 10, 2019 at 05:14:36PM +0200, Johannes Berg wrote:
> > Is any of you familiar with the process of getting a virtio device ID
> > assigned, and if so, do you think it'd be feasible? Without that, it'd
> > probably be difficult to upstream the patch to support this protocol to
> > user-mode Linux.
> 
> Sure, subscribe then send a patch to virtio-comment@lists.oasis-open.org

Ok, great.

> We do expect people to eventually get around to documenting the device
> and upstreaming it though. If there's no plan to do it at all, you might
> still be able to reuse the virtio code, in that case let's talk.

Right, no, I do want to and am working on the code now, but it's a bit
of a chicken & egg - without an ID I can't really send any code upstream
:-)

I can accompany the request for a new ID with working patches.

What kind of documentation beyond the header file should be added, and
where?

johannes


