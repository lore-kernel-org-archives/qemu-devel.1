Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B610B2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meUxCNCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B610B2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYpy-0008Cg-Nw
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtYox-0006yK-Dx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:50:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtYou-0006Jv-7t
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:50:46 -0400
Received: by mail-wm1-x343.google.com with SMTP id g75so2383803wme.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:references:date:in-reply-to:message-id
 :user-agent:mime-version:content-transfer-encoding;
 bh=a3moTjOPGaqcXffTIpHpPXHwO7b72aNQFRcvgJ+XDHg=;
 b=meUxCNCuAEV8d1BrlvnaCD4ltfGlbBuVeejhrkajlcY2+92Rr9stVP48Uwk1JfWEBz
 3EH79PYRaPnwi3nnXi43g128RCMRK2yWELEuLD2ZJXC9KZJCGJgO572aTVZrSKQU1wq0
 msM6T6e+pCybOIwhENENcpOX54NeVAO1g8bBR1bckKtaWygyppT62/jeRgeD1Yzd7R21
 b8Xd19+WH+T5Apy9GEfyylupmH3xhvwaNEq9HxJXKGkabAG3H70RMRKU6Sh0vU9XLsJf
 h998gw5LmJ43OV4roAT84dQvgesuLpvRUTbSOqn5Zxzxol88/2XPHQISBcDuCSRtvC+h
 AdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
 :message-id:user-agent:mime-version:content-transfer-encoding;
 bh=a3moTjOPGaqcXffTIpHpPXHwO7b72aNQFRcvgJ+XDHg=;
 b=CJUhixsx/z2Iy79cSbYcir5HO1Pvfxwu8ykJVORY1SDUJ2pLungcqpObCIX7v61ZLX
 QfDw9191kPXHO1SvF56SW5/CoE16xv3DqW2KgApVrggLV4H78qD0DZaHmaebV6icjyQ0
 OejcgHIoviRViVpuqddMb73VWKSW36Y+YtyUpyiKBbajZafxExkn+macyiSfBx05Bwfw
 F64zmdmHgRgRZA4DUHFjM6g1w2gPOgP+aema9RreOcM6XCB3mV/ulgeb6sPzTF+gpEGL
 wIoXV95Hvweu5i9+e0GxC0ZVjP0VPsY1sgIR0S4YKSM0SpSOAmPYLunTnW2zbwsGSi90
 hUTQ==
X-Gm-Message-State: AOAM533mG+t5I+LBkeXg+Qgs6xtPHgpM0IG8V1NSyAeA2XFg/KWz6HOT
 +o4czOCM8h45guZvx4MxkLX9ZQ==
X-Google-Smtp-Source: ABdhPJwf6OcbNKotvH9o17WXDY/UWAoge3UOk36VpqgLGu3WcC2wzX70/z9/nPjYWfvS49K682lm/A==
X-Received: by 2002:a1c:2e58:: with SMTP id u85mr623917wmu.123.1594309842671; 
 Thu, 09 Jul 2020 08:50:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k20sm5269141wmi.27.2020.07.09.08.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 08:50:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABB791FF7E;
 Thu,  9 Jul 2020 16:50:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: Is VXHS actually maintained?
References: <CAJ+F1C+o7mcb8B9dy_F3w08i7XLrO71qWyqYNaJrjv0j3DhnSg@mail.gmail.com>
 <2666aec2-9872-6af6-7705-d7ce553f611c@redhat.com>
 <20200709152630.GW3753300@redhat.com>
 <CAFEAcA_9NUeMJQWuzbmm9raW4zBgu3FFhgCabxBD_RhKMo9GxQ@mail.gmail.com>
 <CAJ+F1C+MK0tEyHS_xSD6bBWJZFALF6jOwFAU2zYoJimnyGRdAw@mail.gmail.com>
Date: Thu, 09 Jul 2020 16:50:40 +0100
In-Reply-To: <CAJ+F1C+MK0tEyHS_xSD6bBWJZFALF6jOwFAU2zYoJimnyGRdAw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 9 Jul 2020
 19:41:48 +0400")
Message-ID: <874kqgn0vj.fsf@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, ashmit602@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Jul 9, 2020 at 7:30 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>
>  On Thu, 9 Jul 2020 at 16:27, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>  > If it doesn't even compile, do we even need to go through the full
>  > deprecation cycle ? I tend to feel like the release where it first
>  > fails to compile automatically starts the deprecation countdown.
>
>  Mmm, assuming that it's "couldn't possibly compile for anybody"
>  rather than "doesn't compile for me (but maybe it would be OK
>  on some other host OS config)".
>
>  Marc-Andr=C3=A9, what are the details of the compilation failure?
>
> I have done some release bisection.
>
> v2.11.0 compiles, v2.12.0 started failing with:
>
>   CC      block/vxhs.o
> /home/elmarco/src/qq/block/vxhs.c:126:1: error: variable =E2=80=98runtime=
_opts=E2=80=99 has initializer but incomplete type
>   126 | static QemuOptsList runtime_opts =3D {
>       | ^~~~~~
> /home/elmarco/src/qq/block/vxhs.c:127:6: error: =E2=80=98QemuOptsList=E2=
=80=99 has no member named =E2=80=98name=E2=80=99
>   127 |     .name =3D "vxhs",
>       |      ^~~~
> /home/elmarco/src/qq/block/vxhs.c:127:13: warning: excess elements in str=
uct initializer
>   127 |     .name =3D "vxhs",
>       |             ^~~~~~
> /home/elmarco/src/qq/block/vxhs.c:127:13: note: (near initialization for =
=E2=80=98runtime_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:128:6: error: =E2=80=98QemuOptsList=E2=
=80=99 has no member named =E2=80=98head=E2=80=99
>   128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>       |      ^~~~
> In file included from /home/elmarco/src/qq/include/qemu/notify.h:17,
>                  from /home/elmarco/src/qq/include/qemu/timer.h:5,
>                  from /home/elmarco/src/qq/include/qemu/timed-average.h:2=
9,
>                  from /home/elmarco/src/qq/include/block/accounting.h:28,
>                  from /home/elmarco/src/qq/include/block/block_int.h:27,
>                  from /home/elmarco/src/qq/block/vxhs.c:14:
> /home/elmarco/src/qq/include/qemu/queue.h:360:9: error: extra brace group=
 at end of initializer
>   360 |         { NULL, &(head).tqh_first }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near initializati=
on for =E2=80=98runtime_opts=E2=80=99)
>   360 |         { NULL, &(head).tqh_first }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:128:49: error: invalid use of incomplet=
e typedef =E2=80=98QemuOptsList=E2=80=99
>   128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>       |                                                 ^
> /home/elmarco/src/qq/include/qemu/queue.h:360:19: note: in definition of =
macro =E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   360 |         { NULL, &(head).tqh_first }
>       |                   ^~~~
> /home/elmarco/src/qq/include/qemu/queue.h:360:9: warning: excess elements=
 in struct initializer
>   360 |         { NULL, &(head).tqh_first }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near initializati=
on for =E2=80=98runtime_opts=E2=80=99)
>   360 |         { NULL, &(head).tqh_first }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:128:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   128 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:129:6: error: =E2=80=98QemuOptsList=E2=
=80=99 has no member named =E2=80=98desc=E2=80=99
>   129 |     .desc =3D {
>       |      ^~~~
> /home/elmarco/src/qq/block/vxhs.c:129:13: error: extra brace group at end=
 of initializer
>   129 |     .desc =3D {
>       |             ^
> /home/elmarco/src/qq/block/vxhs.c:129:13: note: (near initialization for =
=E2=80=98runtime_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:130:9: error: extra brace group at end =
of initializer
>   130 |         {
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:130:9: note: (near initialization for =
=E2=80=98runtime_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:132:21: error: =E2=80=98QEMU_OPT_STRING=
=E2=80=99 undeclared here (not in a function)
>   132 |             .type =3D QEMU_OPT_STRING,
>       |                     ^~~~~~~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:135:9: error: extra brace group at end =
of initializer
>   135 |         {
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:135:9: note: (near initialization for =
=E2=80=98runtime_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:140:9: error: extra brace group at end =
of initializer
>   140 |         {
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:140:9: note: (near initialization for =
=E2=80=98runtime_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:145:9: error: extra brace group at end =
of initializer
>   145 |         { /* end of list */ }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:145:9: note: (near initialization for =
=E2=80=98runtime_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:129:13: warning: excess elements in str=
uct initializer
>   129 |     .desc =3D {
>       |             ^
> /home/elmarco/src/qq/block/vxhs.c:129:13: note: (near initialization for =
=E2=80=98runtime_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:149:1: error: variable =E2=80=98runtime=
_tcp_opts=E2=80=99 has initializer but incomplete type
>   149 | static QemuOptsList runtime_tcp_opts =3D {
>       | ^~~~~~
> /home/elmarco/src/qq/block/vxhs.c:150:6: error: =E2=80=98QemuOptsList=E2=
=80=99 has no member named =E2=80=98name=E2=80=99
>   150 |     .name =3D "vxhs_tcp",
>       |      ^~~~
> /home/elmarco/src/qq/block/vxhs.c:150:13: warning: excess elements in str=
uct initializer
>   150 |     .name =3D "vxhs_tcp",
>       |             ^~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:150:13: note: (near initialization for =
=E2=80=98runtime_tcp_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:151:6: error: =E2=80=98QemuOptsList=E2=
=80=99 has no member named =E2=80=98head=E2=80=99
>   151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
>       |      ^~~~
> In file included from /home/elmarco/src/qq/include/qemu/notify.h:17,
>                  from /home/elmarco/src/qq/include/qemu/timer.h:5,
>                  from /home/elmarco/src/qq/include/qemu/timed-average.h:2=
9,
>                  from /home/elmarco/src/qq/include/block/accounting.h:28,
>                  from /home/elmarco/src/qq/include/block/block_int.h:27,
>                  from /home/elmarco/src/qq/block/vxhs.c:14:
> /home/elmarco/src/qq/include/qemu/queue.h:360:9: error: extra brace group=
 at end of initializer
>   360 |         { NULL, &(head).tqh_first }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near initializati=
on for =E2=80=98runtime_tcp_opts=E2=80=99)
>   360 |         { NULL, &(head).tqh_first }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:151:53: error: invalid use of incomplet=
e typedef =E2=80=98QemuOptsList=E2=80=99
>   151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
>       |                                                     ^
> /home/elmarco/src/qq/include/qemu/queue.h:360:19: note: in definition of =
macro =E2=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   360 |         { NULL, &(head).tqh_first }
>       |                   ^~~~
> /home/elmarco/src/qq/include/qemu/queue.h:360:9: warning: excess elements=
 in struct initializer
>   360 |         { NULL, &(head).tqh_first }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/include/qemu/queue.h:360:9: note: (near initializati=
on for =E2=80=98runtime_tcp_opts=E2=80=99)
>   360 |         { NULL, &(head).tqh_first }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:151:13: note: in expansion of macro =E2=
=80=98QTAILQ_HEAD_INITIALIZER=E2=80=99
>   151 |     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:152:6: error: =E2=80=98QemuOptsList=E2=
=80=99 has no member named =E2=80=98desc=E2=80=99
>   152 |     .desc =3D {
>       |      ^~~~
> /home/elmarco/src/qq/block/vxhs.c:152:13: error: extra brace group at end=
 of initializer
>   152 |     .desc =3D {
>       |             ^
> /home/elmarco/src/qq/block/vxhs.c:152:13: note: (near initialization for =
=E2=80=98runtime_tcp_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:153:9: error: extra brace group at end =
of initializer
>   153 |         {
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:153:9: note: (near initialization for =
=E2=80=98runtime_tcp_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:158:9: error: extra brace group at end =
of initializer
>   158 |         {
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:158:9: note: (near initialization for =
=E2=80=98runtime_tcp_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:160:21: error: =E2=80=98QEMU_OPT_NUMBER=
=E2=80=99 undeclared here (not in a function)
>   160 |             .type =3D QEMU_OPT_NUMBER,
>       |                     ^~~~~~~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:164:9: error: extra brace group at end =
of initializer
>   164 |         { /* end of list */ }
>       |         ^
> /home/elmarco/src/qq/block/vxhs.c:164:9: note: (near initialization for =
=E2=80=98runtime_tcp_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c:152:13: warning: excess elements in str=
uct initializer
>   152 |     .desc =3D {
>       |             ^
> /home/elmarco/src/qq/block/vxhs.c:152:13: note: (near initialization for =
=E2=80=98runtime_tcp_opts=E2=80=99)
> /home/elmarco/src/qq/block/vxhs.c: In function =E2=80=98vxhs_open=E2=80=
=99:
> /home/elmarco/src/qq/block/vxhs.c:309:12: warning: implicit declaration o=
f function =E2=80=98qemu_opts_create=E2=80=99; did you mean =E2=80=98qbus_c=
reate=E2=80=99? [-Wimplicit-function-declaration]
>   309 |     opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abor=
t);
>       |            ^~~~~~~~~~~~~~~~
>       |            qbus_create
> /home/elmarco/src/qq/block/vxhs.c:309:12: warning: nested extern declarat=
ion of =E2=80=98qemu_opts_create=E2=80=99 [-Wnested-externs]
> /home/elmarco/src/qq/block/vxhs.c:309:10: warning: assignment to =E2=80=
=98QemuOpts *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from intege=
r without a cast [-Wint-conversion]
>   309 |     opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abor=
t);
>       |          ^
> /home/elmarco/src/qq/block/vxhs.c:310:14: warning: assignment to =E2=80=
=98QemuOpts *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from intege=
r without a cast [-Wint-conversion]
>   310 |     tcp_opts =3D qemu_opts_create(&runtime_tcp_opts, NULL, 0, &er=
ror_abort);
>       |              ^
> /home/elmarco/src/qq/block/vxhs.c:312:5: warning: implicit declaration of=
 function =E2=80=98qemu_opts_absorb_qdict=E2=80=99 [-Wimplicit-function-dec=
laration]
>   312 |     qemu_opts_absorb_qdict(opts, options, &local_err);
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:312:5: warning: nested extern declarati=
on of =E2=80=98qemu_opts_absorb_qdict=E2=80=99 [-Wnested-externs]
> /home/elmarco/src/qq/block/vxhs.c:319:20: warning: implicit declaration o=
f function =E2=80=98qemu_opt_get=E2=80=99; did you mean =E2=80=98qemu_aio_g=
et=E2=80=99? [-Wimplicit-function-declaration]
>   319 |     vdisk_id_opt =3D qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
>       |                    ^~~~~~~~~~~~
>       |                    qemu_aio_get
> /home/elmarco/src/qq/block/vxhs.c:319:20: warning: nested extern declarat=
ion of =E2=80=98qemu_opt_get=E2=80=99 [-Wnested-externs]
> /home/elmarco/src/qq/block/vxhs.c:319:18: warning: assignment to =E2=80=
=98const char *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from inte=
ger without a cast [-Wint-conversion]
>   319 |     vdisk_id_opt =3D qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
>       |                  ^
> /home/elmarco/src/qq/block/vxhs.c:346:21: warning: assignment to =E2=80=
=98const char *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from inte=
ger without a cast [-Wint-conversion]
>   346 |     server_host_opt =3D qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
>       |                     ^
> /home/elmarco/src/qq/block/vxhs.c:362:30: warning: passing argument 1 of =
=E2=80=98g_strdup=E2=80=99 makes pointer from integer without a cast [-Wint=
-conversion]
>   362 |     s->tlscredsid =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
>       |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                              |
>       |                              int
> In file included from /usr/local/stow/glib/include/glib-2.0/glib.h:82,
>                  from /home/elmarco/src/qq/include/glib-compat.h:19,
>                  from /home/elmarco/src/qq/include/qemu/osdep.h:107,
>                  from /home/elmarco/src/qq/block/vxhs.c:11:
> /usr/local/stow/glib/include/glib-2.0/glib/gstrfuncs.h:217:52: note: expe=
cted =E2=80=98const gchar *=E2=80=99 {aka =E2=80=98const char *=E2=80=99} b=
ut argument is of type =E2=80=98int=E2=80=99
>   217 | gchar*               g_strdup        (const gchar *str) G_GNUC_MA=
LLOC;
>       |                                       ~~~~~~~~~~~~~^~~
> /home/elmarco/src/qq/block/vxhs.c:374:46: warning: passing argument 1 of =
=E2=80=98g_ascii_strtoll=E2=80=99 makes pointer from integer without a cast=
 [-Wint-conversion]
>   374 |     s->vdisk_hostinfo.port =3D g_ascii_strtoll(qemu_opt_get(tcp_o=
pts,
>       |                                              ^~~~~~~~~~~~~~~~~~~~=
~~
>       |                                              |
>       |                                              int
>   375 |                                                           VXHS_OP=
T_PORT),
>       |                                                           ~~~~~~~=
~~~~~~~
> In file included from /usr/local/stow/glib/include/glib-2.0/glib.h:82,
>                  from /home/elmarco/src/qq/include/glib-compat.h:19,
>                  from /home/elmarco/src/qq/include/qemu/osdep.h:107,
>                  from /home/elmarco/src/qq/block/vxhs.c:11:
> /usr/local/stow/glib/include/glib-2.0/glib/gstrfuncs.h:157:46: note: expe=
cted =E2=80=98const gchar *=E2=80=99 {aka =E2=80=98const char *=E2=80=99} b=
ut argument is of type =E2=80=98int=E2=80=99
>   157 | gint64        g_ascii_strtoll  (const gchar *nptr,
>       |                                 ~~~~~~~~~~~~~^~~~
> /home/elmarco/src/qq/block/vxhs.c:400:5: warning: implicit declaration of=
 function =E2=80=98qemu_opts_del=E2=80=99; did you mean =E2=80=98qemu_open=
=E2=80=99? [-Wimplicit-function-declaration]
>   400 |     qemu_opts_del(tcp_opts);
>       |     ^~~~~~~~~~~~~
>       |     qemu_open
> /home/elmarco/src/qq/block/vxhs.c:400:5: warning: nested extern declarati=
on of =E2=80=98qemu_opts_del=E2=80=99 [-Wnested-externs]
> /home/elmarco/src/qq/block/vxhs.c: At top level:
> /home/elmarco/src/qq/block/vxhs.c:126:21: error: storage size of =E2=80=
=98runtime_opts=E2=80=99 isn=E2=80=99t known
>   126 | static QemuOptsList runtime_opts =3D {
>       |                     ^~~~~~~~~~~~
> /home/elmarco/src/qq/block/vxhs.c:149:21: error: storage size of =E2=80=
=98runtime_tcp_opts=E2=80=99 isn=E2=80=99t known
>   149 | static QemuOptsList runtime_tcp_opts =3D {
>       |                     ^~~~~~~~~~~~~~~~
> make: *** [/home/elmarco/src/qq/rules.mak:66: block/vxhs.o] Error 1

That looks more like it got missed in a clean-up series because we don't
have coverage in our typical builds and CI?

--=20
Alex Benn=C3=A9e

