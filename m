Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FC2C2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4A6206A1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpBm2/tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4A6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjgp-0002Xj-2s
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 16:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNjgB-00022m-Rb
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNjgA-00089D-Nv
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:58:11 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:45749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNjgA-00088a-Fd
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:58:10 -0400
Received: by mail-ot1-x32d.google.com with SMTP id 60so7284002otl.12
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9c1IMFieK+UUBgy2jtS+oVL6G6HOP6//tEfC3CeIR9s=;
 b=UpBm2/tfC4VsBU8fN47M5jsmb8i+/bkJUIBdO6Bjee25RUQKlpDewhUedUCmkqwxf3
 Pso4yKqjc5nC/gBrVxlLvpdQIn3COMFQV351cvmq1JXDae5MayKpYT2QEu7fW9VMVFmK
 dpRgokmjDGxtbjCyvIfcvCnhKpa7QNnWSefhBspZA8hxS+1Omaf28wBAPDQXUNRlZ7E9
 CAtshPJ4B61DhU6dUcwnN4aeQsAribBeyldk2XgiqkzVMrW8WfcT79za+dG2+3uVUSHb
 F8qbKSpgDjZ2q525GOg+TxcKc+Hj+qHSt60n6AWr/4Lsm+UxhTnDuG+Jw9k1GjfJb0o2
 ztGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9c1IMFieK+UUBgy2jtS+oVL6G6HOP6//tEfC3CeIR9s=;
 b=K8yPwI0H20BclL2vmjV0z9wWf/zwP1VXI+PXlRqjOfaLsAzsmz3256c1i875jttSMy
 qcgB9m8JzxA9vM9B8rql5KAIPgNHNjcq69m8UhH+IfAfADVCRHShcI++9jGMAjwaLYDx
 c2HxNnjmHTUO1D1/0e5tjy2f+8MfbvPrMn9m4SEnh1bqhm4eWeAXlmPRodU4wG9oWYRC
 93t90M2VQYrZmGD8z5oOPt0DjZlbvChzOaUrUEYVhbzOzz/uGLndEgx3W57g1+5yxWQK
 atm7I+7lBUqVaK1CKX64DIaHuFAjdTPet96vTvj1k7KBt2gBsDPIqb443eFt6UptM9Wb
 w25w==
X-Gm-Message-State: AGi0PubTz+Ue1fn0CYjjl6ys6t4DbfWRZCeajzMK34KQ7sQAFpfBlUCP
 Kf8s9er1aIV+rKPPUyr/U4wUdJK9li01kpiUVPwgNg==
X-Google-Smtp-Source: APiQypLuafkEN+DstrEC2Koin/LoRnxe0YnWpmz9He+5adNbPtNHjZXxFuSeVg/2U613q9L8VzOqT9fXYmiqlt79sHg=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr12413075oth.135.1586725089234; 
 Sun, 12 Apr 2020 13:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200411091453.30371-1-f4bug@amsat.org>
 <20200411091453.30371-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2004111953020.75236@zero.eik.bme.hu>
 <811e2026-963d-e4d6-b90c-2713f9f30404@amsat.org>
 <CAFEAcA-ntHLEJnQ8Sd_c8n8LJmJ0X44VousM-BtNTndXRdf8ew@mail.gmail.com>
 <98306a3a-46c9-cedd-48c2-af065c597640@amsat.org>
In-Reply-To: <98306a3a-46c9-cedd-48c2-af065c597640@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 12 Apr 2020 21:57:58 +0100
Message-ID: <CAFEAcA_U-sxDCSt9DPdNw0PUbjySeWUaNWivezq-6qBFOK3-Eg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 1/2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 12 Apr 2020 at 21:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> "VMs using KVM" as security boundary is very clear, thanks.
>
> Note 1: This this doesn't appear on the QEMU security process
> description: https://www.qemu.org/contribute/security-process/

It's part of the list of how to decide whether an issue is
security sensitive:
 "Is QEMU used in conjunction with a hypervisor (as opposed
  to TCG binary translation)?"

We also document it in the user manuals now (a relatively
recent improvement):
 https://www.qemu.org/docs/master/system/security.html#non-virtualization-u=
se-case

> Note 2: If a reported bug is not in security boundary, it should be
> reported as a bug to mainstream QEMU, to give the community a chance to
> fix it.

Yes; bugs are still bugs.

thanks
-- PMM

