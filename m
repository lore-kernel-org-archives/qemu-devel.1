Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C30C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B33320739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohwMN3bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B33320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFK4Q-00032j-50
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFK3U-00025Q-40
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFK3S-0004pT-7g
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:59:27 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFK3R-0004or-3o
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:59:25 -0400
Received: by mail-oi1-x242.google.com with SMTP id j5so7022797oij.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ijrISVWIxi7tzoH96MnsY8KNqgYdgLuTO9cfbL6w7cM=;
 b=ohwMN3bJrAgdxgA6bxhzAnd+JIyWHLj6WfvHG/N9zmyL/cNXiwU0qiWyatTjwSYmGX
 wzjZ5k5ChKo0KokmI782NpxtKbiB6hO8YHznsE7ou/r0xQXZtYmmf2+HuJ4t9rga05xS
 hZCq3EbqxG6zHekdh/Z41WtoTaDIbs0dE/AGuB4oBUc2TwCu7C5IYbEkHn4i82WMV/fz
 esfsEME3iXt7NKqRIKrtKNytWp2l9akMgPAc7jgbUCT0E29XowvGd2lN3B9PGEFRPpml
 a7qMlV1GgdTqu0m2IPHSWzasyzjlzTE2h29clrQBgQUlm6Z0FQ+NTLySgGfJ6feXYjMP
 YGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ijrISVWIxi7tzoH96MnsY8KNqgYdgLuTO9cfbL6w7cM=;
 b=kv2ZdYiCZPo2v6MRjax8zXOBvWCav1eiR+nsVtQ3CKRVmSSR2icUDOhepidNFgiBqF
 PNt3Bzax+KLfA2kH2xAY4usFCo7mGeA/3e8T0VOfUuaBrLPS8ZJM1y7JBDvWLIA+bYxT
 nkz1wWMBUbDDr9Nv0F+zIztoiQGckSbH8lbel1zMhN5SzTTe+e3/2RzWMw6kFPP6CdSr
 dousjORjbbiNT/iZZZTeLHe5xdds/g7H/N7aNDpzW2rC3impqoqPXbrGiiodnJIpLqn+
 cwyW9OwQXgyJefpkE9exMN4V5Lr5M29vGzCte1qbm9x5OsfVhjYAHRseWBqzZbL54GRO
 EFAg==
X-Gm-Message-State: ANhLgQ1J11dNEs1Kig2f4EAkhgaNMXifE3C4ZvHj7und8InG0Lt6ArFL
 zBmjc+w3tXBwXNTUHJZSn5yu3R7A+ZgcIKsM38lpug==
X-Google-Smtp-Source: ADFU+vtH8syic/81QuBn/HtCoctW1WZwGiEhJPN6K/rj2Sl8BLW3ddtYrwybGvcv56vPmriu6IelQr7/UV2+hm1/nVw=
X-Received: by 2002:aca:190f:: with SMTP id l15mr6771333oii.48.1584719964079; 
 Fri, 20 Mar 2020 08:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200318071620.59748-1-pannengyuan@huawei.com>
In-Reply-To: <20200318071620.59748-1-pannengyuan@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 15:59:12 +0000
Message-ID: <CAFEAcA_DGyeH39OL00o+GePGJx=CNu+Xv+r51_6M=zLT0+FmbA@mail.gmail.com>
Subject: Re: [PATCH] hmp-cmd: fix a missing_break warning
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Euler Robot <euler.robot@huawei.com>, zhanghailiang@huawei.com,
 Keqian Zhu <zhukeqian1@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 at 07:18, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>
> This fix coverity issues 94417686:
>     1260        break;
>     CID 94417686: (MISSING_BREAK)
>     1261. unterminated_case: The case for value "MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD" is not terminated by a 'break' statement.
>     1261    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
>     1262        p->has_throttle_trigger_threshold = true;
>     1263        visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
>     1264    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:

This is CID 1421950. (I'm not sure where your number comes from.)

> Fixes: dc14a470763c96fd9d360e1028ce38e8c3613a77
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

thanks
-- PMM

