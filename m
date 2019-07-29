Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F9CC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55733206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIELFnFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55733206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs22H-0007wG-F4
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 05:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58680)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs21m-0007Xi-OZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs21l-0008Qe-OE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:33:10 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs21l-0008Q0-IH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:33:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so61906672oth.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hkG5FlQj0Hs+nhY6uGwXP8K0o6htEplfutVYgKyoodk=;
 b=PIELFnFxaKFJYx+0e5lEgKpVvig/jZlqWtRqscXEdvbddMNiJ3F9Y8C9B3VwkLlEXB
 a/eTu9sVTSVHsSXmgAMvxtYkZHQE/XdyZZxJIvsih/TE9DJOpc9iWX2emM8gC6W+Hn/h
 l3gvf0UFpibRheW5VwCB5qTIFS/ZcxbwtOySvMA+2w/BtTRqUDq5Mc0PD/MNx4983T9i
 TOVm5JFZ+Bg4YsgarfIcX0qtAPd/A8JaPCAfTNINnpGaSkpQriL3P55jf9bPBVW+XEaz
 ow2GT0K6sT1nEXnLnfdH+YV2kig4nzcZYtEjPN8r/DUYHKtyVxa0cjJBSsoRkL0Fnh6k
 tkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hkG5FlQj0Hs+nhY6uGwXP8K0o6htEplfutVYgKyoodk=;
 b=IcE0ElyOREXV5aX/XmI8X7gVMESPvM0kccJLf3KLqeG1ij3NtdGEdSS6EKO4+6Pl1o
 mqlLAAGZTnOzdVTXZSG3CqNTqBTm69Iso4Ne/DdZXjvhrdS9cygQkkBdoe11T7FEmP5f
 fstlNBE9vL7y/WwOvMGPV18VwuYZuZOJcrPEeMF3r8VwS4PGSqZsHAP3k/ndoH4Hw8mQ
 bV2pDJNjnOeRWGScDMpeeCm1K46SGnuEETzfSudkiVXuiLmhSiouQcBeOlWbMCSIYydp
 C9caeEfPGlFXhYQy/brwTerXUl9Ct7syrEkjzz49pQyiCIHK31Yf2IFffWxoyGF/W1jq
 UN0A==
X-Gm-Message-State: APjAAAUlC/NOXTVtxjBH8r9ZpyEjPJN8NtU9Vprbd7NDZciPeos5isdB
 k8qAk6CZaz8A52vmKMtSXJHO+Y9ne4qDZ/+3S305Ww==
X-Google-Smtp-Source: APXvYqwaR4JbBrbSsv2Ca4FIcc2bo2IjRqAyqt07efOYB4tF8yTLDM1UZGD34felVfDJW02EYqMMSROhiq2+udcTUXQ=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr75600412otj.97.1564392788469; 
 Mon, 29 Jul 2019 02:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <87ftmptiyq.fsf@dusky.pond.sub.org>
 <41165962-2d61-697f-d17a-d5fa7516e8cc@redhat.com>
 <CAFEAcA-Egqpz3MwC2Kk-h_iCP4U74rYh66Nb2oaK5rdjD=7JMQ@mail.gmail.com>
 <aa4801a9-ad0f-a6b8-e167-1fc5f4e6925e@redhat.com>
In-Reply-To: <aa4801a9-ad0f-a6b8-e167-1fc5f4e6925e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 10:32:57 +0100
Message-ID: <CAFEAcA9X=F2=XP97pf171LJ0PiKHTPNNtKZSqJ8g06CmqWmzUA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 10:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/07/19 11:21, Peter Maydell wrote:
> > On Mon, 29 Jul 2019 at 09:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> There is no case where we're using per-.o file CFLAGS for anything other
> >> than dependencies.
> >
> > disas/libvixl is a counterexample -- we use per-.o-file CFLAGS for:
> >  * suppressing warnings in third-party code we don't want to
> >    carry local modifications to
> >  * dealing with a NetBSD weirdness about header inclusion order
>
> The NetBSD thing could be worked around with a static library but
> instead those -D options could be added as global C++ flags:
>
>     __STDC_LIMIT_MACROS and __STDC_CONSTANT_MACROS are a workaround to
>     allow C++ programs to use stdint.h macros specified in the C99
>     standard that aren't in the C++ standard.
>
> Likewise, the -Wno-sign-compare probably should be added to all files
> for GCC <=4.6, but in fact we don't support anymore GCC 4.6 so it can go
> away.

I think it's an indication that the mechanism in general is
useful. Switching to a new build system worries me if we
already find that it is lacking flexibility we're using with
our current build system -- it suggests that there's likely
to be missing stuff we're going to run into in future as well...

thanks
-- PMM

