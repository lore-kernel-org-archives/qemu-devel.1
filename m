Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD923C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884F7206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3zAOCnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884F7206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5wp-0003nE-PF
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5vz-0002Ya-7u
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:02:50 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5vw-0003Y1-D9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:02:46 -0400
Received: by mail-ed1-x541.google.com with SMTP id c8so1354390edv.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iMZrEZKXjCIFEtYK2ltrm7qy4+QL6LNzUVQ2d/yVhyw=;
 b=N3zAOCnplMf9fAZhZAu6gGjFp+gdpQ4gA2fWvwW0vabF8ldXAw+R0h5hc8AkuPA+Fg
 Nn5QRU2zq0qz1W0QtqO4xQzYwDsq+HsVWNffqtNTOGRYpf4DsUPSi1XSik8jrXNRGpHu
 grdUVTPrCMAyjFHQ0uPFFnwzEGNF/XycO7CTQ4DhhENhDnJj2WfT8GvJ0fBzGjKAQLth
 2k90A5OuQgfd4hazm76WnzRv1CDfyTJ84+lfx9X5ECAtvl11fLkx7+VLUneyPAX0TTUa
 26xzgjbxd9ZiBdpxCrKnsscao7TwCXhf8epSjoaeRldMzfODOcSmLAEyZsApDXqZa/qs
 QtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iMZrEZKXjCIFEtYK2ltrm7qy4+QL6LNzUVQ2d/yVhyw=;
 b=T212evd980/m+UBlFAuESYyFQOpW0j7TN7Yd2YGPqrJKGSw6FfTRJJOh8FG7Z2ZsAK
 YGbQ3So7CzcH9F4wmTJ9qmWrDb/fh3zIzCiLWAAwQd+tkQ+t9GVshQmoJbQuaG8HrEnf
 MpIvm0Wp8U+/oTTXpaY25cD4UDN/rUxf6UgNy9VMPOLA8jNDHhHtTAuLDjyT2TJCjmoH
 hLLLerz3JZ1+ok5Gh9NbVYHdyxgE2T5Ke2NVtcG7VBE1tSFRuptS9wRTpavX3qKmOW+c
 q7DnAEmBuExoTKM5JA5qQKmGVttoQE8GUXnA6WJqiM8sVeHLEcG3INVPjtjgEVQUuN+v
 ZPlA==
X-Gm-Message-State: AOAM533bCThTF+QEPTB2L4fRRaOzdbI3c54A5R/vvpXWWih+hmeJTKou
 jyEZ9qZerUT8bbaxqqFtLvXaEznBbITSwNApiGYI6Q==
X-Google-Smtp-Source: ABdhPJzrnbxS9isRX3Z+TgMgj3Ft6NUFpGHRfj6G0hXZ0IaS70Id3yvSFqDzKRDZHPPCRZ75pC39NfysFu1FA7hMht0=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr1669768edq.204.1598965362824; 
 Tue, 01 Sep 2020 06:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200826141952.136164-1-graeme@nuviainc.com>
In-Reply-To: <20200826141952.136164-1-graeme@nuviainc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 14:02:28 +0100
Message-ID: <CAFEAcA8Kuk4XZ6W9D77nVphH=-vaFF4ciDOJmUTGSuckjT8=TA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add an embedded controller to sbsa-ref machine
To: Graeme Gregory <graeme@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Radoslaw Biernacki <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 at 15:19, Graeme Gregory <graeme@nuviainc.com> wrote:
>
> This series is to an add embedded controller to the sbsa-ref machine
> so that PSCI can communicate platform power states to the platform
> which in this case is QEMU.
>
> v1->v2
>  - broke out the EC itself as hw/misc/sbsa_ec.c as seperate patch
>  - applied review comments to date
>



Applied to target-arm.next, thanks.

-- PMM

