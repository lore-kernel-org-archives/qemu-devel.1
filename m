Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC518C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926552085B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8F+NPA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926552085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKGI-0002tJ-Jw
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kKK2d-0004UM-8p
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:31:31 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:43941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kKK2b-00015n-KN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:31:30 -0400
Received: by mail-pg1-x52f.google.com with SMTP id t14so8757738pgl.10
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7/Cf4+bQ+JCv4CMTx69Me1q6TM58iCqVGSPw4dCcDeI=;
 b=m8F+NPA8XhFVWXSamfPp836sDzMNdOtRGP+zI9961QsMx67V+D5LNMEQ2Eb4gSy3UA
 v8DoxgkZv/4Rh1AWByG+19ugf8CxuiGm9La9FUKzfVeVgp7PlEsBChJdXkYYUZuZyXv1
 aFKNrapVD4LAtAxvzKVvkgK/iW6GlrKM5ZfElAjmvPt2/yme8ivlP4MgFKiB5AzhturB
 XSXQAHtW33hI5pCGS4qEtg9n0M2fUzO/I/mMplLalQ9DLGuV5ZcwFL+c4rt0oXv/TE8C
 VCtseu8gKwTjU81Rv/vmqjUvFniHJKXHTIZApKWkTuC6Cj5QztpGP9fk76uls8NUXRey
 CeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7/Cf4+bQ+JCv4CMTx69Me1q6TM58iCqVGSPw4dCcDeI=;
 b=B4Ja+FSZPdvuOHQxkVrUR0hQWHGzPcF9ve1Du37R4LnCR1xDN9yuELgmsjtya9Rbef
 iOhbQGw4IkrohxesKVxe2ujOI7zRMNZiZwm4qrZPvRUOT1JtLNHgkuznEHTw/uEuwds8
 nfU0QA049T5KtdcJ0SBocbe7KtTEDB/LxOE3Xs4S4io2S0d2ZxNTiIVMIzvjEv4sN1S0
 XI+1S3JayLDpAIct1k4U8sGXda5IL4ls4cuymVIZOLefaJbFsBZMDYxQWIbL+J6UsGsR
 a/7yTaKSDYaBg+JaxIQSeHYz2DBYFEPIPyM2xFSlr0ObHXUc4LZ1YS3pNhmCNsGhXlkI
 /+vg==
X-Gm-Message-State: AOAM530MyMCwanIMdJStla40rNoTmIitOYsnm558nEyqlRfBYDrwT8PE
 hvum9Sg1h3WNdcFKxDZdyqhzldiLa9tziMh/yUU=
X-Google-Smtp-Source: ABdhPJxqLKkpQ3jdk7GZbSj7ZN9kF6U8AVizFK/ZKnwyx4icK/042ujdPkiwJbovdwhlPDSJIK/z7Tl/11zyvkrB2u0=
X-Received: by 2002:aa7:9730:0:b029:13e:d13d:a091 with SMTP id
 k16-20020aa797300000b029013ed13da091mr42278198pfg.40.1600687888335; Mon, 21
 Sep 2020 04:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <160044888692.1133.11388395637815022535.malonedeb@chaenomeles.canonical.com>
In-Reply-To: <160044888692.1133.11388395637815022535.malonedeb@chaenomeles.canonical.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 21 Sep 2020 12:31:16 +0100
Message-ID: <CAJSP0QXp5dq_nHdFZgyh5Ye1Pv+kOvVS0GRici2y1Xadu+LbGw@mail.gmail.com>
Subject: Re: [Bug 1896263] [NEW] The bios-tables-test test causes QEMU to
 crash (Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed) on AMD processors
To: Bug 1896263 <1896263@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 6:18 PM Apteryx <1896263@bugs.launchpad.net> wrote:
> Host CPU: AMD Ryzen 3900X

I also hit this test failure.

Host CPU: Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
Host kernel: Linux 5.8.6-201.fc32.x86_64

qemu-system-x86_64: error: failed to set MSR 0x4b564d02 to 0x0
qemu-system-x86_64: ../target/i386/kvm.c:2714: kvm_buf_set_msrs:
Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.

