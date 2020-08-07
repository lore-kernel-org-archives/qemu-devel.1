Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C481820748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoyQPNcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C481820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zBv-00020I-2v
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zAh-00012k-BU
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:00:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zAe-00065d-Es
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:00:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id a15so1105501wrh.10
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1xs/6T4a1mvMkV5VAlxQg+XqLtTwBk3TEAaZpfJgSPo=;
 b=CoyQPNcyHQcbFpVTdQJmfmtbjeGIb3YHSSJLBYILWE6BvZddCuLdAHYqPWJIKXMvR9
 ZlQfdACrlw2pxzOYMMyT3/ZxoBDWgWl3j0I7fMkWzGIPbFChi9JRNBPZOWQ0wD7DHJrK
 AClZNLAXx3HKmNqjHRbUgnO1NqpyN1ZBnH9EN76+uhZ3bGLaqxsDATYm2VVsuFfqSrON
 eZtlRhsbFLRZvuRk1jjtEND6S/nDtb1UEJxpLjKos43hc0K3rlhqN/wrgGnJS3uAiqHm
 TFJK5ChK6YLRQo/mctYk+jNcpj91871O+RV1Da4pp3jGR5UtmPwgDhYu6Ye5AN4EA/h5
 8k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1xs/6T4a1mvMkV5VAlxQg+XqLtTwBk3TEAaZpfJgSPo=;
 b=ML38GLEVwWWQNxuYWUkVXDml6zOzJiAr0kHey+mWJWJogueF2KTem/7n4LPiKYw83Q
 Az5EoydgffD91PTfHEjDVg27bcSfGzNAnY1jw5BoQRqHvwln+VyPUPFjFgLMc7D+SkUq
 rRNERXEcArLjDYj+408kupejfF8z4vIyBKRxoRUcSYaXRCRr4EJm0UTp8MVVFfwUcKPe
 9J+GlNw6/jKOTfw2qeUTot92gQewxdisB1ipU4eBM4K0u6ip+bLQhfDUnnIU7BTnMHHq
 TzdsuEIYxsBsFwX5Y7NjjuC7WEnoXYTOMMSDDUKt4zvr1uxx5K19YqAU5Xqtn/8g8VgG
 Xqhg==
X-Gm-Message-State: AOAM533oBSSRF5PGzPuH31Cy2OuXpIutziQipvjClp7wbcDiBeoobY1z
 6yk692YVY73Cgapn8DMG6UuOPg==
X-Google-Smtp-Source: ABdhPJxPW7O16jrhaEwVYmE8m+cH/P3tLB/FHUTOMAWa3rCyAE0FMW124LxjuY68XoXhcnaKHz6ZoQ==
X-Received: by 2002:adf:ee83:: with SMTP id b3mr11161438wro.163.1596794407832; 
 Fri, 07 Aug 2020 03:00:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s205sm10149179wme.7.2020.08.07.03.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 03:00:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2002E1FF7E;
 Fri,  7 Aug 2020 11:00:06 +0100 (BST)
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-6-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_mN3XrgxRbhq5U0B=OxBq6T3DXymb4_U-tzOya=W-AbQ@mail.gmail.com>
 <d676a107-c49d-ab3f-f6e3-f6b594af9c4f@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 005/143] meson: rename .inc.c files to .inc
In-reply-to: <d676a107-c49d-ab3f-f6e3-f6b594af9c4f@redhat.com>
Date: Fri, 07 Aug 2020 11:00:06 +0100
Message-ID: <877dualqs9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/08/20 10:59, Peter Maydell wrote:
>> On Thu, 6 Aug 2020 at 20:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>> What's the rationale for this ? ".inc.c" is the project's
>> standard naming convention for files which aren't headers
>> but which are lumps of C code #included into a top level .c
>> file. The .inc.c deliberately ends '.c' because that way
>> editors will use the right syntax highlighting for the file.
>
> Good point.  It can be changed to .inc.h too, if that's preferrable
> for you.

We have two types of inc files - the inline C sections but also .inc.h
files. I'm not sure they should be lumped together. I think most of the
header based ones are essentially templates which get expanded multiple
times with #undef/#define blocks before each inclusion.

>
>> It would be much better if Meson could cope with our
>> standard naming convention rather than forcing us to change it.
>
> First of all I need to describe why this is needed; it is because of the
> way Meson handles dependencies on generated headers.
>
> With Makefiles that have automatically generated dependencies, you
> typically make generated includes depend on the Makefile so that they
> are built before everything else and they are available when first
> building the .c files.
>
> Meson is similar, however the way it works is that you list those
> generated includes in the sources.  The dependencies are still
> automatically generated, but the build rules will ensure that the
> includes are generated before attempting to build the toplevel C sources.
>
> The problem is that Meson decides if something is a source vs. a
> generated include by looking at the extension: '.c', '.cc', '.m', '.C'
> are sources, while everything else is considered an include---including
> '.inc.c'.
>
> Going back to patch 124, I can now answer your question:
>
>>> It's not clear to me why all the decodetree lines ended up in a
>>> single "gen =3D []" block -- they're independent of each other.
>
> The files are added to the source list with "arm_ss.add(gen)".  All that
> line does is ensuring they are built before other target-specific files
> for ARM targets.
>
> The question then is if Meson could be changed to cope with our naming
> convention, and unfortunately the answer is no.  The root cause is that
> Makefiles list .o files (and uses implicit patterns to connect .o files
> to the corresponding sources), while Meson lists .c files.
>
> There is a silver lining, in that you do get something out of this: if
> you have a typo in the name of a .c file, it is detected it at
> "configure" time rather than having to wait until "make" tries to find
> the source code for that ".o" file.

Hmm - I guess one workaround is to tweak editorconfig so whatever we end
up renaming things still get identified as the right type of file for
syntax hi-lighting purposes.

--=20
Alex Benn=C3=A9e

