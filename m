Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D57C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 20:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8D120734
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 20:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8D120734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfqgx-0002UZ-2e
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 16:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nbd@lists.ewheeler.net>)
 id 1jfqgF-0001zv-Cw
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 16:05:07 -0400
Received: from mx.ewheeler.net ([173.205.220.69]:38156 helo=mail.ewheeler.net)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nbd@lists.ewheeler.net>) id 1jfqgD-00019i-TE
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 16:05:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.ewheeler.net (Postfix) with ESMTP id B4E38A0694;
 Mon,  1 Jun 2020 20:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mail.ewheeler.net ([127.0.0.1])
 by localhost (mail.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id DNHe6eO6-mGv; Mon,  1 Jun 2020 20:04:37 +0000 (UTC)
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.ewheeler.net (Postfix) with ESMTPSA id 81DA6A0415;
 Mon,  1 Jun 2020 20:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ewheeler.net 81DA6A0415
Date: Mon, 1 Jun 2020 20:04:34 +0000 (UTC)
From: Eric Wheeler <nbd@lists.ewheeler.net>
X-X-Sender: lists@mail.ewheeler.net
To: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [Libguestfs] Provide NBD via Browser over Websockets
In-Reply-To: <20200530092715.GX3888@redhat.com>
Message-ID: <alpine.LRH.2.11.2006012002380.10871@mail.ewheeler.net>
References: <CAMRbyytcufK8-XdFu7LU+UwO_FRoGJO2FhhBHtH9etf3A2htwQ@mail.gmail.com>
 <alpine.LRH.2.11.2005280014150.13970@mail.ewheeler.net>
 <20200528090443.GN7304@redhat.com>
 <alpine.LRH.2.11.2005282147410.13970@mail.ewheeler.net>
 <20200529093744.GS3888@redhat.com>
 <13571029-5bf4-2dfa-6879-0ad2642afb3f@redhat.com>
 <20200529135042.GJ2755532@redhat.com>
 <ff2e7dd1-c8b2-b46c-3c3b-ed88d9ad9689@redhat.com>
 <20200529141315.GU3888@redhat.com>
 <alpine.LRH.2.11.2005292107180.10871@mail.ewheeler.net>
 <20200530092715.GX3888@redhat.com>
User-Agent: Alpine 2.11 (LRH 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1514185278-384355341-1591041876=:10871"
Received-SPF: none client-ip=173.205.220.69;
 envelope-from=nbd@lists.ewheeler.net; helo=mail.ewheeler.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 16:05:03
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, nbd@other.debian.org,
 Nir Soffer <nsoffer@redhat.com>, libguestfs <libguestfs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1514185278-384355341-1591041876=:10871
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 30 May 2020, Richard W.M. Jones wrote:
> On Fri, May 29, 2020 at 09:08:29PM +0000, Eric Wheeler wrote:
> > On Fri, 29 May 2020, Richard W.M. Jones wrote:
> > > On Fri, May 29, 2020 at 08:58:06AM -0500, Eric Blake wrote:
> > > > On 5/29/20 8:50 AM, Daniel P. BerrangÃ?Â© wrote:
> > > > 
> > > > >>>(2) You need to persuade qemu's NBD client to read from a WebSocket.
> > > > >>>I didn't really know anything about WebSockets until today but it
> > > > >>>seems as if they are a full-duplex protocol layered on top of HTTP [a].
> > > > >>>Is there a WebSocket proxy that turns WS into plain TCP (a bit like
> > > > >>>stunnel)?  Google suggests [b].
> > > > >>>
> > > > >>>[a] https://en.wikipedia.org/wiki/WebSocket#Protocol_handshake
> > > > >>>[b] https://github.com/novnc/websockify
> > > > >>
> > > > >>qemu already knows how to connect as a client to websockets; Dan Berrange
> > > > >>knows more about that setup.  I suspect it would not be too difficult to
> > > > >>teach the qemu NBD client code to use a WebSocket instead of a Unix or TCP
> > > > >>socket as its data source.
> > > > >
> > > > >Actually the inverse. The QIOChannelWebsocket impl is only the server
> > > > >side of the problem, as used by QEMU's VNC server. We've never implemented
> > > > >the client side. There is nothing especially stopping us doing that - just
> > > > >needs someone motivated with time to work on it.
> > > > 
> > > > In the meantime, you may still be able to set up something like:
> > > > 
> > > > local machine:
> > > > iso -> NBD server -> Unix socket -> websockify -> WebSocket
> > > 
> > > I guess the idea is to have a zero-install solution for the browser.
> > > As I said in the email earlier this is very common for IPMI-type
> > > remote access to blade servers and in my experience is implemented
> > > using a Java applet and a proprietary protocol terminated at the BMC
> > > (which then emulates a virtual CDROM to the server).  There are some
> > > HP blade servers on Red Hat's internal Beaker instance where you can
> > > play with this.  For qemu we wouldn't need to invent a new protocol
> > > when NBD is available and already implemented (albeit not yet on top
> > > of WebSockets).
> > > 
> > > The NBD server must run inside the browser and therefore be either
> > > written from scratch in Javascript, or an existing server
> > > cross-compiled to WASM (if that is possible - I don't really know).
> > 
> > Interesting idea about WASM.  I'll see if I can build one of the simple 
> > nbd servers that are around.  Not sure how to link it to the JS file IO, 
> > however.
> 
> After reading a bit about compiling to WebSockets it sounds like you
> can cross-compile a C program, but there's no library support at all.
> IOW to port an existing server you'd have to implement enough of POSIX
> to make it work.  nbdkit has a liberal license deliberately to make it
> possible to chop it up and incorporate it into completely forked
> codebases (nbdkit is a plot to make NBD more popular).
> 
> But since NBD is pretty simple, a fresh Javascript server might be
> easier, especially if you stick to only implementing reads.

Good point, I'll wait on trying WASM.  

If anyone plans to implement NBD in JS let me know, otherwise I'll 
probably implement a stripped down verion to integrate as an nbdkit plugin 
to avoid re-writing all the handshake and version bits.

--
Eric Wheeler

> Rich.
> 
> -- 
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-top is 'top' for virtual machines.  Tiny program with many
> powerful monitoring features, net stats, disk stats, logging, etc.
> http://people.redhat.com/~rjones/virt-top
> 
> 
--1514185278-384355341-1591041876=:10871--

