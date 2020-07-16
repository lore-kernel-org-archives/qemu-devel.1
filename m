Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16027C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D412071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTP1LJsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D412071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6Td-0000Ya-6L
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6Rp-0007rn-5p
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:09:25 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:38982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6Rn-00070j-9j
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:09:24 -0400
Received: by mail-oo1-xc44.google.com with SMTP id c4so1278786oou.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9FkVEsF0BHxFABiA7vfz5bbXl6mMie10ZHf6+p78MUw=;
 b=jTP1LJsyDpy8Jf/TSnRv35YhPCgwIO4oq4ExRMCKWwcQQqVOZsC+EvgUj/BTMZoqsh
 u9RfytDTamKaDEWgdq5FkSUnRaqVShg7344zS2u6Zn1pq3FvnDrwudNhBwKHsgKcW1Ds
 cHyQZ5jcQMXbDPa/psSnhAMW/6nRnARXtXWyPF2Ylq7ZX73o+kWR1/WiDUH10Q05xRF+
 BwpSPZFhT2XftrFlpc4410vnrkxag4MBbSY9dYydU+xxioXLZzWA1UHM6A64EMmVd7bA
 QX/1gJ7MYapGUJ9e+z3zsX2W6TuQXNOKpBFhFEnHm/l3c6scVpM3yWr0XmQkLUaT7spL
 J5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9FkVEsF0BHxFABiA7vfz5bbXl6mMie10ZHf6+p78MUw=;
 b=kbCvjdpbqDuDI8hKyaFYhL6EmIO+X23YW3X5WzB/Oazk7G1Q1EjsAgnLltKCJL4N9W
 P/nBleQN5mPKjiVZ5HZ9CXYKXFaJUvDIrBD5xLG0p2ETSx9/iGglUa+ufiANF70RiOEN
 4cz69eduqoZ1EKOFmMsN5qbq2bKPEDPX0q5tHnyHAXHYUDaqewHyHuNNhVYycKc0AZle
 cCLkYnBm6w/xIDCW0QFX4/4ac++ctV6CNgMESDWFVXkjjWE2bnenGKOMEv+8kC1S+030
 uB9F9ValyKATdK6gUcqWCAJDlzIyRGSzv5Oglqzu27yM3yJlnRvXDZbmzh9nn8l3ofYZ
 hT4A==
X-Gm-Message-State: AOAM530IOd3fDJ2HLxg2EmbXlwijiV9XaseiwxfqeEoBQb0CiKk3Dvg7
 oqcd1IHvlUX2yHAGaSIAfrvM0J9KBYXzk7ouuZolJA==
X-Google-Smtp-Source: ABdhPJwOVuLgDegdYwh63u/WUm8+4RNwo+rGH2jDL6XhiVYWLhEUsRCkEiTyFnWAx+8oyefFZvf4oPnxqGH/4aVVcEE=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr4856087oop.20.1594915762123; 
 Thu, 16 Jul 2020 09:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-8-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-8-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 17:09:11 +0100
Message-ID: <CAFEAcA8e_VJjFKQRogdD1g0Zd8YQN4vkm45aBrpB=F3kEpo7gg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] tz-ppc: add dummy read/write methods
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 13:31, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add tz-ppc-dummy mmio read/write methods to avoid assert failure
> during initialisation.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

