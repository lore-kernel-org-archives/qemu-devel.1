Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE7C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB80820714
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Udb3Q6M7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB80820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Bgf-000069-U6
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Bg2-00087D-5R
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Bg1-0001RG-7a
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:12:50 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:33736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1Bg1-0001QO-2N
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:12:49 -0500
Received: by mail-ot1-x32b.google.com with SMTP id b18so6903373otp.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 08:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xhMmfioPM/BeW5BjBHyxnMNSfdxq8kegEZ7y640k5cc=;
 b=Udb3Q6M7vP2nGffEpaCTm+BIqbKjI04royH9jg2pfwoSXs8IE7hAvt/b3mOdOd0A7d
 iB8rZgGdZwRM4ZOuVIODaW3szkTACn4w2wEs6eEXOYhe3GxpyVr0FcQAhNx7vF5LazVr
 +YU9yy3fyIpf2scpJY+orcjATGZDkuJ6jbbeXJn8R4fLVW/BTWPmDzNywqvTwJE4TXUk
 o54oeyhuy5jVfGhdhVCTBH/yv5SxlQerKO5q0uWjX+0OIiOlpprZZttNk0Kon7j7K6Sd
 lT12iXFaXYWYhkp1UK7dne3XNNXbcVJRmRAd64H6xDb/2X966OvCS921us8mpV0P5A3e
 9nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xhMmfioPM/BeW5BjBHyxnMNSfdxq8kegEZ7y640k5cc=;
 b=dT1AvP3TaJSCYpBa/QJTrtVXtfPkvHc51H6Mn4FNtvC0fdk14SLB+xG5+gRfmLW54/
 U7NYQGnza/N4VCTJFLGZc4xUtnfJM7hXXgxpGKlmiFcdRWidPp5sBiYf1zw/++1d1lvS
 xouHxtGe/jmcTPi2OMgN33iiZhh5Ln7wTRuAVf/W6fOz7/OnPeFa2+wjInBbc3MUvqVU
 fs0C9PihuS/1rZWUdp+RYabd1ZqscAshivsl8oX/n13C3ZPFwbYY+xEHtMsz/QcF+V5T
 8JYXtmdhYmjPx90zWulsJV31QYsSif/+tMhrhKpIXOLzbpurFzm+s4MsS3Axo4Vhexlm
 vkhw==
X-Gm-Message-State: APjAAAU3YZ0kcC/glmWy8/3C8vVntyn/OpLfWSnVMGk409oHnx180108
 VPP49ihx9Tn6tAtFMrsNdkK65h9ZCa82pW4XySwF+Q==
X-Google-Smtp-Source: APXvYqyxgTZ11d7zFtP8JrwxEOXPaktKScvdGK5+BrabWGype4ydEwOG4oMBuuGgcD3OQLhjE6MT+SapUTuzoMAbmtc=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr1512826otq.97.1581351167833; 
 Mon, 10 Feb 2020 08:12:47 -0800 (PST)
MIME-Version: 1.0
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <CAFEAcA-C5Kvp-tUZfXSeAiFAHW-YXb+ddwFqyo5Y=0ziPhFbDA@mail.gmail.com>
 <871rrs136l.fsf_-_@dusky.pond.sub.org>
 <f450e310-3614-5e03-b932-ecba95970c95@redhat.com>
 <dc1c60f7-3f88-2d86-9f03-88cca1b6d49e@redhat.com>
 <874kvypgx4.fsf@dusky.pond.sub.org>
In-Reply-To: <874kvypgx4.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 16:12:37 +0000
Message-ID: <CAFEAcA9GKPbQOhD7dNJiKB2HR8vam0NeNPge0H087fgs8KoXpg@mail.gmail.com>
Subject: Re: Getting whole-tree patches reviewed and merged
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020 at 16:04, Markus Armbruster <armbru@redhat.com> wrote:
> Once that's done, the next questions are what level of review we want
> for the instances of the pattern, and how to merge the thing.
>
> One way is to split along subsystems boundaries, and ask subsystem
> maintainers to merge their part.  Infrastructure has to go first, of
> course.  That would be my job as error subsystem maintainer.  Getting
> everything merged via pretty much every subsystem we have will likely be
> a drawn out affair.
>
> Another way is to go ahead and merge everything, damn the torpedoes.

For this sort of thing, provided that somebody has reviewed the
overall approach, and somebody has reviewed each patch at least
vaguely, and we've given subsystem maintainers a chance
to say "I would prefer to take the patches that apply to the
subsystems I care for via my tree", in my view we should default
to "take the patches via one tree/pullreq" (in this case that
would be one of yours I guess). I suspect most of the time
most submaintainers won't care and will be happier not having
to actively deal with the change...

thanks
-- PMM

