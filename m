Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF35C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81445207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJ8SVpGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81445207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQdYs-0007Dj-Dt
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 17:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQdXs-0006hh-V0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:33:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:41959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQdXp-00061u-2X
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:33:52 -0400
Received: by mail-ed1-x52b.google.com with SMTP id l24so7314163edj.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ZnUkXAqBH0fs+AGJddqaralR68uCNmVQhqeYC8IdQBc=;
 b=SJ8SVpGnd2chAQBj9j6566kUtmkjnq4GqUmKpWpPCRyntKapUNSpFOUAMshP6Pqbkl
 Zkltv0ASyJ/dS806XGAA+4EHyuPxoV1SIEK1VnYysR/y1ZYWz9ieYRf53L1DFzK//MAf
 opuJ2+ql21WcJ8XJRSX/+Jxogp9nVfgjIfGUwNMM9nRj08L3nkk8L2Ki8ifoF+oZJ71c
 rBxdMjeqqxaPd5L7mp73/rhgfPT/eBAfXQCCPmgCjgrb5FC3xAzVRYsaqUd+LUhf07NQ
 XfMX/OtHwK5QcP/A6erNCpttJSIXx+exwz3p1yTjr/+YNcpGc9QaLayWKyPGzzp8cOoH
 XoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ZnUkXAqBH0fs+AGJddqaralR68uCNmVQhqeYC8IdQBc=;
 b=gLJfyXfeo21Bjx2pGtiUk2AsB4OjhvNz1Q6eHvXRcCOBUgAeK1BDLX6NN7v0ZxFgZX
 1oIZDITIsx14Ipqdun3bLB/1WEqzhIqVidkfkzX5ROWX8dLx1U37oza0kguKLFHqdASd
 5DjAyj5bNAYSzRUJvKB34UFUsq+C5SvYMU4rOiDof1j2Y09xvUCEWo2uNYfXUGN7YVFO
 gc8yRfrbhOBj8wFGalqWdaFR8f6cy9Z+bj7cMbvXuYO1wh6IZGGl0qEOHrPc60JJiZR6
 NQ5eJbSqpuiEgq+/SNDEI6Mfgth5oiM5uUBM7aB43N+TEgGFqZzRCN8wHMM+yk71Zivo
 FaDw==
X-Gm-Message-State: AOAM531X65AjdlkifYzqi2YipGdDqxG11lKOa/rtNsMRMg7p5JrX8M+b
 gMleJmFZfnTaEnwh6EwoHoSxi/pw+hJruC+oraJ8al1PgKxy+Q==
X-Google-Smtp-Source: ABdhPJwXb2NmPQ6dnYbSt1LH/zfP4Y47pNHUXz9mimUQG8q7RDEEf6SdlQUhUtzvh1zOIE8Tu2ax+wZ/kK2coQviLyw=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr11735551edf.52.1602192826463; 
 Thu, 08 Oct 2020 14:33:46 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 22:33:35 +0100
Message-ID: <CAFEAcA-wP4NDc30WXVbWRZv3WDSNNjoxaeAA-rjATN_W2n5rQw@mail.gmail.com>
Subject: more findable locations for compiled/generated files in the build
 tree?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Is it possible to get Meson to put the files that are
generated/compiled as part of the build process in more
sensibly findable locations? I would generally expect
that a file foo.c should generate into foo.o, and
foo/bar.c should generate into foo/bar.o, and if we
generate a .c file from foo/bar.decode then it ought
to end up in foo/bar.c or something similar.
The old build system got all this generally right.
Meson seems to do silly things involving turning
directory structures into filenames, putting enormous
numbers of object files into single directories, and
I have no idea where to find anything in the build
tree any more :-(

thanks
-- PMM

