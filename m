Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD60C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 19:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80712073A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 19:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80712073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWlzo-0000ui-M2
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 15:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kWlyM-0000S1-BL
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 15:46:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kWlyK-0007kU-D4
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 15:46:33 -0400
Received: by mail-io1-f66.google.com with SMTP id z17so7725220iog.11
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 12:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CzgGK2/W1U2NYS6sLq3jt9y1wUuFWZrAZoxUzKZPBmM=;
 b=UJUdkPoQMtv9u++hnO5+xdyD0JP+P1IMxq2A0ik50xuKKe4PTXeoG+qJOeFQRQoZFC
 MEHQ89++Z+ROvgO2rZjIWEXF+HDZXgccpfOW826nPyG5kihmOGvV+Awm6pVIZaJGban/
 HJitFmjx9zlSpBXvoo4EmQoDQnEmpaW4iVevrf+Nn1E1rp0AhQj75Oa9b9mnzlsv56v9
 b9HYdEmT/+i0J76ULNEj1EVA5iv+Mxo52BbBdIz6URZkvk1VL2Drte7XZWV8KSaekoql
 2MjomExsv9dSusGeBsG4/iIt5A1x4Daz6bfbNjbmFWfVmxHGg+VTTu1ZUeN+Vl0s5CIG
 BU/g==
X-Gm-Message-State: AOAM5337sU9oGEkVxtOfhRtsSF4XGkRMefesz/pjXU3kH93tCzirQMcA
 xFMO43JIxdgy315vylzJzeOTc4899zk=
X-Google-Smtp-Source: ABdhPJzjVSYf2WClDhhc3MOCcMh5lkVvr20qkX6Sq0TEXFDHLLiX4wqtzMCogeikWsSeajVrdcmwaA==
X-Received: by 2002:a05:6602:330f:: with SMTP id
 b15mr8337432ioz.126.1603655191043; 
 Sun, 25 Oct 2020 12:46:31 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com.
 [209.85.166.51])
 by smtp.gmail.com with ESMTPSA id e13sm4370635iob.43.2020.10.25.12.46.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 12:46:30 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id q25so7715197ioh.4
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 12:46:30 -0700 (PDT)
X-Received: by 2002:a05:6638:1351:: with SMTP id
 u17mr1946757jad.120.1603655190406; 
 Sun, 25 Oct 2020 12:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-7-j@getutm.app>
 <aa4c227-c33-72dc-92c6-75792f60b58e@eik.bme.hu>
 <CA+E+eSAYV50ACGaAvd_e-eR3FoSiBq6EXqDVRH7vJZyYHvhA8w@mail.gmail.com>
 <b1a9e0c9-4327-6950-bc58-8c79dbe8b8a0@linaro.org>
In-Reply-To: <b1a9e0c9-4327-6950-bc58-8c79dbe8b8a0@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Sun, 25 Oct 2020 12:46:19 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCy-WwLCUKhVB03J91aKrG7N9gL-1-LxJcTgbPf=B16sg@mail.gmail.com>
Message-ID: <CA+E+eSCy-WwLCUKhVB03J91aKrG7N9gL-1-LxJcTgbPf=B16sg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] tcg: implement mirror mapped JIT for iOS
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.66; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 15:46:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 19, 2020 at 5:20 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/19/20 3:39 PM, Joelle van Dyne wrote:
> >> Explicit cast may not be needed here so this could be a macro if caling it
> >> differently helps or why don't you just use tcg_mirror_prr_rw directly
> >> everywhere?
> >
> > There are quite a bit of code that depends on tcg_insn_unit * type such as
> >
> > *tcg_code_ptr_rw(s, code_ptr) = insn;
> >
> > and
> >
> > (tcg_code_ptr_rw(s, p))[i] = NOP;
> >
> > I think it's cleaner to not have to manually cast in every one of 30+
> > instances of this. In v1, I used a macro but was told to use an inline
> > function instead.
>
> Yep.
>
> >> Is that !defined or are you missing an implementation and #else here?
> > No, `flush_dcache_range` is only needed when mirror mapped (after
> > writing to the RW mirror). Now there is no iOS compatible compiler for
> > any other arch than x86 and ARM. However, in the slim chance that
> > Apple decides to change arch again in the future and moves to RISC-V
> > or something, then we get a nice compiler error.
>
> *shrug* As opposed to the nice compiler error you get for a missing function
> declaration?
>
> That said, I think __builtin___clear_cache() may be the target-independent
> runtime function that you need.  Both GCC and LLVM support this, and I'd be
> surprised if that doesn't carry through to iOS.
You would think so but unfortunately iOS likes to be "special"
See: https://gitlab.haskell.org/ghc/ghc/-/issues/8561

>
> >> Maybe this patch could be split up some more, making the RW offset
> >> handling and cache management separate patches even if they don't work
> >> separately just to make it easier to review.
> >
> > I can probably do that for v3 but imo most of the LOC here is because
> > the same change has to be done to every TCG target. No matter how you
> > split up the patches, it will look like a lot of changes.
>
> It occurs to me that the majority of the code changes in patches 5 and 6 are
> due to your choice that code_gen_buffer points to the RX copy and not the RW copy.
>
> Swap the two, and instead have an inline function that produces the executable
> pointer from the rw pointer, and suddenly there are very much fewer changes
> required.
In the original incarnation of this code from a year ago, this was the
chosen path, but we ran into other issues which unfortunately were not
recorded anywhere. I think one issue is that the mirror offset has to
be stored somewhere that can easily be retrieved or otherwise code and
structs have to be modified to take a copy of the value. If we default
to the RW copy, there may be less LOC changes but the changes will be
more significant. This version has also been running by iOS users for
the past year or so without issue and a major change in the logic
would probably require a lot more testing.

>
> For the most part, tcg/$cpu/ generates pc-relative code, so it need not
> consider the absolute address.  There are a few exceptions including,
> obviously, 32-bit x86.  But the number of places that occurs is small.
>
> There's the assignment to tb->tc.ptr of course, and
> tcg_ctx.code_gen_prologue/epilogue.
>
> In any case, each of these changes (generic, per tcg backend) can occur before
> you finally add a non-zero displacement that actually separates the RX and RW
> mappings.
>
> Finally, I'd like to have this implemented on Linux as well, or I'm afraid the
> feature will bit-rot.  This can be trivially done by either (1)
> MREMAP_DONTUNMAP or (2) mapping from posix shared memory instead of MAP_ANON so
> that you can map the same memory twice.  Thus virtually all of the ifdefs
> should go away.
Okay, I will do that.

-j

>
>
> r~

