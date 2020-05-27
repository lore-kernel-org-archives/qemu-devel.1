Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F27AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C0320663
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AESdMemZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C0320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je085-0004up-GM
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1je06D-0004Co-Pl; Wed, 27 May 2020 13:44:18 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1je06D-00043k-0o; Wed, 27 May 2020 13:44:17 -0400
Received: by mail-io1-xd42.google.com with SMTP id r2so16687049ioo.4;
 Wed, 27 May 2020 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VN0HAw1UpgCzRN5REzb2GYHooDMY8JPD7ej0ICJDsH8=;
 b=AESdMemZyL1O36rB6D8KoJu+JpZM13QrhCSc8JsPgvXm1hA4mg9i5etb7629NrWKM/
 Y5l7yrhcrjxxIG4icMfNrTCz8SWYOjOz+QgqjMRac4CLrMIgps6xUV+YDgjNTmMgFXBz
 nANgq4euByIAX01BKtiE0VL1fwLSYwwS9H1ufaiqRAsCHqKANHv3bY7mUOwNLi6YdpK4
 qP8AHctrbgyr1g+NLt4LpSypHvuJCdgBYYjUgcXya6n0XN5Xyz12tOps1y9eR8QcP8o3
 XFPngJwa5bTAr/SaaUnfeIF78RwnLqOpafCjjHeeRIPuArvPSOupd5A6TiEnYLGypeQ3
 G0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VN0HAw1UpgCzRN5REzb2GYHooDMY8JPD7ej0ICJDsH8=;
 b=pRHdD7vdIzbKTbIk5uA0nw4hA1mZTnk7WosuwNQPbCHDPuVLZ7STMmqmgmZjEP/Sou
 /okBgtKj7SR36SZJQ9yodzRuDokcxUrSLTeF2DLdRYm24Me7U0/q+/sMulexZfs1tvpf
 B7O60E28a8mCxWyFdratvM37fEHnpfXJBdu+IvGbgTI3Z2TLmjXrTIyGTpdK95Y3EowY
 5mkG9MmGltHgfV+5wiwR3nIOEJv1hwaXDH8VpHfwhWQGjNV/cOvyST3d4j0wRIQlXU5m
 nJqREkrZkD3XVeBU8oMsXF0zZnW+3YWvMtvrQHq9RMqxEddygG/r5G7bAYCeNa/xdSQU
 5/cQ==
X-Gm-Message-State: AOAM530EgGrOwiDgBQ/ltq+1+7BuqqBk7FSZmjAXxPiIqWGi7u3jp93r
 hj5s2smgIkK9t3u9raAobRjPW7QrxigHtnNpldw=
X-Google-Smtp-Source: ABdhPJzpxqmVsMOmcjNqN84PH6cBQwqfvSVnXIrqqQ0Z4/VsTB8U/HxdC9Y2yjOo1ettNJTIvg5bqXZqB0Uy6xPgJS4=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr22671642iol.105.1590601455208; 
 Wed, 27 May 2020 10:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590533156.git.alistair.francis@wdc.com>
 <0c7494fe-f812-9ee4-6c35-bc1991d0aff2@redhat.com>
In-Reply-To: <0c7494fe-f812-9ee4-6c35-bc1991d0aff2@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 27 May 2020 10:35:15 -0700
Message-ID: <CAKmqyKOY0m0uZMLH1wcS=vaJqy-EEBG=Sm0t5uLaLt8u366Miw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] RTISC-V: Remove deprecated ISA, CPUs and machines
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 12:17 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 27/05/2020 00.47, Alistair Francis wrote:
> >
> >  include/hw/riscv/spike.h                      |   6 +-
> >  target/riscv/cpu.h                            |   8 -
> >  hw/riscv/spike.c                              | 217 ------------------
> >  target/riscv/cpu.c                            |  30 ---
> >  target/riscv/cpu_helper.c                     |  82 +++----
> >  target/riscv/csr.c                            | 118 ++--------
> >  .../riscv/insn_trans/trans_privileged.inc.c   |  18 +-
> >  target/riscv/monitor.c                        |   5 -
> >  target/riscv/op_helper.c                      |  17 +-
> >  tests/qtest/machine-none-test.c               |   4 +-
> >  10 files changed, 60 insertions(+), 445 deletions(-)
>
>  Hi,
>
> looking at the diffstat, I think you should also edit
> ./docs/system/deprecated.rst according to your changes?

I'm not sure what I should edit there. These are already marked as
deprecated, do I need to make a change when they are removed?

Alistair

>
>  Thomas
>

