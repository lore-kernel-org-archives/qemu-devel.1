Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB04C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A481206B1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OArJ+0uQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A481206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDevR-000302-8a
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDdQr-0001Sn-HC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDdQm-0006aW-IU
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:16:37 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:33484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jDdQm-0006TL-CS; Sun, 15 Mar 2020 20:16:32 -0400
Received: by mail-oi1-x236.google.com with SMTP id r7so15971887oij.0;
 Sun, 15 Mar 2020 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=V1LCdhJPbbNcMQqy0F1us7cNHjjRfdWD+o3iHVyNasI=;
 b=OArJ+0uQCpBjanoYPLXh/eraqb2y38wb9P33idKuUoZFP5XkAVpQkdMVQPQUwNcHlD
 zPt5eLX4Bnd7sIKt2S4/A8kxu3CP2HFtwpnCREAT3d1ofCDAQvAtvxwq7AgPIv2heL+I
 hknmySDuXKfxl3g5/S4yg4dfOIjxH9AMr6D0M5VVzEAXSrUaqh+SsQ66YMsMtIwb5Y7z
 3mGfcKOw2bJtNnb99C3GXoJ+wIB72vi8XmhwBWbSV8fe+FSQ5Vg5jqFFgFvUW5ihbxvy
 efCPwC+JCDQFYQQ1KQHwrV8MmDcgULZisSz5iRY6Sd2CIBR9cWjdglTHm3okwmHBpBgi
 4rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=V1LCdhJPbbNcMQqy0F1us7cNHjjRfdWD+o3iHVyNasI=;
 b=a9ht6AUCfkbgqYRq7JXz9wetFYJNXF/rD6h4o9V9cJKMutE6CNMyPeoKkQklLHYhTq
 fEiBT2dRjcm7XINXkVBT/nx9Exf98FKIt5eK3Uo46RmdIxh6D7JYabVnap6lXZ6tyvBn
 Gi3uQJu0XcYpzQTjvM7Tw4j1UJwqSVuhiRsVv/eVdFdpDnGtpppYX8WnLnK+EouXnUW+
 5clc5/2OQZGv4GNAE648n3S+7i5N/0BzOfn63e1h0qwLWDPbZIIW1AfCK1Ngi97wS4MA
 M4Uv/EkrzcB6Br86OOAa6pXk78/XpkBQxm9EhfOZxk3YRlRkP1xJ3aGvYwtMX+CBgAt1
 2Uvg==
X-Gm-Message-State: ANhLgQ1m3yGImqPcstK9EsImeWE1Bc47LHP6CLNiKufDlxJx7VIOByJm
 HJnBnFfxztM3JB/BCN2vDhKbVFHPQ87FSEFASek=
X-Google-Smtp-Source: ADFU+vtgLZh4j7Abt6I9OD16g5KewFNtua0ssPyeqLDnVU07E+I/kRFCKF3vgRYBW9026aMTDFaH0h26GzEUi3Mj/3I=
X-Received: by 2002:aca:3c45:: with SMTP id j66mr15750276oia.62.1584317791176; 
 Sun, 15 Mar 2020 17:16:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Sun, 15 Mar 2020 17:16:30
 -0700 (PDT)
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 16 Mar 2020 01:16:30 +0100
Message-ID: <CAL1e-=jBg6OVe+Qgg5SOoJ+S4x70vQF_rttE2_VTddhR4O5n0w@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] user-mode: Prune build dependencies (part 1)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000278cfd05a0edbbbf"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000278cfd05a0edbbbf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, March 16, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
wrote:

> This is the first part of a series reducing user-mode
> dependencies. By stripping out unused code, the build
> and testing time is reduced (as is space used by objects).
>
> Part 1:
> - reduce user-mode object list
> - remove some migration code from user-mode
> - remove cpu_get_crash_info()
>
>
What is the purpose of dividing into parts? What is the content of other
parts, and when do you plan to submit those? A series is usually a
stand-alone and a complete logical unit - why did you decide to submit
"parts" separately (just curious)?

Does this series affect executables' size, or cut build times only?

Thanks,
Aleksandar



> Since v1:
> - Addressed Laurent/Richard review comments
> - Removed 'exec: Drop redundant #ifdeffery'
> - Removed 'target: Restrict write_elfXX_note() handlers to system-mode'
>
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688456.html
>
> Philippe Mathieu-Daud=C3=A9 (12):
>   Makefile: Only build virtiofsd if system-mode is enabled
>   configure: Avoid building TCG when not needed
>   tests/Makefile: Only display TCG-related tests when TCG is available
>   tests/Makefile: Restrict some softmmu-only tests
>   util/Makefile: Reduce the user-mode object list
>   stubs/Makefile: Reduce the user-mode object list
>   target/riscv/cpu: Restrict CPU migration to system-mode
>   exec: Assert CPU migration is not used on user-only build
>   arch_init: Remove unused 'qapi-commands-misc.h' include
>   target/i386: Restrict CpuClass::get_crash_info() to system-mode
>   target/s390x: Restrict CpuClass::get_crash_info() to system-mode
>   hw/core: Restrict CpuClass::get_crash_info() to system-mode
>
>  configure              |  4 +++
>  Makefile               |  2 +-
>  include/hw/core/cpu.h  |  7 ++++-
>  arch_init.c            |  1 -
>  exec.c                 |  4 ++-
>  hw/core/cpu.c          |  2 ++
>  target/i386/cpu.c      |  6 ++++-
>  target/riscv/cpu.c     |  6 +++--
>  target/s390x/cpu.c     | 12 ++++-----
>  stubs/Makefile.objs    | 52 +++++++++++++++++++++----------------
>  tests/Makefile.include | 18 +++++++------
>  util/Makefile.objs     | 59 +++++++++++++++++++++++++++---------------
>  12 files changed, 108 insertions(+), 65 deletions(-)
>
> --
> 2.21.1
>
>
>

--000000000000278cfd05a0edbbbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, March 16, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">This is the first part of a series reducing user-mode=
<br>
dependencies. By stripping out unused code, the build<br>
and testing time is reduced (as is space used by objects).<br>
<br>
Part 1:<br>
- reduce user-mode object list<br>
- remove some migration code from user-mode<br>
- remove cpu_get_crash_info()<br>
<br></blockquote><div><br></div><div>What is the purpose of dividing into p=
arts? What is the content of other parts, and when do you plan to submit th=
ose? A series is usually a stand-alone and a complete logical unit - why di=
d you decide to submit &quot;parts&quot; separately (just curious)?</div><d=
iv><br></div><div>Does this series affect executables&#39; size, or cut bui=
ld times only?</div><div><br></div><div>Thanks,</div><div>Aleksandar</div><=
div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Since v1:<br>
- Addressed Laurent/Richard review comments<br>
- Removed &#39;exec: Drop redundant #ifdeffery&#39;<br>
- Removed &#39;target: Restrict write_elfXX_note() handlers to system-mode&=
#39;<br>
<br>
v1: <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg688456=
.html" target=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@nongn=
u.org/<wbr>msg688456.html</a><br>
<br>
Philippe Mathieu-Daud=C3=A9 (12):<br>
=C2=A0 Makefile: Only build virtiofsd if system-mode is enabled<br>
=C2=A0 configure: Avoid building TCG when not needed<br>
=C2=A0 tests/Makefile: Only display TCG-related tests when TCG is available=
<br>
=C2=A0 tests/Makefile: Restrict some softmmu-only tests<br>
=C2=A0 util/Makefile: Reduce the user-mode object list<br>
=C2=A0 stubs/Makefile: Reduce the user-mode object list<br>
=C2=A0 target/riscv/cpu: Restrict CPU migration to system-mode<br>
=C2=A0 exec: Assert CPU migration is not used on user-only build<br>
=C2=A0 arch_init: Remove unused &#39;qapi-commands-misc.h&#39; include<br>
=C2=A0 target/i386: Restrict CpuClass::get_crash_info() to system-mode<br>
=C2=A0 target/s390x: Restrict CpuClass::get_crash_info() to system-mode<br>
=C2=A0 hw/core: Restrict CpuClass::get_crash_info() to system-mode<br>
<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +=
++<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-<br>
=C2=A0include/hw/core/cpu.h=C2=A0 |=C2=A0 7 ++++-<br>
=C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<br>
=C2=A0exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 ++-<br>
=C2=A0hw/core/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++-<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++--<br>
=C2=A0target/s390x/cpu.c=C2=A0 =C2=A0 =C2=A0| 12 ++++-----<br>
=C2=A0stubs/Makefile.objs=C2=A0 =C2=A0 | 52 +++++++++++++++++++++---------<=
wbr>-------<br>
=C2=A0tests/Makefile.include | 18 +++++++------<br>
=C2=A0util/Makefile.objs=C2=A0 =C2=A0 =C2=A0| 59 ++++++++++++++++++++++++++=
+---<wbr>------------<br>
=C2=A012 files changed, 108 insertions(+), 65 deletions(-)<br>
<br>
-- <br>
2.21.1<br>
<br>
<br>
</blockquote>

--000000000000278cfd05a0edbbbf--

