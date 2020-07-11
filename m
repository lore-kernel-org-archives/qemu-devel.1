Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F5C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 06:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B84206F0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 06:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoLxkPxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B84206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju9I8-0000V2-EF
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 02:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1ju9HM-0008Mw-HU
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 02:46:32 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:44018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1ju9HJ-00044q-As
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 02:46:32 -0400
Received: by mail-vk1-xa43.google.com with SMTP id e10so1714576vkm.10
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 23:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GPX/+VTRYVIvBeoLayuBrN/vbPHRw0Wh7B1SdAcqqmA=;
 b=aoLxkPxV2gCFkADN52staENtMVnpWKaCrj0S7bNGpH/ZxjFbnk5b1x1nRUZ6hzAt+I
 7n27ZCOYC/m9/NusJvqs9vNLdMnIiDWf/ppM8e9TnFlqT337U83lRmCqe6HHQ1MSHYnb
 opP6iMPLmN/WRop/2cXiI3S3gicrtOP8ah7mb0fWxKsBRFpLoroPXI/5VdypELiGPoIr
 urPqIHhe6SxUKOhhxJaqiE5Ro4S6CPWsMkf5h5oTLx+wUQGS7qJqvRHD1vAoT4B/RT2n
 1zboCB2u8cP6zZqt34Xezb4Fq27n+3eXIohHwVFTrv6YBlhC+3+Xaz+IUyue5HOgvqee
 OgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GPX/+VTRYVIvBeoLayuBrN/vbPHRw0Wh7B1SdAcqqmA=;
 b=Um8Bzf34lgW4ZzS8qKQAZzqyAuykhdWjWkQd5g2AyEOipXeDz0pDhD2V4WgvdTl7Sb
 yocfsXb3YUX3d8XDc4zYL1yETsXHXYVK8oDBSbCdLC8KUBjptG3PpQ2dTw3astObqvYs
 Sz1v4tgI6ov6vwvSjXfp+MlfJz2pOM6dmisllAN/AewmGYOllhvMcoOtigRvCXpDFt/H
 j7BMDGLkYyOLlqSn5j87VU/fV8xz5TQW73Y/IX5N5CsSRiqsIe4Qe8bZw0s8RUL6dKGQ
 fAhSaPeXOUugPZ/Zcx4NkxNXsEzea48FCcICd/j2ZHawtmKNmMtVLHY4m2BqnrcN9EF3
 Rscw==
X-Gm-Message-State: AOAM530EhSBy4IwcXT4y9QgorYQNpiBSoqaolPSBp8qyjC+X3JyrXAcD
 iSj7PM8+r4voBqs9Jumxf7d/hWOMbrN/tUnCrjUWJQ==
X-Google-Smtp-Source: ABdhPJwE6+XsRhygyLulcW/+LM5p3aTP1qZJCfrSQOYlg+SyPuk5NSdvlJXbwcEw8wnQEpICRtp6N8EkQk2pzCx+Zfo=
X-Received: by 2002:a05:6122:130b:: with SMTP id
 e11mr21570579vkp.20.1594449986033; 
 Fri, 10 Jul 2020 23:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-2-hskinnemoen@google.com>
 <2fe8ea5e-56de-f57f-6146-8355125daa7f@amsat.org>
 <CAFQmdRYx99PpWz6bftCvBR7=YRftD_WNex_A9aoDaeRg=4tsCw@mail.gmail.com>
 <bd2972b0-0684-e379-6d66-16ceb62deade@amsat.org>
 <CAFQmdRbHXhd9-HUQP5ET=JQEnQ3FMCQBHajwZrP5d7=iCc0tzA@mail.gmail.com>
 <ee8bc620-6d58-98ef-1c53-a8687282af50@amsat.org>
 <CAFQmdRa3u_Sst0i6e2whoJcYau15gVQubhZHmm+z26SD8G8uCQ@mail.gmail.com>
 <c19401c1-f629-a95f-c8a5-60df78e41061@amsat.org>
In-Reply-To: <c19401c1-f629-a95f-c8a5-60df78e41061@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 10 Jul 2020 23:46:14 -0700
Message-ID: <CAFQmdRafRXYJpZvxbmjiMhNNmQ97GqQREvrYvWWdOPWfYTQq-g@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] hw/misc: Add NPCM7xx System Global Control
 Registers device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 10, 2020 at 2:31 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/9/20 7:42 PM, Havard Skinnemoen wrote:
> > On Thu, Jul 9, 2020 at 10:24 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >> On 7/9/20 7:09 PM, Havard Skinnemoen wrote:
> >>> On Thu, Jul 9, 2020 at 9:23 AM Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
> >>>> On 7/9/20 8:43 AM, Havard Skinnemoen wrote:
> >>>>> On Wed, Jul 8, 2020 at 11:04 PM Philippe Mathieu-Daud=C3=A9 <f4bug@=
amsat.org> wrote:
> >>>>>> On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
> >>>>>>> Implement a device model for the System Global Control Registers =
in the
> >>>>>>> NPCM730 and NPCM750 BMC SoCs.
> >>>>>>>
> >>>>>>> This is primarily used to enable SMP boot (the boot ROM spins rea=
ding
> >>>>>>> the SCRPAD register) and DDR memory initialization; other registe=
rs are
> >>>>>>> best effort for now.
> >>>>>>>
> >>>>>>> The reset values of the MDLR and PWRON registers are determined b=
y the
> >>>>>>> SoC variant (730 vs 750) and board straps respectively.
> >>>>>>>
> >>>>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> >>>>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> >>>>>>> ---
> [...]
> >>>>>> Maybe use HWADDR_PRIx instead of casting to int?
> >>>>>
> >>>>> Will do, thanks!
> >>>>
> >>>> Glad you are not annoyed by my review comments.
> >>>>
> >>>> FYI your series quality is in my top-4 "adding new machine to QEMU".
> >>>> I'd like to use it as example to follow.
> >>>>
> >>>> I am slowly reviewing because this is not part of my work duties,
> >>>> so I do that in my free time before/after work, which is why I can
> >>>> barely do more that 2 per day, as I have to learn the SoC and
> >>>> cross check documentation (or in this case, existing firmware code
> >>>> since there is no public doc).
> >>>
> >>> Your feedback is super valuable, thanks a lot. I really appreciate it=
.
> >>
> >> OK I'll continue, but might not have time until next week.
> >> After I plan to test too.
> >
> > OK, I'll try to post a v6 before the weekend, unless you prefer that I
> > hold off until you've reviewed the whole series.
>
> I don't mind, if it is not too much overhead on your side.
>
> What I noticed on the QEMU community is:
>
> - If a series reviewed the same day and is almost done except
>   a single bugfix, it is OK to repost the same day, so the
>   maintainer is likely to queue it directly.
>
> - If there are various reviews, and you do gradual improvements,
>   it is OK to repost every 3 days. Else reviewers tend to skip/
>   postpone your series for later.
>
> - Pinging for review before 1 week passed is stressing reviewers,
>   except in case of critical security bug (CVE) or during freeze.
>
> - Series with integrated test provided are usually reviewed first.

This is very helpful, thanks.

> >> What would be useful is an acceptance test (see examples in
> >> tests/acceptance/), using the artefacts from the link you shared
> >> elsewhere:
> >> https://openpower.xyz/job/run-meta-ci/distro=3Dubuntu,label=3Dbuilder,=
target=3Dgsj/lastSuccessfulBuild/artifact/openbmc/build/tmp/deploy/images/g=
sj/
> >
> > Yes, tests are definitely on my radar. I'm working on SPI flash
> > qtests. I haven't had much success with avocado yet, but I'll keep
> > trying (perhaps using docker to control the environment more tightly).
>
> This might help:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg704907.html

Thanks, I got it working now.

> > Since the 5.1 release is frozen now, I might post some followup
> > patches before this series is merged, e.g. tests, bootrom
> > submodule+blob, more peripherals, etc. Is it preferable to keep this
> > series frozen (modulo API updates) since you spent a lot of time
> > reviewing it, and post the new stuff separately, or is it better to
> > add new patches to the end of the series and resend the whole thing?
>
> If you rework a peripheral, you need to reset the Reviewed-by/Tested-by
> tags. If you add new peripherals, you only need to reset these tags on
> the SoC patch. I'm fine either way, I use git-backport-diff to see the
> SoC changes easily:
>
> https://github.com/codyprime/git-scripts/blob/master/git-backport-diff

I've been adding new peripherals incrementally after the basic SoC
support patch. Is that OK to do without resetting the tags?

But it's more likely that I'll add other things than peripherals next,
i.e. bootrom and tests.

> >
> >> But these are apparently not stable links (expire after 30 days?).
> >
> > Sorry, I'm too ignorant about Jenkins to know. I'll see if I can
> > figure something out.
>
> What I do in that case is take the binary used for the test,
> write a comment and push it in a stable branch to my own repo:
> https://github.com/philmd/qemu-testing-blob/ and use the stable
> url in the test.
>
> We know QEMU emulation worked with this particular binary at some
> point. We want to avoid regressions in QEMU, so let's keep testing
> what we know worked. We don't want to track 2 bugs at a time (one
> in the updated guest and one in QEMU).

Good point. I'll see if I can upload images to github. I might fork
the openbmc repository and attach binaries to a github release, to
make it clear where the binaries came from.

I accidentally broke my test image and had some trouble recreating it,
so I ended up reworking my various hacks a bit. The good news is that
I got most of them turned into proper bug fixes that I can send
upstream.

It might take a little longer than I said previously, but I'll try to
include acceptance tests in the next series.

Havard

