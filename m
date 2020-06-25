Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BC2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906FB206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bt4s4Q07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906FB206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRnE-0000B2-Pv
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRmM-0007qB-7v
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:18:58 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRmJ-0001Zp-JK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:18:57 -0400
Received: by mail-ot1-x32e.google.com with SMTP id u23so5173706otq.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f6g8y7ZckUShav8n8cxxoZCVcK4tu3TwSv063R9jGqU=;
 b=Bt4s4Q074ayxhgpYgloGeim3whJKAawl6PmqZtl0Pygjilx+dbrxc/zz7YhWfcAMUA
 I5SRL5+ebvCAAX03eriLirJBSOZRBScWAJt6ieVyXJmwXnglNLMkQfy8uiMTOa+Dpd61
 trn2vvY5+oCJFUa06Y5W9wNgjMUONBv7vYvff5WWc4wDWfs2+lco0o7qvY59ndDv3r29
 4v1VRBwVUkZb7ekWt7cFYXwGrzu4jtFmWUea9NVYyq7lTGosPbk2PlSsSnUHu9WGQ8vY
 Nn8CBWHGaSNiwFUFXMzMHCDfo+N5ia6VhLTQTCr2Tzgp6lMEYjS4eYimXW4fFgS3jXUJ
 w00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f6g8y7ZckUShav8n8cxxoZCVcK4tu3TwSv063R9jGqU=;
 b=KIw4e2ek3mR/7Obg3XqAna1Eel00pGbmBijWAwyoN39Zwd3WaxPur/schFiQcBaW3y
 lsz/NfODY64oz1ke0tVSbOtvX8IDELYSArHwoPgtgLlxdslWfJy/lslQ24LWP8uA5jyX
 NbJUJm1xQpEDUr/PGhFq4zIdjjKTRBIhWrTy1Vl3UX97tUG6QJVC0cTHWlfddUHGGc1k
 GPlMMOEqwMEhC9VCcXwTROirI6HKajWlm9fQKeTTQuv789yLaexIop4/B0uXZsDe6So0
 p2ElLOg6e48Xq3J6vSQhXYYaBFJeFi0ln+qu+ZWdqjv7q4mQo1JR09U8zYGUfqXvj+W+
 bv/Q==
X-Gm-Message-State: AOAM532FJ10mRV1nFm24aVv0ZK7m3OZwNVOXz916WGX3eYfJxqBTjCO1
 fq1Ru3av08VV5gs0lMeL2pGeMY060XxbX82WhNkTDg==
X-Google-Smtp-Source: ABdhPJzkuVyE/A9Dm3YYVFDNfdI+mOpllBua/1pJiWAaLYYnIC+nHfP5+ta85A2bGtvw3+UuXcwZOWxV8zHrPGf1Bmo=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr26557737oto.91.1593091134339; 
 Thu, 25 Jun 2020 06:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200623072132.2868-1-f4bug@amsat.org>
In-Reply-To: <20200623072132.2868-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 14:18:43 +0100
Message-ID: <CAFEAcA8NP41n4NG_mDKLC-=e1tpcChotG=rot_NoHSdS=ENRoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/arm/aspeed: Improve QOM usage
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 08:21, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Yet another cleanup.
> Simplify aspeed machine QOM usage.
>
> Since v1, addressed C=C3=A9dric review comments:
> - Rename AspeedBoardState -> AspeedMachineState
>



Applied to target-arm.next, thanks.

-- PMM

