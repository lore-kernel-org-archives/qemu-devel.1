Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A2ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707472086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4WNY68q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707472086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFKKT-0006Xy-Ae
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iFK3M-0006iR-9C
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iFK3L-0001MI-7T
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:27:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iFK3L-0001Li-10
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:27:03 -0400
Received: by mail-ot1-x343.google.com with SMTP id y39so11898639ota.7
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uOnTYkKkcsF15l4e9tmhZ6ILUXkACWj+QW49q+FYEL4=;
 b=X4WNY68qXDL8h7y8WcssElgUOTiH+aQ80BFRiYEyX74fz0QVPmhUgb6T78baNMnNN0
 x4ICj1EhkgIwGT9OmeYgiRuI7sDlarcpZ3SpMK5Kj4mPeNZjNxPhSlYQ8mKfc2GWMk5G
 SluuilaYAkIu/WwaRxffW04CVP20M+qjJSoYlEljQKUrtYD+2BsNxKBxqQ/Fl0h7jclU
 JRCgG8kBPQuirexO9uyopG5gGFhqR653VHCEFwWPK511x+5HZRpxfrX4f/oLyNHq16QV
 88rMvhR4yW7TbMzQVcjnoENxmb/CuvY0cqnDcrYeZCLbZ0NIg/QHmSzL1iti4HBOr1Mg
 pigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uOnTYkKkcsF15l4e9tmhZ6ILUXkACWj+QW49q+FYEL4=;
 b=IEqNrsZ4r1wCnYCjpfyTki6CMxqQqvkI1xt1RLp4pzzisx2VwZVYqyWQK97oZ2lX3F
 7UtZ1nsqNfgwSY9nRYlpoTdJ4gqR1F5umE7G7pvqxdZ355lRQUeXhI6yofnbaWW1uuRp
 YWmCu7RzmoEjSIw1XX3geBlQS8mVn3Dd+/XuKuNjvaKyl15V4rc3h+5Kkb/UnQ4kt6VB
 dMAxkxyhMdeMsAbLhzd6eUG7y/oZ2yVJxZVanD0vI9Qjj1Lo+YHPi+Z7Bytq2/q+4Avb
 FsLCkfFUm4M7Aqfbw/z8jLjzNV1zNLbedWORDZxfPmMdAmnIpg2x8jmJfTq1McgVjzbI
 NLwA==
X-Gm-Message-State: APjAAAWv34bhaMac5mCMEde4MnhKsyOLrNYntcu2SAg9HbPXZs7h6z8d
 ugA4I0JPe3tJNR5oJU7CvvqW7fwT3GpbY0yC9BQ=
X-Google-Smtp-Source: APXvYqyV7tY6ppvo1GaP4nFtxsAeYDFKp774Uj2yotz/gKBvPdkxXn7YR7F6fbSekBLxVhIwrzN5C7qIqTepCpH+Jy0=
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr14205478otn.295.1569943622005; 
 Tue, 01 Oct 2019 08:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 1 Oct 2019 17:26:51 +0200
Message-ID: <CAL1e-=jK6uB7BVHMdmhzugmsjyTYLKbRCRxnZjckV+3sXqLmkg@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] target/mips: Misc cleanups for September/October
 2019
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 2:47 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Mostly cosmetic changes.
>
> Aleksandar Markovic (20):
>   target/mips: Clean up helper.c
>   target/mips: Clean up internal.h
>   target/mips: Clean up kvm_mips.h
>   target/mips: Clean up mips-defs.h
>   target/mips: Clean up op_helper.c
>   target/mips: Clean up translate.c
>   target/mips: msa: Split helpers for <NLOC|NLZC>.<B|H|W|D>
>   target/mips: msa: Split helpers for PCNT.<B|H|W|D>
>   target/mips: msa: Split helpers for BINS<L|R>.<B|H|W|D>
>   target/mips: msa: Unroll loops and demacro <BMNZ|BMZ|BSEL>.V
>   target/mips: msa: Split helpers for B<CLR|NEG|SEL>.<B|H|W|D>
>   target/mips: msa: Split helpers for AVE_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for AVER_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for CEQ.<B|H|W|D>
>   target/mips: msa: Split helpers for CLE_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for CLT_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for DIV_<S|U>.<B|H|W|D>
>   target/mips: msa: Split helpers for MOD_<S|U>.<B|H|W|D>
>   target/mips: msa: Simplify and move helper for MOVE.V
>   target/mips: msa: Move helpers for <AND|NOR|OR|XOR>.V
>
>  target/mips/helper.c     |  132 +--
>  target/mips/helper.h     |  144 +++-
>  target/mips/internal.h   |   60 +-
>  target/mips/kvm_mips.h   |    2 +-
>  target/mips/mips-defs.h  |   53 +-
>  target/mips/msa_helper.c | 2115 ++++++++++++++++++++++++++++++++++++----------
>  target/mips/op_helper.c  |  913 +++++++++++++-------
>  target/mips/translate.c  |  421 +++++++--
>  8 files changed, 2888 insertions(+), 952 deletions(-)
>
> --

I applied patches 2-4 and 6-20 to MIPS queue, as there was no
disagreement about them. I did some corrections as said by Philippe
and Aleksandar R. There were more inaccuracies in MSA patches, which I
corrected with the little help of unit tests. All MSA unit tests pass
now.

Patches 1 (helper.c) and 5 (op_helper.c) are left for future versions
(so, not abandoned, will be improved).

Aleksandar

> 2.7.4
>
>

