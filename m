Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA13C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678B3206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlHRaODZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678B3206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAhdU-0000Va-IV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 18:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAhcq-00004x-Ak
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 18:41:08 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAhcl-0005nx-3m
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 18:41:07 -0400
Received: by mail-io1-xd43.google.com with SMTP id s2so198940ioo.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=unK95Z2M491TLUQEjef2+HJLGHlOl+N6VB1ICEcb8kQ=;
 b=RlHRaODZJFSJyQQZpqcp1jAnkBfQ1lmgMx1QX2TVMUI1Wv2MbJC/EwBqDBOpzSM2AM
 lg5yWv8ixx2Uv5TT4eeIYgqEvm+Z1i02wreQC0Eo9S+CbM75ApivyXCwEsPmSJjNvRpn
 AZziUl2WQtHdRMD7Fmm/kimW40AJWGK65sVfWw0wLXmr6sjO7GK+42rGVMqPp72T0tDu
 cyefdyMuyDGJkAbmFAykSF0zEWG9qJO9/y9cBoMscSs+5GFxGnxRhM1pMYbQo/dxwk3X
 1aoJKNh1YddQifia2jqHnqOhd1IU2LEQEzadDiD11PRPVOGwFu5UGZmQiUcULq9LTAGT
 a/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=unK95Z2M491TLUQEjef2+HJLGHlOl+N6VB1ICEcb8kQ=;
 b=e8cijMAdFEjV92kNrsKTU6TDViAeNoBMg+1PoLA4YBqvbwidAtCpd5gQgThGaLF/ah
 Nj8LUjxJ/IRRBjvOyok4vE0hk6cahG8pT5Q7mA19XzG/483ispLijLtCRi35EtuGsAqr
 DxxT7rh4wSc/EVR5ts8Zdc/3W5IVZt/b33ytWATUp36MLQoWvzBBtg972oReGSAxkeRc
 SbCTEB/IJrPhZx37kxRdzFhPy07blEG4jJwipHFpWcLVHY3C6Y01ye0qj7Sb6rIjY4uC
 hVB2VXXHTp614YOXK4Ty/N6z54Ok/JcpwSBIfPiII0uakVGNfdW5vQPQrEPDlTz0l5e1
 CcGw==
X-Gm-Message-State: AOAM532W1K77/Hqyj00/1uOcICgvaklbLxMiMNYVNJVhA8C1HX/m1/Ng
 eHHXyRu7Uyike0j3RbArQ9n9ci4MnZzcJLOVLkU=
X-Google-Smtp-Source: ABdhPJzfQbiTHRZqTSkRrM2yaOZtpwzq/+kDIdy/btHtRn86KlyQvNyRCwN0SDZAfRQlrkyG0XXqok2YTEZ6LnHYkGw=
X-Received: by 2002:a02:950e:: with SMTP id y14mr12545293jah.106.1598395261458; 
 Tue, 25 Aug 2020 15:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
 <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
 <CAKmqyKNxURXyNSEePPU1jY7FzcZjRThr2qAvwR393+nqUXBxJQ@mail.gmail.com>
 <CAFEAcA8x=ck1mmJ8Y8o-0NQXWhRgOg5Gp7GvHNkNnLb6rDxygg@mail.gmail.com>
In-Reply-To: <CAFEAcA8x=ck1mmJ8Y8o-0NQXWhRgOg5Gp7GvHNkNnLb6rDxygg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Aug 2020 15:30:18 -0700
Message-ID: <CAKmqyKP6OUoaR6iZ6SD6qZPvYF0bKqpB_rRNeQOteg8BtcqKeQ@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 2:50 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 25 Aug 2020 at 22:32, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, Aug 25, 2020 at 2:24 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > The hypervisor related patches don't seem to have any
> > > reviewed-by tags, which seems a shame for a fairly significant
> > > chunk of work. Is there really nobody who can review them
> > > for you ?
> >
> > Unfortunately not. They have been on the list since April and haven't
> > received any feedback.
> >
> > There isn't a lot of people reviewing the RISC-V patches unfortunately.
>
> :-(   I'd hoped it was a more active target than that.

There are lots of active contributors, we are just short on reviewers.

Richard and Philippe review patches and some of the RISC-V patches get
reviewed by the RISC-V community. The main problem (which is a common
problem in open source) is that large technical patch series just get
ignored.

Alistair

>
> -- PMM

