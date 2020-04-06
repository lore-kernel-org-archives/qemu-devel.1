Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB93C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535D42072F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bL68tnXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535D42072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWYU-0007wg-Gg
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLWMu-0008To-Tb
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLWMt-000231-DG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:21:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLWMs-00021l-Mz
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 14:21:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so424553wma.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=o/xTGwbe+Mtkmr6qoTxzKRQB03I5F1dKkIbdzynv0ls=;
 b=bL68tnXNhyYOhlKGts+unhC0Y/YYX5O4vmiH8mZWE4zejCOsYVGH0D0RvlZGQGfUFD
 HF6gvxtkzCDSQdcVESiPaJ8GINkBigNEUpbide3anoKVjd4WojtcXjLNmWq8qojipDy7
 AzBFbL+D26Uw5s+18Cm8qRoGARBHnUxtGuO7i3+OjJF9KJDTC8iXdH9Re/eFh7KAcpjn
 +3+bVvNKhuPUK3aM+HBycnoTZL9NEIwSR+DDAjx9PVRF9iS8dM5PvyeI9ocnCRbx3tAh
 W8M8Tm50Qve9pmlAt/zE4ecgRzgFJPL5DUZjRCBDunX6i97hPXO/yYyI+xn+2kwJy1XI
 oyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=o/xTGwbe+Mtkmr6qoTxzKRQB03I5F1dKkIbdzynv0ls=;
 b=KL/L9eY1qBOB1QqU0cZDqe/in6HwdyNRRrXEH5VqRqU0wwW71O8xd2FNhTJZsRGMND
 dV7KLoYBN5LxWm7Nslc7btVOVi7wL9ButkPk++8DbXtGNO9LGym+SC9PaTpSxiFRbyjL
 J2Jrkc+59YMz+jvhu0zfFbnaaIbw0ZY1GbR034ISKNoNl59e7Wc+2ZR3zsptsgFnc2ft
 r5wagQF/0TjYSSz+sYaR83ipnWw0EGH+a2lBFrSoXrqONTLldeLftMn9snkRBPAP5sVF
 EIfbD2LDmP2Os/nUmbAjP+JCQYj+j6P1ZslCQKOl3Owmh59Z9FRLqIYCrR1kxzrr213f
 qskg==
X-Gm-Message-State: AGi0PubNiO5t/dSElxwubISLV8uykkCcdozKnGqlwgrL4T04nioAKO3n
 Zttxhgyo4DRc/iVXhGeZdYhsCg==
X-Google-Smtp-Source: APiQypL15vNHN7gcEYcgPsBq+raEpzWeLMQnoqQ9zaEAYyTcZPUssnrzm3L3ToK31Yh+NcpFlUUqUQ==
X-Received: by 2002:a05:600c:4112:: with SMTP id
 j18mr294852wmi.69.1586197265090; 
 Mon, 06 Apr 2020 11:21:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f13sm26294641wrx.56.2020.04.06.11.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 11:21:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A060D1FF7E;
 Mon,  6 Apr 2020 19:21:02 +0100 (BST)
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-8-philmd@redhat.com> <87369gbpgq.fsf@linaro.org>
 <4b9c706f-b9b0-35c6-457f-e03f746c9287@redhat.com>
 <CAKJDGDZePOW6Hg9P5WMoP93U2kGEO1=CGF0W7X-G-E7bid_8kQ@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Willian Rampazzo <wrampazz@redhat.com>
Subject: Re: [PATCH-for-5.1 7/8] .travis.yml: Run fetch-acceptance-assets
 before check-acceptance
In-reply-to: <CAKJDGDZePOW6Hg9P5WMoP93U2kGEO1=CGF0W7X-G-E7bid_8kQ@mail.gmail.com>
Date: Mon, 06 Apr 2020 19:21:02 +0100
Message-ID: <87r1x0a31t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 qemu-devel <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Her?= =?utf-8?Q?v=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Willian Rampazzo <wrampazz@redhat.com> writes:

> On Mon, Apr 6, 2020 at 12:39 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 4/6/20 5:31 PM, Alex Benn=C3=A9e wrote:
>> >
>> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>> >
>> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> >> ---
>> >>   .travis.yml | 2 +-
>> >>   1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/.travis.yml b/.travis.yml
>> >> index 2fd63eceaa..c6b32da447 100644
>> >> --- a/.travis.yml
>> >> +++ b/.travis.yml
>> >> @@ -317,7 +317,7 @@ jobs:
>> >>         dist: bionic
>> >>         env:
>> >>           - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,=
alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips=
64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-sof=
tmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>> >> -        - TEST_CMD=3D"make check-acceptance"
>> >> +        - TEST_CMD=3D"travis_retry make -j1 fetch-acceptance-assets
>> >> check-acceptance DEBUG=3D1"
>> >
>> > You could use TEST_BUILD_CMD for the fetching of acceptance tests - can
>> > that be done in parallel?
>
> If by `parallel` you mean running it with other targets, the
> fetch-acceptance-assets target can run at any time before the
> check-acceptance runs, concurrently with different targets. Now, if by
> `parallel` you mean fetch more than one asset at a time, right now it
> is not supported by Avocado, assets are fetched one by one, but it is
> an excellent idea. I have added it to my list.

See the comment I made about the make file. We could expand the
fetch-acceptance-assets target to have one dependency per python file so
you could invoke avocado in parallel to fetch the assets for each test
group in parallel. Of course this works best if the assets mentioned in
each file are unique otherwise avocado might race with itself.

>> I'd say calling fetch-acceptance-assets parallelized is what seems to
>> break this Travis job (which is why I enforced -j1), but I'll refer to
>> Willian here.
>>
>
> As I mentioned above, no problem with running it in parallel to other
> targets. The errors we saw when you were testing are not related to
> the parallel run. It should be fixed in the next release of Avocado.
>
>> >
>> > Also no point in -j1 here - it's implied.
>>
>> You are right, I wanted to be sure this still work even if the globlal
>> script running the tests is updated. But the correct fix is probably to
>> use .NOTPARALLEL in the fetch-acceptance-assets rule in the previous pat=
ch.
>>
>> >
>> >>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
>> >>         after_script:
>> >>           - python3 -c 'import json; r =3D json.load(open("tests/resu=
lts/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["=
status"] not in ("PASS", "SKIP")]' | xargs cat
>> >
>> >
>>


--=20
Alex Benn=C3=A9e

