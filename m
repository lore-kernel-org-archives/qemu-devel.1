Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23320C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDF72070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzoWvtGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDF72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMt5-00072r-77
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrMsQ-0006Ux-V4
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:41:18 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:43807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrMsP-0002e5-8e
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:41:18 -0400
Received: by mail-oi1-x22e.google.com with SMTP id x83so19121795oif.10
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MODZTho7lM7VCZfH3ZtdvINP1atOX3dIVsfme62NZT4=;
 b=NzoWvtGlURn5vwFsLZreq+dud7/Fjj/MtbU4D2U1xCc3AGl6Z/SyRksi8kdQiotsR/
 YHAAIK3hR94qjJCG++YRmT6pFMrDkeT9Uwj2l7dz9fgFZ5rk4s63Oiot/QsanNEBmviA
 uTnZh1QEdHi2FUWr8E1X0b3O7xUJCG3srfD6nYN7LtVRwlUFcNsMMsUY+5THbh+HHGXL
 ODalsCD2qmZO+q9CUkCyL0OMXGrE++54dFxm4y43gqIs+VFIMrvxyZFanhRO4LGwz1x0
 jy47f4nPBkDVXg6x9sb1fpbYWp6GlY4F1Dtf6Y+b+twG95S8SvveL4XG2XQEEG5zOvg3
 zU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MODZTho7lM7VCZfH3ZtdvINP1atOX3dIVsfme62NZT4=;
 b=M5MLKoZovtbaOLoA5z4XqSuAoSpsRAbcoDu/kTc9oU9q52PHiGGiraqA/rGUo6amEl
 5wKBqdcbFRV1/fPHXXVJzm+msNNAHdaLoblbD9GusvaohtJZEXV2qJzNAsqJ861aJsXj
 syaGF3Vy7Pgm+7Hmdh1fTHJebco1YiII+pRs4q9p9N+X46i0U4++ERD55N3yK/h4emDZ
 iCg6sAnpB9zYrI93IOaBD8Yx0d06cOwkJjjRQ4VgFzgXLt9LryHsECyH7eC6J7AP7cuN
 BEwjGtsUUzuzWdNUioUIkqrU9IQGtnI0XYlmr5X3CL4xHewYwI4Rk17cBEh5NVxPr/8t
 8hkg==
X-Gm-Message-State: AOAM530Wg6YRuhI0eg962x4dt8RPsRKOs0Ra7jMSfH3Yr6HERoyekW0z
 LJULesLDRj4IjRcuW0yYxXNxbDGsK1YF5z87CLXZuw==
X-Google-Smtp-Source: ABdhPJx67/WxnNuVCvrhLwWsiSGP8bY07XC6RLeLHI9dVCnYeEzHJuMZLHD5IZG4ONcUJpea9ZKJIqs31kR+aaXHz2o=
X-Received: by 2002:aca:1706:: with SMTP id j6mr764434oii.146.1593787276078;
 Fri, 03 Jul 2020 07:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <1593769409-13534-1-git-send-email-guoheyi@linux.alibaba.com>
 <CAFEAcA8RU6fS8PX7LMhn4U33nKoRvcO_mnyBFcmW3iOpA40sCQ@mail.gmail.com>
 <00016872-f1ca-5989-8ad6-28cf05ea0c57@linux.alibaba.com>
In-Reply-To: <00016872-f1ca-5989-8ad6-28cf05ea0c57@linux.alibaba.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 15:41:05 +0100
Message-ID: <CAFEAcA-eyudHSQhEaM-G5hpVOqEG4G_kZpT=vjraciux-7P7Bw@mail.gmail.com>
Subject: Re: [RFC] virt/acpi: set PSCI flag even when psci_conduit is disabled
To: Heyi Guo <guoheyi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22e.google.com
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
Cc: Andrew Jones <drjones@redhat.com>, yitian.ly@alibaba-inc.com,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 15:36, Heyi Guo <guoheyi@linux.alibaba.com> wrote:
>
>
> =E5=9C=A8 2020/7/3 =E4=B8=8B=E5=8D=886:37, Peter Maydell =E5=86=99=E9=81=
=93:
> > On Fri, 3 Jul 2020 at 10:44, Heyi Guo <guoheyi@linux.alibaba.com> wrote=
:
> >> vms->psci_conduit being disabled only means PSCI is not implemented by
> >> qemu; it doesn't mean PSCI is not supported on this virtual machine.
> >> Actually vms->psci_conduit is set to disabled when vms->secure and
> >> firmware_loaded are both set, which means we will run ARM trusted
> >> firmware, which will definitely provide PSCI.
> >>
> >> The issue can be reproduced when running qemu in TCG mode with secure
> >> enabled, while using ARM trusted firmware + qemu virt UEFI as firmware
> >> binaries, and we can see secondary cores will not be waken up.
> > If you're using a real EL3 guest firmware then it's the job of
> > the guest firmware to provide a DTB to the guest EL2/EL1 that says
> > "and I support PSCI" if it supports PSCI, surely? QEMU can't tell
> > whether the EL3 code does or doesn't do that...
>
> Thanks, Peter. Does that mean the ACPI tables generated in qemu are only
> templates and firmware should update them if necessary?

I don't really know enough about ACPI to say. I hadn't noticed
that this patch only updated the ACPI tables, sorry. Perhaps it
is correct; Andrew will probably know better than me.

thanks
-- PMM

