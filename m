Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0205EC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C037D2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DnsWuy32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C037D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5n5-000351-TH
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1is5mA-0001r1-1s
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1is5m8-0008Mt-EV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:05:33 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1is5m8-0008MS-7Y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:05:32 -0500
Received: by mail-wm1-x344.google.com with SMTP id f129so3947525wmf.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 06:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8GhEpBm1r5EfFe8YppcE4/zzutmq5A4TJSE+X4Ujc6I=;
 b=DnsWuy32bQ8XfeznyOnZ18rLYts6MOSXf+AxlhbA+Msua+jBzosi26pFBNfGhlf1k7
 oa1auvD/wS7p2xMdOz1iLVNmQsA4NrSrk7g0d0JsKYsrzygfny4JxBThCjVPhOX+tt1R
 9/omIbsDuruq/PiOyC2ZVdxoWSvWP7gcU9l0xWtBraBPKQNhFqgHBTdgpaJZ4ccAEnl/
 raCKd3Yq7afSVQ+HhPwO2l7LCr8dMEx5oSrZeLokV+vS+FWCTbtRyi7dcZkuD3/lXO0F
 hAeoH3XBddjDElPzx0ixxrDw5pMqzdnvUTNI2XLzFFMqq7IobADzHyOeH3JSQORYN1nV
 0axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8GhEpBm1r5EfFe8YppcE4/zzutmq5A4TJSE+X4Ujc6I=;
 b=msRIjmvE5e+wJ5uQFfzke083s75iPw0t2knzsnhiY4Forc5nOdoGq8c/5u3jRRxfbR
 wCYmWIRtjo9BU4dCEXqe73RZW6pEqJZO73RedGv+tLOSvj+SpZHLS0tuXZ81MJ2xYDVZ
 6PCwRO1A+lSiFWYg1hkHROODdCiDuckea3v6g/pZk4w2MfZpJ1kRYS/1psbjEDpPdlnZ
 3j0Xdo+Zx+UBgXWnWJ4aMuvAlaySB6vgdtvnBPPGfbuDWsHPoz8KdYcDSGG4CVcbTorK
 wZFUuw9CIH+6oqrcqmbn4gIjmqtA9H+Dd3nt4yJphAB9JyAyzFEtDiqX364nNmZJYJ6B
 41RQ==
X-Gm-Message-State: APjAAAWzH7SU6zz7KRCu+eKFez20XOYvszK4mtfVbW6QuSn9rDOTQGrJ
 6gtWFS18g4Cqb+DzeGP+Y6UJVA==
X-Google-Smtp-Source: APXvYqwiTTGN6sl+m1C5nqrxi+ZafLYPYeRLWFE05uAZP1aWe3/PmEJEN04HDhFQ6KJ+cF/9GNmsLw==
X-Received: by 2002:a05:600c:2318:: with SMTP id
 24mr6255478wmo.48.1579183530476; 
 Thu, 16 Jan 2020 06:05:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m21sm4848482wmi.27.2020.01.16.06.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 06:05:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D83171FF87;
 Thu, 16 Jan 2020 14:05:27 +0000 (GMT)
References: <20200114210921.11216-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/3] linux-user: Implement x86_64 vsyscalls
In-reply-to: <20200114210921.11216-1-richard.henderson@linaro.org>
Date: Thu, 16 Jan 2020 14:05:27 +0000
Message-ID: <87lfq7lcns.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The x86_64 abi has a legacy vsyscall page.  The kernel folk
> have been trying to deprecate this since at least v3.1, but
>
> (1) We don't implement the vdso that replaces vsyscalls,
> (2) As of v5.5, the vsyscall page is still enabled by default.
>
> This lack is affecting Peter's linux-user testing.
>
> The dependency is not obvious because Peter is running the tests
> on x86_64, so the host is providing a vsyscall page to qemu.
>
> Because of how user-only memory operations are handled, with no
> validation of guest vs host pages, so long as qemu chooses to
> run with guest_base =3D=3D 0, the guest may Just So Happen to read
> the host's vsyscall page.
>
> Complicating this, new OS releases may use a kernel configured
> with CONFIG_LEGACY_VSYSCALL_XONLY=3Dy, which means the the vsyscall
> page cannot be read, only executed.  Which means that the guest
> then cannot read the host vsyscall page during translation and
> will SIGSEGV.
>
> Exactly which of these many variables is affecting Peter's testing
> with Ubuntu 18.04 of my TCG merge, I'm not exactly sure.  I suspect
> that it is the change to drop the textseg_addr adjustment to user-only
> static binaries.  IIRC bionic does not support -static-pie, which is
> the preferred replacement.  This could mean that the host and guest
> binaries overlap, which leads to guest_base !=3D 0.
>
> I vaguely remember someone (Paolo?) implementing something like
> this many years ago, but clearly it never got merged.
>
> In any case, this emulation has been missing for too long.

It turns out the /sbin/ldconfig crash is a regression w.r.t from
stretch->buster so unrelated to these patches. However I've been giving
them a spin with the linux vdso selftests and stuff is breaking which I
guess means it's incomplete?

alex@23eb55f27ff8:~/lsrc/linux.git/tools/testing/selftests/x86$ make test_v=
dso
gcc -m64 -o /home/alex/lsrc/linux.git/tools/testing/selftests/x86/test_vdso=
_64 -O2 -g -std=3Dgnu99 -pthread -Wall -no-pie -DCAN_BUILD_64 test_vdso.c -=
lrt -ldl
alex@23eb55f27ff8:~/lsrc/linux.git/tools/testing/selftests/x86$ ./test_vdso=
_64=20
[WARN]  failed to find vDSO
[RUN]   Testing clock_gettime for clock CLOCK_REALTIME (0)...
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)

Also from selftests/vDSO:

alex@23eb55f27ff8:~/lsrc/linux.git/tools/testing/selftests/vDSO$ ./vdso_tes=
t=20
AT_SYSINFO_EHDR is not present!

vdso_standalone_test_x86 just exits with a non-zero value. I'm still
looking into that one.

>
>
> r~
>
>
> Richard Henderson (3):
>   target/i386: Renumber EXCP_SYSCALL
>   linux-user/i386: Split out gen_signal
>   linux-user/i386: Emulate x86_64 vsyscalls
>
>  target/i386/cpu.h          |   6 +-
>  linux-user/i386/cpu_loop.c | 197 ++++++++++++++++++++++++++-----------
>  target/i386/translate.c    |  16 ++-
>  3 files changed, 155 insertions(+), 64 deletions(-)


--=20
Alex Benn=C3=A9e

