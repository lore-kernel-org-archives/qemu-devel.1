Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA2C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3233B2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDeWwsdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3233B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQc3n-0003uF-9y
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc2V-0002up-RM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc2R-0008Oh-8S
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:25:07 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQc2Q-0008Ms-Qu; Mon, 20 Apr 2020 15:25:02 -0400
Received: by mail-io1-xd41.google.com with SMTP id i3so12332776ioo.13;
 Mon, 20 Apr 2020 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z/z6tWvsAAr6WJjgZ7JK6HDrhITes5+RAY4FbMVRoTc=;
 b=BDeWwsdV+FeQVWY+UPtM2e2Q8MN+aYPRGDxJTYhekgLicIbFBuNk+RfMmH+Ka9fugh
 AkSSdu7Xgponom4yl4bvjiZAl0tjkm1Eh8yAGuAf0Joyx4o1aoQSgJgSUP8rPSDX1GL8
 1mhNKFA2XwKe4tnRlFH0FDrBlCst1KWjvP4fW4tgWajQdrQjPyPV+IxVB+6OSI5ZoI6J
 trbhOEQeRbU8Cm+zFGDy/Bdh3SnqdlF3qHzVhTNdSNm1St1oBWFURD3nZNwa6b0/J8AH
 g7yWSqnFgIvttUmyBh5m+VPgh+hKkqGidwHDboPvi4/bUURfW+gdg5Am4b48ANzs+QHu
 qWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z/z6tWvsAAr6WJjgZ7JK6HDrhITes5+RAY4FbMVRoTc=;
 b=ebgodjI84Sor9tNF3JLYZCJutKbYim45Q5O2Okd4CAqzjzCuus7FU2/kD0ow6Sx3W7
 N4/rthpt5byk7YGccbrEiusfGvKO/Csguk7UO5tkYD4qE/vAV+mrI9RTtfKxlDTIcvz1
 aZcy+Rr/VAfQyyAkyYQPY8uE4+WgGirm3ZExqZqGWZXvJWZ+yultWdoQ9yJGA84Nc/Cw
 oTQc+Z40KnOPjJjzYzkMEMbXwS51REY/LTskWmG+4W84D6QtmHvL3xPLTbZo2UpiSeea
 Y8W+kFE+AeB3docVPZI/KwC8lkS5u2Xw8cGHhaICigqFGbbAXpOEhxb5/oYb3BP/4zK2
 Tj6A==
X-Gm-Message-State: AGi0PuYgLlCzwNEe/12oV962Of5jRqtp2SjCJmpOiLV2LH/G2QmIOWNe
 TpTwhqblIUSWZ7XXEHjbucwtRBbOGa3USuhBe9I=
X-Google-Smtp-Source: APiQypK66Tc0rKPBj5GD74IrcA2UDxNqOxn/vGyxHjlH/gyInVm1JWSAI9HmjQpcuL5X1rQSLhLRtcJigYcAea8QpzE=
X-Received: by 2002:a02:6414:: with SMTP id t20mr17511792jac.8.1587410701122; 
 Mon, 20 Apr 2020 12:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585262586.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1585262586.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 12:16:33 -0700
Message-ID: <CAKmqyKO8otTL+r9z6Jko_QBXy_mCo4+W8C5E7J2SHb-+ac7bHg@mail.gmail.com>
Subject: Re: [PATCH for 5.0 v1 0/2] RISC-V: Fix Hypervisor guest user space
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 3:51 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> This series fixes two bugs in the RISC-V two stage lookup
> implementation. This fixes the Hypervisor userspace failing to start.
>
> Alistair Francis (2):
>   riscv: Don't use stage-2 PTE lookup protection flags
>   riscv: AND stage-1 and stage-2 protection flags

Applied to the RISC-V tree for 5.1

Alistair

>
>  target/riscv/cpu_helper.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> --
> 2.26.0
>

