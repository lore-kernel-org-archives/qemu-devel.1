Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035BBC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D587206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oo8aEJYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D587206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMxu-0003ch-LT
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOMqX-0004Ji-Ir
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:19:45 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:34974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOMqV-0001CN-Mc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:19:45 -0400
Received: by mail-ej1-x634.google.com with SMTP id u21so2529355eja.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ev6WsFt1/GGcPMANMoNRt/LGFZtNVFe2cwCI687KV/k=;
 b=oo8aEJYVJGiMQ42rID2yv0PEfHKHdVylu5fG47PvTo7zsmoTkuNQkKRhKNvByU8tZL
 6c7ri9s+0vXTVKEJMJinDK8Qepesb8Fdg7cRIQ9EPB3g0nhq4mwMhrqlKG0hzRPr1kPv
 n74pZoL6E24GjeNgqyCvjELUK8v17u80g7XUYgjjxdyaHnPxAaXuChff0oNQVN8tTkU5
 3YApaPnSlXsCHOmNTJOoSncDQH/xkxbTyGKK4UYmg28gqDlqIVzQIO+UGBCvDzEC74RT
 vT6jgoXA+MX1EqFeKh0x3OblSnLImFaKGpbhS8ue4TSs64H5vMYwp0SGti6eae3C+KN0
 1xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ev6WsFt1/GGcPMANMoNRt/LGFZtNVFe2cwCI687KV/k=;
 b=P3XwoJubUA9gfAGtR9JVhdlYj0f6i9fHro3hxS6DxkAcw/kdT0YYWcGwoZPurxl78g
 8A12r62UUNIRcixYNbeiu2G7E4oXLkQ2Xcxl/lZ4n3ae0zZcJCF1gylUHzoJI4D/aS9s
 K7zSs+sinz/ukb48w6/i1dpD6FTr4fFo6PKdarU+aKgaP13Gevl04VDMYsPHZOy/aKuI
 ocec3GNubUheojnztdq0eoJoeQ52z/1rCxwjHyiDjr9ecZHPpxOUSLbjq9BfNH5TK4wv
 J30fuoADe1qc9SfX026Qs0S3nNcUCSwoFayYtOOFhpPYwKLh6Eij1HKCWWdo5fZaimRf
 QwtA==
X-Gm-Message-State: AOAM531jnD4OGSeYCc5+1FvUHpLTCYK+aabpnU9l9eS9TMFCnSijp5HT
 M5z0MGZUgexcYuif0RJsOJUF/VxH3zv2l3CXIh5Jvg==
X-Google-Smtp-Source: ABdhPJwlBlqKZRxxZ0lZKimXnNpmKZliLLlU9M6GjhUnpfYBf4y8YUnVCNCiJgYoIPhhiLSWTaZfZx5+JcR4577kl3c=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr2717683ejb.85.1601651981818; 
 Fri, 02 Oct 2020 08:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201002121118.180315-1-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 16:19:30 +0100
Message-ID: <CAFEAcA9K31Dv6RsL6O3oQqC9NQw6P1DjE0f+2TME0p4URusEyQ@mail.gmail.com>
Subject: Re: [PULL 00/19] s390x changes
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 13:11, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit b5ce42f5d138d7546f9faa2decbd6ee8702243a3:
>
>   Merge remote-tracking branch 'remotes/jsnow-gitlab/tags/ide-pull-request' into staging (2020-10-01 19:55:10 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20201002
>
> for you to fetch changes up to be2b567018d987591647935a7c9648e9c45e05e8:
>
>   s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA) (2020-10-02 13:52:49 +0200)
>
> ----------------------------------------------------------------
> s390x update
> - support extended sccb and diagnose 0x318
> - implement additional instructions in tcg
> - bug fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

