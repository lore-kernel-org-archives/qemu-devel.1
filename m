Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6EDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 20:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C1120838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 20:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vj9ZsEJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C1120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DzM-0003oh-Mk
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 16:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dva-0007fn-Mb
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:57:50 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:33743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DvZ-0005mw-1Y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:57:50 -0400
Received: by mail-oo1-xc44.google.com with SMTP id g18so2150646ooa.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BAz7VtPx1kOSs6OwmmYbsd5LcYeU25MdRE6zU8iuobc=;
 b=vj9ZsEJGcsQfvHbXBJSwiEwa6dx2TJS403L7ixKI45MTSQQSxWUrjaMXNzbLIgr71L
 GXjpDkl+0m3rwlgIIxnTKULgqfeD+BDfgBVn2+x8VI4iMizS3T/ydk93kLlsHFHTBXsR
 Rl1pjNZJzc4hl5CStWQWI70nFLPWwL4T1etA3LkLsFLM/jSD11hCkl+cnLqmeT0WOP/q
 096rusLNKuJwav3Y1mpvtSAzfua08La41jKeSELe8xUFZK0H7ALXgi6Uwl2hKn7d57nX
 eHcqMto0HJRv6fQWnO+z2GQR8xpNoze8/XIMIVKy5wT6ZCHyHm9W0YEzP/VD/LDWcweF
 Cf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BAz7VtPx1kOSs6OwmmYbsd5LcYeU25MdRE6zU8iuobc=;
 b=bYxw5o6sDI65AWX8P/JL09tpzvqDNSe7b19CjEPGoyJHZ/Mlua0FbrHT/JIQlXZVCn
 7+CbFceyGKa/HFR+lo7uWYJYlbVdaHGR97h6q6Jx18B4bdhRCB9m9xGcpGF8pQljqqo/
 5Oh5jhh8QhcMDWCYfSI4/DjbCjjch99sxVp6JARvDUUhVDTy8YHU6nYMnUKX0dbPjQay
 moQJPMC3X4bntwS1n/KgKBrjDF+0qYTPV3rHs/Yg32rBIyGH5t4Vm91rp2sZsOJmeJvU
 ktxhbx+eXBvdpxNxZQTD0VZy7bdhRmjgzHyp1UyXzur5vAQk3LgWqGNm2rJhMA7jB5Bo
 SuhQ==
X-Gm-Message-State: AOAM532hi0NO7GzpeAeyCeT3/+u3fjDRYOlfi4jKaCGhVah2Vgl2UTu2
 G6l/4fpM67ZcXfAnfu1Sw1w3oy5oKlPpg9HK83VMgQ==
X-Google-Smtp-Source: ABdhPJzpvuNznDKvONyDTvOr5EqIYSeJhumQaaUhCwW29JKWCMFWW/jJEmy1RaqSb9dzAApcrxEuM8tQdTB62kXqRR4=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr2172681ool.69.1597089467653;
 Mon, 10 Aug 2020 12:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
 <0c4c75a6-0165-6549-6d3d-24c3f3f7d180@redhat.com>
 <CAFEAcA8o6PvVMhxS5VPmqMiXEjCdFf194-LAOqrMm4VhaOAV6w@mail.gmail.com>
 <85e3b495-9855-dc16-986a-1042de99237c@redhat.com>
 <CAFEAcA8Azxzyjwg8YG2ALmEkXGrm0csFYPzJRdzYMkdHag+01w@mail.gmail.com>
 <0e1a3132-2426-b553-c4c7-747c339f2eaa@redhat.com>
In-Reply-To: <0e1a3132-2426-b553-c4c7-747c339f2eaa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 20:57:36 +0100
Message-ID: <CAFEAcA_NtuHYa203faCU+0Sk9K_UFxFt_pqLB+0pX3Zd4k3KWw@mail.gmail.com>
Subject: Re: [PATCH 135/147] meson: sphinx-build
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 20:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/08/20 21:36, Peter Maydell wrote:
> >> It should be possible and probably not too hard once I figure out how
> >> Sphinx events work.  It's a fair request since build_always_stale is
> >> inferior and Meson requires no particular magic to include the depfile.
> >>  Maybe that will win you over. :)
> >>
> >> I can also leave out sphinx from the initial conversion.
> > If we have a working-but-build-always conversion for Sphinx
> > I'd be happy to take that and then upgrade it to processing
> > the dependencies properly later.
> >
> > (The thing I'm not really looking forward to is updating
> > the qapi-doc-to-rst patchset to Meson...)
>
> Since it's all handled internally by sphinx, I think you only need to
> add the man pages to the dictionary, and get rid of the corresponding
> Texinfo outputs in qapi/meson.build and qga/meson.build?

The patchset has a fair amount of change to the makefiles:
 Makefile                                   |  86 +---
 rules.mak                                  |  14 +-


> In other words, it should be just this:

...so if it's that simple that would be nice.

-- PMM

