Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67474C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F602253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2ooI1Xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F602253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiad-0008B6-FM
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuhSD-0008C7-9e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuhSB-0008ND-7s
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:43:44 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuhS9-0008Li-GW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:43:42 -0500
Received: by mail-ot1-x344.google.com with SMTP id z9so3747339oth.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tkotc8S4hCcILSnkrDe0+TCYBqSuyzi4c0KOqtlTaR4=;
 b=d2ooI1Xpqb4YAVzEXs7kLYyVRQttniYYCwQ+z+WGSo2IoJk6f20ZjlCuJyaaN4OMDB
 295TlVJUD61ELQTmDng5+2x0pHGXYdrT2jIAYWM2bxybnsiz0rsTsBS5zWwSGzwqI0Va
 94yr/f/Pil5wPfI4ouA+oiKs01QtSAP0xCmzXOvXSfdM0H3Slj9AYmdnAP2gQJU5m6u4
 lHu9Di3SwwTP2M9zgSU6H0PsrHbQNSDACpT+WAAzWTXC6RtScVD8leITBgTNyPjnCsPR
 UEWaKV2LwVC6W9CjRZrzbp81QUj/6xs0KpLcxyx/hO7uCE2QiMZ5FpfLhuEaHavK4cZP
 LliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tkotc8S4hCcILSnkrDe0+TCYBqSuyzi4c0KOqtlTaR4=;
 b=tAhOhPwsYK+1j+ny00LTPqXcrze9wHI8JhWTSQCI9yfWBwRVK4kIgNs4jFcHXgxRTy
 shzNwz6KD3vPydQUkmOIeY7QP/iAxRPvMGXqYETZ9IWXPfeS8DrZMX9yV/jxGK4FRcG/
 U+dYiwwB+UHjVEIZr+UvmEupTvsBCtHaEfLlSJ1C7rIz34g4oVpHCtacfdjWiWVCxehx
 9e5uljoSTYse/jmr5+YEDPiXdpc/71QKkhnXvL3YfT/EI70QDwLH689EaYcjJqZ79bNz
 7HopEqcT7DE0VNKimzcjp1cMg2WNppsneAqX0g07zH5CVetD3OQVF4QrmOMN2UEKMxPr
 4w0Q==
X-Gm-Message-State: APjAAAUTZ8L8aLXQFayYoumTVEqh34DU0lNtYV4cMNa2KbYvSj6I5UeU
 q3eKvrSWQkJ+MFwaeqaflSkitZ8m0EWaK9kaOsQ8qw==
X-Google-Smtp-Source: APXvYqyZnEvhCGYHVaXMsZyl9Z3LXuoXc2SmimmZmBRQZolcWqwvNFoL2lQDu46pRhKLN/i3WcYS0NI6f2+1mz8wohs=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr12374921otq.135.1579805019205; 
 Thu, 23 Jan 2020 10:43:39 -0800 (PST)
MIME-Version: 1.0
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 18:43:28 +0000
Message-ID: <CAFEAcA8R5yDfAYYraeBStD_Oh7G60QSgUaw_JVdqC=C8y4n0Jw@mail.gmail.com>
Subject: Re: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 16:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd=
40:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-2020=
0121' into staging (2020-01-21 15:29:25 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f7bb7a3f1e8f4f854208785eead0d807ad8a688c:
>
>   tests: fix test-qga on macosx (2020-01-23 14:34:49 +0100)
>
> ----------------------------------------------------------------
> * Register qdev properties as class properties (Marc-Andr=C3=A9)
> * Cleanups (Philippe)
> * virtio-scsi fix (Pan Nengyuan)
> * Tweak Skylake-v3 model id (Kashyap)
> * x86 UCODE_REV support and nested live migration fix (myself)
> * Advisory mode for pvpanic (Zhenwei)
>
> ----------------------------------------------------------------

When I try to build-test this merge, the clang sanitizer
build seems to fail whenever it tries to link anything:
(configure args '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
'--extra-cflags=3D-fsanitize=3Dundefined  -fno-sanitize=3Dshift-base -Werro=
r')

  LINK    tests/qemu-iotests/socket_scm_helper
tests/qemu-iotests/socket_scm_helper.o: In function `send_fd':
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:53:
undefined reference to `__ubsan_handle_type_mismatch_v1'
tests/qemu-iotests/socket_scm_helper.o: In function `main':
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:111:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:116:
undefined reference to `__ubsan_handle_type_mismatch_v1'
tests/qemu-iotests/socket_scm_helper.o: In function `send_fd':
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:56:
undefined reference to `__ubsan_handle_type_mismatch_v1'
tests/qemu-iotests/socket_scm_helper.o: In function `main':
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:121:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:121:
undefined reference to `__ubsan_handle_nonnull_arg'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:106:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:123:
undefined reference to `__ubsan_handle_type_mismatch_v1'
tests/qemu-iotests/socket_scm_helper.o: In function `get_fd_num':
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:68:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:69:
undefined reference to `__ubsan_handle_nonnull_arg'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:70:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:77:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:77:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:73:
undefined reference to `__ubsan_handle_type_mismatch_v1'
clang: error: linker command failed with exit code 1 (use -v to see invocat=
ion)

I suspect the configure patches that try to clean up cflags
are the cause here.

thanks
-- PMM

