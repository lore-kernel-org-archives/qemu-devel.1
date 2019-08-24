Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D67C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 07:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07602146E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 07:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bchcml/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07602146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Qk3-0005BK-QN
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 03:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i1QjF-0004Ni-D5
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i1QjD-00022p-WA
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:44:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i1QjD-00022J-OL
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:44:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id p17so10544052wrf.11
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BLgjtcia8cMafD7t8HujSdrcrbGEaSwtVdie0r+EkYU=;
 b=bchcml/VFOYx+Fk7kcc0OjsTlV/3zuyqTf4vynhl2D7Kef/owAPnZd6ikG2ZW2vR69
 8wdTLzjeyYmfMGsJpv7nlKA6mipdQ0c9N4jtRyugjNVdCWg5Wffq82txq9VO3WyBu1mv
 TyqCSpOHxTyAT9cTbFSIDKkifttqYdsWVsGYnOHlNqbaOIqVM2iDZJKF0TwruAszMDVr
 T5dJ5r4lkxIah6mFiHqB+lmhwpFO1+4fK3HXyf4Rb4avwKWesqrXpM0s7eQLZLGPk91Q
 iSu33hC+2NmE3+3NvOZcMWgw5bR3fxV8Q7fxAzUd3EbPXwgnkeL1OmqgCMSwMdQdK3Xg
 O6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BLgjtcia8cMafD7t8HujSdrcrbGEaSwtVdie0r+EkYU=;
 b=DB8WKzm3og0Tmm0MeAg9UHniCfsASwfNiQXh4/MyKu3J7pNYo3OnIFuNRFkoYBWyuj
 XYBKyhtIpbFQI2sJ4q8stlgKAs1z4Y490geRUanMGtXlFkkt3AtpVPE6YNrwPGjA2IdN
 y/4f/7z1x6KpvVzSMZAQjXTERUOKhsSCxdefE8N8iv0YMBfdqTfwNnXeXS/NGcH9A/cT
 mSAFOpPR0c7azExUoiDZqMWeTycHLOq5ZwD30E8p/WeuA6vq+NjOW08vgnfOYi8bvjMJ
 J0d2GUTVFibH5AKe/G5TjoEs3ZYbeNHuvRmObnITszMGyq1qFvMdsUincdcQ/bOP71ZD
 5R3A==
X-Gm-Message-State: APjAAAWx0B9FnR4hWG6cLWgnCv32opVqEo7kdUV5BSf4aCmmwi9zLoVw
 SDIe2e4YywxMPfVyQF3r7yGnuw==
X-Google-Smtp-Source: APXvYqy0jhIQ0TbzSaExpVFKro4yJ9HXkI4rC8gDwDxlhQPIZRYdeVUVB8WCt9kok7nRVa3/gPGz4Q==
X-Received: by 2002:adf:f286:: with SMTP id k6mr9843808wro.320.1566632690613; 
 Sat, 24 Aug 2019 00:44:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p19sm6070355wmg.31.2019.08.24.00.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2019 00:44:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 145781FF87;
 Sat, 24 Aug 2019 08:44:49 +0100 (BST)
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822114747.GS3267@redhat.com> <20190822163150.GA3332@work-vm>
 <9caf3a64-0841-dde6-3413-a77dc80e22bd@redhat.com>
 <20190822165045.GM3277@work-vm>
 <b9f98b17-49c4-a227-ab87-de4a6f42f089@redhat.com>
 <a9fdc89e-bc75-59c5-2e1a-12c50b3e92de@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <a9fdc89e-bc75-59c5-2e1a-12c50b3e92de@redhat.com>
Date: Sat, 24 Aug 2019 08:44:48 +0100
Message-ID: <877e732ej3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/22/19 7:05 PM, Paolo Bonzini wrote:
>> On 22/08/19 18:50, Dr. David Alan Gilbert wrote:
>>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>>> On 22/08/19 18:31, Dr. David Alan Gilbert wrote:
>>>>>> With both these points in mind, I think it is  pretty hard sell to
>>>>>> say we should write & maintain a custom CI system just for QEMU
>>>>>> unless it is offering major compelling functionality we can't do
>>>>>> without.
>>>
>>> (That was Dan's comment)
>>>
>>>> In theory I agree.
>>>>
>>>> In practice, the major compelling functionality is portability.  If it
>>>> is true that setting up runners is problematic even on aarch64, frankly
>>>> GitLab CI is dead on arrival.  If it is not true, then I'd be very hap=
py
>>>> to use GitLab CI too.
>>>
>>> IMHO if for some weird reason Gitlab has problems on aarch64 then we
>>> just need to get that fixed.
>>
>> I'm sure it's just some packaging or deployment issue.  But
>> https://gitlab.com/gitlab-org/gitlab-runner/merge_requests/725 has been
>> open for more than one year; the last two messages are:
>>
>> * 1 month ago: "I hope we will be able to merge it soon"
>>
>> * 3 weeks ago: "Today I tried use gitlab-runner on my arm64 box, however
>> it kept mysteriously failing"
>>
>> So the question is simply who does the work.
>
> IIRC Samuel Ortiz told he was using GitLab with Aarch64 runners around
> Nov 2018, but "compiling from source". Alex Benn=C3=A9e tried building it=
 on
> our Packet server during early 2019.
> Later an (unattended?) Ubuntu upgrade installed a package that does not
> work anymore with current GitLab server. I noticed this few months ago,
> built it again and tested it, then looked at what was wrong with the
> upstream MR. The Aarch64 packaging succeed when cross-building on x86_64
> host, but fails when building natively... Since part of it is "built or
> tested in the cloud" and involving Go, I simply let a comment:
> https://gitlab.com/gitlab-org/gitlab-runner/merge_requests/725#note_18347=
0145

I need to have another look at this but from memory it is because the
"cross-build" approach they use is to try and build all arches with a
qemu-user controlled docker build. However if the host architecture is
the target you are aiming for that should run normally - however it
failed on qemu-test because you can't build the armhf binaries there as
not all AArch64 machines support AArch32. There is a bug in the Debian
binfmt_misc scripts that I raised but needs proper fixing.

I think the easiest thing to do would be to document how to build
exactly 1 architecture at a time so you don't have to succeed in
building everything at once and can build something natively without
jumping through hoops.

>
> So to confirm what Paolo said, GitLab runners work on Aarch64
> (and we have it well tested), however there is a packaging issue,
> so it does not work "out of the box".
>
>
> Related to:
>
>   Runner compiled with Go 1.8.7 seems to not work properly with
>   multiarch support. Executing the binary built with Go 1.8.7
>   results with an error [...]
>
> There has been 1 recent fix for the go runner:
> https://bugs.launchpad.net/qemu/+bug/1838946/comments/1
>
> And there is an ongoing discussion about "patch to swap SIGRTMIN + 1
> and SIGRTMAX - 1".

Much as I champion qemu-user for solving build problems I think being
able to build natively should be the quicker and easier fix (not that we
shouldn't fix qemu-user bugs as well).

--
Alex Benn=C3=A9e

