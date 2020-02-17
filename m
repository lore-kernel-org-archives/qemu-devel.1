Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16C5C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA62E20801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDcBqoZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA62E20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3j7T-0005pr-4J
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3j6M-0005EV-Et
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3j6L-0002y6-0v
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:18:30 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3j6K-0002xj-Rp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:18:28 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so16584778otd.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 08:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ECaidJJ1fnUpq9ZxkDr0YE9GRsbHQ2Fcl2B0Seiuku8=;
 b=qDcBqoZEXy/s2A6Eh8a9D95Gdz37o8Cw6f8X8l1lodBr5ARihOPsMkg7qh/ux7qeGP
 NHH6grCPXbAkL8mkw7gyALO1bNBpHqVFKB1MmKXv1ivT8n+Sj98u8OXVL0YNa9cJSfnZ
 Gw+jhEcugOm4wD44mUYkpLS1DYBsAyOzIZE4RE65SkEufxN32MsheYxBhxh99G98xHbW
 tZtz0TPF81RtRC4nJmHlD51jvs1UMhgnqPqlicwOwBPiqfd+DD+kSbyXA89s+C/WaMKp
 n8o4OZEXMyrUt/ygc2EFoOoiK6RKBVfd6tmmqIl3fMaWuv4hm7f/Ok+8YAbq2070MDUF
 Uokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ECaidJJ1fnUpq9ZxkDr0YE9GRsbHQ2Fcl2B0Seiuku8=;
 b=mkDQkkFDEi57MNHzNks1Bvkn+IEMRuQQlXEz+mUeTwpTFqVMsoQcMyEK5YwIp21iYH
 qpLHC2XMf1jhqX3ozK+AMFSCUVcDhGpXmkRmeOYJf6RumH2hzYIxnWLh6KYDEZhQw3If
 s4y0hIe+4IKsx5yWn8/5FRWJKKah4ryo0xfPCynsmwD/SKYIC1ZZoZs4h8uTgT4iVHYP
 rn9Zdn5Me/QKMcRAojwV5BGyUWIXzm2zjd1zgDlHLOaKmiLnqqcveA91ZlA6vw8w8dsW
 VzpUP0xaqQpwCOBtVgC3kzxTzYPpApqWmz1Ba8NNMEACn06ASozGlRSW3sFNlKDwpIJP
 5gaw==
X-Gm-Message-State: APjAAAXhkYjdpTkcfqJmNPa0yH75ly3a0Pm8tH20ewmY8xW1achTBx85
 BlxhoRGqnW/RNqS5H9MrHSVxozyIfxbnUH1kAL3EMg==
X-Google-Smtp-Source: APXvYqxiLKk6oNYuITri6k1Z79+lJDivWyyp8naDp42q1lNNpvEKuZrTQ9nOkXl8D/A7Zt97x7MCu/pkaeaTMR+Obi4=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr12145849otq.221.1581956307985; 
 Mon, 17 Feb 2020 08:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20200217155415.30949-1-peter.maydell@linaro.org>
 <1865c4e9-a0b5-0c50-adb8-e46da1b0d8a9@redhat.com>
In-Reply-To: <1865c4e9-a0b5-0c50-adb8-e46da1b0d8a9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 16:18:17 +0000
Message-ID: <CAFEAcA8T0LXra=P9r0xwEA809R++hxbfUCz5d8g7h6=fX0-azw@mail.gmail.com>
Subject: Re: [PATCH 0/3] docs: Create a 'tools' manual
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 16:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/02/20 16:54, Peter Maydell wrote:
> > This patchset creates the new 'tools' manual that we've
> > decided we should have, and moves 5 existing documents to it:
> >
> >  docs/interop/qemu-img.rst
> >  docs/interop/qemu-nbd.rst
> >  docs/interop/virtfs-proxy-helper.rst
> >  docs/interop/qemu-trace-stap.rst
> >  docs/interop/virtiofsd.rst
> >
> > This change will conflict with the QAPI-doc-comment-to-rST
> > patchset because they both change the docs/interop makefile
> > rules, but I expect this one to get in to master first;
> > the other needs a respin at some point anyhow.
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> We can move them back to the system manual once it's converted to rST,
> but for now it's the best solution.

I think they can reasonably continue to live in tools/
even once we've got more stuff in system/.

> (In fact, I am willing to do the conversion from texi to rST if: 1)
> someone else helps with the .hx parts; 2) we accept that the current
> structure of the manual isn't great but we agree to reorganize
> everything after the conversion).

Yes, I'm definitely working on a "we can reshuffle stuff
later, but let's get the basic conversion done first" basis.

The mechanics for handling .hx files are already in the tree;
I can either help or work on the bit of qemu.1 that uses those.

Kashyap has volunteered to do qemu-cpu-models.texi.
I have patches on-list that try to do the QAPI doc-comments.

I think the next thing after this is to take chunks of documentation
that are currently used in qemu-doc.html but not put into the
qemu.1 manpage (ie which aren't in the 'man begin'/'man end'
sections), and convert those into individual .rst files
to go into docs/system:

 * docs/security.texi
 * qemu-tech.texi
 * qemu-deprecated.texi
 * various bits of qemu-doc.texi that don't go in the
   manpage and that are coherent chunks of documentation,
   eg "Supported build platforms", the various "$ARCH System emulator"
   sections

That will whittle qemu-doc.texi down to more or less just
the contents of the manpage. Then we can convert that
part to rST.

I note that softfreeze is now 1 month away -- we should
decide whether we think we can get this basically all
done by then, or whether there's a good "pause point"
we'd like to use where, say, most of qemu-doc.texi
remains as it is, or where it retains just the
content that goes into the qemu.1 manpage.

thanks
-- PMM

