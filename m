Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38265C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4862078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1/gdP0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4862078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDNW-0004Jc-G0
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFDMx-0003nn-0s
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:23:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFDMu-0003BT-Mg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599470599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWiNSUzV9gqZiGO16YMPPiBfAGj5IABr8aHyqtYT3Pg=;
 b=U1/gdP0egc6hBImFK5YOj7reZebbtT14XaDUrP0GXJNUGX//2JuCsoWvD6kaMe7jfQ9xam
 BwdTzUdCMtHs+SUgzdlAwbGg16oRGpE+WcFB361OuchNtV0A/UiO1WpALAwfenTEUh93el
 MJfMrcxeeSBkA2C4BuLWIxm1P/etsX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-y8mA1LgUMqG3Ptzj7xInmg-1; Mon, 07 Sep 2020 05:23:16 -0400
X-MC-Unique: y8mA1LgUMqG3Ptzj7xInmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C422918B9ED9;
 Mon,  7 Sep 2020 09:23:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-154.ams2.redhat.com [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F9E51002393;
 Mon,  7 Sep 2020 09:23:12 +0000 (UTC)
Date: Mon, 7 Sep 2020 11:23:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: make -i check resut for msys2
Message-ID: <20200907092311.GA5615@linux.fritz.box>
References: <CAE2XoE_TJ2T2eN82km0pYqDiqOpsd=waH4EmCe==0k=GYpj3Xg@mail.gmail.com>
 <3d2db346-2517-f6e3-748d-79a8ae993e06@redhat.com>
 <CAE2XoE_3Kjjk+tRz1y7rk94+vre2FSfmCGQVWNgjNW14vSNSdw@mail.gmail.com>
 <48c60a95-c30b-433a-7955-3845074776d8@redhat.com>
 <20200904085057.GB6237@linux.fritz.box>
 <CAE2XoE9na-+OPH1HcssE4yB56B2aDPb6xX1dsQ8J1BQ4d+s_Ww@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9na-+OPH1HcssE4yB56B2aDPb6xX1dsQ8J1BQ4d+s_Ww@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.09.2020 um 08:21 hat 罗勇刚(Yonggang Luo) geschrieben:
> On Fri, Sep 4, 2020 at 4:51 PM Kevin Wolf <kwolf@redhat.com> wrote:
> 
> > Am 04.09.2020 um 08:03 hat Thomas Huth geschrieben:
> > > On 04/09/2020 00.53, 罗勇刚(Yonggang Luo) wrote:
> > > >
> > > >
> > > > On Thu, Sep 3, 2020 at 10:33 PM Thomas Huth <thuth@redhat.com
> > > > <mailto:thuth@redhat.com>> wrote:
> > > >
> > > >     On 03/09/2020 11.18, 罗勇刚(Yonggang Luo) wrote:
> > > >     [...]
> > > >     >   TEST    check-unit: tests/test-replication.exe
> > > >     > **
> > > >     > ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:
> > > >     > assertion failed: (fd >= 0)
> > > >     > ERROR test-replication.exe - Bail out!
> > > >     > ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:
> > > >     > assertion failed: (fd >= 0)
> > > >
> > > >     At least this one should be easy to fix: The test uses /tmp as
> > > >     hard-coded directory for temporary files. I think it should use
> > > >     g_get_tmp_dir() from glib to get that directory instead.
> > > >
> > > >      Thomas
> > > >
> > > > After fixes tmp path, how to fixes following error:
> > > > $ tests/test-replication.exe
> >
> > > >
> > > >
> > > >
> > > > # random seed: R02Sdf2e4ffc0e6fbe96624598386b538927
> > > > 1..13
> > > > # Start of replication tests
> > > > # Start of primary tests
> > > > Unexpected error in bdrv_open_inherit() at ../block.c:3456:
> > > > Block protocol 'file' doesn't support the option 'locking'
> > >
> > > Not sure ... as a temporary test, try to remove the "locking=off"
> > > strings from the test. If it then works, it might be worth discussing
> > > with the block layer folks how to handle this test on Windows in the
> > > best way. If it still does not work, it's maybe simply not worth the
> > > effort to try to get this test running on Windows - and thus mark it
> > > with CONFIG_POSIX in the Makefile / meson.build.
> >
> > This is a bug in file-win32. It reads "locking" from the options QDict,
> > but doesn't delete it from it.
> >
> > Does the following help? (Only compile-tested.)
> >
> > If it works for you, I'll send it as a proper patch.
> >
> > Kevin
> >
> > diff --git a/block/file-win32.c b/block/file-win32.c
> > index ab69bd811a..e2900c3a51 100644
> > --- a/block/file-win32.c
> > +++ b/block/file-win32.c
> > @@ -299,6 +299,11 @@ static QemuOptsList raw_runtime_opts = {
> >              .type = QEMU_OPT_STRING,
> >              .help = "host AIO implementation (threads, native)",
> >          },
> > +        {
> > +            .name = "locking",
> > +            .type = QEMU_OPT_STRING,
> > +            .help = "file locking mode (on/off/auto, default: auto)",
> > +        },
> >          { /* end of list */ }
> >      },
> >  };
> > @@ -333,6 +338,7 @@ static int raw_open(BlockDriverState *bs, QDict
> > *options, int flags,
> >      Error *local_err = NULL;
> >      const char *filename;
> >      bool use_aio;
> > +    OnOffAuto locking;
> >      int ret;
> >
> >      s->type = FTYPE_FILE;
> > @@ -343,10 +349,24 @@ static int raw_open(BlockDriverState *bs, QDict
> > *options, int flags,
> >          goto fail;
> >      }
> >
> > -    if (qdict_get_try_bool(options, "locking", false)) {
> > +    locking = qapi_enum_parse(&OnOffAuto_lookup,
> > +                              qemu_opt_get(opts, "locking"),
> > +                              ON_OFF_AUTO_AUTO, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        ret = -EINVAL;
> > +        goto fail;
> > +    }
> > +    switch (locking) {
> > +    case ON_OFF_AUTO_ON:
> >          error_setg(errp, "locking=on is not supported on Windows");
> >          ret = -EINVAL;
> >          goto fail;
> > +    case ON_OFF_AUTO_OFF:
> > +    case ON_OFF_AUTO_AUTO:
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> >      }
> >
> >      filename = qemu_opt_get(opts, "filename");
> >
> Partial error fixed, new error are coming:

Good, I'll send the patch then.

> $ ./tests/test-replication.exe
> # random seed: R02S3f4d1c01af2b0a046990e0235c481faf
> 1..13
> # Start of replication tests
> # Start of primary tests
> ok 1 /replication/primary/read
> ok 2 /replication/primary/write
> ok 3 /replication/primary/start
> ok 4 /replication/primary/stop
> ok 5 /replication/primary/do_checkpoint
> ok 6 /replication/primary/get_error_all
> # End of primary tests
> # Start of secondary tests
> ok 7 /replication/secondary/read
> ok 8 /replication/secondary/write
> Unexpected error in bdrv_reopen_prepare() at ../block.c:4191:
> Block format 'file' used by node '#block4287' does not support reopening
> files

Can you try to find out what reopen this is?

I assume it's for switching between read-write and read-only. In this
case an implementation of .bdrv_reopen_prepare/commit/abort that can do
this switch is required.

This is more serious development work, so I can't propose a quick fix.

Alternatively, we could just declare replication unsupported on Windows
and let configure make sure that CONFIG_REPLICATION is never set for it.

Kevin


