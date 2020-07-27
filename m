Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4969CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB20520714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBLAhPJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB20520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzyXh-000366-Rf
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 04:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzyX5-0002fQ-8y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:30:51 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzyX3-0004o9-Le
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:30:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so1197578ota.10
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e0o5NYbbWCEMr39olTb/SDA+lN2+eYmZEfjBFGfw9ws=;
 b=UBLAhPJ4gcepDxpi2xk1GlVXa6GT9pgxOfFSXZwboD3FgabCRaZixCX0QB3waaZc5y
 VuKUzjd04WW4D3aMXuj+JNiRb1SQwf8spj3uQIgX3hf3c6yJ3TmFx2T28riA2LppHqXW
 sC0dc42uPMkvzT2hlSomqlbRTnAvKFNHHYcwQZh61gwJJ9MgVXdUR92AlCNbWIUxa1m2
 8OCTzxZBWbVSZviN4x9sxcbwmqYka3QUCST/jQgsYMnJcXFuEWKW84NVCmef+ZfqFuup
 3vCImAEhSJ/H2osgOQPybvBQCmsFDR/r0/YcAiiug/H1DgmkKTz06Rnn9rAmFtuJ5RLb
 Xzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e0o5NYbbWCEMr39olTb/SDA+lN2+eYmZEfjBFGfw9ws=;
 b=NP1QHZHO8s7T/ZTegfjglHJyVoM5QTP5TSNQi89I/TAK+oprcIMpUyFSHDBIKcIuZu
 rI67nnGT09zcwxm72EI0g2BQp5AiOiqeGgefW9bss0IYvsE0uefMVuk+UV6+9ohV7ip9
 XVNqrVuVqQZDrk3lroGft+fy7q0p3rSt4a2wK8Ic2I9IaVPyTG6UvPK+DOiLMIQ7lipK
 BU0KjoqohAHTulfaXA/80Xv4PPbTnD/Qi3SHgrREmsgKDsFCv3BakH1DIhARWtUxw84i
 B4xBfEfkGqkdF4B4f+3uuduESXKXRbh6yMAarH0wlhhagMUzHjIjX0GN4h+NZ9K9VUb/
 ro6w==
X-Gm-Message-State: AOAM531zbqfPsnILB8MIEBibocrTV2xdkJLEotjM/OxRHax4EcB/Z+UB
 FHGhuu0nG4rdQmNNmgI/HJhEp4XO53G4jA/qaBz8Vw==
X-Google-Smtp-Source: ABdhPJzq6GvkgFMLusL74/siLDWFXO6bHIN25aNaFGG8FJUrzMCtb0cVXcH+1hlPi+RXXQc3e4o+MbjPLfNBGkGM6Fo=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr19313985ota.91.1595838648195; 
 Mon, 27 Jul 2020 01:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
 <20200724144651.GG3146350@redhat.com>
 <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
 <20200724164901.GO3146350@redhat.com>
 <5257b25f-62e8-4585-15f9-87ab5b99cf2d@redhat.com>
In-Reply-To: <5257b25f-62e8-4585-15f9-87ab5b99cf2d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2020 09:30:36 +0100
Message-ID: <CAFEAcA8gVHy3101-fyVw45q=QegRGOv_k3yA40MkeseL5vhawA@mail.gmail.com>
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
To: Thomas Huth <thuth@redhat.com>
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 06:44, Thomas Huth <thuth@redhat.com> wrote:
> Sounds like it could be done, indeed. But I wonder whether we really
> really want to silence the warnings here? We'd hide the information to
> the users that sasl is apparently disliked by Apple and might get
> removed on macOS in the future.
>
> Maybe we should rather change the "configure" script to disable sasl by
> default on macOS unless the user explicitely specified --enable-vnc-sasl ?

Does the Homebrew packaging of QEMU depend on and use a Homebrew
packaged sasl, or rely on the system sasl ?

thanks
-- PMM

