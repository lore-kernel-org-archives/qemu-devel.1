Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21685207D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYyWDsHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21685207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahJ6-00087U-B2
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jahH9-0005u8-8Y
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:01:55 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jahH7-0002fb-MK
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:01:54 -0400
Received: by mail-oi1-x241.google.com with SMTP id o7so9238515oif.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kAnFLR/iZLNvMTVRqFp6K8khL813q1hzXRqbt0f3Ezw=;
 b=uYyWDsHhWakQ+eALy/4A5EXpFnmCnF5FKCoMDVVLaduW2BN/HETk3+JdYe+V51EtHm
 0AMbaHsz0039oarI6yDx9WTCpRjgjZQt7YW7r209kWYPIje7pY+jY2IideIHioT1FTvu
 M2FycW9lC+tRQyAsV+YOSxei7jqnwY45G/6Qakoe9rxFl0u/4L3k7x89/4qbdwxM4sTZ
 2slo4nFiNpjT+IDFlRott+wa292lujaHLW0+BjOGO316bPrmJXLdZ16SRt2IiZJ1AWVT
 g0INCzw/Im3fTJ+XuDP2z3SPUJTFDbiGtAtX8HosX6YJG7K3P5wiEZWFT10LWXKFnbCD
 JZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kAnFLR/iZLNvMTVRqFp6K8khL813q1hzXRqbt0f3Ezw=;
 b=Rk9mU58q8AJniUk4+f0/xr1zWFhPHLP9oNg6o/uWQNELvy5199NmBk7NsNXqFruUnT
 zIHjNmnBb5CbNfD/5zzJUnBVVxKrw38QIXS6fscg1no+3PQ5ciD83Yi9X9dN5L4EIqok
 qzzJV0rLFtaj87VNyEsNqiHv7opcyaEhnvxm7ksOziwUml9ESyxu+A12JlHoXWhf0zB6
 CKnoebtScEenFpaX1cN8S31zlqjDLGXS2Kx+rrGN/Ryjh0angXvReTgENIzDZPmMaYw5
 36bP7C2VVKhzZkuJRInNoD3FnMI74kj3yox0MVQNvFZXuSTULG4Z3imbFrSYSeyZHIIK
 Oqrw==
X-Gm-Message-State: AOAM530iTxm/uReAbDi+Tsbk4c1pAvtDZq5qoiFThnfUgMm6ayP7y0fr
 qpIq6KK+vD9auVnIgeXGZ19Y8ZEQ+grVXNhoeqskIgZSIsg=
X-Google-Smtp-Source: ABdhPJzP5gXV6HhxA9USH8N7avaZv9BKQFBqxbuLxOIo5T3fgJ2o7c15Kf6yxz3d7N/2E/lOuLizFZJS4O3w+2QbwEs=
X-Received: by 2002:aca:895:: with SMTP id 143mr11175682oii.163.1589814111302; 
 Mon, 18 May 2020 08:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200514190422.23645-1-f4bug@amsat.org>
In-Reply-To: <20200514190422.23645-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 16:01:39 +0100
Message-ID: <CAFEAcA-RFEQvAr_Zvu+z5Es6X2vpDTo9_YCmb9Hqc+iqLfeK0w@mail.gmail.com>
Subject: Re: [PATCH v3] tests/acceptance: Add a test for the canon-a1100
 machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Antony Pavlov <antonynpavlov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 20:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The canon-a1100 machine can be used with the Barebox firmware. The
> QEMU Advent Calendar 2018 features a pre-compiled image which we
> can use for testing.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20200129090420.13954-1-thuth@redhat.com>
> [PMD: Rebased MAINTAINERS]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Thomas asked me to watch for few of his patches to get merged,
> but I missed this one.
> Peter: I suppose it is flushed of your REVIEW folder, so resending.
> ---
>  MAINTAINERS                                |  1 +
>  tests/acceptance/machine_arm_canona1100.py | 35 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 tests/acceptance/machine_arm_canona1100.py



Applied to target-arm.next, thanks.

-- PMM

