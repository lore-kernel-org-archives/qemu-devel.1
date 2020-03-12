Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447EBC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1496A2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHzgIens"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1496A2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQmp-00015c-6a
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQli-0007wL-OZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQle-0000IB-WD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:33:09 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQld-0000G2-3I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:33:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id j16so6927575otl.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0VRQIv4qXD7Q5fEXczD6vOATnHwuTS2cyDP1QenEnps=;
 b=MHzgIensqHxS/3cxZERb3e3XdvDQgU1GjlryxvGwB1bgIgw+JbE+enfvDyonB3f8gM
 JnpcV1DAUyKyX/ipEBnESgQBXOyxs84B6XQxy+w0hpy5q1f1lZskT8gMhWafZvCjU8vu
 pfaICmM0xEccLFKpQA3tllm635JBBL4l1XiERi+YDqAA2nRE+uDOKOYw3BhigSmmecMW
 yYEK73tlWmhBkpy6JwrrrtlzJ9P5ca8iy3GnFCEHPh6InXhLe/93sysmRKRGxtAeulvr
 FRD50l9e9HlVFC+QSVcP5AWWDo0O0huF8PLvuiBMGcu7+5ghCc1TOR+howe0OaLTKGnH
 DqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0VRQIv4qXD7Q5fEXczD6vOATnHwuTS2cyDP1QenEnps=;
 b=LpVLu4SBBcA/7Gr4g8tsoomIy451CIauFVJWaY0gUCMtbQrLZcbmvsAfTGHzsXlBEb
 KhCXWstnj7kfWfTPqbckIaCf1V0aFXXnvSwpMdgo5chT7vEH9CpGK/0y69Fc3PzoQk8A
 3eZ3V68+ip+O9LhlZVg0CqK3zchDPf1pOuhb1LgHS6BvBptk8cppV15d2A8H4R1UzKhe
 icmvXDbXhKCdYZrBs0M+zG25Dia2NpLLjPpV+MGoTt27tRp3L6rkNtXQcx35gAE8hDqd
 KFusJ9mMsjIN7s5aZN0WMpkaJNcxP7jnNBU9Ei/hWvjQUG5eUbm0vp5FlQ4bwpDqquCN
 MM2Q==
X-Gm-Message-State: ANhLgQ0vyM3Lwozob4iETY7oTxVFTH2+HKzLrJimh49Qf/+3W33SwanG
 lX13ihXzXSRoZ3KRGxnVlTTMp+Qz2YU1rUQD9giltQ==
X-Google-Smtp-Source: ADFU+vsQTL+6pcesecAzObSP/AMwX5+2/sIepkjwZse514F/Bluy0l5CbOVfSwNDL3YK6i4MXxcyW+23beeY+Qb7fMs=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr7105904otq.91.1584030782701;
 Thu, 12 Mar 2020 09:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200312003401.29017-1-beata.michalska@linaro.org>
 <20200312003401.29017-2-beata.michalska@linaro.org>
In-Reply-To: <20200312003401.29017-2-beata.michalska@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 16:32:51 +0000
Message-ID: <CAFEAcA_5avBsNJUDh6o8vGfm4DGcFA-iT-UNG5h8M+hPDOif9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/arm: kvm: Inject events at the last stage
 of sync
To: Beata Michalska <beata.michalska@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 00:34, Beata Michalska
<beata.michalska@linaro.org> wrote:
>
> KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
> As such this should be the last step of sync to avoid potential overwriting
> of whatever changes KVM might have done.
>
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>

Hi; I'm going to take patch 1 into target-arm.next since it
seems worth having on its own and I'm doing a pullreq today
anyway. Andrew's given you feedback on patch 2.

thanks
-- PMM

