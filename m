Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA52CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B78B24125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="dCvxxbIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B78B24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48FT-0003t3-MQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1j48Eg-00036K-Nl
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1j48Ee-0007XN-43
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:08:46 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1j48Ed-0007Tr-Or
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:08:44 -0500
Received: by mail-pf1-x441.google.com with SMTP id s1so11111717pfh.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=y1yweMyAnFLAEcb3Lg5dXjOcfOHy4NAuPVv09AZ8FnY=;
 b=dCvxxbIzQe1yCD6yVioHMLY7OvQ55n8MPrGIg0wk+aPPrkYO7I+NpjZ0/QLBe2Mi/F
 FK7/4p/3BACaPwzkNNIacKJQYYJFxrLe1WSpiQEmjwhmv4RNxDk3wXyI7UQrl9/EjVwh
 XFPzYeWbmlvxepgdpnYPldAhXTY9qEy4WgC0uQ469+cZ5fUIVJqxAD+3apx/rwWoROPQ
 pmElmSngu9eejM00M+z/WcxqwjIB4Wxr4V3tkRDkaFLoKMTdPm5w6uaoKTocMmjG1BC7
 eJl1Qcjqy9ge/ll8rrpGzkh41lYJz6nrWSHf0NwLDjFjPTgMICQCPgi+VFXeWTM7jO8R
 FBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=y1yweMyAnFLAEcb3Lg5dXjOcfOHy4NAuPVv09AZ8FnY=;
 b=XUKSCMYqR0ZYtMtBoqEpE6+2RITh1y4ojfoP8jWCLm18+4Mvj/T96t3M7klu5OH+aI
 K5ob3Fp8OTKyHEGddVUhcl5/ovK/+cQq5IA1jUiRCyFtOdNzW597SspUoKid5J+dE8JI
 JDfnZcpan11pWTwDi2TqeTOdx909BOxOniRE5IM17abw+UJGa1Q8RP8QUajGuH9AVwBX
 UxLGTnT+8pXza48HCX+vO25a/YJU27aXEoml8//q5Uw8hBWJt0r1Zi45Qr/MihNqOJ11
 2sUqljAv97fM2WPb7JdcUuql7O2vxoUFQ/r9M0uIFanPh9jSPoWwYNdYFC7TEf61lhir
 cMgA==
X-Gm-Message-State: APjAAAWPT7e/ETz2C7IR+CVYPjD8dxMgv3BsQEOqVagMHbGLOmh3MoOo
 FARXVAxTXn7pfhqqxczGZbaZsw==
X-Google-Smtp-Source: APXvYqyXqh0FZJp8c3ODQwvjM1apH5TTcDCwuuqXGPtDNDWCI6YZCShY5YzAIYLUHN2El7epFGZHJw==
X-Received: by 2002:a63:5561:: with SMTP id f33mr24499873pgm.14.1582052921952; 
 Tue, 18 Feb 2020 11:08:41 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id g13sm5314651pgh.82.2020.02.18.11.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:08:41 -0800 (PST)
Date: Tue, 18 Feb 2020 11:08:41 -0800 (PST)
X-Google-Original-Date: Tue, 18 Feb 2020 11:08:34 PST (-0800)
Subject: Re: [PATCH v3 0/2] RISC-V TIME CSR for privileged mode
In-Reply-To: <20200202134217.14264-1-anup.patel@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-5b433044-9056-4323-88ce-626a1bd2c128@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 02 Feb 2020 05:42:15 PST (-0800), Anup Patel wrote:
> This series adds emulation of TIME CSRs for privileged mode. With
> this series, we see approximately 25+% improvement in hackbench
> numbers for non-virtualized (or Host) Linux and 40+% improvement
> in hackbench numbers for Guest/VM Linux.
>
> These patches are based on mainline/alistair/riscv-hyp-ext-v0.5.1
> branch of https://github.com/kvm-riscv/qemu.git and can be found
> in riscv_time_csr_v3 branch of same repo.
>
> Changes since v2:
>  - Register CLINT rdtime callback only for QEMU RISC-V virt machine
>
> Changes since v1:
>  - Use braces for single-line if-statements
>
> Anup Patel (2):
>   target/riscv: Emulate TIME CSRs for privileged mode
>   hw/riscv: Provide rdtime callback for TCG in CLINT emulation
>
>  hw/riscv/sifive_clint.c         |  6 ++-
>  hw/riscv/sifive_e.c             |  2 +-
>  hw/riscv/sifive_u.c             |  2 +-
>  hw/riscv/spike.c                |  9 ++--
>  hw/riscv/virt.c                 |  2 +-
>  include/hw/riscv/sifive_clint.h |  3 +-
>  target/riscv/cpu.h              |  5 ++
>  target/riscv/cpu_helper.c       |  5 ++
>  target/riscv/csr.c              | 86 +++++++++++++++++++++++++++++++--
>  9 files changed, 108 insertions(+), 12 deletions(-)

This is queued for the next pull request.

Thanks!

