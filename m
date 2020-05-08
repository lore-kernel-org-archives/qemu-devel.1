Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8C2C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436B6208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkoQsLsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436B6208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1Ma-0000Kc-D2
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jX1M1-0008LI-4Q
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:39:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jX1Lz-0008VG-Rh
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:39:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id g12so10238481wmh.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Q43gVxLtXyZVieDw0AQ6DRz4FFD8AMXuRSu39tjxhPw=;
 b=JkoQsLsKBj3j+l12nkKDlMuqHbQ3kT1iQD0guyPZZtu73BOH3sukve57AC1K+HCob4
 SZ8FPugQXFkf502DYg8agaa0NHhFIKqkYs7dVdSEG1cZ/+VHi427sq5JgMWvK2oi2Yr3
 VjkTBaA1CXKNuYVN2oguOn7T/wIvebFh9ATl49MVBB9hnXk9E4ve+Iry75eH/PHHciLq
 GOJOSBJFz+v1XYEYcjtKQHxXg6vdafKm37zT9fdfXt/OszoWIcdIYGL9va4qfVu0MYWh
 gMLpEEdVobi9CqpHB4Wime+o8AuLAb6p4E7QuUy9H0UwwdYjuZqNcWyPnaNR8ckoMrKk
 vw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Q43gVxLtXyZVieDw0AQ6DRz4FFD8AMXuRSu39tjxhPw=;
 b=Pdn0278rc6JKwap5PI6XnNriVGtKQP0DH2wKxfAkn1v++0xgIH+ILaTOf4teMacdI6
 7IY3QkExKs7eoN5FgZTKv9VJynCecGVelzUhcU+a06dWaXLRDYapPvRETyVCUiEUVnbc
 vXbwzM6rJEY5tj4zbjJWS424sd/gL/hbsLBN3xpUrGxaod91SVV0r1Hjzuob2Kw7pqEF
 SRv7va46entXjxqLD3FEsUJoaqYq6YlbndZ11uRX2LcABaSZpKzhWGvRrZSgP+jtCW0Q
 BN8/MZovLLWRa4bJZnN+/jZtncPK4z1+fx9Y1ovWqqS2E+FruPpH9kvexpWZV1J7qZ4k
 b4zg==
X-Gm-Message-State: AGi0PuYSpMvdNs8pareTJ2RY3eUCOP0zcqqyfJMJeCeGlVW+eqnfUJEN
 +7oJKB3Eav575ST1M8nREsduF8FbBwk=
X-Google-Smtp-Source: APiQypKdlS7vcMJ91Pm7HrtqSVnfq7CrPtAV+HaQdehvtf1aF3XPsLu1y62v4LGb98yrT4S9+4AicA==
X-Received: by 2002:a05:600c:2284:: with SMTP id
 4mr14872205wmf.97.1588937980964; 
 Fri, 08 May 2020 04:39:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g74sm12572675wme.44.2020.05.08.04.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 04:39:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C33D1FF7E;
 Fri,  8 May 2020 12:39:38 +0100 (BST)
References: <tencent_D787B2532D5D3E3EBC6DD3B6A714D4106F08@qq.com>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: casmac <1482995675@qq.com>
Subject: Re: how to run qemu test
In-reply-to: <tencent_D787B2532D5D3E3EBC6DD3B6A714D4106F08@qq.com>
Date: Fri, 08 May 2020 12:39:38 +0100
Message-ID: <87y2q24pvp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


casmac <1482995675@qq.com> writes:

> Hi all,
> &nbsp; &nbsp;I am having trouble running qemu tests. basically ,can not r=
un check-tcg and check-unit.
> &nbsp; Before executing the tests, I did the configuration=EF=BC=9A&nbsp;=
configure --target-list=3Dsparc-softmmu --cross-prefix=3Dx86_64-w64-mingw32=
- --enable-gtk --enable-sdl --enable-debug
> &nbsp; The source code is built&nbsp; alrigtht . but can not execute the =
tests.
> &nbsp; Running make check-tcg returned nothing but:
> $ make check-tcg
> &nbsp; BUILD&nbsp; &nbsp;TCG tests for sparc-softmmu
> &nbsp; BUILD&nbsp; &nbsp;sparc-softmmu guest-tests SKIPPED
> &nbsp; RUN&nbsp; &nbsp; &nbsp;TCG tests for sparc-softmmu
> &nbsp; RUN&nbsp; &nbsp; &nbsp;tests for sparc-softmmu SKIPPED

You will either need docker/podman setup so we can use those images to
cross-build the tests for other architectures or have cross compilers
installed for your targets. This is documented in docs/devel/testing.rst

> &nbsp; Runing make check-unit, give me "undefined reference"error message=
=EF=BC=9A
> $ make check-unit
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: tests/test-bitmap.o: in function `check_bitmap_=
copy_with_offset':
> D:/cuix/workspace_devl/qemu-4.2.0/tests/test-bitmap.c:25: undefined refer=
ence to `random'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: D:/cuix/workspace_devl/qemu-4.2.0/tests/test-bi=
tmap.c:26: undefined reference to `random'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: D:/cuix/workspace_devl/qemu-4.2.0/tests/test-bi=
tmap.c:27: undefined reference to `random'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: D:/cuix/workspace_devl/qemu-4.2.0/tests/test-bi=
tmap.c:28: undefined reference to `random'
> collect2.exe: error: ld returned 1 exit status
> make: *** [/d/cuix/workspace_devl/qemu-4.2.0/rules.mak:124=EF=BC=9A
> tests/test-bitmap.exe] error&nbsp; 1

Hmm not sure about this but I suspect the unit tests are written
assuming a POSIX environment although I would have thought glib would
have smoothed over those differences.

>
> &nbsp; &nbsp;Something went wrong but I have no clue at all. Any suggesti=
ons?&nbsp;
> &nbsp; &nbsp;Thanks a lot.
>
>
> regards,
>
>
> xiaolei


--=20
Alex Benn=C3=A9e

