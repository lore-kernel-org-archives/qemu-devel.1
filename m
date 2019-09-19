Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A2C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B9E2196E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4OruGCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B9E2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwvc-0005Jx-5n
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAwam-0005FD-1J
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAwak-00072u-HF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:35:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAwak-00071E-Ah
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:35:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id b2so3058082otq.10
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sC1n+xac5laRv1FUAYrxPOXVVHRe74osFPLUzc3ptm8=;
 b=N4OruGCKrMgzkItbywZTfwVMUadDxp9oC3lVcMlJ7Iix1jRDy7qP6NOfu+7O0qovwO
 Xg9D3zIZLtZ4Yu0i9EoYVvBMoBcNaLMnEu4toesJUUHGjk7frQw+Ln8+p9YwHN6yFbXx
 yA4m3li0QJoJ3Z+I/eN/MDd5vi3AtdKz3qydbgIYBkJKtWGzhv/RzA3joKmpp8nsjNZ4
 KaqbmXVF0KMygDhGQfvl81h5zAKk9cFgxpPRsY4BKH/VKIos9migkiQSpRkawyyctGfN
 kMZKSsSHf/rOzhOhmHWwUSpNkBUqk8aIJo07TMU1G1rh8jkAu6MdBR+xP2tgb5tj1p6Q
 0gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sC1n+xac5laRv1FUAYrxPOXVVHRe74osFPLUzc3ptm8=;
 b=LRqXd+pYMzwN5XUHDx82DCz8lSZ4lGvIxkeA8p7+OaCNU1DZUWnXKxSX70SR7P9vng
 BwHxK5BNIdkQbtrQGkCZWX1kGlzu0edjrQvQZM+b4aC4qFFl8MXyQqIK3RoHbB9IfgGX
 TIQQJ1+g5o7pan5sVYNanJnWplVj14cvm+eAbzY/P/r4pk1/Q4ISFSr418YBYXD9leWQ
 kNkM5KYBE1UAHt9iZBUQWhS5TCDhGf3lC9GwcfUr72CFQaLjKiHP87Ktf3shWWqZfm47
 LuYQF1wnYB+mrUWzs7XJlIgnbORm+tl5hqCE4Y/2h5d+uLK+ldbsD5+7rRNrstVtWMiA
 dX7g==
X-Gm-Message-State: APjAAAXp9f/uQnUZ5wvqmz4/WZaU/qE0kdkO8HVsg3RmYDfdFU3EDb+W
 btaUwocsZbzhr2Nxm25Yu9XIfevfcmZ5BWjqLHBLrw==
X-Google-Smtp-Source: APXvYqzKJ+sdexKyRKClQUCQJjshlSuadjxDVQ//7zw34MhDqnFn3rvX7OZAxLW3h3Kg+k+3bt0AB58J/UU1yHVLTU0=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr6716478otq.91.1568900125186; 
 Thu, 19 Sep 2019 06:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
 <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
In-Reply-To: <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:35:14 +0100
Message-ID: <CAFEAcA_P8H4=-tnKLrm+YTqH_p7x2oVjHq1Sg03m6ssrWnKsjw@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 14:27, Eric Blake <eblake@redhat.com> wrote:
>
> On 9/19/19 7:00 AM, Peter Maydell wrote:
>
> >> In an incremental build on Fedora 30, I'm now seeing:
> >>
> >>         CHK version_gen.h
> >>   GEN     docs/interop/qemu-ga.8
> >> No filename or title
> >> make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
> >> Error 255
> >>
> >> and suspect this patch introduced it.  It may be that I just need to
> >> nuke intermediate artifacts rather than an actual problem with the
> >> patch, but I'd welcome help in identifying the problem.
> >
> > If you build with V=1 what does it say it's doing?
>
> make[1]: Leaving directory '/home/eblake/qemu/dtc'
> perl -Ww -- /home/eblake/qemu/scripts/texi2pod.pl -I docs -I scripts -I
> docs/interop -DVERSION="4.1.50" -DCONFDIR="/usr/local/etc/qemu"
> scripts/texi2pod.pl docs/interop/qemu-ga.8.pod && pod2man --utf8
> --section=8 --center=" " --release=" " docs/interop/qemu-ga.8.pod >
> docs/interop/qemu-ga.8
> No filename or title
> make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
> Error 255

Do you have sphinx installed on this machine? I'm wondering
if the problem here is that we have disabled the sphinx build
runes but are then falling back to the "try to make any %.8
via the TEXI2MAN rule in rules.mak" [*]. On the other hand
docs/interop/qemu-ga.8 is only put into DOCS if BUILD_DOCS is
set, which should only happen if sphinx is available.

[*] these rules are a bit bogus, because I think they will apply even
if there's no other rule saying 'foo.8 depends on something.texi',
and then as you can see in your command line we end up running
texi2pod with an empty "$<" rather than passing it a texi file.

thanks
-- PMM

