Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5CA205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlgadNZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5CA205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYveg-0003fj-Rr
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvZn-0004qt-T7
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:53:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvZm-0005ct-E0
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:53:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id z72so19942959wmc.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xTK/AsH48qlkGsgsl1dCxQ0TAve1ljfAMIUS/b4hTm8=;
 b=rlgadNZ7ymWobsXU1Iz5E4bDLo3kul3Ink7SuhJKblxkErNZqvF2hih5TXzUtxtNtm
 P4SmQYRPn7VNJ4TGOakkFq/vhIYfJJPOn82SLC7YMswKOanyo3DIBuazbWpN7lt6jja4
 i6I1C+EeicV17eF3DjL2ydxvL5FzOc4wNN1u7UQhouTJDZvX87+LAAaHMxEeL5o7REqw
 jlYd4//mvxPa1P0waekoeb47gr17CLP9WRs7l8QHCpN0KsEIj9XNpikv65ywlayPIPtw
 xm1FnJPzv4CUzUd/K2HhAf6f8kYIFp8niveGdBBt/wKjx2jl5F3pU+L++UeRxOZjK70c
 t5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xTK/AsH48qlkGsgsl1dCxQ0TAve1ljfAMIUS/b4hTm8=;
 b=QbXpQ41JtoP9/ICoP8X64cSvXE6umnAfHd1S6e9fdgux9kWvQrvBoMASvAo2WWajqi
 LBPW0EZhNiQHB17A0kDebB7ntOfBL1ADrXcSiaWrPJnBNjUm49ApEHfYmKGvUU7/msqL
 LFKFJo1xhlP1LXhb1WzmiAxsbP5bC+IH1lj5FAPr+otJwoTsQdbH9LpuNM9zJ+04ixha
 ig3oNUFtuB0O/KHR4IRRcebvjQrX0JqdJZSWKBVNlqSErXL+iP80cunCWOG7JVYwQHLn
 3m3nSMZwlRjoMyMEqDEHzVHpb8udWDZgYv/d5xJICfbNNljx7INTlepCPlChP46MS0mE
 2WYA==
X-Gm-Message-State: AGi0Pub5jB7fZQUSVkf+/Ngp6F8fOELttpWpijzuFEUHn/HO+uR5xuYN
 wpAHDItgcnAN+1XcgIWXTyWeOw==
X-Google-Smtp-Source: APiQypL+PQZucta5TWBOVgw2TUMUvgpN53hse2FKSy0pXVgD0PR7HVhaIgHN1gYsz/cGHW/8kyJocQ==
X-Received: by 2002:a1c:2888:: with SMTP id
 o130mr23460771wmo.138.1589392428675; 
 Wed, 13 May 2020 10:53:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h1sm37375772wme.42.2020.05.13.10.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:53:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D8EF91FF7E;
 Wed, 13 May 2020 18:53:46 +0100 (BST)
References: <20200513120147.21443-1-f4bug@amsat.org>
 <87a72beuhn.fsf@linaro.org> <20200513173246.GB1720163@eldamar.local>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH] tests/docker: Kludge <linux/swab.h> breakage by pinning
 linux-libc-dev
In-reply-to: <20200513173246.GB1720163@eldamar.local>
Date: Wed, 13 May 2020 18:53:46 +0100
Message-ID: <871rnnen6d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Christian Borntraeger <borntraeger@de.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Salvatore Bonaccorso <carnil@debian.org> writes:

> Hi,
>
> On Wed, May 13, 2020 at 04:15:48PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>=20
>> > Linux kernel commit d5767057c9a [1] aimed to fix an issue with the
>> > swab() declaration, but doing so it introduced the BITS_PER_LONG
>> > definition, without using the kernel __ prefix, leading to odd
>> > failures in userland code using kernel uapi headers, such:
>> >
>> >       CC      block/file-posix.o
>> >     In file included from include/qemu/timer.h:4,
>> >                      from include/qemu/timed-average.h:29,
>> >                      from include/block/accounting.h:28,
>> >                      from include/block/block_int.h:27,
>> >                      from block/file-posix.c:30:
>> >     /usr/include/linux/swab.h: In function `__swab':
>> >     include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evalu=
ates to 0 [-Werror=3Dundef]
>> >        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * =
BITS_PER_BYTE)
>> >           |                                  ^~~~~~
>> >     include/qemu/bitops.h:20:41: error: missing binary operator before=
 token "("
>> >        20 | #define BITS_PER_LONG           (sizeof (unsigned long) * =
BITS_PER_BYTE)
>> >           |                                         ^
>> >     cc1: all warnings being treated as errors
>> >     make: *** [rules.mak:69: block/file-posix.o] Error 1
>> >
>> > The issue has been fixed in Linux kernel commit 467d12f5c78 [2].
>> > Some distributions already backported the first commit, but still
>> > lack the second one.
>> >
>> > This is the case for Debian Buster.
>> > The linux-libc-dev package contains the Linux kernel headers.
>> > Kernel commit d5767057c9a has been backported in package
>> > commit 1fb0eb7956 "Update to 4.19.116" [3], see debian/changelog:
>> >
>> >   +linux (4.19.116-1) UNRELEASED; urgency=3Dmedium
>> >   ...
>> >   +    - uapi: rename ext2_swab() to swab() and share globally in swab=
.h
>> >
>> > The previous released update before it is debian/4.19.98-1,
>> > released as debian/4.19.98-1+deb10u1.
>> >
>> > We can find this package in the Debian snapshot archives,
>> > luckily archived on 2020-04-28 21:20:54 (see [4]).
>> >
>> > QEMU use Debian based Docker images for most of its cross-builds,
>> > which are tested by our Shippable CI jobs. The current broken
>> > package makes most of our CI red. We can kludge this by using the
>> > latest package released before the breakage. Do so by pinning
>> > the package version (apt hold), and using the snapshot archives,
>> > similar to commit b4048a7cd1.
>> > We'll revert once the fix is backported on Debian.
>>=20
>> May as well mention:
>>=20
>>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D960271
>
> FWIW, we applied in the buster packaging branch
> https://salsa.debian.org/kernel-team/linux/-/commit/a4fb2a7b7688f3a7cb36e=
17b9d8c661ac44a41a4
>
> But the point release just happened last weekend, so it might take
> some time until the fix will enter either via the 10.5 point release
> or sooner by a needed update.

Thanks for the update. So I guess we wait for a CVE to trigger an early
release ;-)

--=20
Alex Benn=C3=A9e

