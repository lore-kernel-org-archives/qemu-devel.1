Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C067C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 23:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D939420771
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loscGXWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D939420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpgJL-0004wL-0Z
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 19:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jpgIL-0004VV-Me
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 19:01:05 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c]:33734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jpgIJ-0001BG-3U
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 19:01:05 -0400
Received: by mail-io1-xd2c.google.com with SMTP id i25so15309610iog.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FUa0m6sT/lDZPByjPFIB3dwbn3sMld9GMgCX+enquxs=;
 b=loscGXWs2RXhho7gtsrYD1w/Ue8+OaaC1QWEmPbTWqfVyjwN6lA4zr7ZiN5lbEdCJ9
 C4BdXT8s8FyjKIBhLTNd8h4hCuZ84BIIYK0m5sFkU2dsJ2YrK+B5ll6TjEwsj159cT+v
 RRhgYMLJ9IlkwsT2dLil2tgtfNo83Q682pAjyjyLV+ACreoIYXva3LvVgztf9MR7XQTh
 r17ObdZWp73hfmXuAYzeb7F4pACxjhF65SPUFtA1d7z6O2AOWo2jF0qLBnkqnSrRCdpv
 R+a3jolk+fs59XN0wGtCLbt9STDzlsMx9BjJkbkg/230irrZAlDQgoSRPH/QRE2n/iHJ
 Pvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FUa0m6sT/lDZPByjPFIB3dwbn3sMld9GMgCX+enquxs=;
 b=GtG5nEvL47eNmmR8Py26qZXx+DGXtHzfeSGJhq03kQwYSMK4aeaE/RtNvQXE1Mmw6G
 yNOuh6hQszX9WLHy0j4jddkRc+la+MF1a6kh6PubI6G+2xW5Yj+Fa9pz2PLCmvXkBQ5F
 V3M/aIT2JynR1mDfTZsS8yceHDRMh60qBxmjmPPBBdYNaHz9/i0/FX+Dl3xdFN2A8ywf
 tQXqwRAJS2erdQ28kky0vPxw0OpE5fUH13WLAqu5LI3nLQWbwQ2Xum8YXxBBY7Cqt4cq
 xTruXeJc+fvu4Mjyj1bwGmWLnwXLs8Ry7iE8gbdjS1OvKpRXBcNp7AGgDc+srjcJ76kX
 7uDg==
X-Gm-Message-State: AOAM5315tr1kQdiyHalkKJqAU1iD1JgJAD8TLD6bcyTHgo6J7NRvrzQX
 swsL/GM/9ikBI5RAdDXXYewos64g4UPAWqnn+FU=
X-Google-Smtp-Source: ABdhPJy3CLXun9vqIouVvQJdFUNmLQdam1h2tSCLv+/l3hyOBkHAaBsaPS2zQeOnQ+irA/KleHfJnpHyjhCSQUElyKQ=
X-Received: by 2002:a6b:8dd1:: with SMTP id
 p200mr14256348iod.118.1593385261145; 
 Sun, 28 Jun 2020 16:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
 <CAFEAcA-8QejH-sFsP_rmKuYdYbQdYRjrHaNz4vLHzfYiSBCKYA@mail.gmail.com>
In-Reply-To: <CAFEAcA-8QejH-sFsP_rmKuYdYbQdYRjrHaNz4vLHzfYiSBCKYA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 28 Jun 2020 15:51:20 -0700
Message-ID: <CAKmqyKNo9rPtbtqb1R3OFKH71geYjo0mZONNLxkL0Mg6bnb1Zw@mail.gmail.com>
Subject: Re: [PULL 00/63] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd2c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 7:30 AM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Fri, 26 Jun 2020 at 22:53, Alistair Francis <alistair.francis@wdc.com>=
 wrote:
> >
> > The following changes since commit 553cf5d7c47bee05a3dec9461c1f8430316d=
516b:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2=
0200626' into staging (2020-06-26 18:22:36 +0100)
> >
> > are available in the Git repository at:
> >
> >   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200626-=
1
> >
> > for you to fetch changes up to b39d59434ea10649fdb9e0a339c30c76e38c5e17=
:
> >
> >   target/riscv: configure and turn on vector extension from command lin=
e (2020-06-26 14:22:15 -0700)
> >
> > ----------------------------------------------------------------
> > This PR contains two patches to improve PLIC support in QEMU.
> >
> > The rest of the PR is adding support for the v0.7.1 RISC-V vector
> > extensions. This is experimental support as the vector extensions are
> > still in a draft state.
> >
>
> Hi; I'm afraid this fails to build on PPC64 and s390x (ie
> our big-endian hosts):

LIU Zhiwei do you mind looking into this?

Alistair

>
> /home/ubuntu/qemu/target/riscv/vector_helper.c: In function =E2=80=98vext=
_clear=E2=80=99:
> /home/ubuntu/qemu/target/riscv/vector_helper.c: In function =E2=80=98vext=
_clear=E2=80=99:
> /home/ubuntu/qemu/target/riscv/vector_helper.c:154:21: error: invalid
> operands to binary & (have =E2=80=98void *=E2=80=99 and =E2=80=98long lon=
g unsigned int=E2=80=99)
>          memset(tail & ~(7ULL), 0, part1);
>                      ^
> /home/ubuntu/qemu/target/riscv/vector_helper.c:155:27: error: invalid
> operands to binary & (have =E2=80=98void *=E2=80=99 and =E2=80=98long lon=
g unsigned int=E2=80=99)
>          memset((tail + 8) & ~(7ULL), 0, part2);
>                 ~~~~~~~~~~ ^
> /home/ubuntu/qemu/target/riscv/vector_helper.c:154:21: error: invalid
> operands to binary & (have =E2=80=98void *=E2=80=99 and =E2=80=98long lon=
g unsigned int=E2=80=99)
>          memset(tail & ~(7ULL), 0, part1);
>                      ^
> /home/ubuntu/qemu/target/riscv/vector_helper.c:155:27: error: invalid
> operands to binary & (have =E2=80=98void *=E2=80=99 and =E2=80=98long lon=
g unsigned int=E2=80=99)
>          memset((tail + 8) & ~(7ULL), 0, part2);
>                 ~~~~~~~~~~ ^
> /home/ubuntu/qemu/rules.mak:69: recipe for target
> 'target/riscv/vector_helper.o' failed
>
>
> thanks
> -- PMM

