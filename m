Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DDDC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 04:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B77207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 04:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mekg15te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B77207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM1y6-0004I8-UQ
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 00:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kM1xE-0003qk-Ju
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 00:37:00 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:33965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kM1xB-0004nb-QW
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 00:37:00 -0400
Received: by mail-qt1-x842.google.com with SMTP id 19so4123697qtp.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 21:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:references:date:in-reply-to:message-id
 :user-agent:mime-version;
 bh=nFrB/hH+6ti1S6Is7ZkdxdpEG/2ncrBgu9Fiyg+xv8s=;
 b=mekg15tekXNYR8n9wj74UA3ZUVh0FKre9liDudDxocs9Hsfil46Nn+P6qsTlyLumMA
 FU1T6QO0XL2TNYE/9VMY/J2bToj+gsqVmn0CgvKL7aP66pXUP/yT62A+pahEYl1P3ZCV
 BPHj8f1LdZkENivw72ixo6tXLuCt0TF8VEVm1pdLbBMIX+bEIZFspN3gXMIqMpAHVF6m
 nqWUSN8BpGDnu0G7uXxzsl5QzamVryTUbf+6CIxJcRSSsx1r3FS2pJ7UBWB5TQzFpFw0
 3SDNYoHUyWwWuBQg3TvBknbHGZJQjtg1ZvMoLSzXxzhK6xz38gGUui/CAnTjJiK+y5Ay
 q3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
 :message-id:user-agent:mime-version;
 bh=nFrB/hH+6ti1S6Is7ZkdxdpEG/2ncrBgu9Fiyg+xv8s=;
 b=PRTlZvfA1/g87Isqnice5/pXW0L4TQcIs6mUv3ookQNJn2P6fC9d7MVVqm4oUKj7IA
 oS59hducPhIx5ZIulV1HmKe5dhf+nyWDE5htI++YZCtOXRl5cMmbQKyjQZPkjOFti4FC
 5pcFMUz4rxqRV5MyYq/9I+jqKNpKbcMm/gmfJg1LsvDVH3dIV2+/CvK2/7nGZ2W9YiT6
 /4cx3ULAYCyggFQ4U2sD9vMSeqJr3UzgtOLzQbyt9S9sINoOThyASJsKhUbj00txb21D
 hTTssuQNis/FziAteCa+1XLKjdLYKjnL9XSsRe8eCO7hAPt8wE42L2VWX7CvpSQPxcFS
 F3zg==
X-Gm-Message-State: AOAM532n1rKHjULW3Yc7MxxSoZ/HPHtPVgo1EROt84txGD96tXN034rT
 HOwyoe886qiSmwR2Q7jlVmvsNkZx8RU=
X-Google-Smtp-Source: ABdhPJxbeG8GvrehCXmSNrYo3O1qjBhDHVQEY9/ROcMssdLvE1lFpyK0wv/XN2AMfxvJV2ULzaVUTQ==
X-Received: by 2002:aed:2b86:: with SMTP id e6mr3005887qtd.86.1601095016488;
 Fri, 25 Sep 2020 21:36:56 -0700 (PDT)
Received: from hurd (dsl-10-132-92.b2b2c.ca. [72.10.132.92])
 by smtp.gmail.com with ESMTPSA id s25sm3619015qtc.90.2020.09.25.21.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 21:36:55 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] build: Build and install the info manual.
References: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
 <CAFEAcA_wU73U6eaHU0mwccr-E0EHSKzFJ1yiR++YEKv=1LneJQ@mail.gmail.com>
Date: Sat, 26 Sep 2020 00:38:17 -0400
In-Reply-To: <CAFEAcA_wU73U6eaHU0mwccr-E0EHSKzFJ1yiR++YEKv=1LneJQ@mail.gmail.com>
 (Peter Maydell's message of "Fri, 25 Sep 2020 10:45:54 +0100")
Message-ID: <87mu1dtao6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=maxim.cournoyer@gmail.com; helo=mail-qt1-x842.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Peter,

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 25 Sep 2020 at 07:27, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>>
>> Take advantage of the Sphinx texinfo backend to generate a QEMU info
>> manual.  The texinfo format allows for more structure and info readers
>> provide more advanced navigation capabilities compared to manpages
>> readers.
>
> Not providing an info manual (or indeed any format other than HTML
> and manpages) was a deliberate design choice. The rationale is that
> checking that multiple document formats all ended up rendering
> correctly is more work than people will in practice put in (as
> demonstrated by various errors in the old HTML rendering, for
> instance).

It seems to me that any problem found in the texinfo rendering produced
by Sphinx would be a bug in Sphinx, which could simply be forwarded
upstream when encountered.  My experience with Sphinx-generated texinfo
manuals is rather good.  The CMake project allows producing an info
manual that way, for example, and the result is at least as usable as
their HTML-based doc (as an avid info user, I'd say more usable, given
most commands are indexed).

>> * configure (infodir): Add the --infodir option, which allows
>> configuring the directory under which the info manuals are installed.
>> * docs/index.rst: Include the top level documents to prevent
>> warnings (treated as errors by sphinx-build).
>
> This isn't the right thing. You should be pointing sphinx-build
> at each of the individual manuals (system, interop, etc) and
> generating one info file for each. This is because we generate
> manuals for each of these including the 'devel' manual, but
> we don't want to install 'devel', because it's developer-facing
> and not needed by end-users of QEMU.

Is this the only reason individual manuals are being generated?  It
makes sense for the manpages (which have their own macros), but
otherwise (for HTML and info) introduces a lot of complexity for not
much gain, in my opinion.  Users not wanting to know about devel
internals can simply skip that section; no harm done.

The individual manuals are all stitched back together using a top
index.html page (derived from index.html.in), anyway.  That'd be better
taken care of by Sphinx automatically upon generating the whole doc
tree, in my opinion, as it seems to be the way it was designed to work
and simplifies things all around.

I initially went the individual manual route and devised complicated
Make macros and got individual info manuals produced, only to find out I
wanted to replicate that index.html.in in the texinfo format (Texinfo is
as navigable as HTML, so having every QEMU manual under the same node as
different sections makes more sense in my opinion).  The individually
produced info manual were also all named 'QEMU Documentation' rather
than with their own more accurate names, because of directives in the
included the top-level conf.py.

> won't find you have problems with the orphan top level documents.
>
> (We really need to move those orphan docs into the right places
> in the manual structure at some point.)

We could simply put them in another section called "Others" as a
starting point.  For this patch we can also choose to ignore them rather
than include them, but if someone went to the length of writing those
docs, I'd argue it was to be read rather than forgotten :-).

>> * docs/meson.build (sphinxinfo): Add new target.
>
> You've forgotten your Signed-off-by: line.

I've added it in my local tree; will wait for your feedback on my above
comments before sending an updated patch.

Thanks for the review,

Maxim

