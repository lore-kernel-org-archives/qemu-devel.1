Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FE3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 01:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5065D20888
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 01:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfonTbDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5065D20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdkRK-0006Nw-Em
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 21:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdkQM-0005ok-Cs; Tue, 26 May 2020 21:00:02 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdkQL-0006Qi-Bm; Tue, 26 May 2020 21:00:02 -0400
Received: by mail-io1-xd43.google.com with SMTP id r2so13846057ioo.4;
 Tue, 26 May 2020 18:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=10U+y8lsSgy0y0bJ3gRyCQPkdGSkvvCoQnRQ/cQoeQk=;
 b=EfonTbDxMv/X5PqDWtozvCbgJ/OBgjSFgtYVGo3WFCnWS6AmjlKL2yFGyhgoZadl/+
 u0jHFU6vcckqVFMPUCLpZETHiJFyvPxDq/fzSjOBL7LPcxqi4pUpdSwTrkL6DklJfu73
 BDa+eiFCBVpYHis/i1zA5Jd25p7aUqvECkkG/G4zA9GD72fVU3Gy2c/eNj1rB4xiKRze
 u7c2nii5OXn1Ra8v+ugPQBFqApIH3c+TUPDYfV8U1Bbpfw/1BrEttqxFhb1WoAlfON77
 rE+T0M+7Rr/ncbf9R1zeuEA+axCbSUlNwhkzpPW1LpEeKNQ6TMWXuxXQkoeWxagq4A31
 JSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=10U+y8lsSgy0y0bJ3gRyCQPkdGSkvvCoQnRQ/cQoeQk=;
 b=CcFqagyEcQjorI2L3jLuJ35YQ6BYGRl12lyKixEt1Si4xC+uJAesOqWc3TFC+Gm+rt
 VYL7Br1BaF2SkpiTYTL/BYYlJOK033IEBiM4MukQvk7tFeRR3tW8QSN7BC0bsadS5GT9
 gMa2eSVJT3KROQw0ZIhdHdebbheQzym7fU5FOoWzsZv0MHO/3a09Xe3sW+kVYkTS1N+H
 pXUSgbVjuFdTbI6rge/S44DFbZZ7HracpkJAtk4JFTDyZaFCZHEB85FBIHdIVmqARPFQ
 /ZgQVhkDPAJUdHy1A1z/DIIO74KC6/+mLUvvhaQHOdzr8+gQ+Q1XKFDJys9tqsLwpqQw
 KZGQ==
X-Gm-Message-State: AOAM532zwYTdEBac1PqPQVCBouvje08mEfKubNxVQgsbsyRORww2r6YP
 vQ8DWAwZHWTawWFNZK+oc14zugYh8PpXY9VJ5p8=
X-Google-Smtp-Source: ABdhPJz42nFOjkPliuzl0TWly6AkcqjAbTtsl/prgFG+DYI2N7XP0seqJHNuoDKcP4Ll3jtUEnfLncHjg2oi+NMbCpA=
X-Received: by 2002:a6b:bf83:: with SMTP id
 p125mr19269439iof.118.1590541199836; 
 Tue, 26 May 2020 17:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589923785.git.alistair.francis@wdc.com>
 <c8b00dc5d38574f05be4c8c15549deb431aeba02.1589923785.git.alistair.francis@wdc.com>
 <CAEUhbmVfdwKERmdRzmh30xFOW9Chfu9v8P1LM8nxgK+nLheiTw@mail.gmail.com>
In-Reply-To: <CAEUhbmVfdwKERmdRzmh30xFOW9Chfu9v8P1LM8nxgK+nLheiTw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 17:51:01 -0700
Message-ID: <CAKmqyKOC6cuUMXNUKjuqCy=8Gfq5heaTYJgOB+O3dFfOGxN-hQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] target/riscv: Use a smaller guess size for no-MMU
 PMP
To: Bin Meng <bmeng.cn@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 6:52 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, May 20, 2020 at 5:40 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/pmp.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 0e6b640fbd..607a991260 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -233,12 +233,16 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
> >          return true;
> >      }
> >
> > -    /*
> > -     * if size is unknown (0), assume that all bytes
> > -     * from addr to the end of the page will be accessed.
> > -     */
> >      if (size == 0) {
> > -        pmp_size = -(addr | TARGET_PAGE_MASK);
> > +        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
>
> My previous comments were not fully addressed. I think the logic should be:
>
> if (riscv_feature(env, RISCV_FEATURE_MMU))
>
> Otherwise it does not match your comment and the commit title.

Ah! You are right. This uncovered a bug with how we set the MMU as
well. I have fixed this and added a new patch.

Alistair

>
> > +            /*
> > +             * If size is unknown (0), assume that all bytes
> > +             * from addr to the end of the page will be accessed.
> > +             */
> > +            pmp_size = -(addr | TARGET_PAGE_MASK);
> > +        } else {
> > +            pmp_size = sizeof(target_ulong);
> > +        }
> >      } else {
> >          pmp_size = size;
> >      }
>
> Regards,
> Bin

