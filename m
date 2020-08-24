Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D70C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDE1206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8XuKiK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDE1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAEBV-000684-Mw
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAEAa-0005Za-L0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:14:00 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAEAX-0002BC-Mq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:14:00 -0400
Received: by mail-ej1-x643.google.com with SMTP id d26so2280202ejr.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o1hp5ea9CfSb/8w4fDY6YQAGjA4jnE4ZEMfGiFwFsuQ=;
 b=j8XuKiK7Qgkw9N3tr1IGSDw07tVyEKnefMHoGLDlX4ev5EF0RMcepxICB62X8aql5n
 /KLVqg5httwwD1iABvPVd2t4X5VGz/pyOzftTIH09TgQoRi03ckprXb93OVWHOdBesFz
 4Hl9jYpXQjjvnmzceuriYtF56c/DY8nlrgAu7RB23i3ueZAy5njUn0F2lx81Xckq8L3T
 aJnQzgL6rOqwOrgzjkoegZwU9sHQ7ysV+eghmcguSNhUQm9V4QfVN37JCsRUlA+gb5U0
 H+FD1cwi3rdiDyKh3/sfDDYQ/ue2F9ihDVFUDhsfs6A8vwVGQGzkWc0HEFVb/Zx69hAy
 Rkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o1hp5ea9CfSb/8w4fDY6YQAGjA4jnE4ZEMfGiFwFsuQ=;
 b=XbXY4ZkTcUZHKPrjDhBP3hCACgMvdqdkvtoLnkyx6XWn2bQC09TnSfdMFtZD0qA63t
 ducpPt3YOGbwabUOTHUgqVbCh+mLFbwoywWQj7N6QI+L0IepoyJe+KyNHfydoDItw2h+
 uuAIktkc3a9nRpOTiVjBwvWsidkjWltSk23TIH1qCDXx7EI1b12HcDLHdAKpIjPfzfwW
 fdoo4VDHaEh7Z5fmyyE/BRpIOjiChP0JFQLxI0BU074qCy6H83jQj0YW8DnPMhV1eisz
 Wb4UbOYut2+BZv2rzkxJdiKhDi2qnYvvqa+4d64mD2i1MwWCw4kPZglwn0+BLKXq9AuC
 OnCQ==
X-Gm-Message-State: AOAM531hvcg3Df6iA0Shl4UKFV/kmN1S9j0IGdk+dzg2x5lo4KuyKMOz
 Qg3GbNSdTeJwaOUn21PF6aJGXtdkdIJKG289FvtjDA==
X-Google-Smtp-Source: ABdhPJwUJTcvdtzAB2aoI3R+dGJrq6Xp9+PkZgKwb1V34rbd75VMJHyE5qDhVpPQtuxkIfSMomD/JfEcvm3i4/gK7ww=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr5918546ejr.482.1598282034292; 
 Mon, 24 Aug 2020 08:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200814125533.4047-1-f4bug@amsat.org>
In-Reply-To: <20200814125533.4047-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 16:13:43 +0100
Message-ID: <CAFEAcA_1TqGN2inYvyWZRYjXadmioQ_H4UyM2szoZAnn8rB4bQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/musicpal: Use AddressSpace for DMA transfers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Aug 2020 at 13:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Allow the device to execute the DMA transfers in a different
> AddressSpace.
>
> We keep using the system_memory address space, but via the
> proper dma_memory_access() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

