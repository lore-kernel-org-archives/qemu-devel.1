Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264ADC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C1420719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKZDteuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C1420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmpC-0003Am-43
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kCmWP-0004dj-PI; Mon, 31 Aug 2020 12:19:05 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kCmWO-0007VX-3E; Mon, 31 Aug 2020 12:19:05 -0400
Received: by mail-il1-x144.google.com with SMTP id e14so238642ile.6;
 Mon, 31 Aug 2020 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qLWwmNK/+rVx/1LFPymqX5sgTpx4sJfNRhvArNptifI=;
 b=kKZDteuV6eflCOtcsdtjYVB3uZ64Ku/zMJHuDVdIHZWSd3HY6K8kjRn3UYq2bqcsIR
 q3/PSzSB1RbhUsO+YePK3AwXEjtLOoOPo6/S+k5LAPcCpkmgJvjTQm/9h5mJSWmBN4JL
 b/ljgggouYcu5HGJpC3ej8zsD0hOK77YN9gZE18DWAb92BVk1ekosg7+XUMUCmCajsRU
 xBos2UL/IGGxs6lDna7OZH1L3XTKjGmLL3nFb+v758J4ADyzT6o/O/meqfTE2ps9jewJ
 EV69Ey8+/oKqXqUI1Y9sWCgV1L2jq268/+iGImuj4LQ+5v577MKJDoPeOT2rXI7HPVT+
 br9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qLWwmNK/+rVx/1LFPymqX5sgTpx4sJfNRhvArNptifI=;
 b=UZovwVKu9xbHAgg13REJ3WzRRIOAnxOi23vANBGi+c2A2JaC3MnoutEacc1h7YmbXq
 bHwgHDMsRNf6x5yriCZcRAV26j8nrfMPc4kYHbnx2W3EUt6t5wdkAx3X8WW+sXaxuf1t
 kGRZhmDRycyBTSLE3OJZNPiMOq44oblCBl4yCp6csmBlH81iEjeFbaYqVfyCq9bUomj1
 Z0AxcukXVA6iP1tO8lclNimidvrpdDVHWqtlzk6VSf4shCk5rQrN3KPU8aBFYnbKG8S6
 oTgZNOa8GWKGRSGO0KhEzNWDHIEcZTsmItAX0zZYTQk/lEdE3wSlVjGBHnCbC8ib6obz
 k+jw==
X-Gm-Message-State: AOAM533qRMSoNNVW2uElxc3XZWZBJSVRwpAZhVyZ/G17xyBchKpyh8H/
 sDV261QuZ2rTDR9eeZWLbOo0T5wv77OctFWDL58=
X-Google-Smtp-Source: ABdhPJwx6IxZGPa0Pl/WgRLrnBrjrror/rWorXUNouMAc5gn/GIoA9J4qME9uHmboWoyVm4UMieKSF1ch52LwA1DB/Q=
X-Received: by 2002:a92:189:: with SMTP id 131mr2059884ilb.40.1598890741969;
 Mon, 31 Aug 2020 09:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200610134731.1514409-1-mst@redhat.com>
 <20200827053216.GA1515751@ubuntu-n2-xlarge-x86>
 <20200830021939-mutt-send-email-mst@kernel.org>
 <20200830064944.GA1073664@ubuntu-n2-xlarge-x86>
 <2fd7a1df-db2b-9edd-1d73-7efa18312ace@ilande.co.uk>
In-Reply-To: <2fd7a1df-db2b-9edd-1d73-7efa18312ace@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 31 Aug 2020 09:08:10 -0700
Message-ID: <CAKmqyKPguBdfRr7hi3+HWYy9Xdyq44juEjEiBzx32hVDtTPRTQ@mail.gmail.com>
Subject: Re: [PATCH] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 30, 2020 at 12:24 AM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 30/08/2020 07:49, Nathan Chancellor wrote:
>
> > Unfortunately, it does not. I applied it on top of latest
> > git (ac8b279f13865d1a4f1958d3bf34240c1c3af90d) and I can still
> > reproduce my failure. Is it possible that type of fix is needed
> > in a RISC-V specific driver?
> >
> > Would you like me to comment on the Launchpad bug as well?
>
> Hi Nathan,
>
> I came up with a quick patch to enable some logging to catch memory accesses being
> refused for a similar bug report at
> https://bugs.launchpad.net/qemu/+bug/1886318/comments/13.

Can we apply this to QEMU master to print this is guest error logging
is on? This seems like a common-ish problem and it would be nice to
allow users to debug it themselves.

Alistair

>
> Can you apply the same change to your tree and report any messages on stderr as you
> do your board reboot test?
>
>
> ATB,
>
> Mark.
>

