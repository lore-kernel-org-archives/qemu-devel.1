Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96196C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40E823977
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nv+1s42y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40E823977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOsF-0008CV-GS
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLOr4-0007it-0C
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:52:02 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLOr2-0000n2-G1
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:52:01 -0400
Received: by mail-ej1-x642.google.com with SMTP id e23so3860784eja.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a3QB8E2tAOJeC6Qg19J7fDT68aL0SXzKQSqQHOZi+5Y=;
 b=Nv+1s42y1QtY9FU87FfMvpvauzxMoT9O9zcgFaPccswBDAWbVOBsYcubW04FmZkgG4
 vwiK5eDAw85HUNDx6ikDf/4J5wECeeBDORiCri0ylSBYE2DMIUZGC3xY86JsPkAFfLc7
 AAiX7s9r1jphA4/1FbIpIPMcuEat1mGZiOSCqKJjx14Tw2X7cYJu2kQ4ZCl7PCvgIYcM
 zBHrTvrQd7goAot1rjYstCSBl9GmbHFIpOhJG6VQvRmiODlEaUlwrQAgnvlGS9gD4vw6
 8jK3fAwKlYXw4/mt7udGoO2mv663jNQbjXaGpzc3KgOYhj5uGPCyIv6NfCB1BBC6ETT4
 vrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a3QB8E2tAOJeC6Qg19J7fDT68aL0SXzKQSqQHOZi+5Y=;
 b=m4MCkZyPPF8vBwAzLX9c7q2WGAqcvFNVEG9pIw2e59LxyzqykrE/7Eg14Phs9rBE4y
 OUqBtf3Y9fkybxbWGaWqrb+sskFaSRDZOXxBzpi3NB1B7qCSPLoKyz1I27K66Zf2acM/
 d1XZ8U6A36QDohd61F9s8hmGR5COV4GwUGzYi404TF7EJgmrNQuPZ47H0h/xmtIdg4Li
 T0VaGR7mYa4iJTc+9liu5DkbgT7i5LKGeD+Qu0joziEoH7GACTTA7X4tQYfmGAneBVlS
 /zGEDUvBvZXCESifOpY30qckVP7fHtdjwDK8Vr08peATb1sxUt2s8qtO/hvswSnmROaA
 56MA==
X-Gm-Message-State: AOAM531TUEFVYFlYlvQer/nrKGf/a+N9Inl2e5To5aLEaSXn2mmqxpf/
 ElNgZt4rY2a99DRvLTmFa2p5U5yntNNyrbbtDYczBA==
X-Google-Smtp-Source: ABdhPJyHRQeVUL36BhhNDvJf8snpSTk+wQPfykd6m0lmjBPP7iaI/r0nUvR6hZQHJkGD7RZ7tNppa2qkksGZ4gYlKwA=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr376528ejb.4.1600944718887; 
 Thu, 24 Sep 2020 03:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200921112913.555392-1-mst@redhat.com>
 <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
 <20200921083052-mutt-send-email-mst@kernel.org>
 <20200923164029-mutt-send-email-mst@kernel.org>
 <CAFEAcA8WSbvG9Cgp6J4fqp4AX-rCR2F3vjPsAVegv3axAFUiMA@mail.gmail.com>
In-Reply-To: <CAFEAcA8WSbvG9Cgp6J4fqp4AX-rCR2F3vjPsAVegv3axAFUiMA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 11:51:47 +0100
Message-ID: <CAFEAcA_EyDoO0nA39wrc9ERn=hQ08TWoMVHf1H1Lc2QMAfUjkw@mail.gmail.com>
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Sep 2020 at 11:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 23 Sep 2020 at 21:41, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Peter, you said you see issues on some systems.
> > I pushed a tag:
> >     git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream_test
> > which drops some patches I suspect.
> > If that helps, pls let me know.
>
> Yes, the original tag seems to just cause 'make check' to stall
> out (the logfiles simply stop) for OSX, NetBSD, OpenBSD and
> s390x. I'll try your test tag...

...if the test tag works do you want me to merge it?

thanks
-- PMM

