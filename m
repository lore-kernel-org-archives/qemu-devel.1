Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6BEC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5DE217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngN7VdPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5DE217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52655 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8Ja-0004bg-VU
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:24:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU8Gz-00025K-5n
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU83B-0003Ot-Gl
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:07:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU83B-0003OJ-9u
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:07:49 -0400
Received: by mail-ot1-x344.google.com with SMTP id i8so8301691oth.10
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ucZ3fyDqxiuUKMEbw+ijIzt1Bg35A3bV2wK2S7oQpaY=;
	b=ngN7VdPsV0YO0c8eXNwRQtd8NbFaZf0wJe0qBKFuCQkHT8S+xgTtA9NfBJ0j+cdO++
	wHE+a0eXCRwYeclGIOVRSqeBJg4lhl4y4EXgKPPdl/k7L0p/vy9D4we/e44SMe3pi7Eg
	chSI8yzrUne6yNwVJgpNzKItr1Vo09FfU1y/1J0l4bd3KwuHyOkQEXuUj/toLRlqo/kU
	F7p+q/hyoGxWprpKE9ThiY8F3pGXCF6f2lfiyjRrvMi6gA0T3RrgfStu177c+JaP+1ru
	e8mFt94QjaLJWyWYIBwtp5Re+hQKCs7qR8KZHhUgz5KHPU/59Z68GxiL9CSPs3chsVh2
	Ja8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ucZ3fyDqxiuUKMEbw+ijIzt1Bg35A3bV2wK2S7oQpaY=;
	b=MB57E8o45iflEuyrLFMdJO6vZ7oGAJL+A71xIvvbqDum6clMX3BpzSMi+k6o9AOcZR
	xKaVvKzPowDtHe6YC2rnAnr2EvbrihAryjuuuoaMgasjxrx8yHbmq/DNLaHRFSoopgMZ
	kS8s30MnP9sUK1J2lsQoI+5sg5UsgSXd60Mh5xojLldjqEFi0zOQHdAVVkoo46ucjZOa
	QzCVOOa1W6QHQ0wa4+0muXaNC8uW8tcxQ0N4wIBR72jKa5kJp+ZonX1c+byKzPDh5cdb
	TtoroGoqbWFRYNKQmtg+SIBt/nNXTvOSFBCl8AU890js3138GwVWoO4XOZ/a4VlWy4Ab
	nLqg==
X-Gm-Message-State: APjAAAWtuDBsfYoWvXQ2JvfYT3dsUTV4os5GCaLfkisiJWsi9TvAFdpS
	Dhaff5E1F1uIr898mYQPFx6Od+DenrWD9J+4N90yTQ==
X-Google-Smtp-Source: APXvYqwanTaFilsJjmucmiGK9zHQ2p26vL+Qrs8/VkDTaIoSxu0a2BowsahBmQbTKOf+S+QaYkSc52PMnzKcyVMZXhg=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr31275279otq.221.1558696068263; 
	Fri, 24 May 2019 04:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190523144336.13960-1-laurent@vivier.eu>
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 12:07:37 +0100
Message-ID: <CAFEAcA8x2bNdqkBiu4sTh9T8P=U2JYwdCZYK1dHDK7Q8MbyQ0A@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 00/10] Linux user for 4.1 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 15:47, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit a4f667b6714916683408b983cfe0a615a72577=
5f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' int=
o staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to 069a1504ee1e2943964d0357d798e11b66afd351:
>
>   linux-user: Pass through nanosecond timestamp components for stat sysca=
lls (2019-05-22 20:50:55 +0200)
>
> ----------------------------------------------------------------
> Add /proc/hardware and /proc/cpuinfo,
> update SIOCXXX ioctls,
> update IPV6 options,
> fix shmat emulation,
> add nanoseconds in stat,
> init field fp_abi on mips
>
> ----------------------------------------------------------------

Hi; I'm afraid this fails to build on a couple of the hosts
I test on:

/home/pm215/qemu/linux-user/syscall.c: In function =E2=80=98do_setsockopt=
=E2=80=99:
/home/pm215/qemu/linux-user/syscall.c:1929:5: error:
"__UAPI_DEF_IPV6_MREQ" is not defined [-Werror=3Dundef]
 #if __UAPI_DEF_IPV6_MREQ
     ^

(these were the ppc64 and aarch64 machines in the gcc compile farm, but
I suspect this is just "older kernel headers" rather than arch-specific.)


thanks
-- PMM

