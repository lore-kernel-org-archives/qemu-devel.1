Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C1EC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA352080D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bsdimp-com.20150623.gappssmtp.com header.i=@bsdimp-com.20150623.gappssmtp.com header.b="ML/xSTFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA352080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irCYx-0002z2-Fs
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 22:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wlosh@bsdimp.com>) id 1irCXh-0001qw-8Z
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wlosh@bsdimp.com>) id 1irCXf-0007QY-MQ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:06:57 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:35841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1irCXf-0007OC-4k
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:06:55 -0500
Received: by mail-qk1-x744.google.com with SMTP id a203so10860895qkc.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 19:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PEiuZY8wntkJmaMub+7K0u/MW6DcvT8MnnO20N1yPh4=;
 b=ML/xSTFaSWPZBVWi49ZTmncxnqRil/rnFh4w16Ix6lTE0lZfL66/wJUJfy5f8GuUiO
 YZ4Xc8sIT0VSJHMasLigcOznQgwXxlyOjW3k2tFpCjfBMCY7/HvlWto2z8Z5TaUDSMSI
 OTKWw+ed47YtEiPXkVzSLIBHze/+Cvn6MLPkncfFfPyTQp3piBk0evf0S+A0fEIN5yhh
 fRyNYFoOzKQljfmSowNbiQmiPDIyrTLRQMgHN9SZ+VVauBlVmgTpoKViJ4VlaqG55Km2
 mJMku/eUabQJD3vsNL+babkpsstJAJW01qVh43tN9AU0elmexUVyg6ySB27hY/5mgVws
 mmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PEiuZY8wntkJmaMub+7K0u/MW6DcvT8MnnO20N1yPh4=;
 b=ZrExvuitOrLHMT269XgfHYvttvx40JYymkw4eNzBPd5+QNdZqqf0uxjDBBFEOVb2GF
 IIuwIVvDUEkUBjZF9YyfF93QqAS+4Kmp+B3emSRxbShaEr60i5etUQyEOyJILP+SOToT
 q2wdwXpRxgQnjI3uqSYcK/0vdqY9nThGDAiIw+G3lsVppzS+Inx62pVxFv9GuXMUcVZL
 spVTNfZLkBEpRVvftnj30YrcVSUY2JbfVP/KcLtvNWR0NHLBrBFahMR4L4jiwDTC9Kfr
 hyW1JhH3cjIHw03JclWuHSbT4c7ygAJbXIgmjfUa3mzIP7Hs218boY5FJGgpg2Q6sK5j
 MUtg==
X-Gm-Message-State: APjAAAV3gaj7u5yBgS3mhukyNYi/rdw10Gizxy7u9i3JLOu959MSChnP
 5eWZMbQPWoB3QZ/gp4thHMvKJRXvmm9Ijvc9DIk9iw==
X-Google-Smtp-Source: APXvYqzDxJntvJhNlAAM4zOtlLdEe98OfYqugBNiZtySH2SSIicRPOu+yH8WygtRYblS+EyUgdpLfB3N8WNe3xKx7Y4=
X-Received: by 2002:a05:620a:94f:: with SMTP id
 w15mr19240528qkw.380.1578971213444; 
 Mon, 13 Jan 2020 19:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20200114030138.260347-1-jkz@google.com>
In-Reply-To: <20200114030138.260347-1-jkz@google.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 13 Jan 2020 20:06:41 -0700
Message-ID: <CANCZdfq66Fsw=C0YSi6zWs_=r+0cNfPjhvchiSJnfY2MBWT8LA@mail.gmail.com>
Subject: Re: [PATCH 0/4] migration: Replace gemu_log with qemu_log
To: Josh Kunz <jkz@google.com>
Content-Type: multipart/alternative; boundary="00000000000049cac6059c10e203"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: armbru@redhat.com, riku.voipio@iki.fi, alex.bennee@linaro.org,
 QEMU Developers <qemu-devel@nongnu.org>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000049cac6059c10e203
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 13, 2020, 8:03 PM Josh Kunz <jkz@google.com> wrote:

> The linux-user and bsd-user trees both widely use a function called
> `gemu_log` (notice the 'g') for miscellaneous and strace logging. This
> function predates the newer `qemu_log` function, and has a few drawbacks
> compared to `qemu_log`:
>
>   1. Always logs to `stderr`, no logging redirection.
>   2. "Miscellaneous" logging cannot be disabled, so it may mix with guest
>      logging.
>   3. Inconsistency with other parts of the QEMU codebase, and a
>      confusing name.
>
> The second issue is especially troubling because it can interfere with
> programs that expect to communicate via stderr.
>
> This change introduces two new logging masks to the `qemu_log` subsystem
> to support its use for user-mode logging. The `LOG_USER` mask, for
> miscellaneous logs, and the `LOG_STRACE` mask for strace-specific
> logging. Further, it replaces all existing uses of `gemu_log` with the
> appropriate `qemu_log_mask(LOG_{USER,STRACE}, ...)` based on the log
> message. To avoid potential backwards incompatibility, this patch series
> also introduces a new flag: `-no-force-user-mode-logging`. Since "user
> mode" logging was always enabled before this change, by-default the
> LOG_USER mask is always set. The flag is provided for users that want to
> disable LOG_USER. Hopefully, this flag can be removed, or turned into a
> no-op in the futre, and -d/QEMU_LOG can be used directly to enable
> user-mode logging if desired.
>
> Unfortunately, this change introduces one small backwards incompatibility
> for the linux-user tree: If an explicit `-D` option is provided, or the
> `QEMU_LOG_FILENAME`_ environment variable is set, strace and user-mode
> logging statements will log to the QEMU log file instead of stderr.
>
> Tested:
>   * Built with clang 9 and g++ 8.3
>   * `make check` run with clang 9 build
>   * Verified:
>     * QEMU_STRACE/-strace still works for linux-user
>     * -no-force-user-mode-logging uses QEMU_LOG + `user_mode` or
>       `strace` can be set in QEMU_LOG to trigger the appropriate
>       logging.
>
> Not tested:
>   * Build/logging with bsd-user. I do not have easy access to a BSD system.
>

The bsd-user that is in tree doesn't work. I've been trying to catch up to
qemu head of tree, but I'm only up to 3.2... chances are the bsd-user
changes will not change the state of things...

Warner

Josh Kunz (4):
>   linux-user: Use `qemu_log' for non-strace logging
>   linux-user: Use `qemu_log' for strace
>   linux-user: remove gemu_log from the linux-user tree
>   bsd-user: Replace gemu_log with qemu_log
>
>  bsd-user/main.c           |  13 +-
>  bsd-user/qemu.h           |   2 -
>  bsd-user/strace.c         |  32 ++-
>  bsd-user/syscall.c        |  31 ++-
>  include/qemu/log.h        |  15 ++
>  linux-user/arm/cpu_loop.c |   5 +-
>  linux-user/fd-trans.c     |  55 +++--
>  linux-user/main.c         |  50 +++-
>  linux-user/qemu.h         |   2 -
>  linux-user/signal.c       |   3 +-
>  linux-user/strace.c       | 479 +++++++++++++++++++-------------------
>  linux-user/syscall.c      |  43 ++--
>  linux-user/vm86.c         |   3 +-
>  util/log.c                |   5 +
>  14 files changed, 404 insertions(+), 334 deletions(-)
>
> --
> 2.25.0.rc1.283.g88dfdc4193-goog
>
>
>

--00000000000049cac6059c10e203
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Jan 13, 2020, 8:03 PM Josh Kunz &lt;<a href=3D=
"mailto:jkz@google.com">jkz@google.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">The linux-user and bsd-user trees both widely use a func=
tion called<br>
`gemu_log` (notice the &#39;g&#39;) for miscellaneous and strace logging. T=
his<br>
function predates the newer `qemu_log` function, and has a few drawbacks<br=
>
compared to `qemu_log`:<br>
<br>
=C2=A0 1. Always logs to `stderr`, no logging redirection.<br>
=C2=A0 2. &quot;Miscellaneous&quot; logging cannot be disabled, so it may m=
ix with guest<br>
=C2=A0 =C2=A0 =C2=A0logging.<br>
=C2=A0 3. Inconsistency with other parts of the QEMU codebase, and a<br>
=C2=A0 =C2=A0 =C2=A0confusing name.<br>
<br>
The second issue is especially troubling because it can interfere with<br>
programs that expect to communicate via stderr.<br>
<br>
This change introduces two new logging masks to the `qemu_log` subsystem<br=
>
to support its use for user-mode logging. The `LOG_USER` mask, for<br>
miscellaneous logs, and the `LOG_STRACE` mask for strace-specific<br>
logging. Further, it replaces all existing uses of `gemu_log` with the<br>
appropriate `qemu_log_mask(LOG_{USER,STRACE}, ...)` based on the log<br>
message. To avoid potential backwards incompatibility, this patch series<br=
>
also introduces a new flag: `-no-force-user-mode-logging`. Since &quot;user=
<br>
mode&quot; logging was always enabled before this change, by-default the<br=
>
LOG_USER mask is always set. The flag is provided for users that want to<br=
>
disable LOG_USER. Hopefully, this flag can be removed, or turned into a<br>
no-op in the futre, and -d/QEMU_LOG can be used directly to enable<br>
user-mode logging if desired.<br>
<br>
Unfortunately, this change introduces one small backwards incompatibility<b=
r>
for the linux-user tree: If an explicit `-D` option is provided, or the<br>
`QEMU_LOG_FILENAME`_ environment variable is set, strace and user-mode<br>
logging statements will log to the QEMU log file instead of stderr.<br>
<br>
Tested:<br>
=C2=A0 * Built with clang 9 and g++ 8.3<br>
=C2=A0 * `make check` run with clang 9 build <br>
=C2=A0 * Verified:<br>
=C2=A0 =C2=A0 * QEMU_STRACE/-strace still works for linux-user<br>
=C2=A0 =C2=A0 * -no-force-user-mode-logging uses QEMU_LOG + `user_mode` or<=
br>
=C2=A0 =C2=A0 =C2=A0 `strace` can be set in QEMU_LOG to trigger the appropr=
iate<br>
=C2=A0 =C2=A0 =C2=A0 logging.<br>
<br>
Not tested:<br>
=C2=A0 * Build/logging with bsd-user. I do not have easy access to a BSD sy=
stem.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">The bsd-user that is in tree doesn&#39;t work. I&#39;ve been trying to=
 catch up to qemu head of tree, but I&#39;m only up to 3.2... chances are t=
he bsd-user changes will not change the state of things...</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Warner</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
Josh Kunz (4):<br>
=C2=A0 linux-user: Use `qemu_log&#39; for non-strace logging<br>
=C2=A0 linux-user: Use `qemu_log&#39; for strace<br>
=C2=A0 linux-user: remove gemu_log from the linux-user tree<br>
=C2=A0 bsd-user: Replace gemu_log with qemu_log<br>
<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-=
<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 -<br>
=C2=A0bsd-user/strace.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 32 ++-<br>
=C2=A0bsd-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 31 ++-<br>
=C2=A0include/qemu/log.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 15 ++<br>
=C2=A0linux-user/arm/cpu_loop.c |=C2=A0 =C2=A05 +-<br>
=C2=A0linux-user/fd-trans.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 55 +++--<br>
=C2=A0linux-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 50 +++-<br=
>
=C2=A0linux-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -<=
br>
=C2=A0linux-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0linux-user/strace.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 479 +++++++++++++++++=
++-------------------<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 ++--<br>
=C2=A0linux-user/vm86.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +-=
<br>
=C2=A0util/log.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A05 +<br>
=C2=A014 files changed, 404 insertions(+), 334 deletions(-)<br>
<br>
-- <br>
2.25.0.rc1.283.g88dfdc4193-goog<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000049cac6059c10e203--

