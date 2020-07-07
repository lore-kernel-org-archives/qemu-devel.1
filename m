Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13E2207BB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldllTXLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13E2207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskek-0001yK-HC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jskdc-00016U-Ti
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:15:44 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:39826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jskdb-0001zy-3y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:15:44 -0400
Received: by mail-ot1-x32b.google.com with SMTP id 18so33886103otv.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rWGy1f3j7GSA4d5bloldhJkc4uC7/+lOqpPDq31wOMw=;
 b=ldllTXLZCO1DgbzE+lsLSyU5hwIUpsP78bZ4t+ico7RWI7tyTX0oaaHp4asBHTfRWu
 Y4inGfc8F1jnegZYj1vk63GGQDelHWeLLQX4QZTSQ/NSQ19o9daNxkSftPtmG3+hqQrz
 ZN8kbhhq/dnRAMPb/pHcalK+sKcQLi3R1LOBOMJIHkqHF5kz77TtoA1yVLPlf6i9THE5
 W6n67RYqAuaF18eQglt2Pmr9CxXaQRaR60bc3+SXA5rLD6NoC9XMLdOsWEj0LMWiHDsl
 pWYD1CC1FqRX8I5LbCdxupOFvIeaG8CQNfI/gGi99hRpplSK0YLGFANLDqCHLPe2xayK
 SBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rWGy1f3j7GSA4d5bloldhJkc4uC7/+lOqpPDq31wOMw=;
 b=LHP9YnQstbJk23YkvbdREzzyHuUcyYfc7Cai+GICuskh+2SHymiu9m2uQo4fdN3OMx
 uSDtc8dRpktRaPXIlpHHcYac183YcZ033+60kNIsOxofBTYACo7Fk0Ybv+icxf5igHoz
 uVVnsx9mUuEoFE62HuQ1bFo+msVTdm/Nejfya/4HSIBF9VSVZSnG9F4Rit/2tl2yP/e/
 YNFvN7pj07gJ8idozBDCRbuM4Sl+aDBakBjhbEh1gKFdWb0st9cNHD4jYdRHTlbqsINx
 hYIfFdOS73nlJyh4YoTK1a/lSFv3NbqJdfX3dP5IEmZIQ8fl+NXJB/CF1R0gi8/UBJDg
 Oulg==
X-Gm-Message-State: AOAM530kBJG/a3NxyZsv9qyb6A4fTVVrjKtWcLbv1hETLOt8yTsuFJKo
 PjGjWRoxZAZ8HyDpSzKoPJMZNezKNJnN+UC90GaM7w==
X-Google-Smtp-Source: ABdhPJwE7Hu53s7ke+gaRQhWgkzBCQ61LuWq58jnR62edgkVVcCbh/itSmuuAyWjCL3Zi3twPFLijbo0T29Mpfh4/Ik=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr37763180otk.221.1594116941367; 
 Tue, 07 Jul 2020 03:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <1593769409-13534-1-git-send-email-guoheyi@linux.alibaba.com>
 <CAFEAcA8RU6fS8PX7LMhn4U33nKoRvcO_mnyBFcmW3iOpA40sCQ@mail.gmail.com>
 <00016872-f1ca-5989-8ad6-28cf05ea0c57@linux.alibaba.com>
 <CAFEAcA-eyudHSQhEaM-G5hpVOqEG4G_kZpT=vjraciux-7P7Bw@mail.gmail.com>
 <20200707100436.72ldilqrnwc7pg55@kamzik.brq.redhat.com>
In-Reply-To: <20200707100436.72ldilqrnwc7pg55@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 11:15:30 +0100
Message-ID: <CAFEAcA-h1wXyeqymz3jYiVA_fmADe=C8eAewxUXtLL6ERbqJgw@mail.gmail.com>
Subject: Re: [RFC] virt/acpi: set PSCI flag even when psci_conduit is disabled
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
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
Cc: yitian.ly@alibaba-inc.com, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 11:04, Andrew Jones <drjones@redhat.com> wrote:
> This seems a bit messy to me. With an EL3 firmware, the DTB is provided
> by the EL3 firmware. I guess that's why when I look at the DTB generation
> in virt.c we don't properly set "enable-method" of the CPUs to
> "spin-table", even though we don't set it to "psci"[*].

Well, there's no way in the DTB to say "all the CPUs start at once" :-)
"spin-table" would be just as wrong as "psci" for us in that case.

> So, I think the EL3 firmware should also provide the ACPI tables.

Mmm, but I thought the general design for QEMU was that we have
to help the EL3 firmware along by providing ACPI fragments for it
to assemble. As I understand it, this is a pragmatic decision
because the binary format of a complete ACPI table is painful
to edit. So I suppose one question here is "if QEMU doesn't set
the PSCI flag in the ACPI tables, how hard is it for the EL3
firmware to edit the table to add the flag?".

> However, this patch it probably fine too. For a configuration where
> the EL3 firmware provides the ACPI tables, it will do no harm. For
> configurations where EL3 firmware isn't involved, it will do no harm.
> And, for configurations like this, which I consider a bit hacky, it's
> probably better to assume PSCI than not.

Is this really a 'hacky' configuration? I sort of expected it to
be a fairly common one for the 'virt' board. (For sbsa-ref the
EL3 firmware would provide a complete canned ACPI table, I think,
but for virt it can't and shouldn't do that.)

thanks
-- PMM

