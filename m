Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16B6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD1D2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsvEHkuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD1D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic644-0000wS-Om
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ic61M-0007qz-Va
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ic61I-0003NE-OP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:07:06 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:44189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ic61D-0003HH-3N
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:07:02 -0500
Received: by mail-oi1-x230.google.com with SMTP id d62so2832651oia.11
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YGvTsNIFCLgc1pGrF1uvCYGtRgVnSzUpI+HM84Lstq4=;
 b=JsvEHkuCf/v+3xJFqqopKK+DATkxTOH650ehjP+XGo2bk/DVm9bqpVkBb0ufIcMQ7i
 3JuYRBxhFQP6AG5g3bKuvz4c8GsisYP8SBt96O3dNQ4yR0Sg6ASBZodiDeUBl4HdmUhq
 zva/c011kiDZUy9gUVdcjbz6tVhMR8sD3tNwubyhhN9bk9b4OCNZ50hAQTNI1JvY91/V
 xmQ6cq+AGFXik8sXgulvubF1Fu0N0qXh9NIvP0XAiaa3j/flz2bu/33Wtu1Mymuamof2
 JlE6CON/YMIp00hjv75ng+x98GULsUsdqVJT+x7yybqN0pwQpa9ns7W+8PZvbiGARFmD
 foqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YGvTsNIFCLgc1pGrF1uvCYGtRgVnSzUpI+HM84Lstq4=;
 b=EPayOt4zqSMuA2yRaptICiccxu01oZ7sbhjSH1KNNugY7J93r6G9OEQFmFwkErJCeq
 BFda9VhJEQ+5nKZfg8Fjqns9DEL04VrWJIvFIee7ZwZyq23gJOTNKt0XZrCnJFMKc3oF
 +PX8UtcoO5UO+kCfDTI1Wveri1FkBQYk6isfUyz1WhupL2qkhP6lTu8MBDlZjPSOopup
 yIPzgMVsXg8nrJGnq6ST+BYMRj5wW8i1esRchd2PTMC1peX2azmEP41twqk4Gjo6kY3V
 Q5As0YrbwX+vhuLKNK3ddKwJeFBko+A3VFVi2Ttd/IBPwg9ktmVqH34JYLLfbfF6K9Ol
 HN0w==
X-Gm-Message-State: APjAAAVofQAwtuRbmP3hhwTSMWXht+hi38AKH4CByz5mcn1NjzQhOCWB
 bPL3ZErVbcgJF/ONtQmBT1pUD14SrDcBh9rklr+5lA==
X-Google-Smtp-Source: APXvYqyy+/IidovA2ta05/dG21LVEmwVbFODJ4z0QmN+BEbn+3zMjxmg3Doga7CzImPKDd5w5N3+kxKGC00oA/dT3s4=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr3054671oih.163.1575371215257; 
 Tue, 03 Dec 2019 03:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <20191203105341.GB3078@work-vm>
In-Reply-To: <20191203105341.GB3078@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2019 11:06:44 +0000
Message-ID: <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
Subject: Re: virtiofsd: Where should it live?
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: mszeredi@redhat.com, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 10:53, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>
> We seem to be coming to the conclusion something that:
>
>   a) It should live in the qemu tree
>   b) It shouldn't live under contrib
>   c) We'll create a new top level, i.e. 'daemons'
>   d) virtiofsd will be daemons/virtiofsd
>
> Now, somethings I'm less clear on:
>   e) What else would move into daemons?  It was suggested
>     that if we've got virtiofsd in there, then we should move
>     libvhost-user - which I understand, but then it's not a
>     'daemons'.
>     Are there any otehr daemons that should move?

I like the idea of a new top level directory, but I think
'daemons' is a bit too specific -- for instance it seems to
me that qemu-img would be sensible to move out of the root,
and that's not a daemon.

thanks
-- PMM

