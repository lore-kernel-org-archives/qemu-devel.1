Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8BC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A19206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAuOeTar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A19206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3kY-0002zu-1h
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3jY-0002B0-HG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3jY-0004Fs-4g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:23:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT3jX-0004F8-Nv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:23:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id b13so26074952oti.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RqmLEdTYY4+0eoGr4VmROK+6nEPxwdg81kD6fw/aynY=;
 b=mAuOeTaraGmIvLGElHb4qVHGTiFgO5nw6jiS9zKkrXdEngxtIqFzIrVrPCdbCwoWSs
 IyTkZb5Nva3aawkkYPVQNm2qJAoHN8fqMq82+T3ABH096tOiKAsNPv2YFln2EGad2L7o
 NVzAaslaVyVCUe8B38wXF/5ogV2niHiUruzmiv2E0CjkRJT+mHEM1tBDcO1gqU6yPR2p
 ntAhagQCRPXhoBcQgZRWWddTEbex/UAvFuL45BTkDDgXWAcE6pDFWG+ONYcjvjyDATFD
 kgHuWJhNGBP8zEB1sdNMtSTkt+hwottnndzK2Cp6yRdnJ9Jy5cUnst/pM5jymEkTJuPr
 A7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RqmLEdTYY4+0eoGr4VmROK+6nEPxwdg81kD6fw/aynY=;
 b=RQD+bbm4KQY5kJ+gAByK+ViV4nsSIqNEyaInIP3Jh4bW3MGpLE4Mp8nWZ2FqU2x6WG
 E/hbXvbTqkU7WbjqVtjq0nWyhTM2w9ibTgY1Cw9UqQ0/g3G9OFgdF40q2CSAISsog/Ub
 SAITpl55/YFXjTf7oJdpeabSSJ2b6m1tr9Gu/wSfj0AuwDI3usErvriUc0km+bxDa+sG
 JeKSR0PiOw4CUTB3GNNuTZUaCd3mJlHFNSHY98qScJ1grDXsu+B9F+bTS//kb5hedFyw
 MXBP4/6q+6a+7ohnC3DEleLaO7TB3+40irfInzMgXjH+/KSOLRt51dmfj4XJQydTbm5p
 aBxw==
X-Gm-Message-State: AGi0PuYCfUj16A/1SUJFHHTZqhtbBOiIMrvg1UfqveFSgnCeJgU1ukFf
 hxkPRWjmkAOvpJ+PmXk7+lOk+ToHB6NMhum1vT/ljw==
X-Google-Smtp-Source: APiQypL15AxMZlXTwAib9LHv0mg6ykRz2vN01zj57e5+J+TFyq24QF0OqwXo5E0Q8IyS3hrLFdXzbeppoAFPxW+LC+k=
X-Received: by 2002:aca:3441:: with SMTP id b62mr13876728oia.146.1587993817302; 
 Mon, 27 Apr 2020 06:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200423124305.14718-1-f4bug@amsat.org>
 <CABoDooOz7MZ6DWajfQU1s3mK8Cf_U06pjHcoPW9Tat5+gKGdGw@mail.gmail.com>
In-Reply-To: <CABoDooOz7MZ6DWajfQU1s3mK8Cf_U06pjHcoPW9Tat5+gKGdGw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 14:23:26 +0100
Message-ID: <CAFEAcA84BLBndhMZ+fub-Ss2Zm-Qmgv+3nUzMgC3A5=ipTp-Ow@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 at 14:08, Laurent Desnogues
<laurent.desnogues@gmail.com> wrote:
> On Thu, Apr 23, 2020 at 2:44 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > MIDR_EL1 is a 32-bit register.
>
> In fact MIDR_EL1 a 64-bit system register with the top 32-bit being RES0.
>
> So the right fix might be to change midr field size, just to be future pr=
oof :-)

Yes, I think I prefer changing the midr field size. Looking at the
code this should just be a matter of updating the 'uint32_t midr' in
the CPU struct to 'uint64_t midr' and changing the
DEFINE_PROP_UINT32("midr",...)
in cpu.c to UINT64. (The one user of the property in xlnx-zynqmp.c
doesn't need to change because object_property_set_int() works on
both 32-bit and 64-bit integer properties.)

Mostly we have been fixing up these ID register field size values as
we move them from being top-level ARMCPU fields to being in the
ARMISARegisters struct, but I think midr is unlikely to ever need
to move there because no CPU feature is gated on the MIDR value.

thanks
-- PMM

