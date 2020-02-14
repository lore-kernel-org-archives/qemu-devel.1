Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FCBC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ECE222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMbGZx3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ECE222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gl6-0004Ty-Cc
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j2gkJ-0003sO-Q2
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j2gkI-0005FS-Ky
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:35:27 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j2gkI-0005Ed-D6
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:35:26 -0500
Received: by mail-lj1-x242.google.com with SMTP id q8so11913935ljj.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/FNFc7xZutUXvShMEwdkK3qXhf9yUhDE95gYJZu3dGY=;
 b=pMbGZx3LQcctML6kRyObJKqgWxADu9LFvkepd1JT3ZqIsO0ptzr8h8/D71ZAMG3i/S
 nnE7wxX1ETkqiidf9fqFYN5Z43ghcQ5L/x8PtZW1dKfZCJL0Q0fIQr7UlUw+Yahjvpbd
 Sm7w66Rz+gZ/DNu/VPtbvoFYfxi8f1KQ6tyr2QOPlqx88zqK9pXY0oZjYdp7oU9JdHMX
 4wqQu9ZhO9wR7fOJzibeaW/o5YDmZ0tc5CbeCnj3OsRdq8GBmoba/mvDRfD/w6JOmGTj
 zGLd1W+eT4F3WF0TeWpNUlTEAiZi0wyc9kXmW3nolyR7kYNkIgDJeRLyWY/DgPHNn1bO
 Zq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/FNFc7xZutUXvShMEwdkK3qXhf9yUhDE95gYJZu3dGY=;
 b=DT5RNxWUiUpi2QXWOrYfAABDqgkp6GJpAfdzmpOv0XKmttAeFSF1i35sSae4rLIrdc
 ELFL3CwnhdLdl9FrTXwtyZ5BFA+D4NEf2O2ZGMfRBAkIvwyNyxxnX2ywMWdQ4p56GNVy
 6cNfhfdV3ii6jlWL08s5zStOYsydGpB1qwq68HtViJX8lC/oES8TenELAqNU9EdrVD1B
 j0fsddbdv2SWChcS7yh6KTXoPtCqxV0Z2oRxY+uitvX30KGhq8qK5KAgU20aJMmfJclD
 upUm8fEF6ieIxnsylEZIayS9znDweF6kwIwKlHBxSovXqKkxsCXeMwxj+CayOBFJBAsn
 4zqw==
X-Gm-Message-State: APjAAAVrBmncuq3c1MnkSBg4BXDhHLrp9YqIxe4bvBTFJ1qT8Q8iNHVV
 RhWvQuGPTbnHgLFOX4ruPNAuexNZhKfOkbX3KQalfw==
X-Google-Smtp-Source: APXvYqyKmfswMeY3rNopXi++mbmfe8rqP4erI73H3WBjXB8w5lW/PqVQ8n1tJ7+lvOcwrD2tr6MeYGIjpWOk5jm6dt0=
X-Received: by 2002:a2e:9955:: with SMTP id r21mr2939937ljj.283.1581708924665; 
 Fri, 14 Feb 2020 11:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-15-alex.bennee@linaro.org>
In-Reply-To: <20200213225109.13120-15-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 14 Feb 2020 14:34:49 -0500
Message-ID: <CAEyhzFs2Ge7zb1CfByWBfatgB+mbwndMwKFFsEZ=vbALMUmxYA@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] target/riscv: progressively load the instruction
 during decode
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: fam@euphon.net, Alistair Francis <Alistair.Francis@wdc.com>,
 berrange@redhat.com, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 robhenry@microsoft.com, f4bug@amsat.org, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Palmer Dabbelt <palmer@dabbelt.com>, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, Peter Puhov <peter.puhov@linaro.org>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 18:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The plugin system would throw up a harmless warning when it detected
> that a disassembly of an instruction didn't use all it's bytes. Fix
> the riscv decoder to only load the instruction bytes it needs as it
> needs them.
>
> This drops opcode from the ctx in favour if passing the appropriately
> sized opcode down a few levels of the decode.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

