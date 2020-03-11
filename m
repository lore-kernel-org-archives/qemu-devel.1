Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD1C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5736B2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXlRkfb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5736B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0rb-0003S7-I1
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC0r0-00033J-7G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC0qy-0003oL-RR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:52:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC0qy-0003nq-KQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583931171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N985ATgBdgYMsbfgyxenchAdHFv5CHfRN1M7N2DMhSw=;
 b=BXlRkfb5v81UF9g3LLKaJb/JEKE0qqY5ulvzAWHyoUUziuWjjTbnVh45E9/scuyDWw+HNP
 dpFQx7pL0m1rdVTyyte94DnuAvGi0WtgZXk7+s7QnoZtZhVVb3GaMo7xtssmVTHWGztBnF
 wkUxFzZXIJZgf4lH6brF5AOdK8p/MyA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-w3GsJRNGMrmP6Nj-Pozgbg-1; Wed, 11 Mar 2020 08:52:48 -0400
X-MC-Unique: w3GsJRNGMrmP6Nj-Pozgbg-1
Received: by mail-ed1-f72.google.com with SMTP id ck15so1765620edb.6
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1w5IoF3s0+h3QQNTvXQshUYFeWsO2hMd7d7CFxL3wng=;
 b=eVme5uv1zbYCaxi4C9Z5LlQ6hrQKASQhbJMbm7fRPa1qOyobTKUHlmPFtMwU/tviyL
 emdTONBB3T7wkhtKE99S091WpJKCtR2qQY8dSS4kz79pJioU5TaGrK9uwNhcrVYpP42e
 emzL3Z4u0zOl66U3E6C4Q+R3pn5oXDde0XRCoEnysJG+8VPLC0TVxpDyntSNbH1P8FJb
 FhwsPVntUKywxcnmWPDuSW0l7qeqYUJTFBAv2iqdQUNaSyFFA6eELn0Hhx1Jt+MpnSep
 I68evkRHCfOLfSf93RPxujymNoXubiXD1dIc0rxsG476mptsgGtHIR8JDbmVGcraTUmA
 sOow==
X-Gm-Message-State: ANhLgQ2qnuuMYfscixdWXyYtSfRnNmn3MJrtJbvcIs+MQw4tjhIxu9wl
 gCJV9dT3+DKX2Y0qWEKyqwGPdQFcSFzaeedZ3MluDiF6DlPLpgeLr/4+TEEvnMFQDVCpFidruwO
 aqtjL5tF63OVyC0u0vzKfwehYnwNuwb4=
X-Received: by 2002:a17:906:70c9:: with SMTP id
 g9mr2228520ejk.243.1583931167562; 
 Wed, 11 Mar 2020 05:52:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtbKyR4ESpoaM+6Qa4ocSqnLsqqCKaActQ7+X+Ph0scfQHh2WiZ/AWq2R/q4rQHvcnFcHoZ2YD9x8Z8B9P2vww=
X-Received: by 2002:a17:906:70c9:: with SMTP id
 g9mr2228507ejk.243.1583931167342; 
 Wed, 11 Mar 2020 05:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123624.277221-1-stefanha@redhat.com>
In-Reply-To: <20200311123624.277221-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2020 13:52:35 +0100
Message-ID: <CABgObfat-zQziF1EoJTjCO6zJBEYu074PZUCQOrgpeuC2uzFuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] thread: add lock guard macros
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000094165f05a093b65b"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000094165f05a093b65b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 11 mar 2020, 13:38 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> Lock guards automatically call qemu_(rec_)mutex_unlock() when returning
> from a
> function or leaving leaving a lexical scope.  This simplifies code and
> eliminates leaks (especially in error code paths).
>
> This series adds lock guards for QemuMutex and QemuRecMutex.  It does not
> convert the entire tree but includes example conversions.
>

Thanks for picking this up! It should be possible to use QemuLockable to
introduce a single set of lock guard macros that work for mutexes,
spinlocks and CoMutexes. Would you look into that?

(C++ also has unique_lock, a kind of lock guard that can be unlocked early
and won't cause a double unlock, and also can be created unlocked. However
it makes sense to not implement that unless one has a killer application of
it in the tree).

Paolo


> Stefan Hajnoczi (2):
>   thread: add QemuRecMutex lock guards
>   thread: add QemuMutex lock guards
>
>  include/qemu/thread.h | 52 +++++++++++++++++++++++++++++++++++++++++++
>  plugins/core.c        |  6 ++---
>  plugins/loader.c      | 15 ++++++-------
>  util/qemu-timer.c     | 22 +++++++++---------
>  4 files changed, 71 insertions(+), 24 deletions(-)
>
> --
> 2.24.1
>
>

--00000000000094165f05a093b65b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 11 mar 2020, 13:38 Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Lock guards automatically call qemu_(r=
ec_)mutex_unlock() when returning from a<br>
function or leaving leaving a lexical scope.=C2=A0 This simplifies code and=
<br>
eliminates leaks (especially in error code paths).<br>
<br>
This series adds lock guards for QemuMutex and QemuRecMutex.=C2=A0 It does =
not<br>
convert the entire tree but includes example conversions.<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for picking=
 this up! It should be possible to use QemuLockable to introduce a single s=
et of lock guard macros that work for mutexes, spinlocks and CoMutexes. Wou=
ld you look into that?</div><div dir=3D"auto"><br></div><div dir=3D"auto">(=
C++ also has unique_lock, a kind of lock guard that can be unlocked early a=
nd won&#39;t cause a double unlock, and also can be created unlocked. Howev=
er it makes sense to not implement that unless one has a killer application=
 of it in the tree).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pao=
lo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
Stefan Hajnoczi (2):<br>
=C2=A0 thread: add QemuRecMutex lock guards<br>
=C2=A0 thread: add QemuMutex lock guards<br>
<br>
=C2=A0include/qemu/thread.h | 52 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0plugins/core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++---<br>
=C2=A0plugins/loader.c=C2=A0 =C2=A0 =C2=A0 | 15 ++++++-------<br>
=C2=A0util/qemu-timer.c=C2=A0 =C2=A0 =C2=A0| 22 +++++++++---------<br>
=C2=A04 files changed, 71 insertions(+), 24 deletions(-)<br>
<br>
-- <br>
2.24.1<br>
<br>
</blockquote></div></div></div>

--00000000000094165f05a093b65b--


