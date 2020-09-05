Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B2BC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA3F208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnMpx2di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA3F208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERLE-00016C-TP
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERKb-0000eO-PV
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 02:05:45 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERKZ-0001cM-NE
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 02:05:45 -0400
Received: by mail-lj1-x241.google.com with SMTP id y4so10354553ljk.8
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=OEya0/j8V0lG6He6y55UyxiRUr12CTNBt13/Q5V2MZs=;
 b=tnMpx2ditRVwu8tpVOu3w8m5ehmWB/V6NAm+Rof4MITk9N8TrFwfOZhOj7QvtDaaJf
 2tcoZMUVUX51GLoYb1QkRD/hOw9hbeEdqp6Hfh7ktTrpvjLo7atZrU+MaUivV4as5puz
 LEML8vPLW9m5P65eJl66juQY7da7T1C5cOb+Ly01MKDe0PVe6dQfufiNLE2FPZxuc0g6
 O1AC6XOwp8Vpb3EH/4WUaIFYBcKlCrSe7693jvEYjiiruqDjCGbh296fv999kepFpJAJ
 XV9RSjCVs/OT99lDOl1q24aMH99Lf6drb5EbMzetHI/MPMULeELqmEnHkQw1vnW0s40W
 q3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=OEya0/j8V0lG6He6y55UyxiRUr12CTNBt13/Q5V2MZs=;
 b=HaWp83zD/jwoc+dAjw7zT7kmIPQEE29O32P4oJt8oj9m4ch/6OBp3Bs7KXhXj0WJ3u
 PiWaevb+3Flm0sR+TX1uhMMnzY3UPPxULOHIWjUvRyQmjO1tSTuRtsNC+K7sWf+veDPf
 oMZSIfh5cvOc1Gy1fLheoVB3yHY2B2JYMxGbZLKC0LJyuv6DdGYBanMGoev/tWJqRiPS
 GLjTrxWNJJT4vzAI1K/pYku/owoamh/UDdjLWCTSq1Rh7z9H48BptSMyCINGHwwnxaJu
 Ij/PzK6HM1oimvtF6I/UeTsyWiZMGub93a7xOmy5eIUAGIdUd7bBZa+Sca3r61B1ZFoH
 Ay5Q==
X-Gm-Message-State: AOAM530mbDBDzn3wQMQ23Ynx6Apu+YQ5dheQGfL+K7+hX+7QACDOUZ9f
 0W0AVMl57y/MIrYWT2iEFhODSXPUQq+31HAz47w=
X-Google-Smtp-Source: ABdhPJw7xI+9z+J+wj76vq3Q+pNy7u/YPfdMW4D+Bloeg6IquF0Xs02AH4Qv7xt5ydT9AFVvyMaf3B+85PVyGwip8Y8=
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr5594528ljj.171.1599285941734; 
 Fri, 04 Sep 2020 23:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200902102433.304737-1-thuth@redhat.com>
 <cb02c4e8-6bc4-733e-ead9-bdbf5cd95b83@redhat.com>
In-Reply-To: <cb02c4e8-6bc4-733e-ead9-bdbf5cd95b83@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 5 Sep 2020 14:05:29 +0800
Message-ID: <CAE2XoE85TBKiKRzfaK_neTgJ9Shxi-5GZAwn7YRDw0Mcx3fkvA@mail.gmail.com>
Subject: Re: [PATCH] stubs: Move qemu_timer_notify_cb() and remove
 qemu_notify_event() stub
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000073913a05ae8ac684"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000073913a05ae8ac684
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2020 at 6:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 02/09/20 12:24, Thomas Huth wrote:
> > When cross-compiling with MinGW, there are sometimes some weird linker
> > errors like:
> >
> > ibqemuutil.a(util_main-loop.c.obj): In function `qemu_notify_event':
> > /builds/huth/qemu/build/../util/main-loop.c:139: multiple definition of
> >  `qemu_notify_event'
> >
> libqemuutil.a(stubs_notify-event.c.obj):/builds/huth/qemu/stubs/notify-ev=
ent.c:5:
> >  first defined here
> > collect2: error: ld returned 1 exit status
> > /builds/huth/qemu/rules.mak:88: recipe for target
> 'tests/test-timed-average.exe'
> >  failed
> >
> > It seems like it works better when the qemu_timer_notify_cb() stub (whi=
ch
> > calls qemu_notify_event()) is in a separate file - then we can also eve=
n
> > remove the qemu_notify_event() stub now.
> >
> > This patch is based on ideas from the patch "stubs: Remove
> qemu_notify_event()"
> > by Philippe Mathieu-Daud=C3=A9 and the patch "cpu-timers, icount: new
> modules" from
> > Claudio Fontana.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  stubs/cpu-get-icount.c       | 5 -----
> >  stubs/meson.build            | 2 +-
> >  stubs/notify-event.c         | 6 ------
> >  stubs/qemu-timer-notify-cb.c | 8 ++++++++
> >  4 files changed, 9 insertions(+), 12 deletions(-)
> >  delete mode 100644 stubs/notify-event.c
> >  create mode 100644 stubs/qemu-timer-notify-cb.c
> >
> > diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
> > index b35f844638..4001613240 100644
> > --- a/stubs/cpu-get-icount.c
> > +++ b/stubs/cpu-get-icount.c
> > @@ -14,8 +14,3 @@ int64_t cpu_get_icount_raw(void)
> >  {
> >      abort();
> >  }
> > -
> > -void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> > -{
> > -    qemu_notify_event();
> > -}
> > diff --git a/stubs/meson.build b/stubs/meson.build
> > index 019bd79c7a..e2dfedc2a7 100644
> > --- a/stubs/meson.build
> > +++ b/stubs/meson.build
> > @@ -24,9 +24,9 @@ stub_ss.add(files('machine-init-done.c'))
> >  stub_ss.add(files('migr-blocker.c'))
> >  stub_ss.add(files('monitor.c'))
> >  stub_ss.add(files('monitor-core.c'))
> > -stub_ss.add(files('notify-event.c'))
> >  stub_ss.add(files('pci-bus.c'))
> >  stub_ss.add(files('pci-host-piix.c'))
> > +stub_ss.add(files('qemu-timer-notify-cb.c'))
> >  stub_ss.add(files('qmp_memory_device.c'))
> >  stub_ss.add(files('qtest.c'))
> >  stub_ss.add(files('ram-block.c'))
> > diff --git a/stubs/notify-event.c b/stubs/notify-event.c
> > deleted file mode 100644
> > index 827bb52d1a..0000000000
> > --- a/stubs/notify-event.c
> > +++ /dev/null
> > @@ -1,6 +0,0 @@
> > -#include "qemu/osdep.h"
> > -#include "qemu/main-loop.h"
> > -
> > -void qemu_notify_event(void)
> > -{
> > -}
> > diff --git a/stubs/qemu-timer-notify-cb.c b/stubs/qemu-timer-notify-cb.=
c
> > new file mode 100644
> > index 0000000000..054b408b1c
> > --- /dev/null
> > +++ b/stubs/qemu-timer-notify-cb.c
> > @@ -0,0 +1,8 @@
> > +#include "qemu/osdep.h"
> > +#include "sysemu/cpus.h"
> > +#include "qemu/main-loop.h"
> > +
> > +void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
> > +{
> > +    qemu_notify_event();
> > +}
> >
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
LGTM, can you queue this patch,


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000073913a05ae8ac684
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 2, 2020 at 6:33 PM Paolo =
Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 02=
/09/20 12:24, Thomas Huth wrote:<br>
&gt; When cross-compiling with MinGW, there are sometimes some weird linker=
<br>
&gt; errors like:<br>
&gt; <br>
&gt; ibqemuutil.a(util_main-loop.c.obj): In function `qemu_notify_event&#39=
;:<br>
&gt; /builds/huth/qemu/build/../util/main-loop.c:139: multiple definition o=
f<br>
&gt;=C2=A0 `qemu_notify_event&#39;<br>
&gt; libqemuutil.a(stubs_notify-event.c.obj):/builds/huth/qemu/stubs/notify=
-event.c:5:<br>
&gt;=C2=A0 first defined here<br>
&gt; collect2: error: ld returned 1 exit status<br>
&gt; /builds/huth/qemu/rules.mak:88: recipe for target &#39;tests/test-time=
d-average.exe&#39;<br>
&gt;=C2=A0 failed<br>
&gt; <br>
&gt; It seems like it works better when the qemu_timer_notify_cb() stub (wh=
ich<br>
&gt; calls qemu_notify_event()) is in a separate file - then we can also ev=
en<br>
&gt; remove the qemu_notify_event() stub now.<br>
&gt; <br>
&gt; This patch is based on ideas from the patch &quot;stubs: Remove qemu_n=
otify_event()&quot;<br>
&gt; by Philippe Mathieu-Daud=C3=A9 and the patch &quot;cpu-timers, icount:=
 new modules&quot; from<br>
&gt; Claudio Fontana.<br>
&gt; <br>
&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" tar=
get=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 stubs/cpu-get-icount.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 -----<br>
&gt;=C2=A0 stubs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +=
-<br>
&gt;=C2=A0 stubs/notify-event.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 ------=
<br>
&gt;=C2=A0 stubs/qemu-timer-notify-cb.c | 8 ++++++++<br>
&gt;=C2=A0 4 files changed, 9 insertions(+), 12 deletions(-)<br>
&gt;=C2=A0 delete mode 100644 stubs/notify-event.c<br>
&gt;=C2=A0 create mode 100644 stubs/qemu-timer-notify-cb.c<br>
&gt; <br>
&gt; diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c<br>
&gt; index b35f844638..4001613240 100644<br>
&gt; --- a/stubs/cpu-get-icount.c<br>
&gt; +++ b/stubs/cpu-get-icount.c<br>
&gt; @@ -14,8 +14,3 @@ int64_t cpu_get_icount_raw(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 abort();<br>
&gt;=C2=A0 }<br>
&gt; -<br>
&gt; -void qemu_timer_notify_cb(void *opaque, QEMUClockType type)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 qemu_notify_event();<br>
&gt; -}<br>
&gt; diff --git a/stubs/meson.build b/stubs/meson.build<br>
&gt; index 019bd79c7a..e2dfedc2a7 100644<br>
&gt; --- a/stubs/meson.build<br>
&gt; +++ b/stubs/meson.build<br>
&gt; @@ -24,9 +24,9 @@ stub_ss.add(files(&#39;machine-init-done.c&#39;))<br=
>
&gt;=C2=A0 stub_ss.add(files(&#39;migr-blocker.c&#39;))<br>
&gt;=C2=A0 stub_ss.add(files(&#39;monitor.c&#39;))<br>
&gt;=C2=A0 stub_ss.add(files(&#39;monitor-core.c&#39;))<br>
&gt; -stub_ss.add(files(&#39;notify-event.c&#39;))<br>
&gt;=C2=A0 stub_ss.add(files(&#39;pci-bus.c&#39;))<br>
&gt;=C2=A0 stub_ss.add(files(&#39;pci-host-piix.c&#39;))<br>
&gt; +stub_ss.add(files(&#39;qemu-timer-notify-cb.c&#39;))<br>
&gt;=C2=A0 stub_ss.add(files(&#39;qmp_memory_device.c&#39;))<br>
&gt;=C2=A0 stub_ss.add(files(&#39;qtest.c&#39;))<br>
&gt;=C2=A0 stub_ss.add(files(&#39;ram-block.c&#39;))<br>
&gt; diff --git a/stubs/notify-event.c b/stubs/notify-event.c<br>
&gt; deleted file mode 100644<br>
&gt; index 827bb52d1a..0000000000<br>
&gt; --- a/stubs/notify-event.c<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,6 +0,0 @@<br>
&gt; -#include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;qemu/main-loop.h&quot;<br>
&gt; -<br>
&gt; -void qemu_notify_event(void)<br>
&gt; -{<br>
&gt; -}<br>
&gt; diff --git a/stubs/qemu-timer-notify-cb.c b/stubs/qemu-timer-notify-cb=
.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..054b408b1c<br>
&gt; --- /dev/null<br>
&gt; +++ b/stubs/qemu-timer-notify-cb.c<br>
&gt; @@ -0,0 +1,8 @@<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;sysemu/cpus.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt; +<br>
&gt; +void qemu_timer_notify_cb(void *opaque, QEMUClockType type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_notify_event();<br>
&gt; +}<br>
&gt; <br>
<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank">pbonzini@redhat.com</a>&gt;<br></blockquote><div>LGTM, can you =
queue this patch,</div></div><br clear=3D"all"><div><br></div>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000073913a05ae8ac684--

