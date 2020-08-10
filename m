Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835D2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0F0207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brNqlvSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0F0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CVj-0000yG-8I
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5CJV-0005pZ-7m
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:14:25 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5CJT-000289-9c
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:14:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id a65so8013870otc.8
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P9N+4wg/QjLK1C1fhMrTRf3g+gzYGq9hUP1q66TtW+Y=;
 b=brNqlvSKIQbOcNMbaosgNAfE/y00nkdADY80v/8BlVvGXzE6/ncoLo5HupSNLbrvTh
 tokkzdQNlCYsXl+3x7et32+Yx8Bl25dfCEJtaV0jjB/SFFFTfc5qWopBSaMcKMBL2vYA
 wFpRfMoRDl8KlgrIYVN4BzTAyMI3uyYvTmftu+mXO3nWO+6OdwrXexRNlgvA8FeZEFNX
 +fQHJmpaI3+mSUh0H3nenzb+lmoJmZBmPKLr4zkkoodZAjilZglHrIOgrqZ0k5bArf72
 gwkJcV2Mhs0SZNeJ0Skig0ohKBWADLjYokiwY++fEXM+v45uuWRybc1Aw4sQV9mlp5iC
 RGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P9N+4wg/QjLK1C1fhMrTRf3g+gzYGq9hUP1q66TtW+Y=;
 b=fz3Uj53Z/SxozrGbcG7oejL+uTP6b3oqm7L+BeR49Jj2LfRrrhUXXA4uocNfjUOMVN
 9yBb+DVC4WaVAjUQ5UjN+7J7csMrQGZLZEdOVjGpIA17yPviqHrIM9NnswyfR8JXlnVx
 xOiCernjEzyE7UeGcfJQo68vWCcxzobgdAEoSm3Jk2b77y7qluEz/dBYQ9hdVgcvobcq
 BSc15qpy9aA1ntqGr22/GmqBWF7+Hvr3ZqmZJOGxnxWGq3ranulOIfeiCjbe9NsmREia
 eyveqINIBHb7MhNePyC9tlesyNFeKVfYUkBLS26Ug/8I4kETZPPMbvN0T1Y8MkgwGZyO
 QJqQ==
X-Gm-Message-State: AOAM5324+37/NoihBBujIoU3gqw1LvzirAxGufo6KwjLinfIkElrCr17
 GUrNi1u9+psCyyBHRVSQay62NYLEpL065m2zpUCq0g==
X-Google-Smtp-Source: ABdhPJzwFlW5iaFAuFk/ZsnR+ePvEd2N0pqGkiJnvPuE2UnQwUtQ5mn/BHrrzShOLdkcg/feqL3BAoIv+8qidrEmghk=
X-Received: by 2002:a9d:24e7:: with SMTP id z94mr1771079ota.91.1597083261864; 
 Mon, 10 Aug 2020 11:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
In-Reply-To: <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 19:14:10 +0100
Message-ID: <CAFEAcA-RULUBoTtkr3JWUhujfXYbcaj9+v-UBjdTAMcda7FDAA@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 19:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> The other hosts are still running, will report results as
> they finish. These are just the ones that bailed out
> immediately.

Linux x86-64 succeeded but produced a bunch of warnings:

../../meson.build:9: WARNING: Module unstable-keyval has no backwards
or forwards compatibility and might not exist in future releases.
WARNING: custom_target 'shared QAPI source files' has more than one
output! Using the first one.
WARNING: custom_target 'QGA QAPI files' has more than one output!
Using the first one.
WARNING: custom_target 'QAPI files for qemu-storage-daemon' has more
than one output! Using the first one.
WARNING: custom_target 'dbus-vmstate description' has more than one
output! Using the first one.
WARNING: custom_target 'tools man pages' has more than one output!
Using the first one.
WARNING: custom_target 'system man pages' has more than one output!
Using the first one.

thanks
-- PMM

