Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F8EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BE5206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIY+lRDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BE5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2by8-0004G1-Rw
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2bxb-0003Q2-4B
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2bxZ-0002Qa-U5
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:28:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2bxZ-0002QA-PC
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:28:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id r16so9328282otd.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 06:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J6p9Wu9WENzck/0hkiBA/ui9ccImYu6oISjT4qBKij8=;
 b=oIY+lRDWgTSrs+InjpDlFEzZoAoqV8u2QcjBHGChRJIpxbg1SfP3lxHFDEBaqwUW5z
 Fl15LakwEbgogF9xCmzoDBPCZILuw2BBqaukGlcp8hQAVQEBJxfjTiaU0azk4ydtoSNn
 4/5+/Qb/h4Jq8j82kjgHuEN3Feu6SppvndjgmDUDVrMHu+BlD4sMwLE8TcKvnWAmnTWK
 muxNNlt2gzxBnutcAlYGyQoaAVMvuJdDw3FjlL/KFC2SxFjAIqLuzO2q7ZY/yqjbu9vA
 +xO7nQnQE2RuSUAuRQ03Gt7bCPuNrqxEvhgDrKWJC7jS4vOcYhfeg9bFkzJ4tqPKeStH
 CQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J6p9Wu9WENzck/0hkiBA/ui9ccImYu6oISjT4qBKij8=;
 b=Zg7TeTpPng02+1tYRy6lbk2yTaJ+pL3Ie2jZbVWMBes7k6Zs1tsVfpbaJSyVNIVC8c
 wel0EhPZ/ES2cEzSME3uWuTMCUhHTCZlEqxOXlDcIJaLJ3/Vx3oFKGaqPb0DFuPRIJ4M
 nujBWXzswq4sna+r5XBx33tgqbFc7/lHgqvlUE+PwROzmBPbkfdTuqws0xcZlixK6+f9
 qdaRWxsdXBM/tOULJjdbZIXXlk+5vEmCxhMdmrVUtJZQvyGrO6SIqV6DOypBaeTD+Wl7
 JGmuByPqSnPF/0O77jXELaFX9k3qLys34sp+9JJBD1c94t8E7/HVNnKi4V6MKMrfWa6q
 +V8A==
X-Gm-Message-State: APjAAAXj1slqSXp0xapgltMVYD3EQ6MevCfmVX/HRrhhxgMgK0wSTrBl
 rI9CczIBxpn1e5st58/m+lfsx0MeUlay/V7U/Gag6A==
X-Google-Smtp-Source: APXvYqyeeuMOPjlMULp4c6ITKaxp88aEBDoigfAhPXXsuY+KyGKGzavCCg851I8I0TwfVatzPdQfGtYUayMsZKPhsOo=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr2367802otq.221.1581690528538; 
 Fri, 14 Feb 2020 06:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-16-peter.maydell@linaro.org>
 <87wo8ptfh9.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo8ptfh9.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 14:28:37 +0000
Message-ID: <CAFEAcA8fGvMk1mdOwrpYiYCiz-1vRUi6KOJkvHyLwoCpPNfLhQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/30] qapi/{block, misc, tmp, net}.json: Use explicit
 bulleted lists
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 14:23, Markus Armbruster <armbru@redhat.com> wrote:
> What's the rationale for the split between
>
>     [PATCH v2 13/30] qapi/block-core.json: Use explicit bulleted lists
>     [PATCH v2 14/30] qapi/ui.json: Use explicit bulleted lists
>     [PATCH v2 15/30] qapi/{block, misc, tmp, net}.json: Use explicit bulleted lists
>
> ?

Just keeping down the size of individual patches for ease of
review. ui.json and block-core.json both had enough uses that
needed fixing to feel like reasonably patch-sized amounts. This
patch is all the straggler files, none of which had numerous
enough changes to seem worth splitting further.

thanks
-- PMM

