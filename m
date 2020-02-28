Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110B7C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF04C20732
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nzn478lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF04C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7i9o-0004Es-QS
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7i93-0003Vc-6H
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7i91-0001jr-WD
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:05:44 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7i91-0001iI-Qf
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:05:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id l12so3296735oil.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pgPpw1Fi1Ykytb0XJ7J0i83/eo1eMeohnndGMXJ4snQ=;
 b=Nzn478lV6//uxLU4vBnOVYB4TEPmTwoWgLu0CS0bEJmnqnDk1uYR9buiBB3cXea1iC
 JHtwwmrpp6G45SoDnvWEhAiWg1EvpSSo3q1Vdb5VFtAFx6vUpQo0wR25kujcdDlyC1Ag
 GUT+Sephc5VpDFKPFpUpAOLhEqTN8WdSrVY+yly9l6YPsJanhe/LHkKh6yzKjcBjFX1J
 fUR+TU3Ii5d6eUTOFFYYisMRn9hMGJDTDj9+CPu2wue8msgNepLcYi8VsEKDUe0+vrC9
 KpkGHGDwIGHVyLO7O9UHWKuIeT3aYWIqNikkvk6CQRADbEtWYUAiEye+VK29SLA2Ivhq
 Wzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pgPpw1Fi1Ykytb0XJ7J0i83/eo1eMeohnndGMXJ4snQ=;
 b=aRD5U5naeEBYxGArI3pe2iN+cNLrcOd25U4ChItkOjlDdYdbkoS1k95G7bLMeLfGyO
 z36+AJRJdckjeCVF7dxJ1OJidrKUG8Ea4ROM1B/diIlHVwxDgFluGtJYmDGSjHtwlywS
 Dxoo+1PtqyAUVfjq6JhN3GFnhq+h7I3nk1UK7GB9XaSqlZlOXngZc70G1eTEyY86k8lR
 KV7pkSl8RiffnqUoaLknhDR1LbCQXm3Bd6SDOf5T3WAItIhYH+drEKLp8EWfO1528ZPA
 Ak/+VMpQKZxfWoiLpOfYQvfFlCbqhrWCORALyjQfqsc8wm0F7sSDOaf96/n09H62qS7p
 noFQ==
X-Gm-Message-State: APjAAAXZ6t6cEQDUjEEsuOrnKahVg4vOhdPnBoZ9RoYZ/9C5Emexm+YL
 p+y+98utEDg9ZEVFbnAx/eJB56UblNCADKUdV4UDvg==
X-Google-Smtp-Source: APXvYqwR7A/gGBPp4hWEAzWPmOpj6EtQ0ncDJoQAHdABJq5fK2e3YOjEZo8e+fMMJrMGjdPCpRR5zk+2D6sYAGqapSs=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr3535113oie.146.1582905943002; 
 Fri, 28 Feb 2020 08:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20200225172501.29609-1-philmd@redhat.com>
In-Reply-To: <20200225172501.29609-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 16:05:32 +0000
Message-ID: <CAFEAcA8TmqGxjk9hSfFJ2AKH-9p7dt++kpc9WQ1kRzA73o-Rgg@mail.gmail.com>
Subject: Re: [PATCH 0/4] tests/acceptance: nSeries and integrator/CP tests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 17:25, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> This series collects patches adding tests for arm machines.
> All patches are reviewed.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   tests/acceptance: Extract boot_integratorcp() from test_integratorcp()
>   tests/acceptance/integratorcp: Verify Tux is displayed on framebuffer
>
> Thomas Huth (2):
>   tests/acceptance: Add a test for the N800 and N810 arm machines
>   tests/acceptance: Add a test for the integratorcp arm machine
>
>  MAINTAINERS                                  |  2 +
>  tests/acceptance/machine_arm_integratorcp.py | 99 ++++++++++++++++++++
>  tests/acceptance/machine_arm_n8x0.py         | 49 ++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 tests/acceptance/machine_arm_integratorcp.py
>  create mode 100644 tests/acceptance/machine_arm_n8x0.py



Applied to target-arm.next, thanks.

-- PMM

