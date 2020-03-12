Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90814C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3722067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqBZLk09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3722067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCUWU-0000yA-K3
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCUVT-0007FQ-2Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCUVR-0001Ls-Eh
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:32:38 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCUVR-0001FN-90
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:32:37 -0400
Received: by mail-ot1-x343.google.com with SMTP id h17so7735119otn.7
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=20FeP4YJSM5ZyA5rT4uKYaieifuiYIb/CSQkxdbcHrA=;
 b=sqBZLk09QosH7P6ubASjuAHHGRr6IUSeeUTFrQUeEU98auTxKGNDZEED2Z3l3iyygt
 qvqInr4U1JR3QSryea9XB/7kwH2btfQiOYaW/W6eL2rolT6CvOzoTEq/rTORWeVkzFZ+
 WJ3Y38cSiPTZW7chuHTuhyjG+K7EG2kHIBxZmllrJreCIaKbYTRYTPsb17WEaxHztct8
 kJmADZ7fRZj1aJmqlWLNXXgsQ43RjQvCKNdURpbXg6dU8j2SDX86ydnyZXNutJQeRW/V
 5XhyyxGoWBhsoEZs3u73jB9VKPC1AIXvi0WFdWcXgeLQdBmhnnBDJfQYUpPOmX/qudeq
 NaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=20FeP4YJSM5ZyA5rT4uKYaieifuiYIb/CSQkxdbcHrA=;
 b=LuCPQHJjs2qAm/uejJVu5XYLuhDdb1zqnRVQNB51uPdB6hJZi9uFKxvUf/bpwvE4Z9
 29/MfVO46xPAC48Agc1tgyAp0Yw453o+zRApULxiCOT+7gTvlhe7JB/i+SpIpwOzHfAJ
 I7uUKAf+dFDsgAjnXLCr6PVa7HHQtiJTEbqPcP5mPUaEGUffiBBsyLWmzmR4gZP6XOAl
 pipvuN0+6r4Y2+g8GJXM9ak3+d7FWF06r9anTZ9uIOXzkDcN0JGitH8m8BiGhT8J9oWX
 g8QyJX77CrVHxVhUvjhWeSZzKkyKVumCSU4PLDyiPgUj8srGYKTFtnMEiT4OZLTa7wlg
 FokQ==
X-Gm-Message-State: ANhLgQ0exZLoVEFCvXZvuDF26dlITVcoDlTdqE0KfdfpTXbfDoPE493S
 +WcnSoz9K9kL/hDdJqYpuq0rZ+THjsAEH/cPREminrf5KsA=
X-Google-Smtp-Source: ADFU+vslz0/TutAoVD85Dzc7xJMhQD6kTudVLGr+JSZ8McWSd8k6Eip7ri1+A7uZ/mPaz3Aeq3wj56PPJMI/DriDqiU=
X-Received: by 2002:a9d:6c05:: with SMTP id f5mr8028571otq.232.1584045154329; 
 Thu, 12 Mar 2020 13:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200312164459.25924-1-peter.maydell@linaro.org>
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 20:32:22 +0000
Message-ID: <CAFEAcA8tN1w3=u=UAEkbw1=eEewfO-xacAyb+w9fug7p1etLBw@mail.gmail.com>
Subject: Re: [PULL 00/36] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> arm queue; dunno if this will be the last before softfreeze
> or not, but anyway probably the last large one. New orangepi-pc
> board model is the big item here.
>
> thanks
> -- PMM
>
> The following changes since commit 67d9ef7d541c3d21a25796c51c26da096a433565:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200312' into staging (2020-03-12 15:20:52 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200312
>
> for you to fetch changes up to aca53be34ac3e7cac5f39396a51a338860a5a837:
>
>   target/arm: kvm: Inject events at the last stage of sync (2020-03-12 16:31:10 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix various bugs that might result in an assert() due to
>    incorrect hflags for M-profile CPUs
>  * Fix Aspeed SMC Controller user-mode select handling
>  * Report correct (with-tag) address in fault address register
>    when TBI is enabled
>  * cubieboard: make sure SOC object isn't leaked
>  * fsl-imx25: Wire up eSDHC controllers
>  * fsl-imx25: Wire up USB controllers
>  * New board model: orangepi-pc (OrangePi PC)
>  * ARM/KVM: if user doesn't select GIC version and the
>    host kernel can only provide GICv3, use that, rather
>    than defaulting to "fail because GICv2 isn't possible"
>  * kvm: Only do KVM_SET_VCPU_EVENTS at the last stage of sync


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

