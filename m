Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E01C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 10:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDC320851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 10:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDC320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzfEg-00006h-NR
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 06:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1hzfE2-00087a-GS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 06:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hzfE1-0006eq-DZ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 06:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hzfE1-0006eQ-8G
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 06:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 944AF4628B
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 10:49:20 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED778CBF7;
 Mon, 19 Aug 2019 10:49:19 +0000 (UTC)
Date: Mon, 19 Aug 2019 11:49:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190819104916.GG12960@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
 <20190814020218.1868-7-quintela@redhat.com>
 <20190819095228.GC12960@redhat.com> <87pnl1301v.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnl1301v.fsf@trasno.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 19 Aug 2019 10:49:20 +0000 (UTC)
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

On Mon, Aug 19, 2019 at 12:46:20PM +0200, Juan Quintela wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Wed, Aug 14, 2019 at 04:02:18AM +0200, Juan Quintela wrote:
> >> When we have lots of channels, sometimes multifd migration fails
> >> with the following error:
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
> Nice.
>=20
> With this change I can create 100 channels on a 4 core machine without
> any trouble.
>=20
> How can we proceed from here?

I don't think we want to expose this in the QAPI schema for the socket
address, since the correct value is really something that QEMU should
figure out based on usage context.

Thus, I think we'll have to make it an explicit parameter to the
qio_channel_socket_listen_{sync,async} APIs, and socket_listen()
and inet_listen_saddr(), etc. Then the migration code can pass in
a sensible value based on multifd usage.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

