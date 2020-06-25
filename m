Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B542070A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoYc0Mu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B542070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOsj-0000Kf-JR
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOs4-0007yZ-1R
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:12:40 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOs0-0003RZ-Uf
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:12:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id k15so4715128otp.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p5qTHf9Bzn7HPsXrtYMUG0tdk1VljfvNG8UwQgAN+Pw=;
 b=qoYc0Mu59unPd0nEZQ30Ew4w5yF7wYQd8zmJK3tyyp3TpZemeopuc3Db0nkwbZpdEo
 CLbrI+gE58wyjnKsDrmJbaWie0ufg8zl/TDLuUdI8E2FVjcuviLWsmfKnfKgK2rwudWS
 d/E+yP3jYD4/fNcaIKYnvNl68WNUS1eoBqqU7UQp3J7d7l6FPCDqxulqZOTs9iQtuO4+
 EEJcqzQ3JOrOqIHQGIB6FNW358kNgwmlLl/H2BVpj1ud/Sx8YPnrRJjQ3KvYOXutBL0A
 wY1PMdmLtCuv9z6A84DBArLHmAgfs8JrP5k6O62Hu1RztN7fsbzFHSUPxe2HF9Bgdxqb
 Yszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p5qTHf9Bzn7HPsXrtYMUG0tdk1VljfvNG8UwQgAN+Pw=;
 b=VqnHtCY05ZUvqrvZZF2E32TdRbKwvZIqb7okHKrVI72BxpZ6Muk0s6Mxcgtntgvwpy
 +RoiMn/LZu0Ao8lTi/mtBdgnOlBE24Q9E6OTkGurg4AAhYyE+WV/shF/Nxvy5a5uEiuR
 wdieM7gU9EwfaUJC99zx44cDCt6YM4GhgeIjsCg65axac9LQgU5g6zRsf33iIHpBCaGj
 pb4sBfM0LkAiKR4C2EWFZZHvFaZoL2PTeHDwxCzJ14oVgLidQCORxW46S4Nz/C4us4Ju
 Q/zSu4A/ZMFyoCQsDAsGmI1Bt7UaMARvFIEJa33IFyAAGTYWDf1V8uVJIfcKN5Mn/6uC
 frrw==
X-Gm-Message-State: AOAM532aos6MEwnXc/bRvLIUbtIvFKEhsnJ4v3Tk5pkvwk9C/PmHK9XG
 JdV2kp0mXUOq7FUEiht5ermEjJuVefXq6ExyFx03JQ==
X-Google-Smtp-Source: ABdhPJzaE0mFVCvrXQNTINpNcX5uporOLMIJ26FS3wriJwPQC6o14PrPZwPRvSF5LQGTOShKUp+lzCX7f+bwPcwyC44=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr25976344oto.91.1593079955975; 
 Thu, 25 Jun 2020 03:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200624132625.27453-1-eric.auger@redhat.com>
 <20200624132625.27453-3-eric.auger@redhat.com>
 <87zh8r1v6z.fsf@dusky.pond.sub.org>
In-Reply-To: <87zh8r1v6z.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 11:12:25 +0100
Message-ID: <CAFEAcA8OJ3_yA+o3FSJ1FOTpH73xbu_5YBGA5A5b8hOqEqvkiw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] virtio-iommu: Implement RESV_MEM probe request
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 bbhushan2@marvell.com, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 at 08:06, Markus Armbruster <armbru@redhat.com> wrote:
>     $ qemu-system-x86_64 -nodefaults -S -display none -device virtio-iommu-pci,len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:99
>     qemu-system-x86_64: -device virtio-iommu-pci,len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:99: pc-i440fx-5.1 machine fails to create iommu-map device tree bindings
>     Check you machine implements a hotplug handler for the virtio-iommu-pci device
>     Check the guest is booted without FW or with -no-acpi
>
> By the way: s/Check you machine/Check your machine/.

Patch sent:
https://patchew.org/QEMU/20200625100811.12690-1-peter.maydell@linaro.org/

thanks
-- PMM

