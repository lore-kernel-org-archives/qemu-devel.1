Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F17C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 12:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD7A2073C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 12:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMxt9RCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD7A2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibO9w-00007N-Bh
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 07:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibO7z-0007nH-GH
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 07:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibO7y-00011v-Aj
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 07:15:03 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:34447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibO7y-000106-3Z
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 07:15:02 -0500
Received: by mail-oi1-x232.google.com with SMTP id l136so14288451oig.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 04:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=vNUJqRhekZVTegdhtxxea90z3AJsK6mUqLFLq4BBtWg=;
 b=kMxt9RCjKTzLnra+jA3cbTw/79aryBbsMvpAM6J0SDEDrVPxhMU6/dtVt1t5Y65N/3
 3i2SxFU0GBVdSAdfoGH6Ug/nQiUbJTBG/ZYUvIHSIqfe+/TLvjLBOumgpVO9BxO+NfWn
 5naQWHoGsDrI9jreWYXfhK/wDwRzVyPZPjOasMCZtdvrtHZ95eqbw7kH9W9HrTI/LhfW
 a1U0gDWCxrXWmTYvuwea7b3NZtU1GGUpvD4Wi/T/Bbqy8paVYq15nkkccij9MnjbST5d
 q6tFa2m2Pbpo1mmbmdwfHd86zTukZtVAeHIJHJucXI6VUR9YDUEzcDGB4a0DeL2EzuF5
 ZTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=vNUJqRhekZVTegdhtxxea90z3AJsK6mUqLFLq4BBtWg=;
 b=rVwp1RqC3YZZcBfNDj3uVe8qkr8soy1eDHDBvrN04xVzv7mimGbF5nsDNxkCTpyMr8
 dYVyZuoqQiZ1TmkTHY6ReeH/3VESDhecjc5se/+XX9bOam2ITysAmABYi38CAKXFIprQ
 H18C5mjH42DCNERsgMWcD6dCx3GRlvbvl0b/wvEnGmdT0o80D8y1HWFGCJnOj2IHq7Zi
 CaVmYRvU2QFvdk6CPunOsH5Yj87Z00LbU12lJJ0YDkKz9kF3rUVF3wrFROB0u8LHXbe8
 Ye81LjWllS65nzGHpIhfZfqfXzKBrUHygBz6Oj5YBugdaKSVlBxnJSlpcavIfBodbRyx
 7AeQ==
X-Gm-Message-State: APjAAAXR+sD0wlS48UA9VWDnsHWE9G1bKji54e6A4Spj5qgkYAELWyqT
 jXcxoymgmUoe36aA+o9fvgBA5JVyzllRd3oT0lw=
X-Google-Smtp-Source: APXvYqx+LOGP8KNByw3kIi7sj90t+duFeYwRydcslWn4oViDfSGahTQfyPj1zOpRCqem2y7mX0dGwNYyMDqHSsFX+QA=
X-Received: by 2002:aca:1817:: with SMTP id h23mr12593811oih.53.1575202501072; 
 Sun, 01 Dec 2019 04:15:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 1 Dec 2019 04:15:00
 -0800 (PST)
In-Reply-To: <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 1 Dec 2019 13:15:00 +0100
Message-ID: <CAL1e-=hoxa3md+N4xraW99GyqG=nuPO48jaEc75=F+uyJBRYEQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000086a5030598a369f0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000086a5030598a369f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 1, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail=
.com>
wrote:


> - "RFC: mips/cps: fix setting saar property"
>
> Perhaps I should have used FIX instead of RFC, because this should
> actually be a real fix. However I could use someone help to exercise
> the code path.
>
>
Marc-Andr=C3=A9, hi.

There is a work in progress on fixing this. Can we in MIPS submit the fix
independently, since it involves some additional pieces of code that are
really deeply mips-specific? We acknowledge the bug, and want to develop
the real solution. Can you simply skip this RFC patch in your series, since
the issues will be handled separately in our patch, hopefully soon after
the merge window is open?

For all other mips parts of your series, you have my "reviewed-by"s , in
case I forgot to send them explicitely.

Regards, Aleksandar




> - "
>

--00000000000086a5030598a369f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 1, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=3D"=
mailto:marcandre.lureau@gmail.com">marcandre.lureau@gmail.com</a>&gt; wrote=
:<div><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br>
- &quot;RFC: mips/cps: fix setting saar property&quot;<br>
<br>
Perhaps I should have used FIX instead of RFC, because this should<br>
actually be a real fix. However I could use someone help to exercise<br>
the code path.<br>
<br></blockquote><div><br></div><div>Marc-Andr=C3=A9, hi.<br></div><div><br=
></div><div>There is a work in progress on fixing this. Can we in MIPS subm=
it the fix independently, since it involves some additional pieces of code =
that are really deeply mips-specific? We acknowledge the bug, and want to d=
evelop the real solution. Can you simply skip this RFC patch in your series=
, since the issues will be handled separately in our patch, hopefully soon =
after the merge window is open?</div><div><br></div><div>For all other mips=
 parts of your series, you have my &quot;reviewed-by&quot;s , in case I for=
got to send them explicitely.</div><div><br></div><div>Regards, Aleksandar<=
/div><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
- &quot;<br>
</blockquote></div>

--00000000000086a5030598a369f0--

