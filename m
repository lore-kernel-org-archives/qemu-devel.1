Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D672080A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zim+elRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D672080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkFN-0003Qm-KU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFkEj-0002uq-Lw
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:29:05 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:34650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFkEi-0007cr-1p
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:29:05 -0400
Received: by mail-ed1-x52d.google.com with SMTP id q21so438317edv.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UW8qu0aSyJDtgjYDO4cJ4kvZyTESM6mhROk0I5RVbG4=;
 b=Zim+elRMrojDWLrHB5sugtOvfU/rPrjITY3CSa3N7DDFB2nHkjCRFs0W6pNC3qCX9b
 U8GqA6PwrhUSjd98rXDiFMuytaOsAPVYUpMrSQ/l9RbeypUOOGtMAw/b5R1HWrsaQP4C
 OUYnI6ro/rDfsRpnY4GExCR01cEaI4cuoveMh3EE7+xNmyMbUcOlBn3Ryae0U2mnhvew
 2tG7eWTxwWG9h9rQDguT/SbdfwxrhBTLmQB0S8gILMbE808V8Rkz9CHuGd5Z140KCvy0
 YhKPdMFimhfFHsccC9a35tLbeVPQJ6f5GUbq22PRrXHTt+SaH4z/h0JcPWi5qAF5hOF+
 m/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UW8qu0aSyJDtgjYDO4cJ4kvZyTESM6mhROk0I5RVbG4=;
 b=Yfso0v6kq1Yb8X5QMWRwnEmPgc624D0ghQM/1ewHn9I18EzSLSg8od30GLL/mqvJ5n
 kcHQorYatQCUND/pQFZARKc2ngec9+zxZdwOVFJfv7jpk3OnMpXoka/BmYxRAy7JTp6B
 t8DQjdB6UoR3FpIEHtOmX3Nn5gDnYDm3KrBL6HtIkSYfI/d8QCP+e19qn6U+PNKKPVeI
 8YJoGBoaAvjDJrMHOE7doGE755eLuQeYfzWuQ11ysiHuVksBcHH4vbxDAUtoSfy+BK+b
 gCWhOZq/Btwb3pIxkyZ1tH1UfOTjqKL7rxZz5hCZebe1yswgVWxr0o8qw6kZWQ8ABTwV
 8JyA==
X-Gm-Message-State: AOAM533nLY0mIa8S4JcCeNgBrhGYhzBKc/JyBo8kKLcRN0ldIMgTFDKA
 9K1jRuHobCt0ik+JM15SpVA0ZvMKq+LlJ9DgNQLmdw==
X-Google-Smtp-Source: ABdhPJx+Tt1bzQUaQdssIGKO4h/heSySdRabNgFydj9GZE7lciXEDJkWMOEPC6OSGdzzbq1X6DZSRQdgTsRwHtxAieg=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr844914edm.44.1599596942256;
 Tue, 08 Sep 2020 13:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200908184918.1085-1-luoyonggang@gmail.com>
 <20200908184918.1085-5-luoyonggang@gmail.com>
In-Reply-To: <20200908184918.1085-5-luoyonggang@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 21:28:51 +0100
Message-ID: <CAFEAcA-FGVMKNObinzWgq6sYm9p0GCgPb3mXgx1LD5UnX0wZCQ@mail.gmail.com>
Subject: Re: [PULL 04/16] curses: Fixes curses compiling errors.
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 19:56, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> This is the compiling error:
> ../ui/curses.c: In function 'curses_refresh':
> ../ui/curses.c:256:5: error: 'next_maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
>       |     ^~~~~~~~~~
> ../ui/curses.c:302:32: note: 'next_maybe_keycode' was declared here
>   302 |             enum maybe_keycode next_maybe_keycode;
>       |                                ^~~~~~~~~~~~~~~~~~
> ../ui/curses.c:256:5: error: 'maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
>       |     ^~~~~~~~~~
> ../ui/curses.c:265:24: note: 'maybe_keycode' was declared here
>   265 |     enum maybe_keycode maybe_keycode;
>       |                        ^~~~~~~~~~~~~
> cc1.exe: all warnings being treated as errors

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  ui/curses.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ui/curses.c b/ui/curses.c
> index 12bc682cf9..e4f9588c3e 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -262,7 +262,7 @@ static int curses2foo(const int _curses2foo[], const int _curseskey2foo[],
>  static void curses_refresh(DisplayChangeListener *dcl)
>  {
>      int chr, keysym, keycode, keycode_alt;
> -    enum maybe_keycode maybe_keycode;
> +    enum maybe_keycode maybe_keycode = CURSES_KEYCODE;
>
>      curses_winch_check();
>
> @@ -299,7 +299,7 @@ static void curses_refresh(DisplayChangeListener *dcl)
>
>          /* alt or esc key */
>          if (keycode == 1) {
> -            enum maybe_keycode next_maybe_keycode;
> +            enum maybe_keycode next_maybe_keycode = CURSES_KEYCODE;
>              int nextchr = console_getch(&next_maybe_keycode);
>
>              if (nextchr != -1) {

The problem here is that the compiler hasn't noticed that it's
impossible to return something other than -1 from console_getch()
without initializing next_maybe_keycode.

There are two possible reasons for this:
(1) your gcc is a bit old -- newer gcc are better at working
out this kind of thing. But you said on irc that you're using
gcc 10.2.0, which is new...

(2) this is a variant of the problem with the system headers
that causes us to have to redefine assert() in osdep.h, only
with abort() (ie abort() is perhaps not marked as noreturn in
the system headers). If this theory is true, then changing
the abort() in console_getch() to instead be g_assert_not_reached()
would be a different way to avoid the warnings (and if that works
we should probably fix up abort() the way we do assert()).

thanks
-- PMM

