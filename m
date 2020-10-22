Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB4C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF07C22248
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qroDH7RF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF07C22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVXbe-00083C-H9
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 06:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVXa3-0007Jl-9W
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 06:12:23 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVXa0-0003An-4U
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 06:12:22 -0400
Received: by mail-ej1-x644.google.com with SMTP id dt13so1425655ejb.12
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 03:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fSTraZzd6wj/EAoN6vC60eCZ1HQjJa+tY1wGDBrYfVE=;
 b=qroDH7RFyUxd73xEzQbsI4qMZmLHJ0X5k+5/qrbF7Di+Cma1YmAFKXkfjR1p0RhZmh
 Bb22voj1BxzlzeIze3MkeYFeiPMZSPIcKMliBbDKiom191JR3va3lYy8p6C5sWpRPnHQ
 HoAp28sN5hLV8Of2X080nCqI7lXxS/rfbpccqa7BVW6lvLEME8EMxpElqj2F6v2oGzmd
 HtV2y9kbSOuTeR8a12qgPdJb3hRNIlBs64XA9ApuxayrkpHvGNbPGvuDUOr13up3aCk0
 RCpSD+ydWN+czuNgi+v8peUWuv5W/4ab6GT8KKURVmvN6H7z9kNs/GfVHETvR2kn56Hv
 s/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fSTraZzd6wj/EAoN6vC60eCZ1HQjJa+tY1wGDBrYfVE=;
 b=pwHqffkhwCEAO4PimUl56AfAHsWMCNcVURfU/opfKd9kxesn3CGjlqiVSDU8UVoBL1
 4MSVy5vGUAElxS97a/dNP26IuePdbY4qIm8eGuNhQtegdGYOrjAuJSLyGxus4UObJsvG
 6grj8Sbvnom1VFN4sgs65LDOe9/7pZw3Mecy80KwrQ3U8Ziy7P6tMwP8lQm3+jt96PfZ
 fDSTUX99j449/ASRY90uLfMGNCL7QP8taauy0ExmwytMDQn120dU6z0GR4jynEu/rEoY
 YqQuanWKmiNBwTj96JTAN3c3LWFGZ03OlFVoqeg8UYAu+QcA49jLa/Pw00OOVAIIuSh3
 l5sw==
X-Gm-Message-State: AOAM530wq99VwO0UNITadWHelJrHxcbVEDkKNra30Fm8tYvhKOhxOyCq
 Rj0okJOnGqm+jvF9PLWh3KcA2Q/iK2TBq6JNcinnIA==
X-Google-Smtp-Source: ABdhPJznr2ef5KYBjPGnaBaOgQFC//boGdIBxyPhMf9QWz2oWk+/AK0MC7JL5sm51pmLz4g0H/JLAF1bDfts6G8fBcc=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr1611900ejf.56.1603361538567; 
 Thu, 22 Oct 2020 03:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201021144852.16665-1-kraxel@redhat.com>
In-Reply-To: <20201021144852.16665-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2020 11:12:07 +0100
Message-ID: <CAFEAcA_vc42=4MWcjEgRWnCDHpYNg6_4+Ln_zuOVqAmZacH+hQ@mail.gmail.com>
Subject: Re: [PULL 00/17] Microvm 20201021 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 at 15:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' into staging (2020-10-20 11:20:36 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/microvm-20201021-pull-request
>
> for you to fetch changes up to 66907f3d3b8bfc2de77b82d89253b7b3a8b728ec:
>
>   tests/acpi: update expected data files (2020-10-21 11:36:19 +0200)
>
> ----------------------------------------------------------------
> microvm: fix PCIe IRQs in APIC table.
> microvm: add usb support.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

