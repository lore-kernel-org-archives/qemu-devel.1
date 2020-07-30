Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E417DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7442084D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFd/cDKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7442084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1FTb-0004IT-V2
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1FSQ-0002yT-H1
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:47:18 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1FSO-00070i-Gj
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:47:18 -0400
Received: by mail-ot1-x344.google.com with SMTP id o72so15533312ota.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=clMIo+lUj5/CKd61OQMVlCao7HwZk9bWyZ1KAxmdVq8=;
 b=zFd/cDKDtciNl4hStC3++xrFLYpy/vH+vKwOMLJW/URxn0Gvw4TIOmUYwh2l5cUhUT
 xxWedjm5Itq3R34efSiF99peisoxivn2nAvKKFEutgvXf3GdeA2DnzmosNHi2U/ahsKq
 RbTH/jUJJ2wD7koU8q2Te09anag36Kn/Ngv34UaOEx2LrXT7r32eb9qPTqP+q5chd7OJ
 +64PJA5RyxmvOWXwo4Ro0p1kfrpvberDMXCYfHMJKidRyCBFLinDSm9LBPaGJt0mb9rm
 AqJ5i7jU8vWU5u6IODv5PKT0lxLokfcAYXafEHALssjjUCiA+vrkdvvIO+cmU3Er2tk6
 5nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=clMIo+lUj5/CKd61OQMVlCao7HwZk9bWyZ1KAxmdVq8=;
 b=GFgddIRDN8xEboIT1mi1ZAWOCdn1zQYiaRkDeVN6Zd9w0QXR8LhrPhHh2S+3v1YHKi
 3TYg2jyQjc0H7DmQ1lwsaIlrdl0iZS1QFo+Gx608ypDKHFlLacZlNQRybDClsaOGSFom
 wmncFNG2hScGRiqRrH0/z7IdBgQFBGXWmGbOKbjYEm9yeE9EGlrFlAaBQbbA1txrxv1L
 bfG+CsXO7mlWljOr8nSogDqWXGpxvPWud1ZeJGCW7wfVp1KMlvlQXVLXfRSnhbRtoCdW
 3CCEBZ4TV/KgBEntm/KGN6ECzcqADBHMf14AFIdEodm8yDeiNcpymU53C6jN9kf5yuUK
 O/Zw==
X-Gm-Message-State: AOAM531uI9C2YR2L2qXVCZNnDy9hDd2W3PT9+jItpOgfen5PSfYhcfMr
 e+YU/TBiSxxUSHnkITtbvIaiyRKzmjZ7kPscZFD/oA==
X-Google-Smtp-Source: ABdhPJzRFuA3RcjK+JCKZ8uXJ63fWoxCQ8cAOIzVVrkbnOIioUStX4B6vX8ZmCb+smJLLiUWBoyMV3KIFDXt6dfdS7I=
X-Received: by 2002:a05:6830:151a:: with SMTP id
 k26mr378426otp.363.1596142035292; 
 Thu, 30 Jul 2020 13:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <1596110248-7366-1-git-send-email-likaige@loongson.cn>
 <1596110248-7366-2-git-send-email-likaige@loongson.cn>
 <43e912f0-4383-93c0-ccd7-204c7eaf9850@redhat.com>
In-Reply-To: <43e912f0-4383-93c0-ccd7-204c7eaf9850@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 21:47:03 +0100
Message-ID: <CAFEAcA_hoiEBjvUnjLPUxgJbo0hUk8JPwmGaV7-iyTQGJw16nQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/arm: Fix compile error.
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Kaige Li <likaige@loongson.cn>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 14:17, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Again, what compiler / version are you using? My guess is you are
> using an old GCC, and I wonder if it is still supported.

configure complains if you use a gcc so old we don't support
it (our current minimum is GCC 4.8; Kaige is using GCC 4.9.4.)

thanks
-- PMM

