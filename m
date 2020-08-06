Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DCAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BFE23110
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hH2IGHkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BFE23110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3g7e-0005am-LY
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3g76-00055e-D3
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:39:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3g74-0002yi-Eh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:39:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id z18so40477561wrm.12
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=XwvkaOS+zlPAQxC7KOYzKBbD0RTPzA4FCgsljx8AFyA=;
 b=hH2IGHkh5hrFOBnyH4wmwVg+Q5lpfNhXNMy/o0q5RHinZcAHuhi/nONmrUYtHFGFPh
 MsY8w90VQS4JkPQ/UQigxIcR/VbexBzNRZpZV1RGWBOXRRl1cP6MnShdsVmj5LnEKnoU
 rxuskXh63FMCWzTaZW1bRgIADe90MMg+5pVaD+zWSd+AJ148YHPfFDN5SjmwmEWyfLwU
 +ZqwKwE6MvIJFvLFM/tzvIu5wiRqc2ey5xpZO91z4Wwxn4JrcMj3TBLgh1CM9LI/RzVq
 NnHlX2QH0mhWsnLwZq8ugi7Jwh20WKxkXS5W19yEVLgKIKo41eQlUR4rD2S4aUsFBFGO
 /qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=XwvkaOS+zlPAQxC7KOYzKBbD0RTPzA4FCgsljx8AFyA=;
 b=L77Z3lVMZEgefRbI+fCOW9nJuVRmgNbogL4W1rxsUPtZclCQzmtl6d1W8HeS+BnFH5
 GbfLSU7sGU+xhMQgr9cEnj6Pi4xUDGnRnxt4iK2QUeqChFm34Rhofwb4DPRlmGt6BFcN
 37Y+EJGtvZ92E6ziUSm5GqqS7oLrA3YyPM5yx3yzr8rlAt7CPXxSKlLwrba8BW45tHPP
 E8PqaVYixTYvhrxo4T0kaT7lE3Q5eCfEoS1iajlHiG5Bz5SraajR0Lkbrw6s+oKy7vrb
 cJOfMAiIHNcdrKB0jA9d5kyXKZ9c87etdq2x/XFisE9AtCKaUhwHsyh7HC5BFJDHMRQT
 bGRg==
X-Gm-Message-State: AOAM530iqryRNNaTW3qrPqxGrbFLtM/4ILOCFT+IjuefAPI53gfIazIJ
 7VQFJpfo5vJp0oQhCCSqs/siTQ==
X-Google-Smtp-Source: ABdhPJxh3SvBWCEym3nyBVMrPVXzypgq9rJleizyVbSusoe6+vKY5qoIfH3u+mOQQWwwFx2rIfN14Q==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr7431886wrn.389.1596721155928; 
 Thu, 06 Aug 2020 06:39:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m8sm6735860wro.75.2020.08.06.06.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:39:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E6B511FF7E;
 Thu,  6 Aug 2020 14:39:13 +0100 (BST)
References: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
 <20200806110826.GH4159383@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
In-reply-to: <20200806110826.GH4159383@redhat.com>
Date: Thu, 06 Aug 2020 14:39:13 +0100
Message-ID: <87a6z7lwqm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Dave Gilbert <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Aug 06, 2020 at 11:24:13AM +0100, Stefan Hajnoczi wrote:
>
> ...snip...
>
> I broadly agree with the points about why Rust is desirable as
> a language for QEMU.
>
>> How can we change programming language?
>> ------------------------------------------------------------
>> When I checked in 2018 QEMU was 1.5 million lines of code. It has
>> grown since then. Moving a large codebase to a new programming
>> language is extremely difficult. If people want to convert QEMU to
>> Rust that would be great, but I personally don't have the appetite to
>> do it because I think the integration will be messy, result in a lot
>> of duplication, and there is too much un(der)maintained code that is
>> hard to convert.
>>=20
>> The reason I am writing this post is because device emulation, the
>> main security attack surface for VMMs, can be done in a separate
>> program. That program can be written in any language and this is where
>> Rust comes in. For vhost devices it is possible to write Rust device
>> backends today and I hope this will become the default approach to
>> writing new devices.
>>=20
>> For non-vhost devices the vfio-user project is working on an interface
>> out-of-process device emulation. It will be possible to implement
>> devices in Rust there too.
>
> I guess this dovetails into our view of security bug classification.
> Stuff that affects virtualization use cases is security critical,
> while stuff that affects emulation is NOT security critical.
>
> With this in mind, it is not a priority to convert the whole of
> QEMU to Rust. The priority is the subset that affects virtualization
> use cases. It is a much more tractable problem if we're looking at
> creating rust based vhost-user / vfio-user, only for the devices
> that are commonly used for KVM with modern OS, and ignore the many
> 100's of devices that are only there for emulation or foir legacy OS.

I'm definitely interested in vhost-user daemons in Rust. The one I've
been writing so far has been tried to be a minimal POSIX base without
including QEMU utility functions but I'm sure it would be nicer to start
with a clean standalone Rust library.

>> If you are implementing new device emulation code please consider
>> doing it in Rust!
>
> Yes, but I think we'll need put in significant effort to guide / assist
> people in taking this direction, and think about what it means for the
> future of QEMU as a brand and GIT repo.
>
> In many ways it is a good thing if the Rust vhost-user impls are
> all in their own standalone git repos. They're likely to be independent
> codebases, so there's little compelling reason to force them into the
> QEMU git, where they'll have to use QEMU workflow, and QEMU release
> cycle. They're better off free from QEMU where they can choose to adopt
> modern development practices like GitLab merge requests if they
> desire and release on a more frequent cycle than QEMU's 3-times a
> year, etc. Would also make them more appealing for use by alternative
> non-QEMU userspaces for KVM.
>
> The downside is that QEMU git would only contain the "legacy" builtin
> C impls of the devices, and all the "recommended" modern Rust impls
> would be elsewhere. Essentially QEMU would no longer be a self-contained
> provider of the complete solution. Many parts would be disaggregated,
> and users now have the burden of finding all the right pieces to build
> the best solution. We've already seen this to some extent with existing
> vhost-user impls, but it feels like we'd be pushing towards that as a
> more general model for the future which would amplify problems we've
> largely been able to ignore upto now.
>
> I'm not sure what a good answer here is. Perhaps QEMU could try to
> become more of brand for an umbrella project that covers multiple
> independant repos ? eg create new repos under gitlab.com/qemu-project/
> but allow them to work fairly independantly from the main qemu.git ?
> That way we can more easily promote a collection of QEMU repos as
> showing the recommended architecture, without forcing everything
> into qemu.git. We can leverage the QEMU website, wiki and documentation
> in general to showcase the overall solution, while still letting the
> pieces develop independently.

I think there would be scope for a vhost-user-daemon repo with multiple
reference implementations.

So has any vhost-user stuff been prototyped in Rust yet?

>
>> Conclusion
>> ---------------
>> Most security bugs in QEMU today are C programming bugs. Switching to
>> a safer programming language will significantly reduce security bugs
>> in QEMU. Rust is now mature and proven enough to use as the language
>> for device emulation code. Thanks to vhost-user and vfio-user using
>> Rust for device emulation does not require a big conversion of QEMU
>> code, it can simply be done in a separate program. This way attack
>> surfaces can be written in Rust to make them less susceptible to
>> security bugs going forward.
>
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

