Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE092C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33142065D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3mvc+GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33142065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuq9-0004s2-UT
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtunl-0002w2-9N
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:19:01 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:43070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtunj-000479-Pn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:19:00 -0400
Received: by mail-ot1-x333.google.com with SMTP id 95so4428943otw.10
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Rpo6nCzJ8sa8ds9cnKWvnzlsoTNpfxieNeFE4rniC0A=;
 b=F3mvc+GSh0BRX1RxcNEl0QMJDvJp903bN0vr0MhQ50K5nMUDJdMGn1ckxJKNMfXxPp
 7th+H2mjjh0zmjc9O9f7C72MY0zQaGapU8idSdgbKLOq7UuEaTjeMYQ3ol9fYuUr8YOJ
 E90sMiMyteWDzBVMHPJ/0BKbSr6G9sN6Gn8mu7cKIQXeN/cyyTbxaLTkKPAzMHT1UUBD
 D1XunfZ/F8bEi8g16UDxrXOTBVqNTzYERVHXw2k/tP7uDt5FT3Ef+63bSanZgUq/QCxC
 n00Y0pX110omV0gpDvakOha9fkOTMHROwFfTdJKdmS6PMjyueTOI2lOqy+Z57M4Xa0Wf
 Cs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rpo6nCzJ8sa8ds9cnKWvnzlsoTNpfxieNeFE4rniC0A=;
 b=FwJ+VS68I/kzweOOVxzHdFHVM0ETSjvhn1rNQwqMA8qJgG53k7iwwus9wVjEym3GFy
 Fyr2d2AZy4w6m4OUTlUgpHXbkbNxgJLYdJQ8UiKK8DBGVGWSf78p3mIijWRMNxEYtdmv
 1+xnbn+PGxY6NitWcqeq/Z10Wd2tWkkKFZXHhe/YZHONWkMCuSpUw/9T8V8LB/Qc1nkU
 eivOr3eaKQpE8Jb8KE5wqekFnj/htEObAOgokd5ul/OuNIvyr+gpoN+bONBzR2sEEZQR
 9U8AS+84ebq5mL2P6x1RMegvCIXTo8gEZa5y7XTL2IwVD191px+8P4eFRaS6ncnnOIR3
 WDPg==
X-Gm-Message-State: AOAM533g0f7dRn4RLM8bW1ix+HToae89COKP7Qt9oGikyVMQYm4xEppo
 mfyqx1otPF3Pk8ZSQDNj6bEM7P3c1Ue7UXtcUmszsA==
X-Google-Smtp-Source: ABdhPJzeOx1HLESPqKX53aYOQP5Aa8vyi+Tajw15tSXMcSuKR/GcS0DfsvXXQXknKnwQG5nQqWW9ZVgvf+xNJsO2P/U=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr56081532ota.91.1594394338322; 
 Fri, 10 Jul 2020 08:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200708172542.25012-1-pbonzini@redhat.com>
 <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
 <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
 <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
 <e78820bb-af5f-c2a0-7727-1a0caedfa584@suse.de>
 <CAFEAcA-raDJ2pSUG-OYHcJi_LnQwxMHvcyjsD7+=WxGYcrSz3w@mail.gmail.com>
 <a8113ed1-c508-0502-4f88-77f875d1a739@redhat.com>
 <40f4c566-8a5b-c27e-22a7-2a112a0cd77d@suse.de>
 <c6e3336f-38b8-a8fa-4862-58e6f094711d@redhat.com>
In-Reply-To: <c6e3336f-38b8-a8fa-4862-58e6f094711d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 16:18:46 +0100
Message-ID: <CAFEAcA80XK4voLDj+8kVFcHJb35HT9HL+Qh8kGb3_Qe5Em9ouw@mail.gmail.com>
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 16:13, Max Reitz <mreitz@redhat.com> wrote:
>
> On 10.07.20 16:44, Claudio Fontana wrote:
> > Speaking of MacOS and CI, commit 57ee95ed4ee7b4c039ec5f0705c45734c56706=
bc
> >
> > Author: Max Reitz <mreitz@redhat.com>
> > Date:   Thu Jun 25 14:55:30 2020 +0200
> >
> >     iotests: Make _filter_img_create more active
> >
> > broke cirrus-ci completely for me due to missing "readarray" builtin.
> >
> > Maybe it is bash vs zsh?
>
> Possible, but the iotests depend on bash.  All the iotests shell source
> files explicitly reference bash in their shebang line, and so far we=E2=
=80=99ve
> always assumed that they are thus going to be run by bash.

readarray only arrived sometime in bash 4, and the OSX system
bash is 3.2.57, so it won't have that builtin.

thanks
-- PMM

