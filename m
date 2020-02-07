Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF0C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D624E20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7hhfeBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D624E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01W7-0004YA-3l
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j01VK-0002jX-L9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j01VJ-00075n-Lz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:08:58 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j01VJ-00075L-H1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:08:57 -0500
Received: by mail-ot1-x341.google.com with SMTP id j20so1805466otq.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gzD7UNYViBOh2QgvbS95ozxi1ekGwD7XsVKYAodmaLk=;
 b=W7hhfeBOSwuc2xMK488XdY+o37BmFjflccEvAHNU6gyGpGo6nb149JjrWNqBSsNGnn
 cfxNHLUHP93DCmgo+JUWZQj9NyvCkRyUdtAOArjaCx8kxC99jiVcWpwvb9luSKzO/LDQ
 8REfSk40fG4zrI9aHiY02oqFjVlStURXb8KW01wTZPyB9k3e7AhJL/DOr4bmfzn7kzW7
 jCo36+EGwYlLtdF8oplkYkbSG4rTY9vFWXQJ9OrT1N7r/UugY+qGPRBG5eKKyrar881/
 3KLFHnRBq98vxTJ24uLMKm2GXZg9c/6h4fGHVycLvYRPBz5tBZuK5iDBIhdJjz4WpmEl
 zFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gzD7UNYViBOh2QgvbS95ozxi1ekGwD7XsVKYAodmaLk=;
 b=RLpUyaYK3E+tz+EfqEC7fF65QNGDUhZ4YfI5Ujqm5wwRqLykZ6m0JSI660tMxynKYK
 u9x8tZ9VISlGXNxkUJmjN42dQBTVf0Rb5s3U1f2uD2TWbTxL8f+96t1QwNE8uNhpuB4B
 uk9pHfXhuE4R9X8nqNwN9rp9A/FZRnulSATj362NBZWFwmLUkUpYTXpjbjhRfhm7VrPV
 HLZrTGB3yuKtxODq2UBoMtUVSOlEzx2rwHo1rAk9J9vOJOoxjGoYlvNi04gvlwHMvkwV
 zQ5gzzk0aHN5L9ynSZyvL7+3VkIXUJ9igWhgpf4UK+gBaZB6GVgVxZd5/6uDEOM81TbW
 I22Q==
X-Gm-Message-State: APjAAAVJ9LwBLTo3Q7pc79K1k43Rih9wivQOQCWGMkYXJHd7GicMfCUb
 0dRiGAATdVPM06qiJ81Y67Mie8+atCbZ7e/rWvUjAw==
X-Google-Smtp-Source: APXvYqyL4b0YldIte/t4pRpukkjBRFEXpiB6sNh1k3hR4YQW+58NMsWhGrIDuVvPQJGOmc+jJ55jGk3izMXOyybFf3c=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr2117981otq.97.1581073736613; 
 Fri, 07 Feb 2020 03:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <CAFEAcA-+tAbb9h2wZOm56TqUvjQJT0OYFLwTVS-UxKrF5PO3mQ@mail.gmail.com>
 <5aece614-4341-35e5-53a6-2f3d788e6e8d@huawei.com>
 <e8b93460-48e6-43cd-4608-370c07cb45ec@huawei.com>
 <350aa4ca1b57a466ed882236caf23051@kernel.org>
 <c67c1563-045f-a5f8-8b8b-97d792aa1912@huawei.com>
 <f8394aafb2adb513186cd2784a1cb077@kernel.org>
 <58519c6b-5c0e-b557-ac91-2024c594b28c@arm.com>
In-Reply-To: <58519c6b-5c0e-b557-ac91-2024c594b28c@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 11:08:45 +0000
Message-ID: <CAFEAcA-rdWsf-pOYs9GfMQgeYZRM1TFAfpUA38RdFiNRFCF0Xw@mail.gmail.com>
Subject: Re: [RFC v2 00/14] Add SDEI support for arm64
To: James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Mark Rutland <mark.rutland@arm.com>, Gavin Shan <gshan@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 10:52, James Morse <james.morse@arm.com> wrote:
> Is there an established pattern for how Qemu 'gets' things that are done in secure-world?
> For PSCI the kernel does it, but this obviously doesn't scale to something like OP-TEE.

The answer broadly is "it doesn't get them", the same way
that a real hardware implementation that provides only EL1
and EL0 has no way to get them. Ideally there would be an
architecturally provided way to run a virtualized EL3 in the
guest so it could run (a QEMU-aware flavour of) firmware...

thanks
-- PMM

