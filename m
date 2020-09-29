Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A326C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AD2221E7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0i748Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AD2221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDbN-0002D2-37
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNDTX-0001V8-CE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:07:15 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNDTV-0003N1-MZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:07:15 -0400
Received: by mail-ej1-x641.google.com with SMTP id p15so14359174ejm.7
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RT04pNx78VMA9LPYMm5j9UMmMpAB7NyDUIvXtnkc47g=;
 b=s0i748YnK6JbxHTtID/0vQnTV7q49BvDrii+Dtk/EwehhE0PSiVPp0AtxkCUAJ4Ull
 JcjO3UNlCUNSsK3Li0pSd3MT32Z2+DwGGwzaFC5m9ykSIIDgaagsDgFyr/NWgJhbdLq2
 7HTH1a8ZUx9+8ZQrYrxezhW92Q7ArFPSet1Lhf4N+YWxZzb09AoxNvqmI+uPk392yncN
 oKhK64KU78sifOeq0LcsRSlwFyyKptHH29SUVNM3rIuZgB/BnWf+N8p3KBl4XmCoCITo
 lvasG55vj+0XC30q6Pl+yXFVjg+1dRgDaHO7OQV5R6bzseUY7vNuzn7rXzNZ/yfzGfHV
 2O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RT04pNx78VMA9LPYMm5j9UMmMpAB7NyDUIvXtnkc47g=;
 b=o79diksP/kFek7Ut/AEMmWUsUjdJZRcOxvDx+EXmQJ2EW+H1I7Zjv43pVCG+Mr/Smc
 eV5RDf1+y/KXJ0VGdtT9BTd9mcVIcyfpNgQtmLRYy2myUhhlaVyztlqomCYt1PU523s/
 GK9gbScm4CYs3N5pnCi4KaqF5TFdS/63ZKJkOBjrtp8JgCUgelAB62Cvyh5r4E7Iipmw
 56K071eHRCJzGJbsPQIvuBALxgVyGxqPloHTcdLhaIZ11x96oNcJe3hZqHlXj5gviCS5
 5XmimntIY8E94Eam9v5jjSYBcOYvJNWCkxL+5yd3qFkm4V525X94HdPlYJgAQ+IHCJxp
 2gjA==
X-Gm-Message-State: AOAM5313cOhfY9AIUO2Ei4eh5kx3gEECLxoQFPMzO8W8Il0v6NJWnJMg
 Lvl65CiBUZVcyoZnkNGgqF70U1XDWXl0ls5OC9z34bighNGLLdVJ
X-Google-Smtp-Source: ABdhPJxJK+ay5zto+Z6I1cFb1d9t2bMA6+2P0DqQiM9l2s3GxV8wdF+wfXvKMLH7JF/5G1yby+rz8DpjQ8csKm8H6Lo=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr3352634ejb.4.1601377632019; 
 Tue, 29 Sep 2020 04:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200929071948.281157-1-mst@redhat.com>
 <20200929070322-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200929070322-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 12:07:01 +0100
Message-ID: <CAFEAcA_D+qM6jW9LeB4gpU-A9skUv8mpWWQJ1uu9xMjw7nwxOA@mail.gmail.com>
Subject: Re: [PULL v4 00/48] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 12:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 29, 2020 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> > Changes from v3:
> > - dropped reconnect tests
> > - added more fixes, an smbios feature
> >
> > The following changes since commit 74504514b154ebebdff577d88e4bf5c13074e9ed:
> >
> >   Merge remote-tracking branch 'remotes/alistair/tags/pull-register-20200927' into staging (2020-09-28 16:49:10 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 8138405528c29af2a850cd672a8f8a0b33b7ab40:
>
> Ani Sinha pointed out that this included unnecessary files, I pushed out
> a new commit 192d48b4ae4216f0dc40fba35e8edf3b92713aa7 which should be
> ok.

Oops, I just merged 8138405528c before reading this mail. Could
you send another pullreq which makes the fixes as changes to master,
please?

thanks
-- PMM

