Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4963C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B248214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oaQhe9Ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B248214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izmCG-0001pQ-PD
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izmBX-0001Ip-DF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izmBU-0001y8-GB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:47:31 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izmBU-0001qp-9I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:47:28 -0500
Received: by mail-oi1-x242.google.com with SMTP id j132so5640160oih.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 10:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W1QD4+y0q0eM1PwCMwwBeY/E5UiYS+V7aYoYuV5EFX0=;
 b=oaQhe9Ripi34qO/PXevvR+mgi1uLO84fdHITe6xnNMLZVFqxJWQ6vHfSPvEb9hSOcR
 w05Wj0RKPZsKbVxY1/gEy3NOffDQgJ/XT2WJNR49oyw7RVYH6BbLWwy2lSc3RgpbGEfh
 py5SSJTzzLgFBFRFPz5RwH+dtxTWmQB52s0fYovRH+b8TNbdYeWAjs9CGDHEAy7WQvPY
 RIqkN3o0oWbgSJSr514pk18Q6nA4vacaURV+i4ODMxSnmeZGD/7M/F+MOb3HseONv/pQ
 GxjGknzizk+0/IDFZQxGObUA11Ao0R5rYMTXYcwwDvvIc//s/ENUGousSYLn8SMCWwFj
 m9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W1QD4+y0q0eM1PwCMwwBeY/E5UiYS+V7aYoYuV5EFX0=;
 b=mJK2yD/V/q0hkduI+pHvgfeTT0wXpgTIrKjKpWdxq2TnSSTzH+NqxlZlSlk7jhmBqa
 6DDGgXitlXR+SasdDSVRJeBf112jh9VJ4T1xVsB6r5LlXkbDwUe1XLUfeQ6SGCmPsJlb
 CjInY2VN3KfIv7QJAWFFCIWpKRDqhzuNFUeF6T6rTzTXWlhRSHzZtuG15p3eAxqPaSTe
 5FDKJcOk5LJKWlnZk7yadvHFUR5cJTvVRxck/lTHp56XWcqmgVG7DV1YurkQwiVzJuR/
 5HKWDCYl8XjkCsdvMf48iRBTbq/SpxhDTgYWjEQCB6ny0KqsoN/Qu78LcKrmAFh1QhYd
 4WvA==
X-Gm-Message-State: APjAAAVPvQaxiw7hX9AN1YsFSxXYAefeHPWES5j8RNMDD1H/4pwlZu33
 bqr6phvflO0+pX7vA+VYgj8b3ectnqtlfih43LqySSiZ
X-Google-Smtp-Source: APXvYqwuRVfclYNA/gPu1ZBSD+sXCNC/yhTt69bDbQuBENN9WvyNM94nvoHB9U6io0rufY0Jeh7NgD9BhT6Ys1Vt4dQ=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr7709063oie.146.1581014846637; 
 Thu, 06 Feb 2020 10:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2020 18:47:15 +0000
Message-ID: <CAFEAcA8pD9kk3t5PcUsCGdS+Wzcv6z0xn7L_aE-2SA6k66j9+w@mail.gmail.com>
Subject: Re: [PATCH 00/29] Convert QAPI doc comments to generate rST instead
 of texinfo
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Feb 2020 at 17:30, Peter Maydell <peter.maydell@linaro.org> wrote:
> This series switches all our QAPI doc comments over from
> texinfo format to rST.

Oops, this fails 'make check' because I forgot to run it (not thinking
of docs changes as being stuff that affects test) and there are
a couple of golden-master files that need updating. I have some
minor changes that I'll put in v2 which correct that:

 * a new patch "tests/qapi/doc-good.json: Clean up markup"
   which removes some oddities of the old markup that we don't
   want to support, tightening up the tested doc comments:
     * in a single list the bullet types must all match
     * lists must have leading and following blank lines
     * indentation is important
     * the '|' example syntax is going to go away entirely,
       so stop testing it
 * patches "scripts/qapi: Move doc-comment whitespace stripping to doc.py"
   and "scripts/qapi/parser.py: improve doc comment indent handling"
   both make minor whitespace changes that require updates to the
   tests/qapi-schema/doc-good.out reference
 * "scripts/qapi: Remove texinfo generation support" now
   removes the no-longer-used tests/qapi-schema/doc-good.texi

I won't send v2 until this has had some review, though. If you
want a git branch with the pending-for-v2 fixups it's at:
https://git.linaro.org/people/peter.maydell/qemu-arm.git sphinx-conversions

thanks
-- PMM

