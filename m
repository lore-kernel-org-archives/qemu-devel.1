Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8353B20786
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsSvLm/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8353B20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJ6G-0001wo-PA
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmJ4S-0005mo-OM
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:36:48 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:45296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jmJ4Q-00051C-Ve
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:36:48 -0400
Received: by mail-il1-x142.google.com with SMTP id 9so9586537ilg.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aaH9X0n7j0dnCYXLc9dDiUcmTNR1I6fIFHyALcq1pp8=;
 b=FsSvLm/XD2fJWxk6S2CT9ksBuBsZtTuTkz3tCMQIjxPnFMbV66jFakry12bEDoogQd
 JNkC+nt7QXPVmaYkPUz9VWblpGzwjC08Xu19jQfqmkKKJZMgkMJS1cKSUL/KiyTStdhw
 8DttoHKNxdcKV/WRm3tlMxFfhHW06dy0Bw5r84USTsQ6q6/C10aRS6tDKshdnuCIfsi4
 dtFBGdJDsHNRIMTzuyK2Chbqu7kvVxm9NyMYSpKImbHyTYOYswIl9pjY0jk9slXxhmfD
 i07Tu4Dh30ldB6QopUCLFsV3Ms2kSC0Tby8CwmduvzR/5WgWfSgiWSehPBTMLgPDfVyy
 fkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aaH9X0n7j0dnCYXLc9dDiUcmTNR1I6fIFHyALcq1pp8=;
 b=tMkFbpFrLL7EXNDfK4s2iLmoVU2Bjs9odhq4AzZLBCQvtW4ubwF58Ruy7gmGB9ZTbV
 BTpIo0Z9P5ZviGYvftfQ5gcmVhG5L/wnuY/ZxtmPVFF92U84uNkNr99wPHyK/nePegEu
 MzxYOvQaS4lMz3L+VgOUAXOz9lYKBRs6c39NviXs+WBwE4Jo3x+IZ6aoDHp+YwarOEd7
 yYHaSLADjg7t6UoD7Q2bJDwhs1wK06qmKSd/79ixBdbtCH3l5wrR6p0nmDhlRAEyVaOn
 ICtzofNGq8WkdIeJGJGShwnrIomTmRMp9BhH+kl5QtN9To3xKGbw7b3Pfu1yqGVGxtcc
 jpwg==
X-Gm-Message-State: AOAM531gO3qUI2au3EjZkd3c6P1vyvXMopAQuIUUn2LxbDC+iQAIzgZn
 mjmcLd/hXzPZ2pvq+pKLNtCD4/VIof2XRdNahrw=
X-Google-Smtp-Source: ABdhPJwZSbcyXypxgi7kay+dK0CZz9E+l0plpe90aym4DZf9kX6hdQWLwAt2LFL0jv+l3X5Dxx3H8cPVnlqdIXD2S9A=
X-Received: by 2002:a05:6e02:4d:: with SMTP id
 i13mr4404824ilr.227.1592581005373; 
 Fri, 19 Jun 2020 08:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
 <CAFEAcA9VKbE89N3YkpN4VhcEHD92=fGb3W_-mgqd+yY0rc0=6g@mail.gmail.com>
In-Reply-To: <CAFEAcA9VKbE89N3YkpN4VhcEHD92=fGb3W_-mgqd+yY0rc0=6g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Jun 2020 08:27:18 -0700
Message-ID: <CAKmqyKO+YLQ+kYMsPsfBXPETAxKJJ1NE4PvhObZMy3DuFoUS8w@mail.gmail.com>
Subject: Re: [PULL 00/32] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 5:37 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 19 Jun 2020 at 07:34, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > The following changes since commit eefe34ea4b82c2b47abe28af4cc7247d51553626:
> >
> >   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200617a' into staging (2020-06-18 15:30:13 +0100)
> >
> > are available in the Git repository at:
> >
> >   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200618-1
> >
> > for you to fetch changes up to fad6a8463510ff5e0fb31bb451a6c3218a45d179:
> >
> >   hw/riscv: sifive_u: Add a dummy DDR memory controller device (2020-06-18 23:09:16 -0700)
> >
> > ----------------------------------------------------------------
> > This is a range of patches for RISC-V.
> >
> > Some key points are:
> >  - Generalise the CPU init functions
> >  - Support the SiFive revB machine
> >  - Improvements to the Hypervisor implementation and error checking
> >  - Connect some OpenTitan devices
> >  - Changes to the sifive_u machine to support U-boot
> >
> > ----------------------------------------------------------------
>
> Hi; I'm afraid this fails "make check":
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=riscv32-softmmu/qemu-system-riscv32 QTEST_QEM
> U_IMG=qemu-img tests/qtest/qom-test -m=quick -k --tap < /dev/null |
> ./scripts/tap-driver.pl --test-name="qom-test"
> PASS 1 qom-test /riscv32/qom/opentitan
> PASS 2 qom-test /riscv32/qom/spike
> PASS 3 qom-test /riscv32/qom/virt
> PASS 4 qom-test /riscv32/qom/none
> qemu-system-riscv32:
> /home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:438:
> qdev_assert_realized_properly: Assertion `dev->parent_bus ||
> !dc->bus_type' failed.
> Broken pipe
> /home/petmay01/linaro/qemu-for-merges/tests/qtest/libqtest.c:175:
> kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
>
> This is a recently introduced check that all devices created
> get realized; probably somebody's added a new device in this
> pullreq but forgot a realize call.

Argh! The final rebase introduced this. Sorry, I'll send a v2.

Alistair

>
> thanks
> -- PMM

