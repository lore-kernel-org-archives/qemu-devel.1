Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC377C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973032070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJOMoL6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973032070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRLf-0002Qg-TV
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwRL1-0001z8-Bv
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:27:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwRKz-0001Ol-4j
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:27:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id b6so11330114wrs.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8SOgN09JSMSPjx+VUbm82cpMSQRYwxa/6o23S/Dkg78=;
 b=SJOMoL6wZ9Sagf8n1Br87ryC5mxdgLUMv+ENUVuNZXyAltKpXTnrVxWwIQ8B671Jr3
 0fWSoRnFs1O4/aJdFBSWd/xccz2n3dEiLvxBYQImc9hTP67YjO2T11Kf5U9VW5a/EJhP
 hWoPNoOTp74i/MnVE319D3AK34ET7JD0tFsAWb4X4x87IPX+lQfwngJ9VnWaZlwWXfxU
 gfuWcQiuSEviJPG1AwRQHsfRTm29x7OHrxJK2tU+LSVdEM4AKyynqycIbZMLgI0hGoWN
 80+es8n3KOHae8cfDS2U0a049gFhc3BqGe7QHNwXeLqJSH6vT0HN5pJpAk8Iba57C2mp
 gkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8SOgN09JSMSPjx+VUbm82cpMSQRYwxa/6o23S/Dkg78=;
 b=BYwGBKgKWRA95zI2gGbGgeVNECRnleacMdDK1xb3cP83ryXWpdlj46vA6Fctdg2whb
 CC9VA0dJIaMfrQJ38fFO4k0DIHnO+C+JM6RYHQSVn8YjIn6+j2++nLGF7hWR9MAkXMeM
 rphQQidLnED79rWfm80jxCCJSZmNDYtMQ/QjHRaZfBNMcw3rbqYZr0z3jE8af3uUTG0d
 flZrJdjosonYFjO52HdgVyc+El85S65pdmU9q1NCGiNtsNL/aPWLCQXlrE27bYgO15av
 dWdK8zw+oj2Md8yUS2/Jwc4kQO1/6ZSpPYVQxPBOOdZv6McL2bAGZrY2HWgSKN6xDgKY
 MuRw==
X-Gm-Message-State: AOAM530du3E9d0qmRuU7kktnSsU5dI/TRpPOXCTNbLRjgkW5012dnyJk
 cCZH7Ea8jUUAqLDB/9L7rHuUJw==
X-Google-Smtp-Source: ABdhPJxpuAu2MdWqGUn/HVzJAddGk2aZ8PDT5//CG9R5waxbj41h1paszzs8aywkMJXsaNtTVTpGOA==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr10538480wrc.218.1594996063008; 
 Fri, 17 Jul 2020 07:27:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t14sm2825645wrv.14.2020.07.17.07.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 07:27:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3CE0C1FF7E;
 Fri, 17 Jul 2020 15:27:41 +0100 (BST)
References: <CAATJJ0JDs78irZYRA7-wBefZhmTFK7SpCecuq79Ub-8n1jfy3A@mail.gmail.com>
 <alpine.LMD.2.03.2007151755360.31652@eik.bme.hu>
 <CAATJJ0L2V5QgPHoJW25HrT1_4_YhZJOLS=jFdCU6+JkHFG_MbA@mail.gmail.com>
 <871rlbwhlp.fsf@linaro.org>
 <CAATJJ0+v5jPD+Qed8oq4i=pfKt5xXVhUq5kPw8P-KGEUOnb_3g@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: TB Cache size grows out of control with qemu 5.0
In-reply-to: <CAATJJ0+v5jPD+Qed8oq4i=pfKt5xXVhUq5kPw8P-KGEUOnb_3g@mail.gmail.com>
Date: Fri, 17 Jul 2020 15:27:41 +0100
Message-ID: <87k0z2usgy.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Christian Ehrhardt <christian.ehrhardt@canonical.com> writes:

> On Thu, Jul 16, 2020 at 6:27 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>>
>> Christian Ehrhardt <christian.ehrhardt@canonical.com> writes:
>>
>> > On Wed, Jul 15, 2020 at 5:58 PM BALATON Zoltan <balaton@eik.bme.hu>
>> wrote:
>> >
>> >> See commit 47a2def4533a2807e48954abd50b32ecb1aaf29a and the next two
>> >> following it.
>> >>
>> >
>> > Thank you Zoltan for pointing out this commit, I agree that this seems
>> to be
>> > the trigger for the issues I'm seeing. Unfortunately the common CI host
>> size
>> > is 1-2G. For example on Ubuntu Autopkgtests 1.5G.
>> > Those of them running guests do so in 0.5-1G size in TCG mode
>> > (as they often can't rely on having KVM available).
>> >
>> > The 1G TB buffer + 0.5G actual guest size + lack of dynamic downsizing
>> > on memory pressure (never existed) makes these systems go OOM-Killing
>> > the qemu process.
>>
>> Ooops. I admit the assumption was that most people running system
>> emulation would be doing it on beefier machines.
>>
>> > The patches indicated that the TB flushes on a full guest boot are a
>> > good indicator of the TB size efficiency. From my old checks I had:
>> >
>> > - Qemu 4.2 512M guest with 32M default overwritten by ram-size/4
>> > TB flush count      14, 14, 16
>> > - Qemu 5.0 512M guest with 1G default
>> > TB flush count      1, 1, 1
>> >
>> > I agree that ram/4 seems odd, especially on huge guests that is a lot
>> > potentially wasted. And most environments have a bit of breathing
>> > room 1G is too big in small host systems and the common CI system falls
>> > into this category. So I tuned it down to 256M for a test.
>> >
>> > - Qemu 4.2 512M guest with tb-size 256M
>> > TB flush count      5, 5, 5
>> > - Qemu 5.0 512M guest with tb-size 256M
>> > TB flush count      5, 5, 5
>> > - Qemu 5.0 512M guest with 256M default in code
>> > TB flush count      5, 5, 5
>> >
>> > So performance wise the results are as much in-between as you'd think
>> from a
>> > TB size in between. And the memory consumption which (for me) is the
>> actual
>> > current issue to fix would be back in line again as expected.
>>
>> So I'm glad you have the workaround.
>>
>> >
>> > So on one hand I'm suggesting something like:
>> > --- a/accel/tcg/translate-all.c
>> > +++ b/accel/tcg/translate-all.c
>> > @@ -944,7 +944,7 @@ static void page_lock_pair(PageDesc **re
>> >   * Users running large scale system emulation may want to tweak their
>> >   * runtime setup via the tb-size control on the command line.
>> >   */
>> > -#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
>> > +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (256 * MiB)
>>
>> The problem we have is any number we pick here is arbitrary. And while
>> it did regress your use-case changing it again just pushes a performance
>> regression onto someone else.
>
>
> Thanks for your feedback Alex!
>
> That is true "for you" since 5.0 is released from upstreams POV.
> But from the downstreams POV no 5.0 exists for Ubuntu yet and I'd break
> many places releasing it like that.
> Sadly the performance gain to the other cases will most likely go unnotic=
ed.
>
>
>> The most (*) 64 bit desktop PCs have 16Gb
>> of RAM, almost all have more than 8gb. And there is a workaround.
>>
>
> Due to our work around virtualization the values representing
> "most 64 bit desktop PCs" aren't the only thing that matters :-)
>
> ...
>
>
>> > This is a bit more tricky than it seems as ram_sizes is no more
>> > present in that context but it is enough to discuss it.
>> > That should serve all cases - small and large - better as a pure
>> > static default of 1G or always ram/4?
>>
>> I'm definitely against re-introducing ram_size into the mix. The
>> original commit (a1b18df9a4) that broke this introduced an ordering
>> dependency which we don't want to bring back.
>>
>
> I agree with that reasoning, but currently without any size dependency
> the "arbitrary value" we picked to be 1G is even more fixed than it was
> before.
> Compared to pre v5.0 for now I can only decide to
> a) tune it down -> performance impact for huge guests
> b) keep it at 1G -> functional breakage with small hosts
>
> I'd be more amenable to something that took into account host memory and
>> limited the default if it was smaller than a threshold. Is there a way
>> to probe that that doesn't involve slurping /proc/meminfo?
>>
>
> I agree that a host-size dependency might be the better way to go,
> yet I have no great cross-platform resilient way to get that.
> Maybe we can make it like "if I can get some value consider it,
> otherwise use the current default".
> That would improve many places already, while keeping the rest at the
> current behavior.
>
>
>> >
>> > P.S. I added Alex being the Author of the offending patch and
>> Richard/Paolo
>> > for being listed in the Maintainers file for TCG.
>>
>>
>>
> From Zoltan (unifying the thread a bit):
>
>> I agree that this should be dependent on host memory size not guest
>> ram_size but it might be tricky to get that value because different host
>> OSes would need different ways.
>
> Well - where it isn't available we will continue to take the default
> qemu 5.0 already had. If required on other platforms as well they can add
> their way of host memory detection into this as needed.
>
>> Maybe a new qemu_host_mem_size portability
>> function will be needed that implements this for different host OSes.
>> POSIX may or may not have sysconf _SC_PHYS_PAGES and _SC_AVPHYS_PAGES
>
> We should not try to get into the business of _SC_AVPHYS_PAGES and
> try to understand/assume what might be cache or otherwise (re)usable.
> Since we only look for some alignment to hosts size _SC_PHYS_PAGES should
> be good enough and available in more places than the other options.
>
>> and linux has sysinfo but don't know how reliable these are.
>
> sysconf is slightly more widely available than sysinfo and has enough for
> what we need.
>
>
> I have combined the thoughts above into a patch and it works well in
> my tests.
>
> 32G Host:
> pages 8187304.000000
> pagesize 4096.000000
> max_default 4191899648
> final tb_size 1073741824
>
> (qemu) info jit
> Translation buffer state:
> gen code size       210425059/1073736659
> TB count            368273
> TB avg target size  20 max=3D1992 bytes
> TB avg host size    330 bytes (expansion ratio: 16.1)
> cross page TB count 1656 (0%)
> direct jump count   249813 (67%) (2 jumps=3D182112 49%)
> TB hash buckets     197613/262144 (75.38% head buckets used)
> TB hash occupancy   34.15% avg chain occ. Histogram: [0,10)%|=E2=96=86 =
=E2=96=88
>  =E2=96=85=E2=96=81=E2=96=83=E2=96=81=E2=96=81|[90,100]%
> TB hash avg chain   1.020 buckets. Histogram: 1|=E2=96=88=E2=96=81=E2=96=
=81|3
>
> Statistics:
> TB flush count      1
> TB invalidate count 451673
> TLB full flushes    0
> TLB partial flushes 154819
> TLB elided flushes  191627
> [TCG profiler not compiled]
>
> =3D> 1G TB size not changed compared to v5.0 - as intended
>
>
> But on a small 1.5G Host it now works without OOM:
>
> pages 379667.000000
> pagesize 4096.000000
> max_default 194389504
> final tb_size 194389504
>
> (qemu) info jit
> Translation buffer state:
> gen code size       86179731/194382803
> TB count            149995
> TB avg target size  20 max=3D1992 bytes
> TB avg host size    333 bytes (expansion ratio: 16.5)
> cross page TB count 716 (0%)
> direct jump count   98854 (65%) (2 jumps=3D74962 49%)
> TB hash buckets     58842/65536 (89.79% head buckets used)
> TB hash occupancy   51.46% avg chain occ. Histogram: [0,10)%|=E2=96=83 =
=E2=96=87
>  =E2=96=88=E2=96=82=E2=96=86=E2=96=81=E2=96=84|[90,100]%
> TB hash avg chain   1.091 buckets. Histogram: 1|=E2=96=88=E2=96=81=E2=96=
=81|3
>
> Statistics:
> TB flush count      10
> TB invalidate count 31733
> TLB full flushes    0
> TLB partial flushes 180891
> TLB elided flushes  244107
> [TCG profiler not compiled]
>
> =3D> ~185M which is way more reasonable given the host size
>
> The patch will have a rather large comment in it, I'm not sure if the full
> comment is needed, but I wanted to leave a trace what&why is going
> on in the code for the next one who comes by.
>
> Submitting as a proper patch to the list in a bit ...

Ahh did you not get CC'ed by my patch this morning?

--=20
Alex Benn=C3=A9e

