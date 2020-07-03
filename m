Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4392AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102B420760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwpba1dC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102B420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLha-0000Zx-Bz
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLgr-00080c-7c
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:25:17 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLgp-0002CN-LK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:25:16 -0400
Received: by mail-ot1-x341.google.com with SMTP id 95so16043720otw.10
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qTMpZ5M5QQeSAk5YUXOyZrf1KpZpanRokddJ1f0sX3w=;
 b=iwpba1dCT8WZrWE22viM33u9ufCvlTsI0GFo0h91yWtzuTBTyG5a8/yf8/FKAa0oTU
 rdtoDUAPoMNfftqUdulWmQcg3J1tTirr7IJr8OT6pBMOIyrZ1iNpNIgEIoH4KKNSjUkQ
 8qHkKyDrH201CUYPN6hdUgNRh7wUW8HZw4gC8zb3kfURD7HmBYgzGWF3eEt68QLgMKSF
 btrSfogZAAGrUxR6x1qXFTyh9jEe6fl12J3s7zGV3pdanmgIOnQ6TI76LNZJmk1eSikw
 PobVI/8ohVwH1pC2RDsRo8RXWW5pcZk8MXMU8yC8dEsqvygva+vJraMpJL+R4BmYt8Hu
 94HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qTMpZ5M5QQeSAk5YUXOyZrf1KpZpanRokddJ1f0sX3w=;
 b=chbLtouce42hf2/K4wzA1f3aZMoVHuqLC2S8N8wsQ4E0IgwL36Blg9WagRLUlP74fz
 4n0eA+eSL8FOcXfzyZU+wtKmioCcm/spxps8HsfYFkL8VHJJMMqIadWkPMwhXRjT6E+c
 e4UN6eeGdtNuyKTHB2YjDPSKt4p9qPSSJ3GdCmEOHc49HKn7eZR1jHSn0QrBYqL0H1BW
 h8gsF8p0fxQG1L3CBTPiX7Hsap6J1pyfv6Hs+7yG0yPPKV2jKwzqnmNVk4oWCcIg9aKz
 ciDKFNwkgIryNSEv8f4vHFk7JOmOOZTkRt3bPInLdDdttiFaehFQCwUmwd64DAqVlO0S
 dbUA==
X-Gm-Message-State: AOAM5312HdvGjqqMhW6F+XRbCLVcXA/EdEM2KNByktO6qPsV/FvHavOJ
 P72c3YQqRxCYrZ1YmEj+vxS+8jSy+gKwID9nP1tC3Q==
X-Google-Smtp-Source: ABdhPJx0K6xtF2mW3TYrDPRjaS8VdKIvt+phK+/ltreJTQ+T2n7g8iH0ioW+qZNuRe6IqJRGoEbPkJO9pkZ6qgvHV6A=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24474006otk.221.1593782714681; 
 Fri, 03 Jul 2020 06:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-15-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-15-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:25:03 +0100
Message-ID: <CAFEAcA_=UdAqTkFiquXgad3CVEF91=ijHaALNkgWhwvy74Fz_Q@mail.gmail.com>
Subject: Re: [PATCH v7 14/17] hw/sd/sdcard: Make iolen unsigned
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> I/O request length can not be negative.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

