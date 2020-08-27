Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3195C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDA52087D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUkt22ZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDA52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBKG8-0003jy-2a
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 11:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kBKFK-000383-1L
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:55:26 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31]:34469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kBKFI-0002iS-Dx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:55:25 -0400
Received: by mail-io1-xd31.google.com with SMTP id w20so6368881iom.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q1B9kk+5MosqY7eiNhAa3L1BMIITtrbcQ+a4wQ1HsV0=;
 b=RUkt22ZLtMd7MVEJbFmVWUBxutUc0gV2gVyZfH46+QILQY1k7liGEWj0vOdeQ2nAAh
 aLYBcPiBORuIU/o5JPegMwUcCMLRnGCBvHVReu2aKizKW3aatFaz8r7/4DK5TFwx3kfN
 rtQTHfqw5WwT+S7xFh+6c9Ev+HYeXjzRQYAJ+JR73x7rGDT0wleYfIOoqcuQtOATWuHy
 50PvusqM7ZlIHVYaUW5Zav7xMETQy242PNBawcuYax2wQnV4QaY+NoST2DPnO2DM5Xa4
 mhMxqbmvsk6sFsdkGOFDqLb0aW/1cjxSa/dtGfqVyZg1J6vSwID9AH04hUP5QCbgMDzu
 JJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q1B9kk+5MosqY7eiNhAa3L1BMIITtrbcQ+a4wQ1HsV0=;
 b=hFArDQ5yUAaQO7L+gC8cvc4WNS6daBpZTvsbXD9w66VX1dwy8/lY3qv3XZWKfnX0JQ
 HPtN9aCOt7tXMzvMv9tyzFXuy6/hZH4eLyvgsmIqEX6BCFID2zvhf7le9Hp1lzkaL8+a
 SsamMzMO8L3Xe2xHkzCC7WCW1mRBrQroFBOZhBJSyVtNqFT6PeQyZNUlsNiNnueSsi4h
 siJYuiWuOvacoCinHSZm+TwtRSuvursMzSQHzyNuX1/xOtOUYwAhDCkxmqo8Qy2IOwz4
 K0TQByfGLVFrDnG7L/AsEE/m1crYzywl/g8hTKMguqST5DRuf6CzpjKPRAtxzZxNHd4j
 Y9dQ==
X-Gm-Message-State: AOAM533jnwx1sx6fIXz9byPVwR7fCBSbtdPwoNjs/VoYkFymwhek8gMS
 jGLleo4ZAPwiY15+46UwaE9cDosrKgH0PkV0vwk=
X-Google-Smtp-Source: ABdhPJw12OUnZP1HBKc9wZwYojuIrXxSd6h6ciXdyu6r0A/T3InUKZPh6UIv2RcKyaeHLMKX5QytPP5dyKAaVeC40jM=
X-Received: by 2002:a6b:400e:: with SMTP id k14mr17221463ioa.175.1598543722703; 
 Thu, 27 Aug 2020 08:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
 <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
 <CAKmqyKNxURXyNSEePPU1jY7FzcZjRThr2qAvwR393+nqUXBxJQ@mail.gmail.com>
 <CAFEAcA8x=ck1mmJ8Y8o-0NQXWhRgOg5Gp7GvHNkNnLb6rDxygg@mail.gmail.com>
 <CAKmqyKP6OUoaR6iZ6SD6qZPvYF0bKqpB_rRNeQOteg8BtcqKeQ@mail.gmail.com>
 <CAEUhbmWN93n1JoGszsW6WrkGbdFD6VsGyi7Ji6bS6wF+DbMOBw@mail.gmail.com>
 <CAFEAcA9026WV-t5Q9EbV-nZi+6GZ3WoKCx2tA9QeAXu5iD5ryg@mail.gmail.com>
 <CAEUhbmWv52oeQb6z3JTpa16utD2NmB1sKZ-sT7uD1R8_3KwNMw@mail.gmail.com>
In-Reply-To: <CAEUhbmWv52oeQb6z3JTpa16utD2NmB1sKZ-sT7uD1R8_3KwNMw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Aug 2020 08:44:37 -0700
Message-ID: <CAKmqyKPtrKfcdmEt6NSLa4ZqmjqVUHL_DHzLLZPUoB-xDek6Pw@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd31.google.com
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

On Wed, Aug 26, 2020 at 3:06 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Peter,
>
> On Wed, Aug 26, 2020 at 5:25 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 26 Aug 2020 at 04:21, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > On Wed, Aug 26, 2020 at 6:41 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > > Richard and Philippe review patches and some of the RISC-V patches get
> > > > reviewed by the RISC-V community. The main problem (which is a common
> > > > problem in open source) is that large technical patch series just get
> > > > ignored.
> > >
> > > Yep, I am only comfortable reviewing patches which I have confidence
> > > in. Right now I am not working on any H- or V - extension for RISC-V
> > > so I cannot contribute to any review of these large numbers of H- or
> > > V- extension related patches. Sorry!
> >
> > So, everybody has a ton of work they need to do and only a limited
> > amount of time they might have for code review, so it's important to
> > prioritise. But I would encourage you, and other people contributing
> > to RISC-V parts of QEMU, to at least sometimes review changes that are
> > a little bit out of your "comfort zone" if nobody else seems to be
> > doing so. Review can find bugs, areas that are confusing or need
> > comments, etc, even without a thorough knowledge of the relevant spec.
> > (In fact, not knowing the spec can help in identifying where
> > explanatory comments can help the reader!) And for the project it means
> > we have more people who at least have some idea of what that bit of code
> > is doing. Review that is limited to "this code seems to make sense but
> > I haven't checked it against the spec" is better than patches getting
> > no review at all, I think. And it's a good way to build your knowledge
> > of the codebase and the architecture over time.
>
> Agree. I really wanted to spend more time on this project but like you
> said it's priorities.
>
> One thing I do not understand is that according to MAINTAINTERS there
> are 4 custodians for the RISC-V maintenance work but it looks to me so
> far only Alistair is actively reviewing patches. I know Palmer used to
> review patches but if it's only one person that might be some issues.
> At least MAINTAINTERS can cross-review, and we have 4 there.

Yeah, most of the people in the RISC-V MAINTAINERS file are inactive.
Besides Palmer and myself I haven't seen an email from anyone.

Alistair


>
> Regards,
> Bin

