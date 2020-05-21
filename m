Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFEDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 01:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0A220748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 01:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g71zBcPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0A220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbZfP-0007Kc-RZ
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 21:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbZel-0006oH-3m; Wed, 20 May 2020 21:05:55 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:35421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbZek-00052g-8n; Wed, 20 May 2020 21:05:54 -0400
Received: by mail-yb1-xb42.google.com with SMTP id o134so1960131ybg.2;
 Wed, 20 May 2020 18:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CEzFRCCd0zwrtm4gO2zb6puspyYzh9kUYN/GZEBFJEw=;
 b=g71zBcPVHIUvygy/9OVJMvJRZFGCfS09TR1Q2YCCkE+r4L/b5U/ZKwmdebUHGRXoi8
 vCkyG/HcOSZNoKzGzNsRphcWY44dx+NVybei23Z3VEMdYiZwfioc3oD0eM1bvm4VAN+S
 YK5zOUy68S9qT7E1i8AA1NtgUjzwFXcvb3S8Nz0UQQAsotduESUWZ4bUsZy4YQr/y7Tp
 MaYZgwTBRpTfhLqCAkVuV9F75EZJA5KdJBfNXR6Un23JksWaEbcppEHQVmQYIIpW8vLU
 kuM+B9Pezb9gZ2BGINXp31SgH/xZx3e1/ZbTOxnA+2jBnsnV3mzWMQLH6wmDOCIa3qRI
 xFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CEzFRCCd0zwrtm4gO2zb6puspyYzh9kUYN/GZEBFJEw=;
 b=Y6IE8ePsjPFNt+KG4dRJ6XyvD6wLLf6LYJJJC7brAcNQRTsbNG38XIG7tmAtSPecp0
 tDSEKwFHvdi/h5+Zyuo6dSR8FLMwvP3orfAYfv6ovWvoX+2Ud9SBn+BCOQoFiygjxzvi
 WrfXoAiOGIJjkOuh7n5bHJtGHAy4rIyboQFcVaERopwS7XjwFRB9ZEXsIXj9okyTcMUL
 O6pqTP2UdWNSdxQpLQQ5xX9sVUB8F2dIIRLPhUyo8GgT6Hac3m4QQEUiWsAegy4zH5bZ
 l8OLQYpryadCrGnykk891KiASqEiRaYKUf2xu9Txmy4DIdL8dfw57DCwcwu62JuCiuy0
 v8wg==
X-Gm-Message-State: AOAM532HC3VkPGw4DctJjjLx9FzVXECSgy9UtRaP+vs/Km9dFd1xvyKG
 5n5kJdA+Zv/vAqUIAVsCggQPBLSZ1oGlvTU/Uuw=
X-Google-Smtp-Source: ABdhPJzZsXqMT8W6JPACVGFG5micwqTz+OvYjK175JQRbFPvSP9CC2pS0XbUNoV/ZjB9mQlfJ1Bjjwh4y8nWc8Vtiyk=
X-Received: by 2002:a25:bdc8:: with SMTP id g8mr11355082ybk.122.1590023151875; 
 Wed, 20 May 2020 18:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878640.git.alistair.francis@wdc.com>
 <3033d22bf6385fc24a990c0e096696eea552c51d.1588878640.git.alistair.francis@wdc.com>
In-Reply-To: <3033d22bf6385fc24a990c0e096696eea552c51d.1588878640.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 May 2020 09:05:40 +0800
Message-ID: <CAEUhbmUwYge4WiR2rAmbf1CfOfuyUq3=89EqO1ZEBU2FBFVBPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/riscv: spike: Remove deprecated ISA specific
 machines
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 8, 2020 at 3:21 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> The ISA specific Spike machines have  been deprecated in QEMU since 4.1,

nits: there are 2 spaces between 'have' and 'been'

> let's finally remove them.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/riscv/spike.c         | 217 ---------------------------------------
>  include/hw/riscv/spike.h |   6 +-
>  2 files changed, 2 insertions(+), 221 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>

