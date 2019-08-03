Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF316C31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 10:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4762166E
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 10:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPOMD/OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4762166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htrEa-0008Cy-HO
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 06:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htrBJ-0007Y1-HT
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 06:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htrBI-00029k-Gh
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 06:22:33 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:35602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htrBI-000290-Ap
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 06:22:32 -0400
Received: by mail-ot1-x336.google.com with SMTP id j19so4058245otq.2
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=67o3MNZwgMH7ddhJ40svliXMQYW2rKlnxPQztwSGnyw=;
 b=tPOMD/OXxnQqlkg0biiBEGJ9eOES0bg/lIiqdJfbPNzM/u5WSEyw32pYlX3NrcQufb
 HijMPvvHk8741QLkzpGcTZVDg3f9Y/IkbP2eKjubH9IdDaNsApVMp1GSTJ7I6SPHnSDS
 GsMC68YzwZDxzU+BhHtAnUrkkA/qlaijHDaX9+IyiPF3aLu/6kzIKxsPYyAkY2DsY5UA
 QP8g+OrxA0+C4zyihYlPO73ZbvxcLjldNDCpTvTA1e5HhBzKYmL39kRG1NVxPp32xi0z
 xh8ma9zo7J+cS7dIZ4Y4OQ9XXD0VCCXmaoYWATIxV0hO8zdiJcgdpovlEra1QmzieWkz
 nnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=67o3MNZwgMH7ddhJ40svliXMQYW2rKlnxPQztwSGnyw=;
 b=WtOp5BnOLMjVNZY5hzxy3b88YerI9rts0g2pQCfqy6by9FyHxtE6Vsz7Ajx6BQM/pv
 u498sJ8fEexwjrYkMpfz3h9bpUg98HWKFa4jozcstfXF+T+Z5/DF2zEfjqiYhB9piqTN
 tzE6Sq68D13tnzFUUUB+jkQJ7k5HEpumuQPHWBlZm/HkZwojgP9JW5BBLBBvnC8Bc+c+
 vQbDuTY7KPUy4NWbCYZKM+3sifw8U1ABPrfIPiJUqHeSSBEMoyxXmTR7wpMUfLFUZ68a
 Wgjq/LQakoY27Ptz3Mbuz8N8rlBd4Slv5K1cWFceg9GWUtkKNmu4LZI0mPqJTPM5r8w+
 DnOA==
X-Gm-Message-State: APjAAAVnB358C+IXZVrT2LvsF+N91CJxD7GlxUPpeUTUkmw9SXnM1oUG
 tuteyds5tkFt5AXxdQWTaxz7wcCUQ3gyjZyAp1el7g==
X-Google-Smtp-Source: APXvYqyRKLFIybCtJzzYvzm8xBIVV271TXPOn/OOA4H+nBBbyQw5UekVXiHgfWwxKjj7CNBfMZ8M8ZQZJZVuepfk/aE=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr12686499otj.97.1564827750190; 
 Sat, 03 Aug 2019 03:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190803082517.15035-1-philmd@redhat.com>
In-Reply-To: <20190803082517.15035-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 3 Aug 2019 11:22:19 +0100
Message-ID: <CAFEAcA_cPDdwXkSra_8vxE8c9M2y91s5FvpB7sZh12xF-LPUWA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL 0/1] EDK2 firmware patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 3 Aug 2019 at 09:26, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> The following changes since commit 9bcf2dfa163f67b0fec6ee0fe88ad5dc5d69dc=
59:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-CVE-2019-14378=
-pull-request' into staging (2019-08-02 13:06:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20190803
>
> for you to fetch changes up to 177cd674d6203d3c1a98e170ea56c5a904ac4ce8:
>
>   Makefile: remove DESTDIR from firmware file content (2019-08-03 09:52:3=
2 +0200)
>
> ----------------------------------------------------------------
> A harmless build-sys patch that fixes a regression affecting Linux
> distributions packaging QEMU.
>
> ----------------------------------------------------------------
>
> Olaf Hering (1):
>   Makefile: remove DESTDIR from firmware file content

Is this pullreq intended for 4.1 ?

thanks
-- PMM

