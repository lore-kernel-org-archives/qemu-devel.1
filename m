Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77649206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 03:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="S7t+Z/qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77649206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZnNz-0007V6-Lp
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 23:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jZnN7-0006Y4-Cu
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:20:21 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:39238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jZnN4-0007qp-Ra
 for qemu-devel@nongnu.org; Fri, 15 May 2020 23:20:20 -0400
Received: by mail-vs1-xe43.google.com with SMTP id e7so434625vsm.6
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ntfOeviwnrsmn33IFNN/YjgzFTFVkpTKZjtDLanxZEA=;
 b=S7t+Z/qif8g2JA5JGvgoDMefFHBmEGJXdtBCuE/sgBIElvHUmZodiGrrVwKpVH5eSN
 7vB/yTFlKG21VrVJ6GkREI1Mzy3fujS5KjcnimpCcp1sjzsVbhI/WQ2GcTNtQwsOw2IJ
 c3HTl03gBXiANdb2weJ0zzMT+e/FjvvOsriatieNO6mwsk1sqo4JbS3JX1bErc+RshNV
 /j/P3xFPZI7JTmZxJ5adzLq3YzrE/0/JlMQ9IQxtmgy+r7zMk/+/jbrUDDDlnebziczz
 XtcmGyY7T4XsDOxbquEb3pqZjoRWu50bxRimS0vqE3BzouJV2U/1UVJweMt5tC/8jPO3
 panQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ntfOeviwnrsmn33IFNN/YjgzFTFVkpTKZjtDLanxZEA=;
 b=W8JbtswkGZR9DKrIHNR6R8jQu1OKPWqiKHUJq+FKDbap0w4m/r6bScBL7QbBg6O5w1
 Xa6OkLNqHEarszw9daqTihOBman2kpdZa5o3ZebNfLCjPYe1MYkY1OACutdFb5iEsrrc
 eAC95Y6ieHZlmESHtyLWK40xxwkJN690ePVZ7NAu5OWDdN9ptd4zpP2mQahuKnpHN5sW
 3hHFyk4dYDmsw1pgBiXt2MLouOtYOf64iQ0MLdVZaTEXaOySC9HfbOubKlFln1erUIQN
 R95+Q2pGdctC5/CoSAS2ie6XhQ20auUfEn5dozO7EoCiAPml2kxAJJq8bRsH3rruLE5m
 jeyg==
X-Gm-Message-State: AOAM532RsnaOrxIYIxldH6dZMoQtMOHmb4Cvf69yiH701b4fEbCBxPHU
 eNT5L8TB23sWQLMAgbZw0CxjrhDgE//eFXYGWtsZtQ==
X-Google-Smtp-Source: ABdhPJzt8LhPNnw3sHTFf5luhA3FbFaDWXrvko5bL2tQ/lorelGgnYuTaJr+aIDbUtwrDlO29FVinfNpUMIZcYycd9o=
X-Received: by 2002:a67:d71a:: with SMTP id p26mr5069382vsj.34.1589599216460; 
 Fri, 15 May 2020 20:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
 <20200512093521.GA5363@dimastep-nix>
 <20200512235934-mutt-send-email-mst@kernel.org>
 <b9cd40fd-53fb-e1e1-7cb7-ec437bc60ff2@redhat.com>
 <20200513094703.GA15906@dimastep-nix>
 <722839b2-9412-b768-3ce6-d1b697d6d5dd@redhat.com>
 <20200515165449.GA1627@dimastep-nix>
In-Reply-To: <20200515165449.GA1627@dimastep-nix>
From: Li Feng <fengli@smartx.com>
Date: Sat, 16 May 2020 11:20:03 +0800
Message-ID: <CAHckoCyE0r-aRnqqU2m0vgzdcP22RjO39foaJheRYTrnkZTArA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::e43;
 envelope-from=fengli@smartx.com; helo=mail-vs1-xe43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 yc-core@yandex-team.ru, "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Dima.
This abort is what I have mentioned in my previous email.
I have triggered this crash without any fix a week ago.
And I have written a test patch to let vhost_log_global_start return
int and propagate the error to up layer.
However, my change is a little large, because the origin callback
return void, and don't do some rollback.
After test, the migration could migrate to dst successfully, and fio
is still running perfectly, but the src vm is still stuck here, no
crash.

Is it right to return this error to the up layer?

Thanks,
Feng Li

Dima Stepanov <dimastep@yandex-team.ru> =E4=BA=8E2020=E5=B9=B45=E6=9C=8816=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:55=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, May 14, 2020 at 03:34:24PM +0800, Jason Wang wrote:
> >
> > On 2020/5/13 =E4=B8=8B=E5=8D=885:47, Dima Stepanov wrote:
> > >>>     case CHR_EVENT_CLOSED:
> > >>>         /* a close event may happen during a read/write, but vhost
> > >>>          * code assumes the vhost_dev remains setup, so delay the
> > >>>          * stop & clear to idle.
> > >>>          * FIXME: better handle failure in vhost code, remove bh
> > >>>          */
> > >>>         if (s->watch) {
> > >>>             AioContext *ctx =3D qemu_get_current_aio_context();
> > >>>
> > >>>             g_source_remove(s->watch);
> > >>>             s->watch =3D 0;
> > >>>             qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NUL=
L,
> > >>>                                      NULL, NULL, false);
> > >>>
> > >>>             aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
> > >>>         }
> > >>>         break;
> > >>>
> > >>>I think it's time we dropped the FIXME and moved the handling to com=
mon
> > >>>code. Jason? Marc-Andr=C3=A9?
> > >>I agree. Just to confirm, do you prefer bh or doing changes like what=
 is
> > >>done in this series? It looks to me bh can have more easier codes.
> > >Could it be a good idea just to make disconnect in the char device but
> > >postphone clean up in the vhost-user-blk (or any other vhost-user
> > >device) itself? So we are moving the postphone logic and decision from
> > >the char device to vhost-user device. One of the idea i have is as
> > >follows:
> > >   - Put ourself in the INITIALIZATION state
> > >   - Start these vhost-user "handshake" commands
> > >   - If we got a disconnect error, perform disconnect, but don't clean=
 up
> > >     device (it will be clean up on the roll back). I can be done by
> > >     checking the state in vhost_user_..._disconnect routine or smth l=
ike it
> >
> >
> > Any issue you saw just using the aio bh as Michael posted above.
> >
> > Then we don't need to deal with the silent vhost_dev_stop() and we will=
 have
> > codes that is much more easier to understand.
> I've implemented this solution inside
> hw/block/vhost-user-blk.c:vhost_user_blk_event() in the similar way by
> using the s->connected field. Looks good and more correct fix ). I have
> two questions here before i'll rework the fixes:
> 1. Is it okay to make the similar fix inside vhost_user_blk_event() or
> we are looking for more generic vhost-user solution? What do you think?
> 2. For migration we require an additional information that for the
> vhost-user device it isn't an error, because i'm trigerring the
> following assert error:
>   Core was generated by `x86_64-softmmu/qemu-system-x86_64 -nodefaults -n=
o-user-config -M q35,sata=3Dfalse'.
>   Program terminated with signal SIGABRT, Aborted.
>   #0  0x00007fb56e729428 in raise () from /lib/x86_64-linux-gnu/libc.so.6
>   [Current thread is 1 (Thread 0x7fb486ef5700 (LWP 527734))]
>
>   (gdb) bt
>   #0  0x00007fb56e729428 in raise () from /lib/x86_64-linux-gnu/libc.so.6
>   #1  0x00007fb56e72b02a in abort () from /lib/x86_64-linux-gnu/libc.so.6
>   #2  0x00005648ea376ee6 in vhost_log_global_start
>       (listener=3D0x5648ece4eb08) at ./hw/virtio/vhost.c:857
>   #3  0x00005648ea2dde7e in memory_global_dirty_log_start ()
>       at ./memory.c:2611
>   #4  0x00005648ea2e68e7 in ram_init_bitmaps (rs=3D0x7fb4740008c0)
>       at ./migration/ram.c:2305
>   #5  0x00005648ea2e698b in ram_init_all (rsp=3D0x5648eb1f0f20 <ram_state=
>)
>       at ./migration/ram.c:2323
>   #6  0x00005648ea2e6cc5 in ram_save_setup (f=3D0x5648ec609e00,
>       opaque=3D0x5648eb1f0f20 <ram_state>)
>       at ./migration/ram.c:2436
>   #7  0x00005648ea67b7d3 in qemu_savevm_state_setup (f=3D0x5648ec609e00) =
at
>       migration/savevm.c:1176
>   #8  0x00005648ea674511 in migration_thread (opaque=3D0x5648ec031ff0) at
>       migration/migration.c:3416
>   #9  0x00005648ea85d65d in qemu_thread_start (args=3D0x5648ec6057f0) at
>       util/qemu-thread-posix.c:519
>   #10 0x00007fb56eac56ba in start_thread () from
>       /lib/x86_64-linux-gnu/libpthread.so.0
>   #11 0x00007fb56e7fb41d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>   (gdb) frame 2
>   #2  0x00005648ea376ee6 in vhost_log_global_start
>      (listener=3D0x5648ece4eb08) at ./hw/virtio/vhost.c:857
>   857             abort();
>   (gdb) list
>   852     {
>   853         int r;
>   854
>   855         r =3D vhost_migration_log(listener, true);
>   856         if (r < 0) {
>   857             abort();
>   858         }
>   859     }
>   860
>   861     static void vhost_log_global_stop(MemoryListener *listener)
> Since bh postphone the clean up, we can't use the ->started field.
> Do we have any mechanism to get the device type/state in the common
> vhost_migration_log() routine? So for example for the vhost-user/disconne=
ct
> device we will be able to return 0. Or should we implement it and introdu=
ce
> it in this patch set?
>
> Thanks, Dima.
>
> >
> > Thank
> >
> >
> > >   - vhost-user command returns error back to the _start() routine
> > >   - Rollback in one place in the start() routine, by calling this
> > >     postphoned clean up for the disconnect
> > >
> >

