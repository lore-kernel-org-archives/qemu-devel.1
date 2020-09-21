Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05773C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB50206DC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fw/ERSgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB50206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKP66-0007SX-HG
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKP1l-0004xi-Td
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:50:57 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:34870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKP1j-0002Tm-Lr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:50:57 -0400
Received: by mail-ej1-x630.google.com with SMTP id u21so18752478eja.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JKwZjtuAZvXKjSPWyVU1ge3ImJyQdzxjsi2npcHNE+M=;
 b=fw/ERSgyS4Xe5n8qf4ZbsXego8++xYYXDaAr7S9B0gKcVq5GHXxEu5WCrO/UhotJ92
 8F/eNkGeYbDr0UhAGSeium8A9mLklWloM83l7Y9jIxpTUCWEl6b+O1fTk8NuSxei3YLW
 UA7T4tM8bpyYRS7KaF6+1KWk1J14KZ62MD6UPfWxYMurUiuaclZpofOTegXbj/1u0kIZ
 k11G/pkIayJudMeLkfqOnvn9T5JaDiKW9egGYQ3QJnD4fwSvc5Rgj+axubiyGxNAmqa/
 l+lYE7uUibV5fTapa+WTbi7BWrxOJ3l3L3EcJc3QugZ7bVb8IlKX67fqWQmfArXc6qkX
 3j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JKwZjtuAZvXKjSPWyVU1ge3ImJyQdzxjsi2npcHNE+M=;
 b=MColiKCj/xP4hImWIKY+EZjsoMkV5TMuXqi2H1L5Jvb6/SnXEyVIXssWFkNEIpu9a7
 yvcuc8C7YTUg9nYJ0wA0b7lZbuJcK4FDkGifuBWvSfILK9k9bTGi5IRak7RbnK6CLQGm
 ViQ4hsKvmcfCJSmHsR61RC21VhaKYzm50Egm3vpACDgSUEbzMQWrFFRdNChUwV+btHt3
 2ss5VyjZN3AG1/t0a6GkDnAiY8c2Q4/r4YghxX/4NWPeVghbqCsXi5qOTj+x9exWunZl
 vw9iF1wNzDO9eCrcZMk0E+EHJB44fUjcEQgNfcqr6KO0/hSU6MKwV3M3f2C2ihuu8wMr
 ol9g==
X-Gm-Message-State: AOAM530C8PqivCqPc2WK80EhgCKz6o4zxHwNVhNZhrwBi2qzAgR06/gP
 O5caZw4W3exSz+xWYPG4nDzsgMaPIkhKczEv/3Y+nA==
X-Google-Smtp-Source: ABdhPJzH0+6/wvFvR4EvsBWCiK0Sdj/u37evB8GTNSa+6LLrDlHPM4zcLCIjbmrLykCBpFL0a9vhhkgL2CcCImHpwRY=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr333161ejb.85.1600707053901; 
 Mon, 21 Sep 2020 09:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
 <87eenh38lp.fsf@dusky.pond.sub.org>
In-Reply-To: <87eenh38lp.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 17:50:42 +0100
Message-ID: <CAFEAcA8unnV=bQiaks-YnD0LOrfwMx2FQFN=Zf4zshrgccrwAQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 15:44, Markus Armbruster <armbru@redhat.com> wrote:
>
> $ pycodestyle docs/sphinx/qapidoc.py
> docs/sphinx/qapidoc.py:42:1: E302 expected 2 blank lines, found 1
> docs/sphinx/qapidoc.py:50:1: E302 expected 2 blank lines, found 1
> docs/sphinx/qapidoc.py:74:80: E501 line too long (80 > 79 characters)
> docs/sphinx/qapidoc.py:388:80: E501 line too long (80 > 79 characters)
> docs/sphinx/qapidoc.py:391:80: E501 line too long (80 > 79 characters)
> docs/sphinx/qapidoc.py:430:1: E302 expected 2 blank lines, found 1
> docs/sphinx/qapidoc.py:489:80: E501 line too long (80 > 79 characters)
> docs/sphinx/qapidoc.py:495:1: E302 expected 2 blank lines, found 1

All fixed.

> $ PYTHONPATH=scripts pylint docs/sphinx/qapidoc.py
> ************* Module qapidoc
> docs/sphinx/qapidoc.py:36:4: E0611: No name 'AutodocReporter' in module 'sphinx.ext.autodoc' (no-name-in-module)
> docs/sphinx/qapidoc.py:45:10: R1708: Do not raise StopIteration in generator, use return statement instead (stop-iteration-return)
> docs/sphinx/qapidoc.py:104:4: R0201: Method could be a function (no-self-use)
> docs/sphinx/qapidoc.py:253:4: R0201: Method could be a function (no-self-use)
> docs/sphinx/qapidoc.py:34:4: C0412: Imports from package sphinx are not grouped (ungrouped-imports)

Not fixed: I disagree with the linter on all these.

The first and fifth of these are unfixable because they are the
result of code that is trying to adapt to multiple versions of
Sphinx (one of which has AutodocReporter and the other of which
does not).

The second makes no sense and appears to me to be a linter
bug, because the code doesn't (directly) raise StopIteration.
In any case the function being complained about is just a
straight borrowing from pydash.

The third and fourth would mean that two of the 10 or so
_nodes_for_whatever methods would become functions and
gratuitously different in call signature from the rest
just because it happens that the current implementation
doesn't need 'self'.

(The version of pylint I have also warns about:
 * comments that say "TODO", both of which are ones that
   are carried over from the texinfo generator about dropping
   fallback code when undocumented members are outlawed
 * methods that are part of the QAPISchemaVisitor
   interface and apparently have "too many arguments")
 * single-letter variables
 * the Use_SSI variable name which is from the kerneldoc plugin
I'm going to ignore those too.)

thanks
-- PMM

