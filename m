Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECAFC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EFE20787
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lv78rc3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EFE20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRaL7-0002SK-RG
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRaJy-0001tT-Pw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRaJy-0005DV-De
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:47:10 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRaJx-0005Cy-Ng
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:47:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id m13so5466188otf.6
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mSetTNDcrpopsgPqP6eitB3o26WOer/xC5F/oWH6eUA=;
 b=Lv78rc3/cGLSBgyBX9Rl0tiIxD8cvtx+17/DfZvx9cT0OCOoR+N8Jtl6ZS1Bh9+ShH
 mjFthZElCpGvXIhVUUhAXHWiFUEhCiMkI8TUx7QVAAFgIyOyruiXi5tnidNkITFqcAC9
 yBpoDet85jwLvzcsBNejnhjhjY9dvyvG/baO3koO3IaqZa9T0REk0iozj0+hGhAw4tWv
 oaehfkKCNVIyOYs6+sAqOe542Da5pEnseksIwx0TlgkyBToigCccU3zUrnhmqXQilcsW
 DCmEYORkblM2XLWN/60Vmnc9illgY+8pLXPD3t/Sm7VRzGixC85C8YX2gluUAOqM68G4
 YgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mSetTNDcrpopsgPqP6eitB3o26WOer/xC5F/oWH6eUA=;
 b=Q7JxZ8izo08Lhs2Ro5ARDb4rluXawUmgWnNOgy0C1KZMrDbxusDr4bpwd7IcoZnZjA
 EYgUjGT2sIaTq/9995IwJ7SHZYGY6hUUXirnU1m6SRi+t3LLaMoiZGxQfrtsT6/H0bjZ
 IJNJtc8qN53l/RgV0kJ91EDsbRQVsJNjZe7rAKNTPOoHqOCbjos8I9Pdw2L8bzXYQzH3
 QjPMopS0dA12/XCkrqkPgXr/6VZQv5igYzPbshsQJ2E2/wRaUVqZKAvn3qnAKitIDH2J
 IIYwWIQctzwB+BVhakbLvmpA6c2z2ECOgg4Lc8Qk6g51E5XrPlfW5mTBiDoS8KK2FIdm
 foaA==
X-Gm-Message-State: AGi0PuZ/zg+3hmCD/c4VQvEX2q5KlodlsUgTdxhX7VrKMAI9dOb8M4RQ
 OA5hbwFJJzDgkFKGsgxyuSiFKxPj36MJ7ymIQwj+iw==
X-Google-Smtp-Source: APiQypLFUdvR9Jrkjt5fVQep5MAF2XwOPMzwq7teSfZLyffr28U9YmeG5NAZQQNWcbD4Om8HJ6aXTwxNk/3Cy3egg70=
X-Received: by 2002:aca:c751:: with SMTP id x78mr2622737oif.163.1587642427692; 
 Thu, 23 Apr 2020 04:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
 <20200419162727.19148-4-edgar.iglesias@gmail.com>
 <CAFEAcA8D2HSPg8-ZvFBocmz+QRXTzhJcjDG21PCk7+_N7+2o1g@mail.gmail.com>
 <20200423114407.GE4289@toto>
In-Reply-To: <20200423114407.GE4289@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 12:46:56 +0100
Message-ID: <CAFEAcA9DBWSGVtUXXE3dCt=hQghaLw+5b9Zj-sCRHa5DXQ+O=A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] hw/arm: xlnx-zcu102: Disable unsupported FDT
 firmware nodes
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 at 12:43, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> Without it, I see the following warning but compat in
> qemu_fdt_node_path should probably be changed to const char *.
> I can make that change in a v2 if you prefer.

Yes, I think that would be better. I can't see any reason
why the compat argument needs to be non-const.

thanks
-- PMM

