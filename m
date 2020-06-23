Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806AEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 03:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6EB206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 03:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JC4A16Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6EB206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnZrR-0003Pr-KA
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 23:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jkz@google.com>) id 1jnZqi-0002pa-9z
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 23:43:52 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jkz@google.com>) id 1jnZqg-0004YJ-IY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 23:43:52 -0400
Received: by mail-pl1-x642.google.com with SMTP id bh7so8520119plb.11
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 20:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GrrlkA+gBTm/MgWgV1ewL+Kuua3oCvHevhU9zWU4FP4=;
 b=JC4A16IccNNrr9xJ5pIrVk25meU7h4mC/WIT1Kv6dYi+XiKLiSHNVZd/RmdrGwC2P2
 Qa0GBdyD0UJOJp5+V+ol04FXY/aMxVaBzaREKjcRXHbdZsJpyOt8JQUSdYFYKucnewnU
 SXFNo0/Gbns8GSrsHWPYGRWAMU75OM220ePKq8UkOwJQYrvoKjsDk8HGfi3LWPdtQWMt
 Q14p4Y11O8+TaumfEIhrbrxPJbIUzRECu8eHf9DiYOK+c9Mnsq5Se/TEqZaAypZET0pd
 Fu/YbmrbwDwchCrZqrSba/hffuMAgM07bg44vAr1XIWoOdXaP76yEtCDkg7T7E33om9Y
 gFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GrrlkA+gBTm/MgWgV1ewL+Kuua3oCvHevhU9zWU4FP4=;
 b=nE1DTm8JogAH0PgWJKwy3PvK2jQao7XniMDxit2B4U0liydjIKpZ/CE5YAk3rCjues
 /lXA+HwxusYuiWV7eP7bH3EVF5/iVNolegAW2bidfxTmzoDmxuXRemyoIKSpTukDA/Lr
 1bNKJ+GHKvhv0yzfW2XDUpM1KHsrQxIqGiaYswBMfYSQRh/gXbl1g08bFjON06h4OdHG
 FlSEeQMQ2SYZlwa7p/q1IYI0xrsoThEL/xXIBONhcDiklYvKF3bcnqZqCf1775rpfjU8
 u06r+w3ZF0TaV/Db2T/Rdl6xIMo7GB2AXd/SkIExWaqnK65CpIhXl+H2iCM2qtmv1EeH
 n07A==
X-Gm-Message-State: AOAM530eJGzEvK6V/eu21s0qiy27fk3saXz3n4TEDmCwh4jx7hz5h06R
 FLmqczyMEXuG/hnNUgunI137TeViUrLn01nKQkJ43w==
X-Google-Smtp-Source: ABdhPJwoJBcTNcQxglfJBRg4JUMEEq8DKa9laQ9vtNctT+M7tahA+gkjZJ/gFc7U79gUraE/4mdZvlAqNg1Gwn8DxPI=
X-Received: by 2002:a17:902:6bcb:: with SMTP id
 m11mr22131664plt.126.1592883825159; 
 Mon, 22 Jun 2020 20:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200612014606.147691-1-jkz@google.com>
 <20200612014606.147691-5-jkz@google.com>
 <87h7vbyowf.fsf@linaro.org>
In-Reply-To: <87h7vbyowf.fsf@linaro.org>
From: Josh Kunz <jkz@google.com>
Date: Mon, 22 Jun 2020 20:43:33 -0700
Message-ID: <CADgy-2uOn835LrnOBDacbqznW8MR7ZQy55kBmpjDbK2Uy1xPEg@mail.gmail.com>
Subject: Re: [PATCH 4/5] linux-user: Support CLONE_VM and extended clone
 options
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=jkz@google.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the responses Alex. I'm working on your comments, but
wanted to clarify some of the points you brought up before mailing a
second version. Responses inline.

On Tue, Jun 16, 2020 at 9:08 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Which by the way fail on some targets:
>
>     TEST    linux-test on alpha
>   /home/alex/lsrc/qemu.git/tests/tcg/multiarch/linux-test.c:709: child di=
d not receive PDEATHSIG on parent death
>   make[2]: *** [../Makefile.target:153: run-linux-test] Error 1
>   make[1]: *** [/home/alex/lsrc/qemu.git/tests/tcg/Makefile.qemu:76: run-=
guest-tests] Error 2
>   make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:851: run-tcg=
-tests-alpha-linux-user] Error 2
>
> Have you managed a clean check-tcg with docker enabled so all the guest
> architectures get tested?

I've gotten this Alpha failure to reproduce on my local build and I'm
working on a fix. Thanks for pointing this out. I'll make sure I get a
clean `make check-tcg` for `linux-test` on all guest architectures.

> > In this patch, I've employed an alternative approach: spawning a thread
> > an "stealing" its TLS image for use in the child process. This approach
> > leaves a dangling thread while the TLS image is in use, but by design
> > that thread will not become schedulable until after the TLS data is no
> > longer in-use by the child (as described in a moment). Therefore, it
> > should cause relatively minimal overhead. When considered in the larger
> > context, this seems like a reasonable tradeoff.
>
> *sharp intake of breath*
>
> OK so the solution to the complexity of handling threads is to add more
> threads? cool cool cool....

The solution to the complexity of shared memory, but yeah, not my
favorite either. I was kinda hoping that someone on the list would
explain why this approach is clearly wrong.

> > * Non-standard libc extension to allow creating TLS images independent
> >   of threads. This would allow us to just `clone` the child directly
> >   instead of this complicated maneuver. Though we probably would still
> >   need the cleanup logic. For libcs, TLS image allocation is tightly
> >   connected to thread stack allocation, which is also arch-specific. I
> >   do not have enough experience with libc development to know if
> >   maintainers of any popular libcs would be open to supporting such an
> >   API. Additionally, since it will probably take years before a libc
> >   fix would be widely deployed, we need an interim solution anyways.
>
> We could consider a custom lib stub that intercepts calls to the guests
> original libc and replaces it with a QEMU aware one?

Unfortunately the problem here is host libc, rather than guest libc.
We need to make TLS variables in QEMU itself work, so intercepting
guest libc calls won't help much. Or am I misunderstanding the point?

> Have you considered a daemon which could co-ordinate between the
> multiple processes that are sharing some state?

Not really for the `CLONE_VM` support added in this patch series. I
have considered trying to pull tcg out of the guest process, but not
very seriously, since it seems like a pretty heavyweight approach.
Especially compared to the solution included in this series. Do you
think there's a simpler approach that involves using a daemon to do
coordination?

Thanks again for your reviews.

--
Josh Kunz

