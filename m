Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA3C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0445208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0445208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84sd-0000Om-4J
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i84ff-0005E8-23
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i84fd-00067X-0j
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:36:38 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:59706
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i84fc-00066m-Jn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:36:36 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i84fZ-0003Fz-EU; Wed, 11 Sep 2019 17:36:33 +0200
Message-ID: <45d6dc06b9973aa231f1076a0de279fd5292d2d3.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Sep 2019 17:36:32 +0200
In-Reply-To: <CAJSP0QXhOQg98FyLzcTnruG7B=b+uUqEd5HvevRKmuP3HhCSmw@mail.gmail.com>
 (sfid-20190911_173128_235736_D9071E83)
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <CAJSP0QXhOQg98FyLzcTnruG7B=b+uUqEd5HvevRKmuP3HhCSmw@mail.gmail.com>
 (sfid-20190911_173128_235736_D9071E83)
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
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-09-11 at 17:31 +0200, Stefan Hajnoczi wrote:

> > +``VHOST_USER_VQ_CALL``
> 
> "call" should be "kick".  "kick" is the driver->device request
> submission notification and "call" is the device->driver request
> completion notification.

Ahrg, yes. I confuse this all the time, sorry, will fix.

Btw, speaking of confusion ... this document may need some cleanup wrt.
the "client" language since it states that both sides might be a socket
server or client, but then goes on to talk about the "client" as though
it was equivalent to "slave", where normally it's actually the other way
around (the device is the one listening on the socket, i.e. it's the
server). This is most pronounced in the section "Starting and stopping
rings".

IMHO, it'd be good to talk more about "device" and "host" instead of
"slave" and "master" too since that's clearer, and just replace *all*
that language accordingly, but YMMV.

> > +  :id: 34
> > +  :equivalent ioctl: N/A
> > +  :slave payload: vring state description
> > +  :master payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS`` protocol feature has
> > +  been successfully negotiated, this message may be submitted by the master
> > +  to indicate that a buffer was added to the vring instead of signalling it
> > +  using the vring's event FD or having the slave rely on polling.
> > +
> > +  The state.num field is currently reserved and must be set to 0.
> 
> Please include an explanation of how this message is different from
> the existing methods.  Maybe something like:
> 
>   Unlike eventfd or polling, this message allows the master to control
> precisely when virtqueue processing happens.  When the master uses
> ``need_reply`` to receive a reply, it knows the device has become
> aware of the virtqueue activity.

Sure, thanks, I'll incorporate that.

> >  Slave message types
> >  -------------------
> > 
> > @@ -1246,6 +1265,19 @@ Slave message types
> >    ``VHOST_USER_PROTOCOL_F_HOST_NOTIFIER`` protocol feature has been
> >    successfully negotiated.
> > 
> > +``VHOST_USER_VQ_KICK``
> 
> s/KICK/CALL/

Indeed. Wait, that should be VHOST_USER_SLAVE_VQ_CALL, actually. Maybe I
already did fix that in v2?

johannes


