Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A229C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D512073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrJtNyXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D512073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVV3-0002af-Hr
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isVSS-0000SE-Db
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isVSR-0002RE-4j
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:30:56 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:35012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isVSQ-0002QZ-W5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:30:55 -0500
Received: by mail-ot1-x335.google.com with SMTP id i15so23219558oto.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=2wHVw6YI0c0F4tPkWzzLnCpXdVZBUb1tkEffK1ygTfA=;
 b=wrJtNyXZ7ggEWeJDVW0K4Enj1UMjq70TTkP0x9+EHjjDZQ270lPz132i6oZ89cD3ZL
 eHLZNb9b6OZqjHwdTi6PeJrDSn6RfXYLtLarKa4AeHYzragAPsHtLuG06dbz9gxwmJxf
 Z29vMGfsTghCgv2SioFGQwO3XpEgde1/RNJEDhy1/iltZCxq1LKAAWWxvS99633kCyE+
 2zDccOKyiNpSY9uhxHIHBplmyit5Ml0SreijU9WOcrzLSd3Z6Uhmi2PjW+19kUatzqaL
 2CTaIdzswAsP5QZ1FNo2AVhdnMbN5A6tc3SP4gvyOVq7HstUyON211TBio7Jgrwtqhp2
 NodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=2wHVw6YI0c0F4tPkWzzLnCpXdVZBUb1tkEffK1ygTfA=;
 b=QpCW/2Qu1Zj2/pgQp336Rkd9RuJhztsjLktR6A+x2EOKRv5wt20+f/sp1jx0Jze8B8
 LAYj1To3u4elv6umLfP2NXMLvEXswnz/eQf4FTF5aiytN9WcgQcBEH/l0eD+6pUkBGRj
 b9CSXT7z/GI6Co0gxJIHEuthWj4Oq8qdpOy4xxSJRz61VEvOIVWpEo1UDqbdwEigB50c
 J5mPRd4FD/7B8CxBhBMruyNfg8jQE8q4Xtf10iQWmPjLvNFG2vRvuQ/LiPkXl+FEinMU
 Rw8d8nEpHnwyXIPHBcSN4m/bDihSOsGqyykSZFHKwkcfp97CFP9I0yve4MunkAbOXVtE
 hZEw==
X-Gm-Message-State: APjAAAWTWU7ykgqlkiqvR00NydrLAkiIPRGFnyiMVVogY40B/4s/x1//
 PgaSPkN78+oxOpY5TJhzwuSFbOR0vly4/wLd9LKyakdNpNg=
X-Google-Smtp-Source: APXvYqyqGD8rAo6E1bmKNzOXgUWPZK3jz4naQ8in4RSwph2o+Uat57Diln6QCB3WDHZ2G2hrssxqk8aQe4p+fxlUhiU=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr6985291ota.232.1579282253879; 
 Fri, 17 Jan 2020 09:30:53 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 17:30:43 +0000
Message-ID: <CAFEAcA-_Y0Qaw-S83tMAph21opaDx-2y6aPbv5J_J0Bo4bgJuA@mail.gmail.com>
Subject: Proposal for handling .hx files with Sphinx
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently our manual creation includes some .texi files which
are autogenerated from .hx files by running scripts/hxtool.
.hx files are a simple format, where where a line is either a
directive or literal text to be output:

HXCOMM
 -- comment lines, ignored
STEXI/ETEXI
 -- mark start/end of chunks of text to put into the texinfo output only
DEFHEADING/ARCHHEADING
 -- appear in the .h file output verbatim (they are defined as C macros);
    for texi output they are parsed to add in header sections

For Sphinx, rather than creating a file to include, the most
natural way to handle this is to have a small custom Sphinx
extension which will read the .hx file and process it. So
instead of "makefile produces foo.texi from foo.hx, qemu-doc.texi
says '@include foo.texi'", we have "qemu-doc.rst says
'hxtool-doc:: foo.hx', the Sphinx extension for hxtool has
code that runs to handle that Sphinx directive, it reads the .hx
file and emits the appropriate documentation contents". (This is
pretty much the same way the kerneldoc extension works right now.
It also has the advantage that it should work for third-party
services like readthedocs that expect to build the docs directly
with sphinx rather than by invoking our makefiles.)

We'll need to update what the markup is to handle having rST
fragments in it. A very minimalist approach to this would
simply define a new pair of SRST/ERST directives marking the
start/end of chunks of rST text to go into the rST only.
(We might be able to do better than that later, as there's
some repetition currently going on. But we'll probably get
a better idea of how easy it is to avoid the repetition if
we start with a simple conversion.)

Here's what we do with hx files at the moment. We have four:

 hmp-commands.hx
   -- defines monitor commands used by monitor.c; generates
      qemu-monitor.texi, used by qemu-doc.texi
 hmp-commands-info.hx
   -- ditto, for the "info" command's subcommand;
      generates qemu-monitor-info.texi, used by qemu-doc.texi

These two use only the "put this in the texi or in the .h file"
functionality, alternating "raw C code defining an entry for the
monitor command array" with "lump of raw texi for the docs".

 qemu-img-cmds.hx
   -- defines options for qemu-img, used by qemu-img.texi

This uses the STEXI/ETEXI directives to alternate C and texi.
In the for-the-h-file section the only content is always a DEF()
macro invocation defining the option; in the texi is only the
synopsis of the command. This means there's a lot of repetition,
as the DEF macro includes an argument giving the text of the
option synopsis, and then the texi also has that synopsis with
some extra markup. Finally the main qemu-img.texi repeats the
marked-up synopsis later on when it has the actual main documentation
of each command.

 qemu-options.hx
   -- options for qemu proper, used by qemu-doc.texi

This uses only the DEF, DEFHEADING, ARCHHEADING macros
in the for-the-h-file sections (and the DEFHEADING/ARCHHEADING
are read also for texi generation). This also repeats the
synopsis in the DEF macro and in the texi fragment.

So I think my current view is that we should do the very
simple "add SRST/ERST directives" to start with:
 * scripts/hxtool needs to recognize them and just ignore
   the text inside them
 * write the hxtool sphinx extension (shouldn't be too hard)
 * conversion of any particular .hx file then involves
   replacing the STEXI ...texi stuff... ETEXI sections with
   SRST ...rst stuff... ERST. There's no need for any
   particular .hx file to support both texi and rst output
   at the same time

I would initially start with qemu-img-cmds.hx, since that's
pulled in by qemu-img.texi, which we can convert in the
same way I've been doing qemu-nbd and other standalone-ish
manpages. The others are part of the big fat qemu-doc.texi,
which is probably going to be the very last thing we convert...

thanks
-- PMM

