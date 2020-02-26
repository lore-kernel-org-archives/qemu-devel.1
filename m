Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D7CC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9AD24656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjnHqNWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9AD24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sFk-00055A-DB
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6sF3-0004dn-Ln
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6sF2-0004d2-IX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:40:29 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6sF2-0004bi-CQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:40:28 -0500
Received: by mail-oi1-x244.google.com with SMTP id l136so2267901oig.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 00:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LbqfINW33lm1H2QmlOS3ffKGerUzM+5NyGHnJsJruRA=;
 b=LjnHqNWu0af5IfArZCYwL+sfy3cDpC7JFtuWwdC4B4cQ4alYm7rGLgNc7ZQaAlqz7x
 hpX3u7tPKGpJsFrizqWdzlpAJVNoWYcTFHP6dje0wdwu6kNiZMRJk1WvtWDK4G8ydpbf
 UrlNn0q2ftxMUhKzZy8+i1e62vGVuDIxVmWb3yOQbUlL+ZVcY+e2jU5ItjVKMvMyg6H8
 yvg+sd9XWDoVdO6kdq4kS8lAIt88C4pOJ+ufGKf6ibtKzd1Rq7gp7j00ptBOUIZSJ+Uk
 iU8ow86QcOs04Fvp9+XgaGUIsPFskyrQJ4Lk10sjO1nfxZehy7oyGfU3OeBhsmU+n5Ju
 p4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LbqfINW33lm1H2QmlOS3ffKGerUzM+5NyGHnJsJruRA=;
 b=hSxplnKO8SFkQoooqLseGcxNVXdfk9/PNMrhakV8sG/e95LKp/EdVSD8rEaT3HywI/
 Hpq7G0kx1oZsehXrqtFviXHR1OJgghtKkYTAB8jiL7QEu3pTLN2VqUpwuQWL2DMoGPcw
 sESXvZxCnG/+EmKEeiXjBDopYElW5fbK9Hi/gtKmP1rJnnI5T7H55/zFFISKOYXD6XS8
 m92fOq0bdBqIHRwZ0O2dTBondYrJ8GZBkjvPDLnBfsvR4BW3cHu1SV+JPk4NVPliSUbB
 cJahvZrGbI6GuL6//syja80uM0KLNMt74wuAlrqE5FjDxZ8NZYuaR82a0CyGznAQdc7E
 x0AQ==
X-Gm-Message-State: APjAAAUEYdZ/wYWpyEEXpxxwKkeNKrXK2Mj8L5MZOm/dSniO8D4gCNRP
 ePbRLfLzTryULcMeAd73TqA+Nf6onDzhFVyhmqA/ug==
X-Google-Smtp-Source: APXvYqxItBcHEIJ35ix20vPXzoUhhArss58ztTO2a0rVi7m3ABeKQEo4G0lt7BnT1Z+DBBpViWaEhCLR8G3bxAuGs/w=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2170047oif.163.1582706427302; 
 Wed, 26 Feb 2020 00:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
 <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
 <874kvdaitf.fsf@dusky.pond.sub.org>
In-Reply-To: <874kvdaitf.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Feb 2020 08:40:15 +0000
Message-ID: <CAFEAcA9ozNX2Jei+E+1rqiCEg+Be=gMzstiWz6MwbkOu2iLU3w@mail.gmail.com>
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 07:50, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> >  * get the qapidoc generation conversion reviewed and into
> >    master (since at the moment it outputs into files included
> >    from qemu-doc)
>
> Not true.  QAPI doc comments go into *separate* manuals, the "QEMU QMP
> reference" (docs/interop/qemu-qmp-ref.*), and the "QEMU Guest Agent
> protocol reference" (docs/interop/qemu-ga-ref.*).

So it does. I think I must have just assumed it was included
in qemu-doc because just about everything else is. That
makes things easier as the process of converting qemu-doc
and the conversion of the QAPI doc comments can be
handled separately without interdependencies.

thanks
-- PMM

