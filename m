Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9654C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51432173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq53mR/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51432173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ZvK-0005uV-OI
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 07:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i2Zu7-00058h-LL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i2Zu5-0004a7-96
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:44:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i2Zu5-0004Zr-2M
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:44:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id m125so2671674wmm.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3rWJSXkU6zY58WMc5OEGuMvg07Jf9SwcVLO3abdD+z0=;
 b=Jq53mR/5ugGqWGHKTVSslN/Uxv7nZOM4ruCRsTvbH1fzoBgg+TsjVwgZIJo0hv/F50
 7p+1LQBoOa1fnvWWDyOwftiGGZ+WQHaiE3u0n1gvHHlEgHkoXNvWbtlzxc1EFiYazWOV
 CiuDt+rrhX1JcNrToXG0/DR10NZpPUnnwsFbXUBhhK2H+lsWrdUWjjcIa4DjyAtuLUIj
 Za0h3gp4SUOFE/OtyP+kaHuVGZ0IDMApH0wJtq9sNKNdfS7erN6bg0gSyY892tHnbaNS
 40cx3uQJngVm7stENTKt5nsnB9GYl3xpMstOtRiA5qzTalPoB8LJ9tWup0YKQ2lDJssx
 qyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3rWJSXkU6zY58WMc5OEGuMvg07Jf9SwcVLO3abdD+z0=;
 b=tgnUxpvvX3F9B3l0cAjQyzrqmOnRZobs5Ct8kWtTrH6eJ8KcvYgiWWzopFm0hNvnAc
 a3eoGgQdttcBMqDgiRLnkkthbh1gSngYvm0ytdE7v9aRbspcmLgn63e/+Hap5OZ4+3Ql
 GgkZruQ0SyWo6k2LPpqawFMS9m6dhlU3nqylVmqlV6+RqWNB3iNCMUITbOSYwe6omQuI
 qCms4MTgEx8XABc9s29WyWH3g94Eoru/WXu3Sxoe5UWexpU9cUd1h3MxW1VwUnqRcqab
 sP0vKB0LaN/TZPGtMdPgiAMUyoSlxFNAaZ8Qa9Ag+P4IvmphqxPtQzwwPXB9MmwLyo99
 gDyg==
X-Gm-Message-State: APjAAAU3yJbn2SR9Kh1cmYu11ARnWJUI6wYHBB/8upLigWT0R2DW6I8m
 rG5zq8tGHe6Z33FH5dmUov0vPzvm1xWR/omy42k=
X-Google-Smtp-Source: APXvYqw7kW947aCbBh7SB1/dNC5AgBFeGmhYMplxp7a2KAWMu3Aqzz1goU2DsoOWzE2vHh8fzn7oM9PcKY0YIZ8YiUE=
X-Received: by 2002:a05:600c:22c6:: with SMTP id
 6mr27966647wmg.5.1566906287725; 
 Tue, 27 Aug 2019 04:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190827083124.30791-1-johannes@sipsolutions.net>
 <CAJ+F1CJo+oo74_Y6c1PGKq4uULUKXwky3cxSpopxLVmcow-9_w@mail.gmail.com>
 <06c72fcfdafa1028439e10ad6cbf15434f11764f.camel@sipsolutions.net>
In-Reply-To: <06c72fcfdafa1028439e10ad6cbf15434f11764f.camel@sipsolutions.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Aug 2019 15:44:35 +0400
Message-ID: <CAJ+F1CKay50ZPhEORdY4N1OzBM6+-Dr9uzZwxTvRFJsFYb5qCA@mail.gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Hi

On Tue, Aug 27, 2019 at 3:37 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Tue, 2019-08-27 at 14:47 +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Aug 27, 2019 at 12:32 PM Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > >
> > > If you try to make a device implementation that can handle multiple
> > > connections and allow disconnections (which requires overriding the
> > > VHOST_USER_NONE handling), then glib will warn that we remove a src
> > > while it's still on the mainloop, and will poll() an FD that doesn't
> > > exist anymore.
> > >
> > > Fix this by just using the internal add_watch() function that has
> > > all necessary cleanups built in via the hashtable, rather than
> > > treating the "main" fd of a device specially.
> >
> > It would be easier to see a backtrace of the error (under gdb with
> > G_DEBUG=3Dfatal_criticals)
>
> fatal-warnings, but sure:
>
> Program received signal SIGTRAP, Trace/breakpoint trap.
> 0x00007ffff7cc6885 in _g_log_abort (breakpoint=3D1) at ../../../glib/gmes=
sages.c:554
> 554     ../../../glib/gmessages.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff7cc6885 in _g_log_abort (breakpoint=3D1) at ../../../glib/=
gmessages.c:554
> #1  0x00007ffff7cc7b8d in g_logv (log_domain=3D0x7ffff7d0d00e "GLib", log=
_level=3DG_LOG_LEVEL_WARNING, format=3D<optimized out>,
>     args=3Dargs@entry=3D0x7fffffffe010) at ../../../glib/gmessages.c:1371
> #2  0x00007ffff7cc7d5f in g_log (log_domain=3Dlog_domain@entry=3D0x7ffff7=
d0d00e "GLib",
>     log_level=3Dlog_level@entry=3DG_LOG_LEVEL_WARNING,
>     format=3Dformat@entry=3D0x7ffff7d150f8 "../../../glib/gmain.c:2116: r=
ef_count =3D=3D 0, but source was still attached to a context!") at ../../.=
./glib/gmessages.c:1413
> #3  0x00007ffff7cbda4a in g_source_unref_internal (source=3D0x55555557b87=
0, context=3D0x555555579120, have_lock=3D1)
>     at ../../../glib/gmain.c:2116
> #4  0x00007ffff7cc09a8 in g_main_dispatch (context=3D0x555555579120) at .=
./../../glib/gmain.c:3217
> #5  g_main_context_dispatch (context=3Dcontext@entry=3D0x555555579120) at=
 ../../../glib/gmain.c:3854
> #6  0x00007ffff7cc0c88 in g_main_context_iterate (context=3D0x55555557912=
0, block=3Dblock@entry=3D1, dispatch=3Ddispatch@entry=3D1,
>     self=3D<optimized out>) at ../../../glib/gmain.c:3927
> #7  0x00007ffff7cc0f82 in g_main_loop_run (loop=3D0x55555557a300) at ../.=
./../glib/gmain.c:4123
> [...]
>
> Doesn't really help (me) much as the cause of the error is much earlier?

That's helpful, thanks

>
> > > @@ -157,5 +157,4 @@ vug_deinit(VugDev *dev)
> > >      g_assert(dev);
> > >
> > >      g_hash_table_unref(dev->fdmap);
> > > -    g_source_unref(dev->src);
> >
> > I think the main problem here is that src is not owned, since
> > vug_source_new() does g_source_unref(). This is looks unfortunate.
>
> I thought so too, but removing that g_source_unref() causes other
> problems.

What other problems? Sure we need the caller to unref.

>
> > However, the source should be destroyed (detached from the main
> > context). I think this is ultimately what your change is about.
>
> Yes, it just makes it use the same path as all the other FDs/sources.
>
> > Imho, we should change the behaviour of the function to return a ref
> > source.
>
> Which "the function" do you mean?

The vug_source_new() function.

>
> I'm not really sure I understand what you're actually saying about
> my patch though. Are you saying I shouldn't do this? But then I don't
> really understand why. Why should the "main" FD be different from any of
> the VQ FDs, and not just all go into the hashtable? I basically arrived
> at this patch by noting that the other FDs were OK (the warning only
> occurs for this one), and the cleanup for the others is handled
> correctly while destroying the hashtable. Having to clean this
> particular one up manually seemed pointless (though I couldn't even make
> it work correctly).


Using the hashtable shouldn't be necessary, as VugDev will handle the
attach/detach of the socket FD.

The hashtable is meant for VuDev callback.

Sure we can add the socket to the hashtable, but it's better to avoid
since we can.


--=20
Marc-Andr=C3=A9 Lureau

