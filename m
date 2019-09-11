Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4697C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACAA2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACAA2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84jD-0000Yg-OG
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i84FI-0007f6-Pn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i84FH-0007wB-Mh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:09:24 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:58528
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i84FH-0007vS-GD
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:09:23 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i84FE-0002ZE-LQ; Wed, 11 Sep 2019 17:09:20 +0200
Message-ID: <fedd74ed3e9cc554287b202e73b047a938515113.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 11 Sep 2019 17:09:18 +0200
In-Reply-To: <20190911095650-mutt-send-email-mst@kernel.org>
References: <20190911134539.25650-1-johannes@sipsolutions.net>
 <20190911134539.25650-2-johannes@sipsolutions.net>
 <20190911095650-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [RFC v2 1/2] docs: vhost-user: add in-band
 kick/call messages
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

On Wed, 2019-09-11 at 10:07 -0400, Michael S. Tsirkin wrote:
> 
> > +  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD        12
> > +  #define VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS 13
> 
> INFLIGHT so INBAND?

*shrug*, sure

> > +  instead of waiting for the call; however, if the protocol feature
> > +  ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` has been negotiated
> > +  it instead means the updates should be done using the messages.
> 
> Hmm I don't like this. I propose that with VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS
> we just don't allow VHOST_USER_SET_VRING_CALL (if you think it's
> important to allow them, we can say that we do not require them).

You can't actually skip SET_VRING_CALL, it's necessary to start a vring,
so libvhost-user for example calls dev->iface->queue_set_started() only
in this case. The docs in the "Starting and stopping rings" section also
explain this.

> But it's important for performance to be able to enable polling.

I don't think if you enable this you care about performance, after all
the whole point of it is to get REPLY_ACK for the in-band message.

> > +  When the ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` protocol
> > +  feature has been successfully negotiated, this message may be
> > +  submitted by the master to indicate that a buffer was added to
> > +  the vring instead of signalling it using the vring's event FD or
> 
> event -> kick?
> fd -> file descriptor

Sure.

> > +  having the slave rely on polling.
> 
> i think polling is a separate option and should be there with inband
> kicks.

See above. But I guess we could put a flag into bit 9 indicating that
you want to use messages instead of polling or a file descriptor, if you
prefer.

> > +``VHOST_USER_SLAVE_VRING_CALL``
> > +  :id: 4
> > +  :equivalent ioctl: N/A
> > +  :slave payload: vring state description
> > +  :master payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS`` protocol
> > +  feature has been successfully negotiated, this message may be
> > +  submitted by the slave to indicate that a buffer was used from
> > +  the vring instead of signalling this using the vring's kick FD or
> > +  having the master relying on polling.
> 
> call FD?

I confused this far too many times and thought I got it right finally,
but yes, you're right.

johannes


