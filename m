Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E3AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 05:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A96D2084D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 05:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiJa5SlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A96D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juUsz-00024T-LA
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 01:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1juUsD-0001RH-Jf
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 01:50:01 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:36286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1juUsA-0006Jp-IG
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 01:50:01 -0400
Received: by mail-vs1-xe44.google.com with SMTP id d11so2527853vsq.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 22:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Btg6Yv97idcpu/upu6nF8Pf/PwK72O/MtR8x5++CRVs=;
 b=PiJa5SlMujalf72b+gkPmGwVhFf5IVsl4c1EdstuyvWxx//NpYnmhn5NoIHWxAxVVx
 SLPp57vUm+y2ekdHGsulAx5L6Nuo06CGuPGwvzELWiubFcE63+/F+ca02tep1x1FpFzz
 Oza5WM6Eb61qGe7psbqZxrRjuZY5ndiT3QOGgGUBAi3A6BT9AWOaur13fHqeRgsHXt/D
 YZ0B1yJQN1tNyE5kSVKldmwN7wXNboRgSUOf0a7RM4v3oJYcpUK0u1wX+4CVpkBnQC5C
 NSmvhoxI9gJSAElzHr7JF/f1q85auBs1Sv3hqq13hd2PVJAbEn0oqQu0f2alNtTHR2KG
 Q64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Btg6Yv97idcpu/upu6nF8Pf/PwK72O/MtR8x5++CRVs=;
 b=uPwoIHKuj9Nn7kjpAestaXy4aVOyk5pCFzY6dsH7WjIAxIwTyb+7dDUdxES1JcD9Q5
 9IDH2/cftR5hmB3B1x43zFWJ9hiETBU8vgDfGjSaLD525PFIzWulQinnhoA740LVO0tj
 1OzipExkg+jHhRNGsx6OKUiGA1AoxtgYOUlMkSOdcbR2kBDL2FW+32UCFgoOonhyfCi8
 tI/0u+8zTqmF0o7ZV9jxxcwAloY9pCMRtvIJ3c/bm1quPu2Yo/HtkUQtqW/1wZllGaM1
 OGravL2k/BxbbgdBhOvCfFsDtIsiUQIfAl+jpod1xTTwq8bKhpH/pBHxFE1oK7BFsRCz
 tsrw==
X-Gm-Message-State: AOAM533G1HcV+qRemxDUATbrvtIq8eCek6GG7KQradWyXdrEvT0YAleo
 DZSU2m0Zezsp4uR+IyS64dX+ZaorBXAH235qaYj3UA==
X-Google-Smtp-Source: ABdhPJxGVOYdQ9V1RTVXk9kqm2cQSnysu7/JFve6O2DzFp2lghuSF8yLW/MVDgdTlDweZzepMX3MMAC6imfws4BiAaI=
X-Received: by 2002:a67:d88c:: with SMTP id f12mr55358994vsj.92.1594532996911; 
 Sat, 11 Jul 2020 22:49:56 -0700 (PDT)
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
 <CAFQmdRafRXYJpZvxbmjiMhNNmQ97GqQREvrYvWWdOPWfYTQq-g@mail.gmail.com>
In-Reply-To: <CAFQmdRafRXYJpZvxbmjiMhNNmQ97GqQREvrYvWWdOPWfYTQq-g@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Sat, 11 Jul 2020 22:49:45 -0700
Message-ID: <CAFQmdRYhR9Fj5yUjntxrKMWAhYcUCFi+qkT6XWEbeELWOmmPGw@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe44.google.com
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

On Fri, Jul 10, 2020 at 11:46 PM Havard Skinnemoen
<hskinnemoen@google.com> wrote:
>
> On Fri, Jul 10, 2020 at 2:31 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > On 7/9/20 7:42 PM, Havard Skinnemoen wrote:
> > > On Thu, Jul 9, 2020 at 10:24 AM Philippe Mathieu-Daud=C3=A9 <f4bug@am=
sat.org> wrote:
> > >> On 7/9/20 7:09 PM, Havard Skinnemoen wrote:
> > >>> On Thu, Jul 9, 2020 at 9:23 AM Philippe Mathieu-Daud=C3=A9 <f4bug@a=
msat.org> wrote:
> > >>>> On 7/9/20 8:43 AM, Havard Skinnemoen wrote:
> > >>>>> On Wed, Jul 8, 2020 at 11:04 PM Philippe Mathieu-Daud=C3=A9 <f4bu=
g@amsat.org> wrote:
> > >>>>>> On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
> > >>>>>>> Implement a device model for the System Global Control Register=
s in the
> > >>>>>>> NPCM730 and NPCM750 BMC SoCs.
> > >>>>>>>
> > >>>>>>> This is primarily used to enable SMP boot (the boot ROM spins r=
eading
> > >>>>>>> the SCRPAD register) and DDR memory initialization; other regis=
ters are
> > >>>>>>> best effort for now.
> > >>>>>>>
> > >>>>>>> The reset values of the MDLR and PWRON registers are determined=
 by the
> > >>>>>>> SoC variant (730 vs 750) and board straps respectively.
> > >>>>>>>
> > >>>>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> > >>>>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > >>>>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > >>>>>>> ---
> > [...]
> > >>>>>> Maybe use HWADDR_PRIx instead of casting to int?
> > >>>>>
> > >>>>> Will do, thanks!
> > >>>>
> > >>>> Glad you are not annoyed by my review comments.
> > >>>>
> > >>>> FYI your series quality is in my top-4 "adding new machine to QEMU=
".
> > >>>> I'd like to use it as example to follow.
> > >>>>
> > >>>> I am slowly reviewing because this is not part of my work duties,
> > >>>> so I do that in my free time before/after work, which is why I can
> > >>>> barely do more that 2 per day, as I have to learn the SoC and
> > >>>> cross check documentation (or in this case, existing firmware code
> > >>>> since there is no public doc).
> > >>>
> > >>> Your feedback is super valuable, thanks a lot. I really appreciate =
it.
> > >>
> > >> OK I'll continue, but might not have time until next week.
> > >> After I plan to test too.
> > >
> > > OK, I'll try to post a v6 before the weekend, unless you prefer that =
I
> > > hold off until you've reviewed the whole series.
> >
> > I don't mind, if it is not too much overhead on your side.
> >
> > What I noticed on the QEMU community is:
> >
> > - If a series reviewed the same day and is almost done except
> >   a single bugfix, it is OK to repost the same day, so the
> >   maintainer is likely to queue it directly.
> >
> > - If there are various reviews, and you do gradual improvements,
> >   it is OK to repost every 3 days. Else reviewers tend to skip/
> >   postpone your series for later.
> >
> > - Pinging for review before 1 week passed is stressing reviewers,
> >   except in case of critical security bug (CVE) or during freeze.
> >
> > - Series with integrated test provided are usually reviewed first.
>
> This is very helpful, thanks.
>
> > >> What would be useful is an acceptance test (see examples in
> > >> tests/acceptance/), using the artefacts from the link you shared
> > >> elsewhere:
> > >> https://openpower.xyz/job/run-meta-ci/distro=3Dubuntu,label=3Dbuilde=
r,target=3Dgsj/lastSuccessfulBuild/artifact/openbmc/build/tmp/deploy/images=
/gsj/
> > >
> > > Yes, tests are definitely on my radar. I'm working on SPI flash
> > > qtests. I haven't had much success with avocado yet, but I'll keep
> > > trying (perhaps using docker to control the environment more tightly)=
.
> >
> > This might help:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg704907.html
>
> Thanks, I got it working now.
>
> > > Since the 5.1 release is frozen now, I might post some followup
> > > patches before this series is merged, e.g. tests, bootrom
> > > submodule+blob, more peripherals, etc. Is it preferable to keep this
> > > series frozen (modulo API updates) since you spent a lot of time
> > > reviewing it, and post the new stuff separately, or is it better to
> > > add new patches to the end of the series and resend the whole thing?
> >
> > If you rework a peripheral, you need to reset the Reviewed-by/Tested-by
> > tags. If you add new peripherals, you only need to reset these tags on
> > the SoC patch. I'm fine either way, I use git-backport-diff to see the
> > SoC changes easily:
> >
> > https://github.com/codyprime/git-scripts/blob/master/git-backport-diff
>
> I've been adding new peripherals incrementally after the basic SoC
> support patch. Is that OK to do without resetting the tags?
>
> But it's more likely that I'll add other things than peripherals next,
> i.e. bootrom and tests.
>
> > >
> > >> But these are apparently not stable links (expire after 30 days?).
> > >
> > > Sorry, I'm too ignorant about Jenkins to know. I'll see if I can
> > > figure something out.
> >
> > What I do in that case is take the binary used for the test,
> > write a comment and push it in a stable branch to my own repo:
> > https://github.com/philmd/qemu-testing-blob/ and use the stable
> > url in the test.
> >
> > We know QEMU emulation worked with this particular binary at some
> > point. We want to avoid regressions in QEMU, so let's keep testing
> > what we know worked. We don't want to track 2 bugs at a time (one
> > in the updated guest and one in QEMU).
>
> Good point. I'll see if I can upload images to github. I might fork
> the openbmc repository and attach binaries to a github release, to
> make it clear where the binaries came from.
>
> I accidentally broke my test image and had some trouble recreating it,
> so I ended up reworking my various hacks a bit. The good news is that
> I got most of them turned into proper bug fixes that I can send
> upstream.
>
> It might take a little longer than I said previously, but I'll try to
> include acceptance tests in the next series.

I uploaded the images here:

https://github.com/hskinnemoen/openbmc/releases/tag/20200711-gsj-qemu-0

I used them to implement an acceptance test that I'll include in v6.

