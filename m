Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C66C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 17:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3094620757
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STC1/Uj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3094620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC4rw-00076a-CF
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 13:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kC4r9-0006gp-TM
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 13:41:35 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:39956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kC4r7-0006qr-La
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 13:41:35 -0400
Received: by mail-io1-xd29.google.com with SMTP id j2so2204848ioj.7
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y1kcAjujuiJhGpHO/R54GNkyzYZ0idwpNYh69IoUyYo=;
 b=STC1/Uj3Ey+VtiE9m0IhekhtBXneQ7Pr8U5U/jGWxnBCOL5IafGKxt75Z3qYcsikk8
 7GWEuULwiX5+kO531tFf7A6ZfqCTTO64Lqj17dl+F+HRSUILmlH2WoFJRCXcoe+adEWQ
 ins84dutQr7eOhduHD7zS+ixmDvtRaBMkIes5QcDZimAF1Bo89vTdmyV8i1RqMb8Q9Y2
 UxAfzVUPnygLRTT9bSure1jcUQQ2ih7yqgE7zUjdhhwJCMiS4rZmnBIGQLrxM7ZuSVNd
 oZVFehhb5UbimrX1lN9QxsDij1ccmzr9sM09L4q8bM10WtG6ntURhaCRexuql99a/4EF
 NjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y1kcAjujuiJhGpHO/R54GNkyzYZ0idwpNYh69IoUyYo=;
 b=IH91jrgNzD3IEZa0c8LWvfbiLUSw3nK/4GQGNx0DIqlSDd+5aStinlC1SRuA04Hd0V
 3rIcignq2+ilQO16rA2f35LnsLI7jThPWypy0l+1eRBMhFpFBGHHZx66MgkuHbldf9oL
 G71wf3ZWzYa0adUAvEUJK7MtUophc3PN04IZh5MSRkTArcZHwVka8IEXJLeGjoUz3uqo
 MSuFFlHqlRUidbREM1JkYIuA82EpomtAhbta9hTmZiKCuUafMTi36sEemVnS8pqADqL0
 PIwN8dt7VkVLUHVmABiUercLPdYRgauX14NUHkXvCIfh+s6Bpder1XfzblZz+5+uJmTQ
 l02Q==
X-Gm-Message-State: AOAM531M2YJ1mWST4bMCQG5Hr21MAIGfyOg0uhMRV0YOYp13y2QiKCNv
 TNtIOFu50jX38RcwX+aWxQQrJFsvtNN+Don5UNE=
X-Google-Smtp-Source: ABdhPJyRpwBQOBdWzVeEkJEpbtzRp/srY3zMt7JszA8EJOHugbs+2OOLSP15kaNo2K/VASsh+wXcavAqXzmzFvC95ss=
X-Received: by 2002:a02:950e:: with SMTP id y14mr5991042jah.106.1598722891633; 
 Sat, 29 Aug 2020 10:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
 <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
 <CAKmqyKNxURXyNSEePPU1jY7FzcZjRThr2qAvwR393+nqUXBxJQ@mail.gmail.com>
 <CAFEAcA8x=ck1mmJ8Y8o-0NQXWhRgOg5Gp7GvHNkNnLb6rDxygg@mail.gmail.com>
 <CAKmqyKP6OUoaR6iZ6SD6qZPvYF0bKqpB_rRNeQOteg8BtcqKeQ@mail.gmail.com>
 <78f899b4-b8f8-9fc7-15a3-4d56d77bb960@c-sky.com>
In-Reply-To: <78f899b4-b8f8-9fc7-15a3-4d56d77bb960@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 29 Aug 2020 10:30:42 -0700
Message-ID: <CAKmqyKNkHDCn_w8+KCvt0N5V6Few_thJVWqfnCNLnyWV9wbw-Q@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd29.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 29, 2020 at 8:50 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/8/26 6:30, Alistair Francis wrote:
> > On Tue, Aug 25, 2020 at 2:50 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >> On Tue, 25 Aug 2020 at 22:32, Alistair Francis <alistair23@gmail.com> wrote:
> >>> On Tue, Aug 25, 2020 at 2:24 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >>>> The hypervisor related patches don't seem to have any
> >>>> reviewed-by tags, which seems a shame for a fairly significant
> >>>> chunk of work. Is there really nobody who can review them
> >>>> for you ?
> >>> Unfortunately not. They have been on the list since April and haven't
> >>> received any feedback.
> >>>
> >>> There isn't a lot of people reviewing the RISC-V patches unfortunately.
> >> :-(   I'd hoped it was a more active target than that.
> > There are lots of active contributors, we are just short on reviewers.
> >
> > Richard and Philippe review patches and some of the RISC-V patches get
> > reviewed by the RISC-V community. The main problem (which is a common
> > problem in open source) is that large technical patch series just get
> > ignored.
> Hi Alistair,
>
> It's really a pity.
>
> I will review every patch that CC me in no more than a week if no other
> people reviewed this patch.
>
> So if there too many patches, just ease to CC me.

Thanks!

If you want to review more it's also a good idea to sign up to the
RISC-V QEMU mailing list. That way you can keep an eye on all patches
and start with reviewing ones that are interesting to you.

Alistair

>
>
> Best Regards,
> Zhiwei
> >
> > Alistair
> >
> >> -- PMM
>

