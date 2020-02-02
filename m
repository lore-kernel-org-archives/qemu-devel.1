Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990E2C3524A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 13:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C3720643
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 13:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uznjtrQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C3720643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyFL8-00051Z-Cp
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 08:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyFKK-0004Ri-1x
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyFKI-0000gh-Qb
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:30:15 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyFKH-0000YO-GV
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:30:13 -0500
Received: by mail-ot1-x344.google.com with SMTP id b18so11132006otp.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 05:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q9y1hOrjhnvikp8id36VWQRu7GzuHCfn7v0dl6m17nc=;
 b=uznjtrQOnwxhMvJY0yUtdOStCsnHIOqj9ZrG3E7cNAcyOnqjurSFDHgwW+b0f37TZ3
 NOaRXe7giqzrX3oD8xESkTLJ+iWvo44UVjx7oTb+CCoG+q7uCq2J5LNjHlvHadJ41KkG
 X0uCaVrrTEpBcKtllC4hPkygDR0C2UAp2nKEFiRRg+l2t59alC6GzlDmgIeWJGeSo88v
 yjfFrsPCO12AVGHp1LyyLZAiSCam7m3JQJl4Dp9JFYXWbdDPdB5B4jIbr67P073t3aIl
 oKi1CmIQ55k2CPIdtDO4mjttlxyOna0Vp99vvbkS5p4HCmPqpeVyoIdpbmtYGMbm6l/Y
 SeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q9y1hOrjhnvikp8id36VWQRu7GzuHCfn7v0dl6m17nc=;
 b=mh5im3TcXhehflZ52F4JZ5Bb9LvHKsQl7jq4Oxh7Syee8FaClbrozxesgUmEyWxCDb
 pgpavS9b62mu289D9pEZvSzjCzZ3Sv8KNR6kJIPiWrhawAJ/j5eqKHBgcGgSSNkntJ9a
 1xn5gcTnRtr3ajp5upsv4ffqVBY3H3tFOsEZzbvPSSXDSDQUHU6o2aZz9w/9Kp0iHbiZ
 hJbe2g0b+k/tT7oI2suDRLqoxiZtWsF0lJhzoyFsykDtlAEOgOT15VFol1Kt/npktivx
 2a9EZTT1cf+6GthWE+O6H4OAGL2x+Fp5xfO6XuYrUZ5iNexIta5nydrghXZI70Fwi3od
 ojBA==
X-Gm-Message-State: APjAAAUOFUMZj2pI8DG5SdwYV1LGTtHx3Cy3YmP48NZQ+zGPUO1RH/0E
 IT10VPhpYFVXhDqow6vI4FStbJjfj4EtU0rEs5vB8g==
X-Google-Smtp-Source: APXvYqw8ZegrCj1691GwOL4p6tlnFfV+0f4sUK80w7WzeoyRsh0ef+kTWor85PFF/eA5tigiJB2Wm/kmwETNP3MQZ2c=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr13558868otq.97.1580650211070; 
 Sun, 02 Feb 2020 05:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20191203234244.9124-1-richard.henderson@linaro.org>
 <20191203234244.9124-3-richard.henderson@linaro.org>
 <CAFEAcA914CO2vfMAkr4aeEA_FV0Vub6S9eF43qN=14e7nU1uHg@mail.gmail.com>
 <2871294a-0577-9390-1887-a2e81c1a35e6@linaro.org>
In-Reply-To: <2871294a-0577-9390-1887-a2e81c1a35e6@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 2 Feb 2020 13:29:59 +0000
Message-ID: <CAFEAcA8tkhpHAM2niDmpm=Oi4XQDTNTzKUJ_A-hKFLXsz_rPxw@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Update MSR access to UAO
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Sun, 2 Feb 2020 at 01:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
> > Does the "on exception entry PSTATE.UAO is zeroed" behaviour
> > fall out automatically for us?
>
> Yes, aarch64_pstate_mode() returns a clean PSTATE.
>
> > How about "on exception entry
> > from aarch32 to aarch64 SPSR_ELx.UAO is set to zero" ?
>
> This follows the same path as above, as far as I can see.

Yes, but SPSR_ELx isn't started with a clean zero and built up
the way the new PSTATE is, it gets copied from the AArch32 CPSR
via cpsr_read(). I forget how carefully we keep the guest from setting
CPSR bits that aren't really valid for the CPU...

> > I think we may also want a minor code change so that an exception
> > return from aarch64 to aarch32 doesn't copy a bogus SPSR UAO==1
> > into the pstate/cpsr.
>
> Well, there is no CPSR UAO bit, so there's no aarch32 bit to clear.  But I did
> add a clearing of PSTATE UAO on the exception return to aarch64 path, to
> prevent the guest from playing games with SPSR.

...for instance on the aarch64->aarch32 exception return path,
I don't think we sanitize the SPSR bits, so the guest could use
a 64->32 exception return to set a bogus CPSR.UAO bit and
then enter from 32 to 64 and see SPSR_ELx.UAO set when
it should not be, unless we sanitize either in all places where
we let the guest set CPSR bits (including 64->32 return), or
we sanitize on 32->64 entry.

thanks
-- PMM

