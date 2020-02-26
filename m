Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6B6C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD866222C2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP8jekfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD866222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70UV-0001Ad-Uw
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j70T4-00005P-1f
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j70T2-0007Lh-AK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:27:29 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j70T2-0007Hk-3R; Wed, 26 Feb 2020 12:27:28 -0500
Received: by mail-ot1-x342.google.com with SMTP id j16so200241otl.1;
 Wed, 26 Feb 2020 09:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gh/bA6yZttar7PgigfbgFIZcmxdx9gMOad8dFJvHZIA=;
 b=OP8jekfQgAehngTv/aUbdRMuZ/m6ZmscXUjmu97ogkFdSr4/PXXeXJtK8atYNMPKkG
 4MmDNsgGNk4/ITNmMd2ACdvGJPYQKKN+oqCpJaJ5EqaiB4qnx1/OMcfBdH80pp3EVxrl
 nOfrYO6oBbybKEwj9MGFSDfZSzpAB0CwPRi1xoPMZlcFNCHlVRVq/KB2kcd4wM2QSHaG
 qcjiGd9rCTJfIicNdpuG/so6uDNfxxYiwMQY/CliYYV1KGOJlVbejc13Rf17/0+jYRoP
 72ATQ1hoLbqsAYqfBlviF7GjgOpYtVj71L5h5Vpfz+r5Ai7VHUrurORjJKHbi5ohk3r6
 f8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gh/bA6yZttar7PgigfbgFIZcmxdx9gMOad8dFJvHZIA=;
 b=rp3cGNajImuCQpJTsQdduNC8OcuoqO4j53ySmIzhBX4EM9fQgopOBtmEde8b92vIk1
 7Nt7fndoYIJ3BbnCTdu7DvBmMJPL7r2LGYjWRQ0l919OnZCjnMXeS0sVEG+xxCcLXA5c
 xt4nA3Alo6EF8s9NVNVmaCfZo6G3GQbCz/Bv3TUQPWQQhn1wyHQr89+n3gPibAx4M7WF
 +SU1OJPPeeshDhFWUwh8Vzp/P0a9pB0tC2ejhz4uCVbzw942/Yzc4Fybv2MOKZctvsg9
 j7IoFvyW8Kp6aw2bhmX42fCBnAMEY7vs8Va3VLsIXEhtr57WUoSgebm7QIB0w0xcJjCE
 IPlw==
X-Gm-Message-State: APjAAAX5OWThrtiRHBYqaSllf+Xzym0mFeVBAmH6AdlXiT0KS2T1k6vP
 jlnPh/wJReM0dfUNkT2tYfrYT9P/FJbHtntRykE=
X-Google-Smtp-Source: APXvYqzNDrJhVfaBvsHZqhCeEO2ptJeDjBUUr91B8PCkLxjFSac4Hpc5F8U2kubWejLQ7G5xOdu/VjqzP7CBZu/lpZE=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr4165239otr.295.1582738047038; 
 Wed, 26 Feb 2020 09:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87eeuhxw0y.fsf@linaro.org>
 <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
 <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
In-Reply-To: <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 18:27:16 +0100
Message-ID: <CAL1e-=hhhw4x4H24DWg6pTp9DmjyfwM6GFMOmWasKC66x5tR4Q@mail.gmail.com>
Subject: Re: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: G 3 <programmingkidx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 Dino Papararo <skizzato73@msn.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 6:04 PM G 3 <programmingkidx@gmail.com> wrote:
>
> Accuracy is an important part of the IEEE 754 floating point standard. Th=
e whole purpose of this standard is to ensure floating point calculations a=
re consistent across multiple CPUs. I believe referring to this patch as in=
accurate is itself inaccurate. That gives the impression that this patch pr=
oduces calculations that are not inline with established standards. This is=
 not true. The only part of this patch that will produce incorrect values a=
re the flags. There *may* be a program or two out there that depend on thes=
e flags, but for the majority of programs that only care about basic floati=
ng point arithmetic this patch will produce correct values. Currently the e=
mulated PowerPC's FPU already produces wrong values for the flags. This pat=
ch does set the Inexact flag (which I don't like), but since I have never e=
ncountered any source code that cares for this flag, I can let it go. I thi=
nk giving the user the ability to decide which option to use is the best th=
ing to do.
>

From the experiments described above, the patch in question changes the beh=
avior
of applications (for example, sound is different with and without the
patch), which is
in contradiction with your claim that you "never encountered any
source code that
cares for this flag" and that "the only part of this patch that will
produce incorrect
values are the flags".

In other words, and playing further with them:

The claim that "referring to this patch as inaccurate is itself
inaccurate" is itself inaccurate.

Best regards,
Aleksandar


> On Wed, Feb 26, 2020 at 10:51 AM Aleksandar Markovic <aleksandar.m.mail@g=
mail.com> wrote:
>>
>>
>>
>> On Wed, Feb 26, 2020 at 3:29 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> >
>> >
>> > Dino Papararo <skizzato73@msn.com> writes:
>> >
>> > > Please let's go with hardfloat pps support, it's really a good featu=
re to implement.
>> > > Even if in a first step it could lead to inaccuracy results, later i=
t
>> > > could solved with other patches.
>> >
>> > That's the wrong way around. We have regression tests for a reason.
>>
>> I tend to agree with Alex here, and additionally want to expand more on
>> this topic.
>>
>> In my view: (that I think is at least very close to the community consen=
sus)
>>
>> This is *not* a ppc-specific issue. There exist a principle across all t=
argets
>> that QEMU FPU calculation must be accurate - exactly as specified in any
>> applicable particular ISA document. Any discrepancy is an outright bug.
>>
>> We even recently had several patches for FPU in ppc target that handled
>> some fairly obscure cases of inaccuracies, I believe they were authored
>> by Paul Clarke, so there are people in ppc community that care about
>> FPU accuracy (as I guess is the case for any target).
>>
>> There shouldn't be a target that decides by itself and within itself
>> "ok, we don't need accuracy, let's trade it for speed". This violates
>> the architecture of QEMU. Please allow that for any given software
>> project, there is an architecture that should be respected.
>>
>> This doesn't mean that anybody's experimentation is discouraged. No-one
>> can stop anybody from forking from QEMU upstream tree and do whatever
>> is wanted.
>>
>> But, this doesn't mean such experimentation will be upstreamed. QEMU
>> upstream should be collecting place for the best ideas and implementatio=
ns,
>> not for arbitrary experimentations.
>>
>> Best regards,
>> Aleksandar
>>
>>
>> > I'll happily accept patches to turn on hardfloat for PPC if:
>> >
>> >  a) they don't cause regressions in our fairly extensive floating poin=
t
>> >  tests
>> >  b) the PPC maintainers are happy with the new performance profile
>> >
>> > The way forward would be to:
>> >
>> >  1. patch to drop #if defined(TARGET_PPC) || defined(__FAST_MATH__)
>> >  2. audit target/ppc/fpu_helper.c w.r.t chip manual and fix any unneed=
ed
>> >  splatting of flags (if any)
>> >  3. measure the before/after performance effect and decide if on balan=
ce
>> >  it's worth keeping
>> >
>> > > I think it's important for qemu to as global as possible and don't
>> > > target only recent hardware.
>> >
>> > Are you referring to guests or hosts? For guests we will always favour
>> > accuracy of speed of emulation. For hosts we need to have IEEE complia=
nt
>> > FPU HW to even stand a chance of using hardfloat.
>> >
>> > --
>> > Alex Benn=C3=A9e
>> >

