Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF73C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98235206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhIik/DX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98235206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLKI-0003hp-Ti
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLJV-0002qK-CO
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:01:09 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLJS-0003wP-Ug
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:01:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id 95so15992091otw.10
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E5rO2xkav8qempBVEekmcKPJ77H6iG3rRif77s86Ajg=;
 b=AhIik/DXfy2epE5Yz43CROdtoC5KMu0B6oq3VndRKh6iqK8kYO2BsOvUnRhu3QZvLx
 4QR/GVl5BGcODHM94yd2OpB3/GvAfliIrSwitIAegpRmI7cR/SP/1K1jsTc8LR0YxirT
 /aDpq5F1XmcZeag1N46Y3oBedrLBf/9UD64RzCmjbDcwa2CIa6yp+SSk2udxPG/GW/KD
 dJihy4DKTUtxKdbkyhAMgsE79Ba7LQR4kjZZSQ5fJvQNCQhwHaz/nznkiM51hhzWrBL5
 8S30GJNbmWdKxe62Lvm9y1m9VhEbnhuIrncwuQK0ezJ8zmVjWtJXj8WHQ8LjyTuSXOlr
 3JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E5rO2xkav8qempBVEekmcKPJ77H6iG3rRif77s86Ajg=;
 b=g+qttqkIVrpjFC4qxOPIIOy4i28qo2skvy/oMbx3wx19Mj+yVH9A07mYNTVEoBuKEk
 aJHuZ35yb5pVKEEMCIX+ZTFFA9wQsjq5HKaJIfT9lc2M8NX+3x5DF1U9iqYUz8KSsw9S
 43V7kly/M9ZUDyqLHZQRT0SzaaM3ZebPQcYtrpnTCSlAi0m63+abtOGt5u9NMlEu9oZM
 zIqhsSu1P6eBZOApfSf/6FvSmKXMRTSDCVfFIDBqmEfM+YoSzLZKPsVAOj3WVw1KSY+M
 lfRYecCB0GElRBYgF1wTwYP161NTXk7/MM0FSnC8vYjijR7n2WndwkNBvVsrGVv4Ucci
 HbXA==
X-Gm-Message-State: AOAM533tK0/EM38iZHMIGZGPGfVL73f8zcQZKaRWRXT7mtYwtIGzIRuj
 ksuDbnLN9J7hVwxTgV0Bq5N4huUVWBFA5b0rct65Fw==
X-Google-Smtp-Source: ABdhPJx/hSX9eOK8XYmESF6MLIATWFTIDJ2rBcyfo9GSqDL5P4aLBbPS2JAdAdxXrPqepYPaRjaIIEtmyCcFWTWO7ys=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr23075129oto.135.1593781265438; 
 Fri, 03 Jul 2020 06:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200629114110.30723-1-beata.michalska@linaro.org>
In-Reply-To: <20200629114110.30723-1-beata.michalska@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:00:54 +0100
Message-ID: <CAFEAcA8F-LR8qBw-ozp=0pDe2f9oC+F1fQW4xDO0ooPRws53uQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] target/arm: kvm: Support for KVM DABT with no
 valid ISS
To: Beata Michalska <beata.michalska@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 12:41, Beata Michalska
<beata.michalska@linaro.org> wrote:
>
> Some of the ARMv7 & ARMv8 load/store instructions might trigger a data abort
> exception with no valid ISS info to be decoded. The lack of decode info
> makes it at least tricky to emulate the instruction which is one of the
> (many) reasons why KVM will not even try to do so.
>
> So far, if a guest made an attempt to access memory outside the memory slot,
> KVM reported vague ENOSYS. As a result QEMU exited with no useful information
> being provided or even a clue on what has just happened.
>
> ARM KVM introduced support for notifying of an attempt to execute
> an instruction that resulted in dabt with no valid ISS decoding info.
> This still leaves QEMU to handle the case, but at least now it gives more
> control and a start point for more meaningful handling of such cases.
>
> This patchset relies on KVM to insert the external data abort into the guest.



Applied to target-arm.next, thanks.

-- PMM

