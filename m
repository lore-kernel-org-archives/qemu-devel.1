Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C66DCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B5120640
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxD56Ad8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5120640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJ3B-0001QH-1K
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNIOF-0004rr-0G
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNIOC-0002A0-Oh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:17:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNIOB-00024F-3G
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:17:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id g24so12529775wmh.5
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LkbhuD5pIVRCOZE9QzNmZaewcdQSd00uLYzuVQL0OIw=;
 b=qxD56Ad8OJUXWcwibqfP5nZ8yjXvdedafHX2G7g1BdWwYLNiE6GocyZZyAcF/gG0zs
 1JPKTJyBfgpA67SUNAJ93aVOqG3TrW8CK/TEeyOntCIzsv0APl2u/AswJaGhdcgYT9gg
 KcF3KsG8TWo7HX0SOUcceNzaJ4MLP3nwrzeyuHsgNif940iDfmfX7bD86OFFDr4bjZf/
 lIQ11H5a4E0w3uyYezD0jEZWCRxgODsywOgAJ2uhctolRrVszOOYmeCjJK7Jut8ybiku
 vRXMWyetNjDjx4iNq7Bq7THqvqGKKHNRvAc59cKHO63BKhKZ5P/Knp72+ry1e74vp755
 O4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LkbhuD5pIVRCOZE9QzNmZaewcdQSd00uLYzuVQL0OIw=;
 b=m2w7vf9b9MpUqrexFsiRRRxigs+QCTf5QEc5RHnhhaACOF42GxVxuyXqlPNDxUwdEf
 DWEp3ub3tZKSVqf8JBPoCNeJHI3o1ZJtfflNgDiBEdILRr4NE0aAyD4fkLF64BuUFzTv
 AyHP7akzxpus0+32cloHPxa1+WS7RKa3TbyBcHiTuIXas4Xz2mCN9Y9s6mAHpINOGcz0
 vs8UqvN32jear01ASe4lrMn9YuFRGt6PtdxwcWBEVsY7LaGCY2RnNOQTdTB9IaidA/2t
 tTY3GZwNDw0ZkVOlHTpirZrN5bKWG15IFIP19QsZraNXKEyt1yTA0mySMTOhx2sUeW5j
 wxNw==
X-Gm-Message-State: APjAAAVJFbxoo99g5f2YdHm2VbfKQBUD6vLJJWm0IFs9bJJ1hSRwAlRz
 jz0kGVqWw013N9EXgyx700FFjA==
X-Google-Smtp-Source: APXvYqwnElo9SghmsYeKjtnq9FpnlWLmGksW8kgNII56XXXoTyqv7CcfgSdJ6r+sL+cA25YXBUYa4w==
X-Received: by 2002:a1c:1d7:: with SMTP id 206mr372859wmb.33.1571843848046;
 Wed, 23 Oct 2019 08:17:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r1sm16280104wrw.60.2019.10.23.08.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:17:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7ED5E1FF87;
 Wed, 23 Oct 2019 16:17:26 +0100 (BST)
References: <20191018174431.1784-1-richard.henderson@linaro.org>
 <CAFEAcA-MyKoA63UF6DYQ6J-dKihYn9iyG09eFCgWT8j4OqsQnw@mail.gmail.com>
 <CAFEAcA-Xj-6CdVzgfcVONipApD5b5PZ84nPnvbbOQjQkqQLnqA@mail.gmail.com>
 <6e06dede-2470-92e1-eba9-40646ed56af0@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v8 00/22] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
In-reply-to: <6e06dede-2470-92e1-eba9-40646ed56af0@linaro.org>
Date: Wed, 23 Oct 2019 16:17:26 +0100
Message-ID: <87zhhrmqyh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/22/19 11:38 AM, Peter Maydell wrote:
>> Turns out this asserts in qemu-armeb :-(
>>
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/armeb-linux=
-user/qemu-armeb
>> -L ./gnemul/qemu-armeb armeb/ls -l dummyfile
>> qemu-armeb: /home/petmay01/linaro/qemu-for-merges/target/arm/helper.c:11=
267:
>> cpu_get_tb_cpu_state: Assertion `flags =3D=3D
>> rebuild_hflags_internal(env)' failed.
>> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>> Segmentation fault (core dumped)
>>
>> Dropping this series again for the moment.
> Argh!  I had forgotten that we have no testing of armeb in check-tcg.

Does it need it's own toolchain or can it be done with flags?

>
> Yes, I see now that we need a recompute in linux-user/{aarch64,arm}/cpu_l=
oop.c
> specific to TARGET_WORDS_BIGENDIAN.
>
>
> r~


--
Alex Benn=C3=A9e

