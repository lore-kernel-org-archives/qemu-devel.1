Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E15C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8927C20707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu861tJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8927C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefrf-0001yC-Nb
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jefPa-0004el-RO
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:51:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jefPZ-0001nZ-4s
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590760260;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9KEu13BuoksDvm3c3vh+oBT4JcND2MUoE0D9C8o980=;
 b=Mu861tJAHZgykzdebD7ygB3yp1hZBmPnn5OBuZwCdU7PQdm1rvCim/XYoNyW+hZ8hRhugl
 ggu8+SgaFY4017EAd4pHG7rR9VkC3OomuJcuT3HI4CZY+/6EFMmjohB2mQukd8Pg0xo8CY
 6QiR5Rz5eyV7YC02hK0dxaIZO72vepQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-r6KQFh6pPxq0z0BKrAYJ6A-1; Fri, 29 May 2020 09:50:51 -0400
X-MC-Unique: r6KQFh6pPxq0z0BKrAYJ6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 656001005510;
 Fri, 29 May 2020 13:50:50 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4903A7A8CA;
 Fri, 29 May 2020 13:50:45 +0000 (UTC)
Date: Fri, 29 May 2020 14:50:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Libguestfs] Provide NBD via Browser over Websockets
Message-ID: <20200529135042.GJ2755532@redhat.com>
References: <alpine.LRH.2.11.1810131833150.18520@mx.ewheeler.net>
 <CAMRbyytcufK8-XdFu7LU+UwO_FRoGJO2FhhBHtH9etf3A2htwQ@mail.gmail.com>
 <alpine.LRH.2.11.2005280014150.13970@mail.ewheeler.net>
 <20200528090443.GN7304@redhat.com>
 <alpine.LRH.2.11.2005282147410.13970@mail.ewheeler.net>
 <20200529093744.GS3888@redhat.com>
 <13571029-5bf4-2dfa-6879-0ad2642afb3f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <13571029-5bf4-2dfa-6879-0ad2642afb3f@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eric Wheeler <nbd@lists.ewheeler.net>, QEMU <qemu-devel@nongnu.org>,
 "Richard W.M. Jones" <rjones@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 nbd@other.debian.org, libguestfs <libguestfs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 07:50:14AM -0500, Eric Blake wrote:
> [adding qemu list]
> 
> On 5/29/20 4:37 AM, Richard W.M. Jones wrote:
> > Going back to the original email from 2018:
> > 
> > > It might be neat to attach ISOs to KVM guests via websockets.Ã‚Â  Basically
> > > theÃ‚Â  browser would be the NBD "server" and an NBD client would run on the
> > > hypervisor, then use `virsh change-media vm1 hdc --insert /dev/nbd0` could
> > > use an ISO from my desk to boot from.
> > > 
> > > Here's an HTML5 open file example:
> > > https://stackoverflow.com/questions/3582671/how-to-open-a-local-disk-file-with-javascript
> > > 
> > > and the NBD protocol looks simple enough to implement in javascript:
> > > https://stackoverflow.com/questions/17295140/where-is-the-network-block-device-format-describled
> > 
> > So I think what you mean here is that in a browser you'd open a local
> > (eg) ISO, and then that ISO could be shared with a remote VM.  The
> > browser runs a Javascript NBD server.  The remote VM is qemu.  Between
> > the two is a WebSocket.
> > 
> > I've seen this being done with an HP blade server of some kind and
> > IIRC the client side used a Java applet.  No idea what the protocol
> > was but likely something proprietary.  It was nevertheless a useful
> > feature, eg to boot the server from an install CD that you have
> > locally.
> > 
> > I guess the problem is two-fold:
> > 
> > (1) You need to write an NBD server in Javascript.  Not especially
> > difficult, particularly if you avoid any complicated features, and I
> > guess you only need read support.
> 
> Or use an existing NBD server over a Unix socket paired to a WebSocket proxy
> that forwards all traffic from the Unix socket over a WebSocket. That may be
> easier than writing the NBD server itself in Javascript.
> 
> > 
> > (2) You need to persuade qemu's NBD client to read from a WebSocket.
> > I didn't really know anything about WebSockets until today but it
> > seems as if they are a full-duplex protocol layered on top of HTTP [a].
> > Is there a WebSocket proxy that turns WS into plain TCP (a bit like
> > stunnel)?  Google suggests [b].
> > 
> > [a] https://en.wikipedia.org/wiki/WebSocket#Protocol_handshake
> > [b] https://github.com/novnc/websockify
> 
> qemu already knows how to connect as a client to websockets; Dan Berrange
> knows more about that setup.  I suspect it would not be too difficult to
> teach the qemu NBD client code to use a WebSocket instead of a Unix or TCP
> socket as its data source.

Actually the inverse. The QIOChannelWebsocket impl is only the server
side of the problem, as used by QEMU's VNC server. We've never implemented
the client side. There is nothing especially stopping us doing that - just
needs someone motivated with time to work on it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


