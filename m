Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D08FC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BF12082C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BF12082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Ltm-0006Yj-Cz
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i7Lsy-0005rM-9h
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i7Lsx-0001UX-7n
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:47:24 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:49612
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i7Lsx-0001Sv-1J
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:47:23 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i7Lsu-0000I0-RY; Mon, 09 Sep 2019 17:47:20 +0200
Message-ID: <c603ed173bbf7c8dfb3f90368331a0e4e422f07d.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 09 Sep 2019 17:47:19 +0200
In-Reply-To: <20190909114358-mutt-send-email-mst@kernel.org>
References: <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
 <20190908091207-mutt-send-email-mst@kernel.org>
 <8a9cf8a1726afce7fed8992a4f19fc808004ef88.camel@sipsolutions.net>
 <20190909083902-mutt-send-email-mst@kernel.org>
 <89f25546ffa71c799c533e50658a3a58e066f436.camel@sipsolutions.net>
 <20190909094609-mutt-send-email-mst@kernel.org>
 <d2e750aaec396bd0aa7ea8c05ef5705567d16595.camel@sipsolutions.net>
 <20190909105057-mutt-send-email-mst@kernel.org>
 <49378faefb98abafb64ff105a7941c47395426e7.camel@sipsolutions.net>
 <f97477a5b16e69a4891c8da542f5002fe4cf2548.camel@sipsolutions.net>
 <20190909114358-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-09 at 11:45 -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 09, 2019 at 05:34:13PM +0200, Johannes Berg wrote:
> > On Mon, 2019-09-09 at 17:26 +0200, Johannes Berg wrote:
> > > Maybe instead we should just add a "VHOST_USER_REPLY_ERROR" bit (e.g.
> > > bit 4 after NEED_REPLY). Qemu in vhost_user_read_header() validates that
> > > it received REPLY_MASK | VERSION, so it would reject the message at that
> > > point.
> > > 
> > > Another possibility would be to define the highest bit of the 'request'
> > > field to indicate an error, so for GET_FEATURES we'd return the value
> > > 0x80000000 | GET_FEATURES.
> > 
> > However, one way or another, that basically leaves us with three
> > different ways of indicating an error:
> > 
> >  1) already defined errors in existing messages - we can't change them
> >     since those are handled at runtime now, e.g. VHOST_USER_POSTCOPY_END
> >     returns a u64 value with an error status, and current code cannot
> >     deal with an error flag in the 'request' or 'flags' field
> >  2) F_REPLY_ACK errors to messages that do not specify a response at all
> >  3) this new way of indicating an error back from messages that specify
> >     a response, but the response has no inherent way of returning an
> >     error
> > 
> > To me that really feels a bit too complex from the spec POV. But I don't
> > see a way to generalize this without another extension, and again the
> > device cannot choose which extensions it supports since the master
> > chooses them and just sets them.
> > 
> > Perhaps I really should just stick a "g_assert()" into the code at that
> > point,
> 
> There's the old way: close the socket.
> This will make reads fail gracefully.
> If we don't want complexity right now, I'd go with that.

D'oh, good point. OK, I'll do that. Though it's almost equivalent in
libvhost-user to just asserting, since it's mostly set up to just handle
a single connection and then quit.

Alright, thanks. Like I said, I'll send some more patches all around
once I get it working, right now I'm crashing in some weird ways that I
need to debug :)

johannes


