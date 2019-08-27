Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B747FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEC2206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEC2206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Znw-0003fA-F6
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 07:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i2Zmj-0002kr-Oh
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i2Zmi-0001ti-Co
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:37:13 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:44480
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i2Zmi-0001sa-6N
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:37:12 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i2Zmd-0006tG-KO; Tue, 27 Aug 2019 13:37:07 +0200
Message-ID: <06c72fcfdafa1028439e10ad6cbf15434f11764f.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Date: Tue, 27 Aug 2019 13:37:04 +0200
In-Reply-To: <CAJ+F1CJo+oo74_Y6c1PGKq4uULUKXwky3cxSpopxLVmcow-9_w@mail.gmail.com>
 (sfid-20190827_124802_305796_AD229BA4)
References: <20190827083124.30791-1-johannes@sipsolutions.net>
 <CAJ+F1CJo+oo74_Y6c1PGKq4uULUKXwky3cxSpopxLVmcow-9_w@mail.gmail.com>
 (sfid-20190827_124802_305796_AD229BA4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [PATCH] libvhost-user-glib: fix VugDev main fd
 cleanup
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-08-27 at 14:47 +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 27, 2019 at 12:32 PM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > If you try to make a device implementation that can handle multiple
> > connections and allow disconnections (which requires overriding the
> > VHOST_USER_NONE handling), then glib will warn that we remove a src
> > while it's still on the mainloop, and will poll() an FD that doesn't
> > exist anymore.
> > 
> > Fix this by just using the internal add_watch() function that has
> > all necessary cleanups built in via the hashtable, rather than
> > treating the "main" fd of a device specially.
> 
> It would be easier to see a backtrace of the error (under gdb with
> G_DEBUG=fatal_criticals)

fatal-warnings, but sure:

Program received signal SIGTRAP, Trace/breakpoint trap.
0x00007ffff7cc6885 in _g_log_abort (breakpoint=1) at ../../../glib/gmessages.c:554
554	../../../glib/gmessages.c: No such file or directory.
(gdb) bt
#0  0x00007ffff7cc6885 in _g_log_abort (breakpoint=1) at ../../../glib/gmessages.c:554
#1  0x00007ffff7cc7b8d in g_logv (log_domain=0x7ffff7d0d00e "GLib", log_level=G_LOG_LEVEL_WARNING, format=<optimized out>, 
    args=args@entry=0x7fffffffe010) at ../../../glib/gmessages.c:1371
#2  0x00007ffff7cc7d5f in g_log (log_domain=log_domain@entry=0x7ffff7d0d00e "GLib", 
    log_level=log_level@entry=G_LOG_LEVEL_WARNING, 
    format=format@entry=0x7ffff7d150f8 "../../../glib/gmain.c:2116: ref_count == 0, but source was still attached to a context!") at ../../../glib/gmessages.c:1413
#3  0x00007ffff7cbda4a in g_source_unref_internal (source=0x55555557b870, context=0x555555579120, have_lock=1)
    at ../../../glib/gmain.c:2116
#4  0x00007ffff7cc09a8 in g_main_dispatch (context=0x555555579120) at ../../../glib/gmain.c:3217
#5  g_main_context_dispatch (context=context@entry=0x555555579120) at ../../../glib/gmain.c:3854
#6  0x00007ffff7cc0c88 in g_main_context_iterate (context=0x555555579120, block=block@entry=1, dispatch=dispatch@entry=1, 
    self=<optimized out>) at ../../../glib/gmain.c:3927
#7  0x00007ffff7cc0f82 in g_main_loop_run (loop=0x55555557a300) at ../../../glib/gmain.c:4123
[...]

Doesn't really help (me) much as the cause of the error is much earlier?

> > @@ -157,5 +157,4 @@ vug_deinit(VugDev *dev)
> >      g_assert(dev);
> > 
> >      g_hash_table_unref(dev->fdmap);
> > -    g_source_unref(dev->src);
> 
> I think the main problem here is that src is not owned, since
> vug_source_new() does g_source_unref(). This is looks unfortunate.

I thought so too, but removing that g_source_unref() causes other
problems.

> However, the source should be destroyed (detached from the main
> context). I think this is ultimately what your change is about.

Yes, it just makes it use the same path as all the other FDs/sources.

> Imho, we should change the behaviour of the function to return a ref
> source. 

Which "the function" do you mean?

I'm not really sure I understand what you're actually saying about
my patch though. Are you saying I shouldn't do this? But then I don't
really understand why. Why should the "main" FD be different from any of
the VQ FDs, and not just all go into the hashtable? I basically arrived
at this patch by noting that the other FDs were OK (the warning only
occurs for this one), and the cleanup for the others is handled
correctly while destroying the hashtable. Having to clean this
particular one up manually seemed pointless (though I couldn't even make
it work correctly).

johannes


