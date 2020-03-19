Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D22DC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1A92071C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2BRLKtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1A92071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEx8U-0002X1-ID
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 11:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEx7n-0001yj-67
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEx7l-00076r-UN
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:30:23 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEx7l-00073B-OB
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:30:21 -0400
Received: by mail-oi1-x241.google.com with SMTP id x5so3031965oic.13
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZuaFBRbKUCjWUeeMn3kMdvwrrkWdlYE0gSCL1+fLH3s=;
 b=P2BRLKtBZolPCQm77uZPF6ck19AsfT+dSsGuLncV88/ONhTdn2Xm8KzHPfmN4egGV4
 +pT3FFki1DytPRHWyFX1lgPVdIOzQTU2sC3untnfGyzhdaQtTELiRC77kYGFsN76s4Ks
 do4lB5/jABJWix7Ll9N2YR3CtaYQGu7EY0RJpFAIqXNFJD2ClK4kyFXX3rpwOT4sVrR1
 XXZ+8N+OCRVQ1Ptt1/3O/Irigg9qMrrNPV4ulFOk0kSNE9iwMFY0b8W4NbWFZ5O7Bbep
 9TPQBAkatps3frC+5iIK17xDIzG1ekJqrhAHUOG1qd+G9oM7ptEvJlgrJ5H0P9S6HCic
 UWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZuaFBRbKUCjWUeeMn3kMdvwrrkWdlYE0gSCL1+fLH3s=;
 b=SmT+I/4COJT3HCmHXqEmONnHOZL4AeHHL2BfOEG7bSf2EnnbTbGTKgTCeyOU/D46uV
 OHy8FJgsql+NbxsvOHrBKsOgcoQM8wRl75CqCAigZeP6bA1uELFY16itV5T+w7cQ4kT5
 RBBhNReUVqhRwCB3xp9EkCqQAxFgawoHYUpkiR3MHpzWGUpBMEJb56mQqooplgdINctu
 KYD8FDoS++NkBzJ7874XvzepoDaV8yfyzr6A5pnHy1YS1L61ENCpmDQISSOVLFyy6sCi
 wLtaWqet2mNbt2OyOTBmuOUK4N+ypF1ZQBTkLD363I89MRisaPGEBr8JbUnwDwfbJyWx
 torQ==
X-Gm-Message-State: ANhLgQ3bCMAiqvLxvRL7+jclBzagWTHqKMeQa8MMgNREjo2PTa0d3rQV
 J1a+dibHgb1ff/wXWYhwHz/YgeQifLwqw/92U6GnfQ==
X-Google-Smtp-Source: ADFU+vtontKk/bTLG/Nq8EF5+0sGc6nl19pX7TQGezyt2YmPqg7S/lHumo+Nx4lMx/EDBLOUjKmrTN6sJbqqmoXAOOU=
X-Received: by 2002:aca:190f:: with SMTP id l15mr2674757oii.48.1584631820600; 
 Thu, 19 Mar 2020 08:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011748.2104336-1-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 15:30:09 +0000
Message-ID: <CAFEAcA982gvZ5YHL7xBJmw-rK9WrwggbUHrdGs58ncCxD4OSqg@mail.gmail.com>
Subject: Re: [PULL 00/13] x86 and machine queue for 5.0 soft freeze
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 at 01:17, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c299cb17:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-03-17 18:33:05 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to 3c6712eca07255803b61ca3d632f61a65c078c36:
>
>   hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids (2020-03-17 19:48:10 -0400)
>
> ----------------------------------------------------------------
> x86 and machine queue for 5.0 soft freeze
>
> Bug fixes:
> * memory encryption: Disable mem merge
>   (Dr. David Alan Gilbert)
>
> Features:
> * New EPYC CPU definitions (Babu Moger)
> * Denventon-v2 CPU model (Tao Xu)
> * New 'note' field on versioned CPU models (Tao Xu)
>
> Cleanups:
> * x86 CPU topology cleanups (Babu Moger)
> * cpu: Use DeviceClass reset instead of a special CPUClass reset
>   (Peter Maydell)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

