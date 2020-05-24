Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B026CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D30207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNxaD2c8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D30207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcqfv-0006Sg-KS
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 09:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcqf2-0005g3-G4
 for qemu-devel@nongnu.org; Sun, 24 May 2020 09:27:28 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jcqf1-0005hd-Gb
 for qemu-devel@nongnu.org; Sun, 24 May 2020 09:27:28 -0400
Received: by mail-oi1-x243.google.com with SMTP id v128so13942836oia.7
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TdGCLAkPEtn9FVvx/hEI+xO1c5a8MG1ZLDpElMnNnjk=;
 b=UNxaD2c8qV84hWmlfEEF4CYb0Z70GZ4uUzDk02jHpR+0MQd7djIB2jnSR0VVyKImKD
 sjmHybvIUVjKsilpYDGa+hnkPqLLCv5avlbvL27EJ0wSG80zmhCcJr3LBCD3PKmc/SiJ
 WHr03jgNkO8BD7arIXlB4V69bg1w9HnXs1NvmNvWHBaYv0vN5SIS0ZHT9ZkKejWJoC8K
 GkZ+AeX+LKKjp6O6mEbxan0/aJ9DSwIWJIqRXYCZ4163WjVZz0QmwA7B4FcLKmHz+EHd
 D2Crc81afPC3bWPNVjdv/X6r3Y6fHvJab3TG8o/k3tACmkN1rWO4AwNmP851Hi9anxNB
 t13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TdGCLAkPEtn9FVvx/hEI+xO1c5a8MG1ZLDpElMnNnjk=;
 b=qC5aCBGfeyacsYj0l7dy+L/blUvoHITQLhSAe62ZAFsRyXAe+WMDZ47qsMOSTMOZDE
 1vkDzE1z+mvTGZKotEymAmBXBs/yVtkWFPZOPrS3Z2RhbwPfSGNYsVbp6vXkyOaybakR
 OCtW6RRjvHx+rgSQH2S2XImbE8q/A8ex4ZT561e0dey7MqV3StUB+nEiDO/CnvTehhvS
 ZSrlUs3d9ymuoSSthR0LwkTqiNQ1ltojMEdY/2YY8k57C1kgFqy0itpAncwZpi0yghlj
 TyKtmYUtuDf5hlMwMOmqziw86iQxBIoab7nF1LUogXsiS6SZNwXLHfWrFc6U4m8Lsduk
 FCEA==
X-Gm-Message-State: AOAM530HMtcKOcrLQWVq/yBKFAJPS2z/IyZGQ/CPF5CXSG4kNtpydfFI
 2AOzx+HGHTJjbmg/RKMyIj+yQ87PbBqKkjJTYUbocg==
X-Google-Smtp-Source: ABdhPJyRY5oPpvgL1qRSmLEi0TO3H4cU0bTxW7iDUS7ZnYicgoHitpvPXdVrzj0kF3zwNgIb2Js+z0G149xTLmS5/C4=
X-Received: by 2002:a54:469a:: with SMTP id k26mr3482104oic.163.1590326845233; 
 Sun, 24 May 2020 06:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200523232035.1029349-1-peterx@redhat.com>
 <20200523232035.1029349-2-peterx@redhat.com>
In-Reply-To: <20200523232035.1029349-2-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 May 2020 14:27:14 +0100
Message-ID: <CAFEAcA9jq6UbaZAT-itF5Kswy1YSAocKa8mVVh0hNF7DuLGBqA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/11] linux-headers: Update
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 24 May 2020 at 00:21, Peter Xu <peterx@redhat.com> wrote:
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Header updates should always include the upstream
kernel commit against which you ran the scripts/update-linux-headers.sh
script, please.

 linux-headers/asm-x86/kvm.h |  1 +
 linux-headers/linux/kvm.h   | 53 +++++++++++++++++++++++++++++++++++++

Are these really the only files which had changes? It looks
a suspiciously short list...

thanks
-- PMM

