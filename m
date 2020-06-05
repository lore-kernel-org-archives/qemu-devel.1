Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31338C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9CE2065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIN70apY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9CE2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhCLK-0006wu-4j
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 09:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhCKm-0006Xm-Kw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:24:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhCKl-0003Tz-J2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:24:32 -0400
Received: by mail-oi1-x242.google.com with SMTP id b8so8221997oic.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c9T9dgLjpTLIHsLNR1TM20xc19kwn4VK2CuRiMqOe9A=;
 b=iIN70apYacyx7mIVvwEjB/vMOwRn18odW3XVEN81YWQ6GB6aqozgqbpSoSExWehoiV
 GUTx9d4deFyJ7O7SMO6NQt7KWJ2mbOF6wxX86x12pD0nSINcCA0LKxP+tUoTQCW6zBM7
 /hp2U7c9yVAAGh7dB94lKqbr27QOGOVJQ9CfKndg5EcdrbD+nB8Tw0P5HXtfFN04HpTm
 0zvL4f+J7+FpUCuB5V60PXvZbqepcr0yh99Tkma/u+9uFFyRh/lLIep+3C0N53qGpqOP
 aLjyYwnTBwBcffRirzUJznguNgwKxMzG5gSHSoClVpyuOPulDq00vcbb7iy3pKug27SA
 HlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c9T9dgLjpTLIHsLNR1TM20xc19kwn4VK2CuRiMqOe9A=;
 b=b+bw1ORV17vExJXvUEiZ8FE3LgMvGHR/4MIT4ywhJ2qjBN6jfvymKSzEXDEZWv2fun
 jER5+YN05pqh7Xzpid2ACXM0LXBjgEL5A+eUqJ34jaYQbvR3qNkpPMlqGGZMBtYmqiRN
 hOv5JTgoacjJrU0+qJAftJ9EM9770KTlew6ULkXGPksaTiavfNLRgnD8dCVuEJaFlO9y
 8Ic3fWSdbk1aDb8nYGBgW/9BO4bn5BQELWni9jGfA4qbeSQUh5PFCfR/LAK1fHpsh4Mq
 6roYyApivYENuihgJURXU8ISQYYiN6pJbxsvP/1WQB3+cCgJpv1W4nMfzrNXP/tDD72b
 P8VA==
X-Gm-Message-State: AOAM531Oy2rvo6BZvoHKtufadMraBi2tLgIL5EEAePvgy16TuwELS+Mz
 t/FTTkhWBkVsyxYbuUh+KzgsIQjkl183ZdhbKgdJhg==
X-Google-Smtp-Source: ABdhPJyzoe84WazvD7UWHabSVUfOGXRqHhlbgwhGup8JGxWVovrjXQu/fe9CewDFd2IV3oVFsEqoAUnkZwUGui57xKo=
X-Received: by 2002:a54:469a:: with SMTP id k26mr1872899oic.163.1591363470008; 
 Fri, 05 Jun 2020 06:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200514212831.31248-1-richard.henderson@linaro.org>
In-Reply-To: <20200514212831.31248-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 14:24:18 +0100
Message-ID: <CAFEAcA9No7VVAt=eiBmuq0Sy78Q5Zjcbu6SKnd=hvvASsEKyzQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] target/arm: Convert crypto to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 22:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In addition, this fixes the missing tail clearing for SVE.
>
> The sha1, sha256, sm3 routines that are not fully generalized
> are not used by sve -- it only supports the newer algorithms.
>
> I'm not sure that this:
>
> Based-on: <20200508151055.5832-1-richard.henderson@linaro.org>
> ("tcg vector rotate operations")
>
> will be sufficient for patchew, because it also relies on
> today's target-arm.next merge to master.  But you get the idea.
>



Applied to target-arm.next, thanks.

-- PMM

