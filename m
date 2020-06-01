Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7113AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3345A206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaNfcivp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3345A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjOi-0007nZ-As
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfjNa-0007F7-Lk
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:17:22 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfjNZ-0007fH-4W
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:17:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id h7so7807822otr.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8D3ltgdEKOYHHzcTB4IMIvlyaWbzQwSDtZpnthKiHTM=;
 b=eaNfcivpwAkOvZbVHrVYlg0h7QR62myZBy73KYNcEt4EN77xe34WkS5iiJldfhkYsK
 jw8nsuQaP/8UiQUhnJjH7JekktryK17FKc6fQRK3T7G4cvOz7T4EfYIi/If7UsBQc+Pu
 oF5J/D4QqgPBVKTqx38EXcd5LMHEs7v5D1UI5OhrG9wuWMZz79j5utyA+j8eQN5T8sSI
 49CTk9NoDhs5dwQs73jDtyHmT9kaK66UbTaqP1H64KOwRk3iKPxCJVfhnD87Mob/Djci
 MXgmBT7gqmdVLT78slt8y8a6W2H255X+c3RWkWLgnBSscg1MULwGSKpq/kj1aaYMeUjp
 NVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8D3ltgdEKOYHHzcTB4IMIvlyaWbzQwSDtZpnthKiHTM=;
 b=VpW45ITGSNWI4vhh+TZE/iV4Oa8tgEcwd55rjq97KkucBHZFsO+XR6Hw2PW0yTl3W5
 WI7k0orpm8aMhJNK0f+WLedUb8PRFkMZzOCDgDsHsD/3ahbyCtNnNXa7aXIEfrNBoG/Y
 URUv80+bLRi5VN4nB9jOGRXwM9SohkHVop8ZtIi2b4qab7CpVDLHkk0rcxfA27xQFUwJ
 AgUaqPvfho2vlM8cWIXBoN6nnrPbWrTHCEzhcubTchGP51c5cu5QUoAnE1dNM+jgCdcY
 jYwEFTXnpMleY8Nck2RilMJ1kvFgmoZxp1S1IrRWCYb1D+IhSczEanNttnhvSFparEpn
 Ji/w==
X-Gm-Message-State: AOAM532YrL7LG3ww1CQyu8EqTm3MvZyGSNaOGEBRDVYX/Jk0BeLx5YAq
 MjLFxxNDF3f3zVg+BX87ZjwQKUMu2T5p7DfLbKWfhA==
X-Google-Smtp-Source: ABdhPJye2jLRgEFA8u2PjPV3Qa6NfrxRI4bAmZf/cf/xq+zML3fgq+P6Uc4bnaJ6WtiPtRYe7zRobpmDxgJb3qRLYos=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr16206294otb.91.1591013839911; 
 Mon, 01 Jun 2020 05:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <4bdfe2a9431643f5b6265e5198a8620f@svr-ies-mbx-02.mgc.mentorg.com>
In-Reply-To: <4bdfe2a9431643f5b6265e5198a8620f@svr-ies-mbx-02.mgc.mentorg.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 13:17:08 +0100
Message-ID: <CAFEAcA92KXS88nx9fvS4ECA21PKonRv_mHqcuvEhLs12Aru+AA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 10/20] nvic: Add NS alias SCS region
To: "Magdy, Mina" <Mina_Magdy@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 16:58, Magdy, Mina <Mina_Magdy@mentor.com> wrote:
> I=E2=80=99m currently going through this QEMU patch that related to addin=
g the NS alias for SCS region in ARMv8m cores.

> Why did you assumed that secure accesses to the alias act like NS accesse=
s to the real region registers. I discovered the any register that is acces=
sed through its alias address behaves like accessing it in no secure state =
(except some cases where current security state is also considered along wi=
th the accessed region) ?

I believe that this is the architecturally required behaviour. In the
v8M Arm ARM (DDI0553B.j) rule R_CFPK says "The Secure view of the NS
alias is identical to the Non-secure view of normal addresses unless
otherwise stated".

More generally, the reason that the NS aliases exist is so that
secure software can read and write the NS versions of the registers.
If secure software wants to be able to make changes to bits that are
only writeable in the secure version of the register, it can do
that already via the normal non-alias register.

> My question was come up due to an issue while setting Application
> Interrupt and Reset Control Register (AIRCR). BFHFNMINS , I tried
> to set in secure state  but through the alias register. But as
> investigated from QEMU code, the current security state is set to
> 0 (no secure) but the CPU state is still secure and wasn=E2=80=99t switch=
ed
> at this point.

This is what I would expect. The alias is provided so that Secure
code can access the Non-secure version of the AIRCR register. In
the Non-secure version of the AIRCR register, BFHFNMINS is read-only.

Do you find that real hardware behaves differently to QEMU?

thanks
-- PMM

