Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D31C55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 11:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E9D206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 11:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ1B6HPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E9D206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb004-0006Dj-UI
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 06:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kazzB-0005hW-6K; Fri, 06 Nov 2020 06:32:53 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kazz9-0001GV-KN; Fri, 06 Nov 2020 06:32:52 -0500
Received: by mail-yb1-xb41.google.com with SMTP id g15so855444ybq.6;
 Fri, 06 Nov 2020 03:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YaXkzWp6lrQ9pt0zOFXkNHeJ/MJkfV8IzcAxDIc+QOg=;
 b=KQ1B6HPSn/FxDOe+b99WbRAdifSySSt8MlD8TMfjo4Nzj71C7krS3yzXuoCl3qdOGQ
 0m0Lf70pdf+55VjvaqT3Vtw0zmk+uiXm6fwVHL8mmPwsltUVHPcCp8gJtrQOLo/oWwly
 fhy2Zs0ZxZU0K+ThyHuK1kutxG2Z5SpI+IdvrKzTpc7FxEQzgB8EwGcl0FVnvxYZL1Do
 1qUv63O4wRPODQagB261Ww0CiKXS8RHJGPcDWsh2RfUKqtz4dOQRPL0SPPKNF/zhf3cU
 2oOW6A6giIkdc65Ycq6CYjOtAp3rW5dvIgwq/lPncYWGYrguIeJVpwMI3kWdnGg0qR01
 f52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YaXkzWp6lrQ9pt0zOFXkNHeJ/MJkfV8IzcAxDIc+QOg=;
 b=He4R6ooB50XaCa5U1rwU/G593DzOKIQ47mB1M6B5HF/ZTkVJwOsl+e3eYfK4T+X0Wi
 5EqlzmAoPpOtU8AQxHwjCEAVGju2UWeKXBYBjaZfDX0rR/NRan9Wl9oOx7z5ogM/KSEM
 lGdX8D4WjyCj1iCLaSoXY9/4AiuIFt982CcJvx9Vm+r/WeHmVIkZVvtT3n7uv5CMflbd
 Z2/oHAAmQLmE8Og6BCzpzTY+FEZDMo5JqCOSnrTuU8RzIYtzOxRcP8qNNuloy7TdKi89
 Yp2WjdAWonTVVDlk0rTgN+2cPXSEJ0BmdI62nRVD8Uk52Mic1BU1qgbIBo5joW7pnOkD
 hi3w==
X-Gm-Message-State: AOAM5314w/hDt1I4cCJY9ySpkOFgmJPwXUOrAGvY6yzeOypfF2uVWNKU
 loGfY9Cl+fPpgLywyLvSwOPwq6/Cdu97PM0kEPg=
X-Google-Smtp-Source: ABdhPJy2Ge/luctSUvOIM+68rpQgpNRW0g+lAZocRsQ43hHM48OLdHs5oov+1Nh/8AgCOZ/l2ub6+GqF2WIWRt2FJcs=
X-Received: by 2002:a25:386:: with SMTP id 128mr2065928ybd.122.1604662370299; 
 Fri, 06 Nov 2020 03:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-3-alex.bennee@linaro.org>
 <CAEUhbmUkwq318FW=8cTuU1fcPk8U46EEUr5f6P9QJTdonNZHJA@mail.gmail.com>
 <874km2bxbm.fsf@linaro.org>
In-Reply-To: <874km2bxbm.fsf@linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 6 Nov 2020 19:32:39 +0800
Message-ID: <CAEUhbmVu64nQp-+dq=Vbvs0MZov-HcV3AW4j_ZFDP71hGcRrPA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/15] hw/riscv: migrate fdt field to generic
 MachineState
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: julien@xen.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, stefano.stabellini@xilinx.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 6, 2020 at 6:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Bin Meng <bmeng.cn@gmail.com> writes:
>
> > On Fri, Nov 6, 2020 at 1:57 AM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
> >>
> >> This is a mechanical change to make the fdt available through
> >> MachineState.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >> Message-Id: <20201021170842.25762-3-alex.bennee@linaro.org>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  include/hw/riscv/virt.h |  1 -
> >>  hw/riscv/virt.c         | 20 ++++++++++----------
> >>  2 files changed, 10 insertions(+), 11 deletions(-)
> >
> > What about the 'sifive_u' and 'spike' machines?
>
> If they support direct -kernel loading then we could certainly do the
> same for them.

Yes, they do.

Regards,
Bin

