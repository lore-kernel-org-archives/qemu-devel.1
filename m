Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49F1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C842081A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AP/flQm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C842081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joBex-00004r-My
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joBeC-0007z4-Lh
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:05:28 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:36271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joBeA-0001fO-Ox
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:05:28 -0400
Received: by mail-ot1-x335.google.com with SMTP id 72so3144875otc.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u7yKdx+/jzRdIIBTYmDiCxsyYpVaZsMbKZqKsTdmFxo=;
 b=AP/flQm4Q2A/5We7PqTb22ZyWPQ+4vfp4RH4jH51aeFkoYZ4DNtVWEaZYR/kTYEcNN
 5eYmRe6dNydYk3fjzlkyyuv1OOztsoQlZRkgiilfyfB5gdp+7A1XW+bDY98UOE4KVPA9
 Ptziaho9FU12SO7ZVf5gqgRqulQwAaYn86tS/FYAm3xRymeErQWQpHskdQwuRECSs2b+
 j9F2TbsgsQXtoZRyygokdrSkp/0ts/HnQKWgN85IKdpHpGkhQ4hLL0AZZHWbTbkpjbA5
 jPwRaBcifqoZUn+pSf6ohXjCiotiXOvZ3DUarUSban4vfJPUBT7b0INua71IzWv9PNvK
 6nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u7yKdx+/jzRdIIBTYmDiCxsyYpVaZsMbKZqKsTdmFxo=;
 b=YxTybs+m51r+yPN1qosgvHh3lHjBSzBOktAIVv35bPW9OU5pi6a6dWETTbU6PAhYmt
 iCOLynZLtVyNrBGNiuXcyTQF/6IpeDcAlKzW7+aUbkOnu2p1tERXbAs3jxz77pGApT8/
 MbKZZX8QZThd99LPrnh671eUHGyUmT6Q51t2VlvnlxOjl6gu/wkNdDb2+x/gQqh3ceXT
 3LqX9lXgAak+LlkYETyEfqrOEYgVoNhUgJa8xJST1s0U2K+oDcHvI82NaH6dXVAataEx
 MfJ4SZop92azQTysXv+INzYaATy4HZHFrsFyzmkX8Ctpy09fNM7+EDlOyLNkdArxKbIK
 4XCg==
X-Gm-Message-State: AOAM5302QjLo3CBN9e17zdppnWVsTrLoR7B/OCVtkHHvOYT4ryRpLmIq
 7PSeUqaqFiD7QXr5hqAqP2AuT8iyjA5AHVN6/56ppQ==
X-Google-Smtp-Source: ABdhPJzGL5sn50LG2qKFF9Jfe1BWUV2XyGOu83h6OszyTuaKs1yLD17YVDf470dpZ9NoypOOF6Ej1btSQePLh/w7IaA=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr10088280oth.135.1593029125173; 
 Wed, 24 Jun 2020 13:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200622124157.20360-1-shameerali.kolothum.thodi@huawei.com>
 <20200624160834.5191b73e@redhat.com>
 <3375d8e35d3a481d8298ce3e6a4ce531@huawei.com>
In-Reply-To: <3375d8e35d3a481d8298ce3e6a4ce531@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jun 2020 21:05:13 +0100
Message-ID: <CAFEAcA86O0fWFR05TZ2bpdTNWW8q5PFanujMiCejfLS+HF1qNQ@mail.gmail.com>
Subject: Re: [PATCH v4] arm/virt: Add memory hot remove support
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
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
Cc: "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "mst@redhat.com" <mst@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 at 17:50, Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > doesn't pc_dimm_unplug() do unrealize already?
> > (/me wonders why it doesn't explode here,
> > are we leaking a refference somewhere so dimm is still alive?)
>
> Does it? From a quick look at the code it is not obvious.
>
> pc_dimm_unplug()
>   memory_device_unplug()
>     memory_region_del_subregion()
>   vmstate_unregister_ram()
>     qemu_ram_unset_idstr()
>     qemu_ram_unset_migratable()
>
> If it does, then we may need to fix x86/ppc as well.

In any case this patch is now in master, so if you determine
that it needs a fix please send that as a followup patch.

thanks
-- PMM

