Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A371DC3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 09:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D0520989
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 09:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D0520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzeLp-0002lr-Er
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 05:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1hzeL5-0001vX-I9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hzeL4-0003vl-5x
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:52:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hzeL3-0003vN-Tz
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8150F1089044
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 09:52:32 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F931DA;
 Mon, 19 Aug 2019 09:52:31 +0000 (UTC)
Date: Mon, 19 Aug 2019 10:52:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190819095228.GC12960@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
 <20190814020218.1868-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814020218.1868-7-quintela@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 19 Aug 2019 09:52:32 +0000 (UTC)
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

On Wed, Aug 14, 2019 at 04:02:18AM +0200, Juan Quintela wrote:
> When we have lots of channels, sometimes multifd migration fails
> with the following error:
> 
> (qemu) migrate -d tcp:0:4444
> (qemu) qemu-system-x86_64: multifd_send_pages: channel 17 has already quit!
> qemu-system-x86_64: multifd_send_pages: channel 17 has already quit!
> qemu-system-x86_64: multifd_send_sync_main: multifd_send_pages fail
> qemu-system-x86_64: Unable to write to socket: Connection reset by peer
> info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> decompress-error-check: on
> clear-bitmap-shift: 18
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off multifd: on dirty-bitmaps: off postcopy-blocktime: off late-block-activate: off x-ignore-shared: off
> Migration status: failed (Unable to write to socket: Connection reset by peer)
> total time: 0 milliseconds
> 
> On this particular example I am using 100 channels.  The bigger the
> number of channels, the easier that it is to reproduce.  That don't
> mean that it is a good idea to use so many channels.
> 
> With the previous patches on this series, I can run "reliabely" on my
> hardware with until 10 channels.  Most of the time.  Until it fails.
> With 100 channels, it fails almost always.
> 
> I thought that the problem was on the send side, so I tried to debug
> there.  As you can see for the delay, if you put any
> printf()/error_report/trace, you can get that the error goes away, it
> is very timing sensitive.  With a delay of 10000 microseconds, it only
> works sometimes.
> 
> What have I discovered so far:
> 
> - send side calls qemu_socket() on all the channels.  So it appears
>   that it gets created correctly.
> - on the destination side, it appears that "somehowe" some of the
>   connections are lost by the listener.  This error happens when the
>   destination side socket hasn't been "accepted", and it is not
>   properly created.  As far as I can see, we have several options:
> 
>   1- I don't know how to use properly qio asynchronously
>      (this is one big posiblity).
> 
>   2- glib has one error in this case?  or how qio listener is
>      implemented on top of glib.  I put lots of printf() and other
>      instrumentation, and it appears that the listener io_func is not
>      called at all for the connections that are missing.
> 
>   3- it is always possible that we are missing some g_main_loop_run()
>      somewhere.  Notice how test/test-io-channel-socket.c calls it
>      "creatively".
> 
>   4- It is enterely possible that I should be using the sockets as
>      blocking instead of non-blocking.  But I am not sure about that
>      one yet.
> 
> - on the sending side, what happens is:
> 
>   eventually it call socket_connect() after all the async dance with
>   thread creation, etc, etc. Source side creates all the channels, it
>   is the destination side which is missing some of them.
> 
>   sending side sends the first packet by that channel, it "sucheeds"
>   and didn't give any error.
> 
>   after some time, sending side decides to send another packet through
>   that channel, and it is now when we get the above error.
> 
> Any good ideas?

In inet_listen_saddr() we call

    if (!listen(slisten, 1)) {

note the second parameter sets the socket backlog, which is the max
number of pending socket connections we allow. My guess is that the
target QEMU is not accepting incoming connections quickly enough and
thus you hit the limit & the kernel starts dropping the incoming
connections.

As a quick test, just hack this code to pass a value of 100 and see
if it makes your test reliable. If it does, then we'll need to figure
out a nice way to handle backlog instead of hardcoding it at 1.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

