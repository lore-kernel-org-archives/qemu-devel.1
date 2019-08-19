Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA39EC3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 10:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99EEE20578
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 10:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EEE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzf60-0004bs-KK
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 06:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1hzf58-00046l-GJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 06:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hzf57-0001rQ-59
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 06:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hzf56-0001qv-Vm
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 06:40:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DC6AA28883
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 10:40:08 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE59A9A060;
 Mon, 19 Aug 2019 10:40:04 +0000 (UTC)
Date: Mon, 19 Aug 2019 11:40:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190819104001.GF12960@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
 <20190814020218.1868-7-quintela@redhat.com>
 <20190819095228.GC12960@redhat.com> <87tvad30mu.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvad30mu.fsf@trasno.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 19 Aug 2019 10:40:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/6] RFH: We lost "connect" events
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 12:33:45PM +0200, Juan Quintela wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Wed, Aug 14, 2019 at 04:02:18AM +0200, Juan Quintela wrote:
> >> When we have lots of channels, sometimes multifd migration fails
> >> with the following error:
> >>   after some time, sending side decides to send another packet throu=
gh
> >>   that channel, and it is now when we get the above error.
> >>=20
> >> Any good ideas?
> >
> > In inet_listen_saddr() we call
> >
> >     if (!listen(slisten, 1)) {
> >
> > note the second parameter sets the socket backlog, which is the max
> > number of pending socket connections we allow. My guess is that the
> > target QEMU is not accepting incoming connections quickly enough and
> > thus you hit the limit & the kernel starts dropping the incoming
> > connections.
> >
> > As a quick test, just hack this code to pass a value of 100 and see
> > if it makes your test reliable. If it does, then we'll need to figure
> > out a nice way to handle backlog instead of hardcoding it at 1.
>=20
> I will test.
>=20
> But notice that the qemu_connect() on source side says that things went
> right.  It is the destination what is *not* calling the callback.  Or
> at least that is what I think it is happening.

IIRC, the connect() can succeed on the source host, even if the target ho=
st
has not called accept(), because the kernel will complete the connection =
at
the protocol level regardless. IOW, don't assume that the destination QEM=
U
has seen the connection. If you turn on tracing, we have a trace point
"qio_channel_socket_accept_complete" that is emitted after we have done
an accept(). So you can see if you get 100 of those trace points emitted
on the target, when you make 100 connects on the source.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

