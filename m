Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2744C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18C925355
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raBB5xrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18C925355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvtL-0001tH-UT
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpvs8-0000xU-FN
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:39:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpvs4-0004E1-V1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:39:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id w17so14035971oie.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LJBnXO/BKgQmZuNfKODBtv2ujBgwswE1G/Q5xK4+dy0=;
 b=raBB5xrRli6YpOSRngQX3tSXUzQ+e2bvusQhstygGPjPoCdCI33qe7B9gn45+ifob0
 OZLfEGrptEuLON+bD48Ic7cQWsTFeRTyvSm76zsGOI6/rkvKZ8UolNLKIUx/rnDOevBx
 hvvTt7YqauNDeXGbr7bGuvTZ17eWRtFhhW6LnwaIK+1ZYv9ehbTJhXXp9YwiAwf8NPJA
 xP1iIfb1FWXmyD94+gjreKzCLudXqQZv+tKqPMjSEzpkLEZ8aNnmY3OJrZ97dl+XvawD
 ffkrjbGdLXpBFMFGwFfodxxIREnU1hCICL+cdr7X1T50NIfSeb0r1HuKb7EgUqrEIqF1
 vXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LJBnXO/BKgQmZuNfKODBtv2ujBgwswE1G/Q5xK4+dy0=;
 b=E0iEu0MOVInOBzdO+ywPygfm9eLhrLU+7c7efC8CPbfGDXioWSEzjP4OPkjIWbTRBT
 9jRS4wLbsMZsUXjRwZWqIwvvdpyCaxQrWfSSYbNJkHB3/6IkF4fh480Dhp21pLptghs9
 XWYOHWfAP9C/EFfiBYofkofXK/4NojaGhSBOMqnCJRAsuwR8/5NHWTjN2p8nplTZ/FRG
 0IOQOBizvk2xu+Q8JPn9qiFOIRCGk50jAtiIkCAYyb/PK6aPNTkaOeTnUWFK5BShvZO1
 79Md9Lqw7BZLhui1xi4GdlfaAMKrdm5TEp3pMzzDbcgEzGDMfQAuY+CYhDPM4j9YJYSA
 SaIQ==
X-Gm-Message-State: AOAM531jmKuScXWOl8rDiRQpkxPx1wd424evRI8mDrwipcp6DhVrjxUo
 UMx2ZkpMM7vyF+TN7BnBQoZwvhxcreZTKJ1JUzag2Q==
X-Google-Smtp-Source: ABdhPJz5eXKatX0ycvrdnRQ5ANxhigAWVk4yusHi4dLtMaBLXmJ7UleJjMY3k3LlqUAQJdfPJQHQZz4wJLBfaTFsTHU=
X-Received: by 2002:aca:2819:: with SMTP id 25mr6762944oix.48.1593445134383;
 Mon, 29 Jun 2020 08:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200629151642.11974-1-pbonzini@redhat.com>
 <aaa5f004-e500-5510-bf70-435b5c0f9383@redhat.com>
In-Reply-To: <aaa5f004-e500-5510-bf70-435b5c0f9383@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2020 16:38:43 +0100
Message-ID: <CAFEAcA9fQ-Lg-fB=_KMtTsNvYUQFExLyNf=idvtJY5bH89WkUQ@mail.gmail.com>
Subject: Re: [PATCH] coverity: provide Coverity-friendly MIN_CONST and
 MAX_CONST
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 16:34, Eric Blake <eblake@redhat.com> wrote:
>
> On 6/29/20 10:16 AM, Paolo Bonzini wrote:
> > Coverity's parser chokes on __builtin_choose_expr inside a constant
> > expression.  Since it is used only to raise compilation errors for
> > non-constant arguments, we can just assume there are no such errors
> > in the Coverity runs, and define MIN_CONST and MAX_CONST to the
> > "classic" ternary-operator-based definitions of minimum and maximum.
> >
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   include/qemu/osdep.h | 17 ++++++++++++-----
> >   1 file changed, 12 insertions(+), 5 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> I wrote a variant in the meantime, and in comparing the two, the only
> major difference was that I added a line:
>
>      Fixes: CID 1429992, CID 1429995, CID 1429997, CID 1429999
>
> in the commit message, as well as a comment in osdep.h:
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 0d26a1b9bd07..98bc7156fa9b 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -250,7 +250,8 @@ extern int daemon(int, int);
>    * Note that neither form is usable as an #if condition; if you truly
>    * need to write conditional code that depends on a minimum or maximum
>    * determined by the pre-processor instead of the compiler, you'll
> - * have to open-code it.
> + * have to open-code it.  Sadly, Coverity is severely confused by the
> + * constant variants, so we have to dumb things down there.
>    */
>   #undef MIN
>   #define MIN(a, b)                                       \
>
>
> I'm fine whether or not we include that.

I would vote for including the comment improvement, please.

-- PMM

