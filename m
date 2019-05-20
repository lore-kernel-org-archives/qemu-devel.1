Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D341C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 19:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7DD20675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 19:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvP0xfZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7DD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40733 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSnhR-0003Bv-Gx
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 15:11:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSnfP-0001Yp-B5
	for qemu-devel@nongnu.org; Mon, 20 May 2019 15:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSnfN-0000m1-D0
	for qemu-devel@nongnu.org; Mon, 20 May 2019 15:09:47 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:33130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hSnfM-0000kS-T2
	for qemu-devel@nongnu.org; Mon, 20 May 2019 15:09:45 -0400
Received: by mail-oi1-x22a.google.com with SMTP id q186so4181898oia.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=mteK9uLYl7CsPLTymDDnf4SlyPM2OPZOd1tWcIDKT4c=;
	b=dvP0xfZ/2snMtQG+Ou8fq6peojX6X0Mg9/nnj+bPIb082CpzjmlVejAdmsZUVK9tKN
	SXKO4QAuF51l4PMOk8ZYjxy9bTrapO1g28RWIHY5aCGUJ2Wto2mS0LCzzSp4i5RrVIjn
	b7NDiCurNTFZzFqbg2MKxX0a38baUYJKIgmkuAKLxijVoc52NT6StJX+vdRhvfOZtX7a
	JjzGlSQi7T10kQV64jJDNdVveQR9Q12mb4/z/yYoLHNNov6iIux+kW3ehV7eBEQHAfOQ
	STsDs84aOYGfQN8kaw9L3iFEzP2J74+zvln2ue28VJSaRpVm/1LNawr+ssK9BEETQwZP
	wdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=mteK9uLYl7CsPLTymDDnf4SlyPM2OPZOd1tWcIDKT4c=;
	b=KU8Bxy54eJFdtWtPPruMzwdk5ykZa8e37W5it8yoGsrBTS9MmMfmVAr1BI1LSrKTTH
	Gn7q2ncYHiKrt47G5J0yWe74pvqNPFnOUFUZk9UZE2qew51K5c1rV2Cx3Le+COrZSY/S
	19PSe2TEFHIfTZLcG8Wmi4Fdx/+mv6o8ydJfpLQsT9pWcn6BmZLn2T8k+OkNVRPl6YBj
	JSv1a29FNxd87veIy9DMjLuWy39HzSCoTv5iI7v17uxA2nVaVMLJPhi7NTsT/mI9nc3O
	tMk0y15NG8MOAsIGqo5UkYwr2bNHv/eDSv9WtF9i1oaYx781LXLlzrH33D6Lng5Ew3xY
	kRZg==
X-Gm-Message-State: APjAAAXATyjZz8MQZ0vIjGXmzCkKWY+6aSN5YcimojqfDi3EtBgJzGMB
	IZIGnLW9yR1BBfLPNlBFDVqbymBityE1IR/Aee8=
X-Google-Smtp-Source: APXvYqzMA+ev7Rnvpa6r+9AYV3DZEPmDtF1pCL04+sOLdEBcZbTGJ7MlMV5HxZqVD1RCChE+Oaw/dELTDeICx5TtZGM=
X-Received: by 2002:aca:5d06:: with SMTP id r6mr541147oib.62.1558379382598;
	Mon, 20 May 2019 12:09:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 12:09:41
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 12:09:41
	-0700 (PDT)
In-Reply-To: <72e09057-0011-04e0-4166-5ad27aa0da3b@redhat.com>
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA842fq=CG+y_qGySWV3i_JNPEk0iQwCJxed6cQcCMidWA@mail.gmail.com>
	<CAL1e-=i91f-vgyFJOJhN51JaUoTZgdhby_F_YyeTr_KYWBsZeA@mail.gmail.com>
	<72e09057-0011-04e0-4166-5ad27aa0da3b@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 20 May 2019 21:09:41 +0200
Message-ID: <CAL1e-=gTrcuEaH8WTX-1M7St7Hov4_LcWFrggci=h2-c_EMRrg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 20, 2019 7:29 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =
wrote:
>
> Hi Aleksandar,
>
> On 5/20/19 2:35 PM, Aleksandar Markovic wrote:
> > On May 20, 2019 2:11 PM, "Peter Maydell" <peter.maydell@linaro.org>
wrote:
> >>
> >> On Sun, 19 May 2019 at 11:52, Aleksandar Markovic
> >> <aleksandar.markovic@rt-rk.com> wrote:
> >>>
> >>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >>>
> >>> The following changes since commit
> > 1b46b4daa6fbf45eddcf77877379a0afac341df9:
> >>>
> >>>   Merge remote-tracking branch
> > 'remotes/kraxel/tags/ui-20190517-pull-request' into staging (2019-05-17
> > 17:25:19 +0100)
> >>>
> >>> are available in the git repository at:
> >>>
> >>>   https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019
> >>>
> >>> for you to fetch changes up to
71074d1d2fae9a0c8dab87c5bb5271a71d6cb7ab:
> >>>
> >>>   mips: Decide to map PAGE_EXEC in map_address (2019-05-19 12:11:46
> > +0200)
> >>>
> >>> ----------------------------------------------------------------
> >>>
> >>> MIPS queue for May 19th, 2019
> >>>
> >>>   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)
> >>>   * A set of fixes for emulation of MSA ASE on big endian hosts
> >>>   * Improved usage of object_initialize() and
object_initialize_child()
> >>>   * Better handling of 'div by zero' cases in MSA ASE
> >>>
> >>> ----------------------------------------------------------------
> >>
> >> Hi -- I'm afraid this fails to build with clang:
> >> /home/petmay01/linaro/qemu-for-merges/target/mips/op_helper.c:4536:20:
> >> error: unused function 'ensure_writable_pages'
> >> [-Werror,-Wunused-function]
> >> static inline void ensure_writable_pages(CPUMIPSState *env,
> >>                    ^
> >> 1 error generated.
> >>
> >> It looks like "target/mips: Fix MSA instructions ST.<B|H|W|D>
> >> on big endian host" removed the last use of this function
> >> but didn't remove the now-unused definition.
> >>
> >> (clang is pickier than gcc about not allowing unused 'static
> >> inline' functions -- gcc ignores them anywhere, clang only if
> >> they're in .h files.)
> >>
> >
> > Ughhh... Sorry. I should have had a script for this. I'll send v2 in fe=
w
> > days.
>
> You can use Travis-CI for that, simply register an account (free) and
> push branches/tags to your GitHub repo, that will trigger many build
> configs run by upstream:
>
> https://travis-ci.org/philmd/qemu/builds/534805597
>

Many thanks, Philippe, for enlightening me with this! I haven't used such
CI services by now.

Avec soulagement,
Aleksandar

> >
> > Regards,
> > Aleksandar
> >
> >> thanks
> >> -- PMm
> >>
