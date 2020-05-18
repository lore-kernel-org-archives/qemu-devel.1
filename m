Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA874C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD63207ED
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ywYBsftY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD63207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jac4m-0007vZ-1S
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jac4A-0007MP-FN; Mon, 18 May 2020 05:28:10 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:34040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jac46-0003Si-OI; Mon, 18 May 2020 05:28:08 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id D4BAD2E1434;
 Mon, 18 May 2020 12:27:59 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 PX8dOMwVYR-RupCS3kC; Mon, 18 May 2020 12:27:59 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589794079; bh=+Hv9+KGVpT0woCFoUXsse/uOv0792WD4TFp+49JtKZ4=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=ywYBsftY305N7PiM8HxRQHdJOl+7U1qa9K9Cxybaml2izYbbgE7x+Mz4Bluejqh0p
 50jU9QpmgEIQ9aCfm6dv40Ysj7T8jfI/hpHLu9GrYNJ6AT5LVqL6Qad7YByy0mIKC+
 lBOyEkfZ194ruNjeU7ggwfEUooIKmfcVmy9WDoOQ=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7514::1:b])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 3act0PEtqi-RuW8pdZl; Mon, 18 May 2020 12:27:56 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Mon, 18 May 2020 12:27:55 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
Message-ID: <20200518092747.GA6374@dimastep-nix>
References: <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
 <20200512093521.GA5363@dimastep-nix>
 <20200512235934-mutt-send-email-mst@kernel.org>
 <b9cd40fd-53fb-e1e1-7cb7-ec437bc60ff2@redhat.com>
 <20200513094703.GA15906@dimastep-nix>
 <722839b2-9412-b768-3ce6-d1b697d6d5dd@redhat.com>
 <20200515165449.GA1627@dimastep-nix>
 <CAHckoCyE0r-aRnqqU2m0vgzdcP22RjO39foaJheRYTrnkZTArA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHckoCyE0r-aRnqqU2m0vgzdcP22RjO39foaJheRYTrnkZTArA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 05:28:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 yc-core@yandex-team.ru, "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 16, 2020 at 11:20:03AM +0800, Li Feng wrote:
> Hi, Dima.
> This abort is what I have mentioned in my previous email.
Yes, i understood it and this abort() message was fixed by the previous
patch. But since we try new postphone approach this patch isn't working
and we need to get the device state somehow:
  - vhost-user disconnect => device not started

> I have triggered this crash without any fix a week ago.
> And I have written a test patch to let vhost_log_global_start return
> int and propagate the error to up layer.
> However, my change is a little large, because the origin callback
> return void, and don't do some rollback.
> After test, the migration could migrate to dst successfully, and fio
> is still running perfectly, but the src vm is still stuck here, no
> crash.
> 
> Is it right to return this error to the up layer?
Well it is the question we talk about with you, i'm also not sure. I can
only summarize some of the statements i used:
  - device state: not started -> is okay for migration
  - device state: vhost-user disconnect, this is the same as "not
    started" -> is okay for migration
  - at least my internal migration tests passed
So my idea for the fix here is smth like:
Add device callback, for instance vhost_dev_started() which will
return device state. And for the vhost-user device (or at least
vhost-user-blk) device this callback will consider the connected field
and return true or false.
As a result vhost_migration_log() will check device state at the start
of the routine and before return.
But if the disconnect state isn't okay for migration, then we should
return an error.

No other comments mixed in below.

> 
> Thanks,
> Feng Li
> 
> Dima Stepanov <dimastep@yandex-team.ru> 于2020年5月16日周六 上午12:55写道：
> >
> > On Thu, May 14, 2020 at 03:34:24PM +0800, Jason Wang wrote:
> > >
> > > On 2020/5/13 下午5:47, Dima Stepanov wrote:
> > > >>>     case CHR_EVENT_CLOSED:
> > > >>>         /* a close event may happen during a read/write, but vhost
> > > >>>          * code assumes the vhost_dev remains setup, so delay the
> > > >>>          * stop & clear to idle.
> > > >>>          * FIXME: better handle failure in vhost code, remove bh
> > > >>>          */
> > > >>>         if (s->watch) {
> > > >>>             AioContext *ctx = qemu_get_current_aio_context();
> > > >>>
> > > >>>             g_source_remove(s->watch);
> > > >>>             s->watch = 0;
> > > >>>             qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
> > > >>>                                      NULL, NULL, false);
> > > >>>
> > > >>>             aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
> > > >>>         }
> > > >>>         break;
> > > >>>
> > > >>>I think it's time we dropped the FIXME and moved the handling to common
> > > >>>code. Jason? Marc-André?
> > > >>I agree. Just to confirm, do you prefer bh or doing changes like what is
> > > >>done in this series? It looks to me bh can have more easier codes.
> > > >Could it be a good idea just to make disconnect in the char device but
> > > >postphone clean up in the vhost-user-blk (or any other vhost-user
> > > >device) itself? So we are moving the postphone logic and decision from
> > > >the char device to vhost-user device. One of the idea i have is as
> > > >follows:
> > > >   - Put ourself in the INITIALIZATION state
> > > >   - Start these vhost-user "handshake" commands
> > > >   - If we got a disconnect error, perform disconnect, but don't clean up
> > > >     device (it will be clean up on the roll back). I can be done by
> > > >     checking the state in vhost_user_..._disconnect routine or smth like it
> > >
> > >
> > > Any issue you saw just using the aio bh as Michael posted above.
> > >
> > > Then we don't need to deal with the silent vhost_dev_stop() and we will have
> > > codes that is much more easier to understand.
> > I've implemented this solution inside
> > hw/block/vhost-user-blk.c:vhost_user_blk_event() in the similar way by
> > using the s->connected field. Looks good and more correct fix ). I have
> > two questions here before i'll rework the fixes:
> > 1. Is it okay to make the similar fix inside vhost_user_blk_event() or
> > we are looking for more generic vhost-user solution? What do you think?
> > 2. For migration we require an additional information that for the
> > vhost-user device it isn't an error, because i'm trigerring the
> > following assert error:
> >   Core was generated by `x86_64-softmmu/qemu-system-x86_64 -nodefaults -no-user-config -M q35,sata=false'.
> >   Program terminated with signal SIGABRT, Aborted.
> >   #0  0x00007fb56e729428 in raise () from /lib/x86_64-linux-gnu/libc.so.6
> >   [Current thread is 1 (Thread 0x7fb486ef5700 (LWP 527734))]
> >
> >   (gdb) bt
> >   #0  0x00007fb56e729428 in raise () from /lib/x86_64-linux-gnu/libc.so.6
> >   #1  0x00007fb56e72b02a in abort () from /lib/x86_64-linux-gnu/libc.so.6
> >   #2  0x00005648ea376ee6 in vhost_log_global_start
> >       (listener=0x5648ece4eb08) at ./hw/virtio/vhost.c:857
> >   #3  0x00005648ea2dde7e in memory_global_dirty_log_start ()
> >       at ./memory.c:2611
> >   #4  0x00005648ea2e68e7 in ram_init_bitmaps (rs=0x7fb4740008c0)
> >       at ./migration/ram.c:2305
> >   #5  0x00005648ea2e698b in ram_init_all (rsp=0x5648eb1f0f20 <ram_state>)
> >       at ./migration/ram.c:2323
> >   #6  0x00005648ea2e6cc5 in ram_save_setup (f=0x5648ec609e00,
> >       opaque=0x5648eb1f0f20 <ram_state>)
> >       at ./migration/ram.c:2436
> >   #7  0x00005648ea67b7d3 in qemu_savevm_state_setup (f=0x5648ec609e00) at
> >       migration/savevm.c:1176
> >   #8  0x00005648ea674511 in migration_thread (opaque=0x5648ec031ff0) at
> >       migration/migration.c:3416
> >   #9  0x00005648ea85d65d in qemu_thread_start (args=0x5648ec6057f0) at
> >       util/qemu-thread-posix.c:519
> >   #10 0x00007fb56eac56ba in start_thread () from
> >       /lib/x86_64-linux-gnu/libpthread.so.0
> >   #11 0x00007fb56e7fb41d in clone () from /lib/x86_64-linux-gnu/libc.so.6
> >   (gdb) frame 2
> >   #2  0x00005648ea376ee6 in vhost_log_global_start
> >      (listener=0x5648ece4eb08) at ./hw/virtio/vhost.c:857
> >   857             abort();
> >   (gdb) list
> >   852     {
> >   853         int r;
> >   854
> >   855         r = vhost_migration_log(listener, true);
> >   856         if (r < 0) {
> >   857             abort();
> >   858         }
> >   859     }
> >   860
> >   861     static void vhost_log_global_stop(MemoryListener *listener)
> > Since bh postphone the clean up, we can't use the ->started field.
> > Do we have any mechanism to get the device type/state in the common
> > vhost_migration_log() routine? So for example for the vhost-user/disconnect
> > device we will be able to return 0. Or should we implement it and introduce
> > it in this patch set?
> >
> > Thanks, Dima.
> >
> > >
> > > Thank
> > >
> > >
> > > >   - vhost-user command returns error back to the _start() routine
> > > >   - Rollback in one place in the start() routine, by calling this
> > > >     postphoned clean up for the disconnect
> > > >
> > >

