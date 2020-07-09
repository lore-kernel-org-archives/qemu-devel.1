Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A295C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3519120720
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo3ShW/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3519120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYhJ-0002kK-H3
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jtYgY-0002KJ-MM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:42:06 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jtYgU-0004er-Mf
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:42:06 -0400
Received: by mail-wr1-x42f.google.com with SMTP id k6so2905896wrn.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OGksp0wUeS3p8PASURcbiVg/c99YFBosLMvmE92qIvA=;
 b=lo3ShW/uYw06ooA6od6+LLY9gA+3Ek865VQ1T/S555bcTTwTGX43VT/yS0IkE0AA6o
 YZnc6Q95nnWq/KShBBm46KsbEdJi/lTlUqs138nlM0zc9pnctvoCEOnVxwfhPnWJOabP
 tkMpQlvvf7tP2W64nwaiCBrYSB92CyTqRgmnYyu3vxpfSt3sV1naRk+dktWC6M89Yi2G
 KazDBnU2KqnTOToCVvyfYHH3TfGrc/V4yizQJJxY0aWobgI5QNThxMaPe2VahojxyEqH
 2cUXq/hjvPqHFVGXpHjgDErQXhGnWlSDAKtNxVLGbHH5pQcIn1R+ojWpshBsVgbYpg+v
 DBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OGksp0wUeS3p8PASURcbiVg/c99YFBosLMvmE92qIvA=;
 b=Buac6qZXOD85GlLNq6erix8AYrq5cIhA8DWAqgxHDMJRweUA7T15wJkuo0USzOr5lF
 Rs4pjmAYpCNdT03O/+ixHOGX97wMekBtXqvVR2XVg19NYdyhLQzv1hrmS3qgNtNQhxWZ
 9J6j0uND8a0GrxysGbKyxYwYK+RQykg78PHXeyCG1ZoNTETPRzZEV+caxkzdkjSFZo4c
 cv0pkf2Kz2KASKrT8TB6Y/p1GmwXGuIqUcloEWXG8a4WN7t7y6D5tFXkAO0va5v2t9CY
 ARdFNcOAt2WPulnW1DeZkbipuY4yKdk3Rd4XQkF1qqIna8GwGuSJizj34XjMOYbk7vuA
 /lwA==
X-Gm-Message-State: AOAM531YWZSBItY2zngvOsFcs7H0x2j20zY1KQKj8MVIu9C7zl+P17Hz
 SdSn8Dzt/aLRl2xNEd6nZoZFtoVijh7UuhF3IWo=
X-Google-Smtp-Source: ABdhPJy/4egNRYCA/Cm5nP3McR80d+S5Jj5vrlzOjXG6ta7pDXJI6TyWXGYNf+7T77qwfg+AXFC6BQo+Kv7IrV+7KQ0=
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr65403124wrp.96.1594309320416; 
 Thu, 09 Jul 2020 08:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+o7mcb8B9dy_F3w08i7XLrO71qWyqYNaJrjv0j3DhnSg@mail.gmail.com>
 <2666aec2-9872-6af6-7705-d7ce553f611c@redhat.com>
 <20200709152630.GW3753300@redhat.com>
 <CAFEAcA_9NUeMJQWuzbmm9raW4zBgu3FFhgCabxBD_RhKMo9GxQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_9NUeMJQWuzbmm9raW4zBgu3FFhgCabxBD_RhKMo9GxQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Jul 2020 19:41:48 +0400
Message-ID: <CAJ+F1C+MK0tEyHS_xSD6bBWJZFALF6jOwFAU2zYoJimnyGRdAw@mail.gmail.com>
Subject: Re: Is VXHS actually maintained?
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b4a1e605aa0410ce"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, ashmit602@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b4a1e605aa0410ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 9, 2020 at 7:30 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 9 Jul 2020 at 16:27, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
> wrote:
> > If it doesn't even compile, do we even need to go through the full
> > deprecation cycle ? I tend to feel like the release where it first
> > fails to compile automatically starts the deprecation countdown.
>
> Mmm, assuming that it's "couldn't possibly compile for anybody"
> rather than "doesn't compile for me (but maybe it would be OK
> on some other host OS config)".
>
> Marc-Andr=C3=A9, what are the details of the compilation failure?
>


I have done some release bisection.

v2.11.0 compiles, v2.12.0 started failing with:

  CC      block/vxhs.o
/home/elmarco/src/qq/block/vxhs.c:126:1: error: variable =E2=80=98runtime_o=
pts=E2=80=99 has
initializer but incomplete type
  126 | static QemuOptsList runtime_opts =3D {
      | ^~~~~~
/home/elmarco/src/qq/block/vxhs.c:127:6: error: =E2=80=98QemuOptsList=E2=80=
=99 has no
member named =E2=80=98name=E2=80=99
  127 |     .name =3D "vxhs",
      |      ^~~~
/home/elmarco/src/qq/block/vxhs.c:127:13: warning: excess elements in
struct initializer
  127 |     .name =3D "vxhs",
      |             ^~~~~~
/home/elmarco/src/qq/block/vxhs.c:127:13: note: (near initialization for
=E2=80=98runtime_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:128:6: error: =E2=80=98QemuOptsList=E2=80=
=99 has no
member named =E2=80=98head=E2=80=99
  128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
      |      ^~~~
In file included from /home/elmarco/src/qq/include/qemu/notify.h:17,
                 from /home/elmarco/src/qq/include/qemu/timer.h:5,
                 from /home/elmarco/src/qq/include/qemu/timed-average.h:29,
                 from /home/elmarco/src/qq/include/block/accounting.h:28,
                 from /home/elmarco/src/qq/include/block/block_int.h:27,
                 from /home/elmarco/src/qq/block/vxhs.c:14:
/home/elmarco/src/qq/include/qemu/queue.h:360:9: error: extra brace group
at end of initializer
  360 |         { NULL, &(head).tqh_first }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro
=E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near initialization
for =E2=80=98runtime_opts=E2=80=99)
  360 |         { NULL, &(head).tqh_first }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro
=E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:128:49: error: invalid use of incomplete
typedef =E2=80=98QemuOptsList=E2=80=99
  128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
      |                                                 ^
/home/elmarco/src/qq/include/qemu/queue.h:360:19: note: in definition of
macro =E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  360 |         { NULL, &(head).tqh_first }
      |                   ^~~~
/home/elmarco/src/qq/include/qemu/queue.h:360:9: warning: excess elements
in struct initializer
  360 |         { NULL, &(head).tqh_first }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro
=E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near initialization
for =E2=80=98runtime_opts=E2=80=99)
  360 |         { NULL, &(head).tqh_first }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro
=E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:129:6: error: =E2=80=98QemuOptsList=E2=80=
=99 has no
member named =E2=80=98desc=E2=80=99
  129 |     .desc =3D {
      |      ^~~~
/home/elmarco/src/qq/block/vxhs.c:129:13: error: extra brace group at end
of initializer
  129 |     .desc =3D {
      |             ^
/home/elmarco/src/qq/block/vxhs.c:129:13: note: (near initialization for
=E2=80=98runtime_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:130:9: error: extra brace group at end of
initializer
  130 |         {
      |         ^
/home/elmarco/src/qq/block/vxhs.c:130:9: note: (near initialization for
=E2=80=98runtime_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:132:21: error: =E2=80=98QEMU_OPT_STRING=
=E2=80=99
undeclared here (not in a function)
  132 |             .type =3D QEMU_OPT_STRING,
      |                     ^~~~~~~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:135:9: error: extra brace group at end of
initializer
  135 |         {
      |         ^
/home/elmarco/src/qq/block/vxhs.c:135:9: note: (near initialization for
=E2=80=98runtime_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:140:9: error: extra brace group at end of
initializer
  140 |         {
      |         ^
/home/elmarco/src/qq/block/vxhs.c:140:9: note: (near initialization for
=E2=80=98runtime_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:145:9: error: extra brace group at end of
initializer
  145 |         { /* end of list */ }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:145:9: note: (near initialization for
=E2=80=98runtime_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:129:13: warning: excess elements in
struct initializer
  129 |     .desc =3D {
      |             ^
/home/elmarco/src/qq/block/vxhs.c:129:13: note: (near initialization for
=E2=80=98runtime_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:149:1: error: variable =E2=80=98runtime_t=
cp_opts=E2=80=99
has initializer but incomplete type
  149 | static QemuOptsList runtime_tcp_opts =3D {
      | ^~~~~~
/home/elmarco/src/qq/block/vxhs.c:150:6: error: =E2=80=98QemuOptsList=E2=80=
=99 has no
member named =E2=80=98name=E2=80=99
  150 |     .name =3D "vxhs_tcp",
      |      ^~~~
/home/elmarco/src/qq/block/vxhs.c:150:13: warning: excess elements in
struct initializer
  150 |     .name =3D "vxhs_tcp",
      |             ^~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:150:13: note: (near initialization for
=E2=80=98runtime_tcp_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:151:6: error: =E2=80=98QemuOptsList=E2=80=
=99 has no
member named =E2=80=98head=E2=80=99
  151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
      |      ^~~~
In file included from /home/elmarco/src/qq/include/qemu/notify.h:17,
                 from /home/elmarco/src/qq/include/qemu/timer.h:5,
                 from /home/elmarco/src/qq/include/qemu/timed-average.h:29,
                 from /home/elmarco/src/qq/include/block/accounting.h:28,
                 from /home/elmarco/src/qq/include/block/block_int.h:27,
                 from /home/elmarco/src/qq/block/vxhs.c:14:
/home/elmarco/src/qq/include/qemu/queue.h:360:9: error: extra brace group
at end of initializer
  360 |         { NULL, &(head).tqh_first }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro
=E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near initialization
for =E2=80=98runtime_tcp_opts=E2=80=99)
  360 |         { NULL, &(head).tqh_first }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro
=E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:151:53: error: invalid use of incomplete
typedef =E2=80=98QemuOptsList=E2=80=99
  151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
      |                                                     ^
/home/elmarco/src/qq/include/qemu/queue.h:360:19: note: in definition of
macro =E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  360 |         { NULL, &(head).tqh_first }
      |                   ^~~~
/home/elmarco/src/qq/include/qemu/queue.h:360:9: warning: excess elements
in struct initializer
  360 |         { NULL, &(head).tqh_first }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro
=E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near initialization
for =E2=80=98runtime_tcp_opts=E2=80=99)
  360 |         { NULL, &(head).tqh_first }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro
=E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
  151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
      |             ^~~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:152:6: error: =E2=80=98QemuOptsList=E2=80=
=99 has no
member named =E2=80=98desc=E2=80=99
  152 |     .desc =3D {
      |      ^~~~
/home/elmarco/src/qq/block/vxhs.c:152:13: error: extra brace group at end
of initializer
  152 |     .desc =3D {
      |             ^
/home/elmarco/src/qq/block/vxhs.c:152:13: note: (near initialization for
=E2=80=98runtime_tcp_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:153:9: error: extra brace group at end of
initializer
  153 |         {
      |         ^
/home/elmarco/src/qq/block/vxhs.c:153:9: note: (near initialization for
=E2=80=98runtime_tcp_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:158:9: error: extra brace group at end of
initializer
  158 |         {
      |         ^
/home/elmarco/src/qq/block/vxhs.c:158:9: note: (near initialization for
=E2=80=98runtime_tcp_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:160:21: error: =E2=80=98QEMU_OPT_NUMBER=
=E2=80=99
undeclared here (not in a function)
  160 |             .type =3D QEMU_OPT_NUMBER,
      |                     ^~~~~~~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:164:9: error: extra brace group at end of
initializer
  164 |         { /* end of list */ }
      |         ^
/home/elmarco/src/qq/block/vxhs.c:164:9: note: (near initialization for
=E2=80=98runtime_tcp_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c:152:13: warning: excess elements in
struct initializer
  152 |     .desc =3D {
      |             ^
/home/elmarco/src/qq/block/vxhs.c:152:13: note: (near initialization for
=E2=80=98runtime_tcp_opts=E2=80=99)
/home/elmarco/src/qq/block/vxhs.c: In function =E2=80=98vxhs_open=E2=80=99:
/home/elmarco/src/qq/block/vxhs.c:309:12: warning: implicit declaration of
function =E2=80=98qemu_opts_create=E2=80=99; did you mean =E2=80=98qbus_cre=
ate=E2=80=99?
[-Wimplicit-function-declaration]
  309 |     opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort)=
;
      |            ^~~~~~~~~~~~~~~~
      |            qbus_create
/home/elmarco/src/qq/block/vxhs.c:309:12: warning: nested extern
declaration of =E2=80=98qemu_opts_create=E2=80=99 [-Wnested-externs]
/home/elmarco/src/qq/block/vxhs.c:309:10: warning: assignment to =E2=80=98Q=
emuOpts
*=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a =
cast [-Wint-conversion]
  309 |     opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort)=
;
      |          ^
/home/elmarco/src/qq/block/vxhs.c:310:14: warning: assignment to =E2=80=98Q=
emuOpts
*=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a =
cast [-Wint-conversion]
  310 |     tcp_opts =3D qemu_opts_create(&runtime_tcp_opts, NULL, 0,
&error_abort);
      |              ^
/home/elmarco/src/qq/block/vxhs.c:312:5: warning: implicit declaration of
function =E2=80=98qemu_opts_absorb_qdict=E2=80=99 [-Wimplicit-function-decl=
aration]
  312 |     qemu_opts_absorb_qdict(opts, options, &local_err);
      |     ^~~~~~~~~~~~~~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:312:5: warning: nested extern declaration
of =E2=80=98qemu_opts_absorb_qdict=E2=80=99 [-Wnested-externs]
/home/elmarco/src/qq/block/vxhs.c:319:20: warning: implicit declaration of
function =E2=80=98qemu_opt_get=E2=80=99; did you mean =E2=80=98qemu_aio_get=
=E2=80=99?
[-Wimplicit-function-declaration]
  319 |     vdisk_id_opt =3D qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
      |                    ^~~~~~~~~~~~
      |                    qemu_aio_get
/home/elmarco/src/qq/block/vxhs.c:319:20: warning: nested extern
declaration of =E2=80=98qemu_opt_get=E2=80=99 [-Wnested-externs]
/home/elmarco/src/qq/block/vxhs.c:319:18: warning: assignment to =E2=80=98c=
onst
char *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer witho=
ut a cast
[-Wint-conversion]
  319 |     vdisk_id_opt =3D qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
      |                  ^
/home/elmarco/src/qq/block/vxhs.c:346:21: warning: assignment to =E2=80=98c=
onst
char *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer witho=
ut a cast
[-Wint-conversion]
  346 |     server_host_opt =3D qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
      |                     ^
/home/elmarco/src/qq/block/vxhs.c:362:30: warning: passing argument 1 of
=E2=80=98g_strdup=E2=80=99 makes pointer from integer without a cast [-Wint=
-conversion]
  362 |     s->tlscredsid =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                              |
      |                              int
In file included from /usr/local/stow/glib/include/glib-2.0/glib.h:82,
                 from /home/elmarco/src/qq/include/glib-compat.h:19,
                 from /home/elmarco/src/qq/include/qemu/osdep.h:107,
                 from /home/elmarco/src/qq/block/vxhs.c:11:
/usr/local/stow/glib/include/glib-2.0/glib/gstrfuncs.h:217:52: note:
expected =E2=80=98const gchar *=E2=80=99 {aka =E2=80=98const char *=E2=80=
=99} but argument is of type =E2=80=98int=E2=80=99
  217 | gchar*               g_strdup        (const gchar *str)
G_GNUC_MALLOC;
      |                                       ~~~~~~~~~~~~~^~~
/home/elmarco/src/qq/block/vxhs.c:374:46: warning: passing argument 1 of
=E2=80=98g_ascii_strtoll=E2=80=99 makes pointer from integer without a cast
[-Wint-conversion]
  374 |     s->vdisk_hostinfo.port =3D g_ascii_strtoll(qemu_opt_get(tcp_opt=
s,
      |                                              ^~~~~~~~~~~~~~~~~~~~~~
      |                                              |
      |                                              int
  375 |
VXHS_OPT_PORT),
      |
~~~~~~~~~~~~~~
In file included from /usr/local/stow/glib/include/glib-2.0/glib.h:82,
                 from /home/elmarco/src/qq/include/glib-compat.h:19,
                 from /home/elmarco/src/qq/include/qemu/osdep.h:107,
                 from /home/elmarco/src/qq/block/vxhs.c:11:
/usr/local/stow/glib/include/glib-2.0/glib/gstrfuncs.h:157:46: note:
expected =E2=80=98const gchar *=E2=80=99 {aka =E2=80=98const char *=E2=80=
=99} but argument is of type =E2=80=98int=E2=80=99
  157 | gint64        g_ascii_strtoll  (const gchar *nptr,
      |                                 ~~~~~~~~~~~~~^~~~
/home/elmarco/src/qq/block/vxhs.c:400:5: warning: implicit declaration of
function =E2=80=98qemu_opts_del=E2=80=99; did you mean =E2=80=98qemu_open=
=E2=80=99?
[-Wimplicit-function-declaration]
  400 |     qemu_opts_del(tcp_opts);
      |     ^~~~~~~~~~~~~
      |     qemu_open
/home/elmarco/src/qq/block/vxhs.c:400:5: warning: nested extern declaration
of =E2=80=98qemu_opts_del=E2=80=99 [-Wnested-externs]
/home/elmarco/src/qq/block/vxhs.c: At top level:
/home/elmarco/src/qq/block/vxhs.c:126:21: error: storage size of
=E2=80=98runtime_opts=E2=80=99 isn=E2=80=99t known
  126 | static QemuOptsList runtime_opts =3D {
      |                     ^~~~~~~~~~~~
/home/elmarco/src/qq/block/vxhs.c:149:21: error: storage size of
=E2=80=98runtime_tcp_opts=E2=80=99 isn=E2=80=99t known
  149 | static QemuOptsList runtime_tcp_opts =3D {
      |                     ^~~~~~~~~~~~~~~~
make: *** [/home/elmarco/src/qq/rules.mak:66: block/vxhs.o] Error 1

--=20
Marc-Andr=C3=A9 Lureau

--000000000000b4a1e605aa0410ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 9, 2020 at 7:30 PM Pete=
r Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lin=
aro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Thu, 9 Jul 2020 at 16:27, Daniel P. Berrang=C3=A9 &lt;<a href=3D"=
mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; w=
rote:<br>
&gt; If it doesn&#39;t even compile, do we even need to go through the full=
<br>
&gt; deprecation cycle ? I tend to feel like the release where it first<br>
&gt; fails to compile automatically starts the deprecation countdown.<br>
<br>
Mmm, assuming that it&#39;s &quot;couldn&#39;t possibly compile for anybody=
&quot;<br>
rather than &quot;doesn&#39;t compile for me (but maybe it would be OK<br>
on some other host OS config)&quot;.<br>
<br>
Marc-Andr=C3=A9, what are the details of the compilation failure?<br></bloc=
kquote><div><br></div><div><br></div><div>I have done some release bisectio=
n.</div><div><br></div><div>v2.11.0 compiles, v2.12.0 started failing with:=
</div><div><br></div><div>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0block/vxhs.o<br>/ho=
me/elmarco/src/qq/block/vxhs.c:126:1: error: variable =E2=80=98runtime_opts=
=E2=80=99 has initializer but incomplete type<br>=C2=A0 126 | static QemuOp=
tsList runtime_opts =3D {<br>=C2=A0 =C2=A0 =C2=A0 | ^~~~~~<br>/home/elmarco=
/src/qq/block/vxhs.c:127:6: error: =E2=80=98QemuOptsList=E2=80=99 has no me=
mber named =E2=80=98name=E2=80=99<br>=C2=A0 127 | =C2=A0 =C2=A0 .name =3D &=
quot;vxhs&quot;,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0^~~~<br>/hom=
e/elmarco/src/qq/block/vxhs.c:127:13: warning: excess elements in struct in=
itializer<br>=C2=A0 127 | =C2=A0 =C2=A0 .name =3D &quot;vxhs&quot;,<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>/ho=
me/elmarco/src/qq/block/vxhs.c:127:13: note: (near initialization for =E2=
=80=98runtime_opts=E2=80=99)<br>/home/elmarco/src/qq/block/vxhs.c:128:6: er=
ror: =E2=80=98QemuOptsList=E2=80=99 has no member named =E2=80=98head=E2=80=
=99<br>=C2=A0 128 | =C2=A0 =C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(runtime=
_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0^~~~<br>In file =
included from /home/elmarco/src/qq/include/qemu/notify.h:17,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/elmarco/src/=
qq/include/qemu/timer.h:5,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from /home/elmarco/src/qq/include/qemu/timed-average.h:29,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /hom=
e/elmarco/src/qq/include/block/accounting.h:28,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/elmarco/src/qq/include/blo=
ck/block_int.h:27,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from /home/elmarco/src/qq/block/vxhs.c:14:<br>/home/elmarco/src/q=
q/include/qemu/queue.h:360:9: error: extra brace group at end of initialize=
r<br>=C2=A0 360 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(head).tqh_first=
 }<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco=
/src/qq/block/vxhs.c:128:13: note: in expansion of macro =E2=80=98QTAILQ_HE=
AD_INITIALIZER=E2=80=99<br>=C2=A0 128 | =C2=A0 =C2=A0 .head =3D QTAILQ_HEAD=
_INITIALIZER(runtime_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~<br>/home/elmarco/src/qq=
/include/qemu/queue.h:360:9: note: (near initialization for =E2=80=98runtim=
e_opts=E2=80=99)<br>=C2=A0 360 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(=
head).tqh_first }<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<b=
r>/home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99<br>=C2=A0 128 | =C2=A0 =C2=A0 .head =
=3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~<br>/home/=
elmarco/src/qq/block/vxhs.c:128:49: error: invalid use of incomplete typede=
f =E2=80=98QemuOptsList=E2=80=99<br>=C2=A0 128 | =C2=A0 =C2=A0 .head =3D QT=
AILQ_HEAD_INITIALIZER(runtime_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/include/qemu/queue.h:360:19: note: =
in definition of macro =E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99<br>=C2=A0 =
360 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(head).tqh_first }<br>=C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~<br>/home/elmarco/src/qq/include/qemu/queue.h:360:9: warning: ex=
cess elements in struct initializer<br>=C2=A0 360 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 { NULL, &amp;(head).tqh_first }<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:128:13: note: in e=
xpansion of macro =E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99<br>=C2=A0 128 |=
 =C2=A0 =C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~=
~~~~~~~~~~<br>/home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near =
initialization for =E2=80=98runtime_opts=E2=80=99)<br>=C2=A0 360 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(head).tqh_first }<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:12=
8:13: note: in expansion of macro =E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99=
<br>=C2=A0 128 | =C2=A0 =C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(runtime_op=
ts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~~~~~~~~~~~~~~~<br>/home/elmarco/src/qq/block/vxhs.c:129:6: err=
or: =E2=80=98QemuOptsList=E2=80=99 has no member named =E2=80=98desc=E2=80=
=99<br>=C2=A0 129 | =C2=A0 =C2=A0 .desc =3D {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0^~~~<br>/home/elmarco/src/qq/block/vxhs.c:129:13: error: e=
xtra brace group at end of initializer<br>=C2=A0 129 | =C2=A0 =C2=A0 .desc =
=3D {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
<br>/home/elmarco/src/qq/block/vxhs.c:129:13: note: (near initialization fo=
r =E2=80=98runtime_opts=E2=80=99)<br>/home/elmarco/src/qq/block/vxhs.c:130:=
9: error: extra brace group at end of initializer<br>=C2=A0 130 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:130:9: note: (near initializatio=
n for =E2=80=98runtime_opts=E2=80=99)<br>/home/elmarco/src/qq/block/vxhs.c:=
132:21: error: =E2=80=98QEMU_OPT_STRING=E2=80=99 undeclared here (not in a =
function)<br>=C2=A0 132 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =
=3D QEMU_OPT_STRING,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~<br>/home/elmarco/=
src/qq/block/vxhs.c:135:9: error: extra brace group at end of initializer<b=
r>=C2=A0 135 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:135:9: note=
: (near initialization for =E2=80=98runtime_opts=E2=80=99)<br>/home/elmarco=
/src/qq/block/vxhs.c:140:9: error: extra brace group at end of initializer<=
br>=C2=A0 140 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:140:9: note=
: (near initialization for =E2=80=98runtime_opts=E2=80=99)<br>/home/elmarco=
/src/qq/block/vxhs.c:145:9: error: extra brace group at end of initializer<=
br>=C2=A0 145 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 { /* end of list */ }<br>=C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/bloc=
k/vxhs.c:145:9: note: (near initialization for =E2=80=98runtime_opts=E2=80=
=99)<br>/home/elmarco/src/qq/block/vxhs.c:129:13: warning: excess elements =
in struct initializer<br>=C2=A0 129 | =C2=A0 =C2=A0 .desc =3D {<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarc=
o/src/qq/block/vxhs.c:129:13: note: (near initialization for =E2=80=98runti=
me_opts=E2=80=99)<br>/home/elmarco/src/qq/block/vxhs.c:149:1: error: variab=
le =E2=80=98runtime_tcp_opts=E2=80=99 has initializer but incomplete type<b=
r>=C2=A0 149 | static QemuOptsList runtime_tcp_opts =3D {<br>=C2=A0 =C2=A0 =
=C2=A0 | ^~~~~~<br>/home/elmarco/src/qq/block/vxhs.c:150:6: error: =E2=80=
=98QemuOptsList=E2=80=99 has no member named =E2=80=98name=E2=80=99<br>=C2=
=A0 150 | =C2=A0 =C2=A0 .name =3D &quot;vxhs_tcp&quot;,<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0^~~~<br>/home/elmarco/src/qq/block/vxhs.c:150:=
13: warning: excess elements in struct initializer<br>=C2=A0 150 | =C2=A0 =
=C2=A0 .name =3D &quot;vxhs_tcp&quot;,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>/home/elmarco/src/qq/block/vx=
hs.c:150:13: note: (near initialization for =E2=80=98runtime_tcp_opts=E2=80=
=99)<br>/home/elmarco/src/qq/block/vxhs.c:151:6: error: =E2=80=98QemuOptsLi=
st=E2=80=99 has no member named =E2=80=98head=E2=80=99<br>=C2=A0 151 | =C2=
=A0 =C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0^~~~<br>In file included from /home=
/elmarco/src/qq/include/qemu/notify.h:17,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/elmarco/src/qq/include/qemu/ti=
mer.h:5,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom /home/elmarco/src/qq/include/qemu/timed-average.h:29,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/elmarco/src/qq/i=
nclude/block/accounting.h:28,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from /home/elmarco/src/qq/include/block/block_int.h:27,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /hom=
e/elmarco/src/qq/block/vxhs.c:14:<br>/home/elmarco/src/qq/include/qemu/queu=
e.h:360:9: error: extra brace group at end of initializer<br>=C2=A0 360 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(head).tqh_first }<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vx=
hs.c:151:13: note: in expansion of macro =E2=80=98QTAILQ_HEAD_INITIALIZER=
=E2=80=99<br>=C2=A0 151 | =C2=A0 =C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(r=
untime_tcp_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~<br>/home/elmarco/src/qq/include/q=
emu/queue.h:360:9: note: (near initialization for =E2=80=98runtime_tcp_opts=
=E2=80=99)<br>=C2=A0 360 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(head).=
tqh_first }<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/hom=
e/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro =E2=80=98=
QTAILQ_HEAD_INITIALIZER=E2=80=99<br>=C2=A0 151 | =C2=A0 =C2=A0 .head =3D QT=
AILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~<br>/home/elm=
arco/src/qq/block/vxhs.c:151:53: error: invalid use of incomplete typedef =
=E2=80=98QemuOptsList=E2=80=99<br>=C2=A0 151 | =C2=A0 =C2=A0 .head =3D QTAI=
LQ_HEAD_INITIALIZER(runtime_tcp_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/include/qemu/queu=
e.h:360:19: note: in definition of macro =E2=80=98QTAILQ_HEAD_INITIALIZER=
=E2=80=99<br>=C2=A0 360 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(head).t=
qh_first }<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~<br>/home/elmarco/src/qq/include/qemu/queue.h:=
360:9: warning: excess elements in struct initializer<br>=C2=A0 360 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(head).tqh_first }<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c=
:151:13: note: in expansion of macro =E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=
=99<br>=C2=A0 151 | =C2=A0 =C2=A0 .head =3D QTAILQ_HEAD_INITIALIZER(runtime=
_tcp_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~<br>/home/elmarco/src/qq/include/qemu/que=
ue.h:360:9: note: (near initialization for =E2=80=98runtime_tcp_opts=E2=80=
=99)<br>=C2=A0 360 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 { NULL, &amp;(head).tqh_fi=
rst }<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elma=
rco/src/qq/block/vxhs.c:151:13: note: in expansion of macro =E2=80=98QTAILQ=
_HEAD_INITIALIZER=E2=80=99<br>=C2=A0 151 | =C2=A0 =C2=A0 .head =3D QTAILQ_H=
EAD_INITIALIZER(runtime_tcp_opts.head),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~<br>/home/elmarco=
/src/qq/block/vxhs.c:152:6: error: =E2=80=98QemuOptsList=E2=80=99 has no me=
mber named =E2=80=98desc=E2=80=99<br>=C2=A0 152 | =C2=A0 =C2=A0 .desc =3D {=
<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0^~~~<br>/home/elmarco/src/qq=
/block/vxhs.c:152:13: error: extra brace group at end of initializer<br>=C2=
=A0 152 | =C2=A0 =C2=A0 .desc =3D {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:152:13:=
 note: (near initialization for =E2=80=98runtime_tcp_opts=E2=80=99)<br>/hom=
e/elmarco/src/qq/block/vxhs.c:153:9: error: extra brace group at end of ini=
tializer<br>=C2=A0 153 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:15=
3:9: note: (near initialization for =E2=80=98runtime_tcp_opts=E2=80=99)<br>=
/home/elmarco/src/qq/block/vxhs.c:158:9: error: extra brace group at end of=
 initializer<br>=C2=A0 158 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.=
c:158:9: note: (near initialization for =E2=80=98runtime_tcp_opts=E2=80=99)=
<br>/home/elmarco/src/qq/block/vxhs.c:160:21: error: =E2=80=98QEMU_OPT_NUMB=
ER=E2=80=99 undeclared here (not in a function)<br>=C2=A0 160 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D QEMU_OPT_NUMBER,<br>=C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~~~~~~~~~~~~<br>/home/elmarco/src/qq/block/vxhs.c:164:9: error: e=
xtra brace group at end of initializer<br>=C2=A0 164 | =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 { /* end of list */ }<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:164:9: note: (near initia=
lization for =E2=80=98runtime_tcp_opts=E2=80=99)<br>/home/elmarco/src/qq/bl=
ock/vxhs.c:152:13: warning: excess elements in struct initializer<br>=C2=A0=
 152 | =C2=A0 =C2=A0 .desc =3D {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:152:13: =
note: (near initialization for =E2=80=98runtime_tcp_opts=E2=80=99)<br>/home=
/elmarco/src/qq/block/vxhs.c: In function =E2=80=98vxhs_open=E2=80=99:<br>/=
home/elmarco/src/qq/block/vxhs.c:309:12: warning: implicit declaration of f=
unction =E2=80=98qemu_opts_create=E2=80=99; did you mean =E2=80=98qbus_crea=
te=E2=80=99? [-Wimplicit-function-declaration]<br>=C2=A0 309 | =C2=A0 =C2=
=A0 opts =3D qemu_opts_create(&amp;runtime_opts, NULL, 0, &amp;error_abort)=
;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~=
~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0qbus_create<br>/home/elmarco/src/qq/block/vxhs.c:309:12: warning: nested=
 extern declaration of =E2=80=98qemu_opts_create=E2=80=99 [-Wnested-externs=
]<br>/home/elmarco/src/qq/block/vxhs.c:309:10: warning: assignment to =E2=
=80=98QemuOpts *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from int=
eger without a cast [-Wint-conversion]<br>=C2=A0 309 | =C2=A0 =C2=A0 opts =
=3D qemu_opts_create(&amp;runtime_opts, NULL, 0, &amp;error_abort);<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>/home/elmarco/sr=
c/qq/block/vxhs.c:310:14: warning: assignment to =E2=80=98QemuOpts *=E2=80=
=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a cast [-=
Wint-conversion]<br>=C2=A0 310 | =C2=A0 =C2=A0 tcp_opts =3D qemu_opts_creat=
e(&amp;runtime_tcp_opts, NULL, 0, &amp;error_abort);<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>/home/elmarco/sr=
c/qq/block/vxhs.c:312:5: warning: implicit declaration of function =E2=80=
=98qemu_opts_absorb_qdict=E2=80=99 [-Wimplicit-function-declaration]<br>=C2=
=A0 312 | =C2=A0 =C2=A0 qemu_opts_absorb_qdict(opts, options, &amp;local_er=
r);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~<br>/home=
/elmarco/src/qq/block/vxhs.c:312:5: warning: nested extern declaration of =
=E2=80=98qemu_opts_absorb_qdict=E2=80=99 [-Wnested-externs]<br>/home/elmarc=
o/src/qq/block/vxhs.c:319:20: warning: implicit declaration of function =E2=
=80=98qemu_opt_get=E2=80=99; did you mean =E2=80=98qemu_aio_get=E2=80=99? [=
-Wimplicit-function-declaration]<br>=C2=A0 319 | =C2=A0 =C2=A0 vdisk_id_opt=
 =3D qemu_opt_get(opts, VXHS_OPT_VDISK_ID);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~=
~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0qemu_aio_get<br>/home/elmarco/src/qq/block/vxhs.c:3=
19:20: warning: nested extern declaration of =E2=80=98qemu_opt_get=E2=80=99=
 [-Wnested-externs]<br>/home/elmarco/src/qq/block/vxhs.c:319:18: warning: a=
ssignment to =E2=80=98const char *=E2=80=99 from =E2=80=98int=E2=80=99 make=
s pointer from integer without a cast [-Wint-conversion]<br>=C2=A0 319 | =
=C2=A0 =C2=A0 vdisk_id_opt =3D qemu_opt_get(opts, VXHS_OPT_VDISK_ID);<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^<br>/home/elmarco/src/qq/block/vxhs.c:346:21: warning: assignmen=
t to =E2=80=98const char *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointe=
r from integer without a cast [-Wint-conversion]<br>=C2=A0 346 | =C2=A0 =C2=
=A0 server_host_opt =3D qemu_opt_get(tcp_opts, VXHS_OPT_HOST);<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^<br>/home/elmarco/src/qq/block/vxhs.c:362:30: warning: passing =
argument 1 of =E2=80=98g_strdup=E2=80=99 makes pointer from integer without=
 a cast [-Wint-conversion]<br>=C2=A0 362 | =C2=A0 =C2=A0 s-&gt;tlscredsid =
=3D g_strdup(qemu_opt_get(opts, &quot;tls-creds&quot;));<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int<br>In file included from /usr/local/=
stow/glib/include/glib-2.0/glib.h:82,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/elmarco/src/qq/include/glib-compat.h=
:19,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
/home/elmarco/src/qq/include/qemu/osdep.h:107,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/elmarco/src/qq/block/vxhs.=
c:11:<br>/usr/local/stow/glib/include/glib-2.0/glib/gstrfuncs.h:217:52: not=
e: expected =E2=80=98const gchar *=E2=80=99 {aka =E2=80=98const char *=E2=
=80=99} but argument is of type =E2=80=98int=E2=80=99<br>=C2=A0 217 | gchar=
* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strdup =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(const gchar *str) G_GNUC_MALLOC;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~~~^~=
~<br>/home/elmarco/src/qq/block/vxhs.c:374:46: warning: passing argument 1 =
of =E2=80=98g_ascii_strtoll=E2=80=99 makes pointer from integer without a c=
ast [-Wint-conversion]<br>=C2=A0 374 | =C2=A0 =C2=A0 s-&gt;vdisk_hostinfo.p=
ort =3D g_ascii_strtoll(qemu_opt_get(tcp_opts,<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int<br>=C2=A0 375 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VXHS_OPT_PORT),<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~~~~<=
br>In file included from /usr/local/stow/glib/include/glib-2.0/glib.h:82,<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/=
elmarco/src/qq/include/glib-compat.h:19,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/elmarco/src/qq/include/qemu/osdep=
.h:107,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fr=
om /home/elmarco/src/qq/block/vxhs.c:11:<br>/usr/local/stow/glib/include/gl=
ib-2.0/glib/gstrfuncs.h:157:46: note: expected =E2=80=98const gchar *=E2=80=
=99 {aka =E2=80=98const char *=E2=80=99} but argument is of type =E2=80=98i=
nt=E2=80=99<br>=C2=A0 157 | gint64 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_ascii_strto=
ll =C2=A0(const gchar *nptr,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~~~^~~~<br>/home/elmarco/src/qq/block/vxhs.c:40=
0:5: warning: implicit declaration of function =E2=80=98qemu_opts_del=E2=80=
=99; did you mean =E2=80=98qemu_open=E2=80=99? [-Wimplicit-function-declara=
tion]<br>=C2=A0 400 | =C2=A0 =C2=A0 qemu_opts_del(tcp_opts);<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 ^~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 qemu_open<br>/home/elmarco/src/qq/block/vxhs.c:400:5: warning: neste=
d extern declaration of =E2=80=98qemu_opts_del=E2=80=99 [-Wnested-externs]<=
br>/home/elmarco/src/qq/block/vxhs.c: At top level:<br>/home/elmarco/src/qq=
/block/vxhs.c:126:21: error: storage size of =E2=80=98runtime_opts=E2=80=99=
 isn=E2=80=99t known<br>=C2=A0 126 | static QemuOptsList runtime_opts =3D {=
<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<br>/home/elmarco/src/qq/block/vxhs.c:149=
:21: error: storage size of =E2=80=98runtime_tcp_opts=E2=80=99 isn=E2=80=99=
t known<br>=C2=A0 149 | static QemuOptsList runtime_tcp_opts =3D {<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~<br>make: *** [/home/elmarco/src/qq/rules.ma=
k:66: block/vxhs.o] Error 1</div><div><br></div>-- <br></div><div dir=3D"lt=
r" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000b4a1e605aa0410ce--

