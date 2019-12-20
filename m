Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE3F2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBckzOfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE3F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHgY-0000zJ-Bc
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiHfp-0000WF-0j
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiHfn-0005WG-G4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:46:28 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiHfn-0005Or-2g
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:46:27 -0500
Received: by mail-oi1-x242.google.com with SMTP id p125so2185716oif.10
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Kkfcv0TlxWwhobEGv7mVFSxHbehe2Omve2VHfmpaVVw=;
 b=ZBckzOfMCw8QWQlCEPa4xZrE76FQoFGS4mAG644ys3QdjxUCuvV/7ruBG8GmMkJ07j
 vCaG4cRt+n/ZIWQ2XsP2Mui9t8v8E6l+lC1hc8KBtcatBD6tduNyoLEoP29D9BzeIDod
 5hIY3si1Q3YuvKpdazfLR+PJ11OIiAexhtRlLR0Ooba14K6h3dKfh2l29Nfp0aOEgyrV
 R5z+c0KEPVVC7jW2QOOeP+BWoeXt2sabZ2H6KbCjzLmr4kJabEveZIU3D9Q1/8DPblyu
 P0FnXr5Q7EJ5ZtTDyhgH4AUlN6SkYKqVq6DafId/5ngys+QuW2byCo/aK4I0RT85x6j8
 j2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kkfcv0TlxWwhobEGv7mVFSxHbehe2Omve2VHfmpaVVw=;
 b=N+3Kh4MIgsRfaSV71Pq235YS6iE0YP9mYs3vNkAP+P07YKkmBe6wH7lpGayfuHFwH+
 B0ro82MSu/sSDzbAu0pmGswmL9nLGLUkBpxtpbs4sZhmgYA4NIvFBObMf76Gq8NhS2aV
 CYKnJjB3b+fqAJCJ8RTqX2J8iI6SzcjVDV3dI4XasKdi9qwwwO80tp+3vvGnK5cEA0DG
 OYgFDxH+V8gtcxd6EF60GKRgAw0yM0vV8NZ2RuPIHvf/Lg7Qu4ToTCOPST+NADgC6YKT
 YNJxgMEdKRrdp9l1sww22vlJ6vgIFy1ePzvB8LDHa0y2jfaUmCzXyjKlxHFFXbBdYJZh
 Vg/w==
X-Gm-Message-State: APjAAAU0E3d74FL3YLi4bGyqFcmF8CIBcVKhnLpxN5saobFfpL8gm+5X
 eYb86zpPDcISQgP2nsSb7YFviYBKVHrJwhmC5RIZwQ==
X-Google-Smtp-Source: APXvYqzDr6QqYDaJhb0gS8JxdJKsOciRf1N+nRETiNBOvcf25Zr/WXQTLZ0gGRFx6SItq3vDvKUo/hhWg/HEVJjF4tA=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr206972oid.98.1576845964645;
 Fri, 20 Dec 2019 04:46:04 -0800 (PST)
MIME-Version: 1.0
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Dec 2019 12:45:54 +0000
Message-ID: <CAFEAcA94cW60isHmBc=B0Eg2QjQBotaLGnBM3CM2-AtxjnfnNQ@mail.gmail.com>
Subject: Re: [PULL 00/87] Misc patches for 2019-12-18
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Dec 2019 at 12:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a6=
81:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to e2328a11bda7a4d087200c524333adafb8beb7d7:
>
>   vga: cleanup mapping of VRAM for non-PCI VGA (2019-12-18 02:34:13 +0100=
)
>
> ----------------------------------------------------------------
> * More uses of RCU_READ_LOCK_GUARD (Dave, myself)
> * QOM doc improvments (Greg)
> * Cleanups from the Meson conversion (Marc-Andr=C3=A9)
> * Support for multiple -accel options (myself)
> * Many x86 machine cleanup (Philippe, myself)
> * tests/migration-test cleanup (Juan)
> * PC machine removal and next round of deprecation (Thomas)
> * kernel-doc integration (Peter, myself)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

