Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96317C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6130F2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbLN3SDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6130F2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvBN-0001MI-MS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtvAP-0000FC-2x
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:42:26 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:39578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtvAN-0007ht-IK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:42:24 -0400
Received: by mail-oo1-xc41.google.com with SMTP id c4so1075367oou.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YlPeS36yjVSqPS/00ncvMAECAMWuuJd6M3mkwHAHOY4=;
 b=hbLN3SDwLQ5xHu7tvpymRGPAbb3dTE6fuIov4CVE9l5nUXWC385JuBQrHfnk9KfFHT
 +32A1qbWCISAedkVgj3EMZd40bKFETycTisEr8sx+HeRFsHySsVPl5b2JiR7kAevBnhL
 mDrgZSxze4GWnFdztFFaRtzPy8ZC+h1nk4+jyKyfpf9UxACicOaFOZ8Jp529azXy/Mnj
 OC3dX3AMg08si8NLqZAOMqnSUS8TFGTs8tIIP6Y50uCSnD9mNy6rOSG6MxL0TAXWrh4G
 bcS9KLzLQty9mtGYZmv4dpGu9Qps5KeI2EIpLdBzEqDWJCZnT9NYlggxvWm7eWQJn9X9
 jhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YlPeS36yjVSqPS/00ncvMAECAMWuuJd6M3mkwHAHOY4=;
 b=YmpgIHqn2MQesJeZsL1N+7NJvWzPECq6GRm7LMDFIN6lO0oDJ+jgaOToOpxyTwKi2l
 rSI9CfWD4n6c6iCOed0YoFDWqH6YiU0AOvBSaTecdiJjMg8VASk/G9tVL++KHTAwNq1P
 vYVHkHKThFMgIgud5QyCWW/3MjeaOEKcpRZHS/2QbU1MSwakYez+4WpJyotW/n5eZDif
 dYtlR4YyHomrrHajXkoBV6WVVgsVJ31CPzJch+fLJGAuU3R1v91cYYprwR1TTlQLmfQB
 y3LVAU7Os0YXN/nAS1RvAcpN8X6bSpc+bi2ATy/3wWMCjZhocEIoQFw7vrWzWcazZEp7
 gvzQ==
X-Gm-Message-State: AOAM531fCt3xbQXnWyPCWCCWvPomXkBsrDY5AbeqPCVWgN2ZSA+fQYit
 PBabkdSBP8GjovKfAnuKkBp6ETSn+mD7djoxgWrMdQ==
X-Google-Smtp-Source: ABdhPJxie6nqqUQFRKPbUcG0QqSlg8kH/iT9SqcA5sDaaVP3G04F46IP0qRCShnmO4vrTy/iFds9WshVY0Eys+0alZo=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr37650365ooi.85.1594395742356; 
 Fri, 10 Jul 2020 08:42:22 -0700 (PDT)
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
 <CAFEAcA80XK4voLDj+8kVFcHJb35HT9HL+Qh8kGb3_Qe5Em9ouw@mail.gmail.com>
 <adeb1f02-c712-e256-6840-649795fdc3b5@redhat.com>
In-Reply-To: <adeb1f02-c712-e256-6840-649795fdc3b5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 16:42:11 +0100
Message-ID: <CAFEAcA9f0tadztJP7Ki0potF6=E+GaG8a_X_5HTyH2yw2T7goA@mail.gmail.com>
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
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

On Fri, 10 Jul 2020 at 16:31, Max Reitz <mreitz@redhat.com> wrote:
>
> On 10.07.20 17:18, Peter Maydell wrote:
> > readarray only arrived sometime in bash 4, and the OSX system
> > bash is 3.2.57, so it won't have that builtin.
>
> It arrived with 4.0, actually, which was released 11 years ago.
> I had assumed that would be sufficiently mature.
>
> So, um, 11 years isn=E2=80=99t sufficiently mature then and I=E2=80=99ll =
have to work
> around not having readarray for macOS?

It's the usual Apple-vs-GPL3 issue.

I note that the iotests do seem to regularly run into
non-portable constructs: Kevin's latest pullreq has
just failed due to a use of 'truncate' that doesn't
work on the BSDs.

thanks
-- PMM

