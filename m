Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41273C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31D9207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hx+FbKSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31D9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrny-0003xc-VW
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrkb-0000yP-Ta
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrkZ-0007uY-K8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:49:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrkX-0007r0-JH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:49:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id i1so3591468wro.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FdJmrelF+GNO9rV54sFbE+oreo+83jL9+HFgZ6Do3/w=;
 b=hx+FbKSSNKYx9B4uuiJ8OtRHBe/J6tXDnCr+knSayEZfMr1Tmt9WXbs/ynbivx9/wH
 RHhcYr8jq3XbbowxK3UZh/aomwlerAXsaR8QdWUBKI0LyGzdxGhRpuJoktNYXsla7Rek
 WptP4xaFtK/rIeK+cMriQ133ct0IzRatTTzjgSn10m+I8GYAF/61Qt/wNMgm5sazpdGJ
 QbmZs3OqQcTnpBs2tyDjgYfXv1X0deiPo4erFoKxJt80DVqWUmQTbuJypdRtcKXbONw6
 cfRmJ/yG/G/3LJQSygjF2bSobgaRcmRidCdKl+NBhOZFzpLCs2whDBWRSkT6w2Y296GF
 g+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FdJmrelF+GNO9rV54sFbE+oreo+83jL9+HFgZ6Do3/w=;
 b=Zq48IxR3sS8cqM1ykD7INxIXV0Ji93H6waJaV+0nZYFZlto6W41JMxPjcPTAOmiLZv
 iBIFL0U2GV5mAjysYFKDjoXMCKAbv9xRSAzx7EOvP10umyxyT7G3YzlYsYDWjT5DzRS1
 MFh41hSFmO2I4aZm39ncTrPx7Q86Aa1lfz8gyaLUIEu4Ik3sdxJ7Fjb9gFni2cnCzFEG
 L9TnRovM8I9g5ALZv5T8U4qhle6eAuP3bnFUZtxh+kAc72Mpf0JZE9k/MYNUig9EHLrE
 gWf49/k8eHG8Rf/loZNotCyIgRu5TxVCr1VdPdQcwUjfeAehQGv7xTOdKwzGS3KIvSCf
 jaAQ==
X-Gm-Message-State: APjAAAX7VfLWu8uNmAJNNr/yj7VuHtq6Vt59LS/gb2p4ow9FHQwQsg8v
 U7cWGF+MD0SOL4DkEGfXvDnS0A==
X-Google-Smtp-Source: APXvYqw4KuwVT7eHnOyhpGyT6aov0Ysop7uczRhZ2ECHw7HkTCfAtenZKBmdsKnav4Vm2GmQEZ3N6Q==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr4883220wrn.16.1569358166142; 
 Tue, 24 Sep 2019 13:49:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v2sm1346924wmf.18.2019.09.24.13.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 13:49:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A6AFC1FF87;
 Tue, 24 Sep 2019 21:49:24 +0100 (BST)
References: <44be7ab6-c648-9109-3d05-1afc57e9b021@redhat.com>
 <e8f0f972-f826-9711-7509-4c3d7e4a5407@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: docker: how to use it when developing on QEMU?
In-reply-to: <e8f0f972-f826-9711-7509-4c3d7e4a5407@redhat.com>
Date: Tue, 24 Sep 2019 21:49:24 +0100
Message-ID: <87y2yda08b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> On 9/24/19 11:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Recently more developers are enthusiast to use Docker/Podman,
>> and have been confused by the different configurations currently in the
>> QEMU repository.
>>
>
> I think it's good evidence we need to improve the abstractions for this
> testing module. It's not easy to know what to do without getting direct
> feedback from the maintainers directly, which won't scale.

It has certainly grown more warty as we've gone on. For one thing we
don't cleanly handle different host architectures.

>
>> There are at least 3 kind of categories I use:
>>
>> 1/ Image used to build QEMU
>>
>> These images should be restricted/updated to our "supported targets".
>> They are useful to (cross)build QEMU on variety of
>> host/target/distributions/distrib_versions.
>>
>> Example:
>>
>> - cross build Cris binary using the Fedora 30 toolchain on a Ubuntu
>> 18.04 x86_64.
>>   host:Ubuntu18.04/x86_64 docker_image:fedora-cris-cross
>>
>
> Is this supposed to be a command invocation? Can we see full command
> lines instead?

 make run-tcg-tests-cris-softmmu V=3D1

and you'll see the docker invocation underneath.

>
>> - cross build MinGW64 binary using Debian 9 MXE toolchain on a Ubuntu
>> aarch64:
>>   host:Ubuntu18.04/x86_64 docker_image:debian-win64-cross
>>
>> An image can not be meant to use on a daily basis, but to avoid
>> regression previous to release (I'd run them only on release candidate).
>>
>
> Do you mean to say "These images are not meant to be used on a daily
> basis, but instead on occasion to prevent regressions during release
> candidate testing." ?
>
> They can build QEMU, but I assume they can't run any tests. Is there a
> special "build-only" target that you can invoke from the Makefile to get
> these to run?

 make docker-test-build

Should run all QEMU builds on all images that support it. Works in testing/=
next.

>
>> Example: building QEMU for the Gentoo PlayStation2 port:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg574468.html
>>
>> 2/ Image used to build test program used by QEMU
>>
>
> I think this is the category most people are wanting to get their hands
> on, usually.
>
>> These images provide enough to build binaries you can then use to test
>> QEMU. If you want to build more of these binaries, there is probably a
>> better way. Here we are only interested in testing.
>>
>> Example:
>>
>> - Test PowerPC Linux-user binaries with qemu-powerpc-linux-user
>>   docker_image:debian-powerpc-user-cross
>>
>> - Build EDK2 payload for Virt/AArch64
>>   It currently doesn't build with Fedora 30 and I'v to use a Fedora 29
>> image.
>>
>> Another case I had is when I tried to build a kernel for the Mipssim
>> machine (supported by QEMU). The Linux kernel code has been removed, so
>> I had to checkout an old kernel which is not buildable with my recent
>> host GCC. Using a docker based on a very old distribution worked. Anyway
>> Thomas Huth found it is easier to use buildroot for pre-3.6 kernels.
>>
>> Similarly, I am testing QEMU port from Stefan Weil, and he shared a
>> working binary supporting the MIPS AR7 target. To be able to use this
>> QEMU I use Debian Lenny and set
>> DEB_URL=3Dhttps://snapshot.debian.org/archive/debian/20091004T111800Z.
>> Yes, this will instanciate a Debian from 10 years ago.

So generally once built you can re-use an image with cross compilers to
build any random source tree. Usually you invoke docker directly with
something like:

  docker run --rm -it -u $(id -u) -v $(pwd):$(pwd) -w $(pwd) qemu:debian-ub=
untu-bionic-arm64 /bin/bash

Which basically drops you into a shell with your build directory mapped
into the docker image. However this usage is out of scope for the QEMU
build machinery although a useful way to use the images.


>>
>> 3/ Bisecting
>>
>> Another of my docker uses is when bisecting before QEMU v3. I use image
>> using snapshot slighly older than the QEMU release, so my bisect script
>> can run without worrying about the library API incompatibilities or
>> newer GCC warnings.
>>
>
> Which images, tests, or invocations are useful for this?
>
>> So not all image have the same use. While they might not be useful to
>> build the latest QEMU, there are still useful for day-to-day development.
>>
>
> I would say that this has grown beyond the abstractions presented by the
> Docker makefile, which makes it hard to figure out how to use any of the
> tools in this directory.
>
>> Anyhow I agree we should document that better. Maybe the wiki is a good
>> starting point.
>>
>
> That might be a good place to organize your thoughts, but the source of
> truth must be the Makefile help invocation.

Agreed.

>
>> Regards,
>>
>> Phil.
>>
>
>
> We should split the images into a few categories in the makefile
> directly, in a programmatic way;
>
> 1. Partial Images
>
> These images are not meant for building or testing anything directly.
> They are dependencies; they should be better distinguished in the
> Makefile help.
>
> 2. Unrunnable Images
>
> These images would otherwise not be considered partial, but are
> conditionally unrunnable depending on the architecture of the host system.
>
> 3a. Images that can build QEMU
>
> Runnable images; but only useful for building QEMU and/or its tools. A
> lot of the cross-compiler images might fit into this category.
>
> 3b. Images that can test QEMU
>
> Runnable images; but can run iotests, make check, and so on. We expect
> all of the tests defined, in general, to work for this image.

3c. Images that can build tests that run with QEMU

These are minimal cross compilers with just the foreign glibc and can
build our minimal tcg test cases.

>
>
> Does that sound about right?
>
> --js


--
Alex Benn=C3=A9e

