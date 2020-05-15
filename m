Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F336CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B634020657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEDNd/Cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B634020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZ7h-00010a-0k
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZZ6r-0000a0-SV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:06:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZZ6n-0006JY-CP
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:06:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id f134so2077855wmf.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 05:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dNOtOuIIuTg5USAmP/zPx3n/dCaP/KSbKP4f1MPOJ6I=;
 b=VEDNd/Cwe+5DanptfqhfQNqWytWuc9rBA727T0rEbW0PNfE43Z1zGVmHLalHpvk1bo
 E7PGGpJsapT0NTl6JucP9r3XDJzM0192gAQn+20nWFS+iycmVV4uMByOZRFkxY7Hl1we
 gfT155gQsvSZTFM3CPVc1nvm0fC+eUdrNG83To/IAfkBZZaRG4lqyxkt1Fe5A1MPHejc
 LIgoHLYdt7t7w7g9SUAbreTC7Z7yW1Jnwj0nvUzq1xg/k71zpmlFTDZRsbRojssdqSx7
 dqv0qfEVfjOe97/uSdqC+15bsEYLHvhcFpfL5HSO0AxuPn6Uxw3TqALl19g2CWwdDeW4
 46jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dNOtOuIIuTg5USAmP/zPx3n/dCaP/KSbKP4f1MPOJ6I=;
 b=eNHbMqWJvDn1mUENyABGZ60vygEWdghTtcaaGPr19DV9igdrvAVfDBzVQCVP/xJfjr
 UWMkx88Y4T2+HvsP7a3eFJ0O5JERqz2KK0onjIp1pnMKzBOhof4QZTwyeZ5V0uuuo0Kn
 TAaqfcp9ShIoVPDlNpdDuc7DlLzFeeGNUuPgTlYd14YOW6gHIVYWHTWX3H5eM8q1dueL
 zt0h668v3xocIThPIfNTbVPSzVFG+cm/Xhfr+A5e+d8dFOxDeW/V+vKcTkfJu77uCUSR
 6mYOWdojq0vesjYjJGRKy9Ulkh5zlhrhrN65E5QbPyc+UW3fYWx8WMKU+aEOSiYr1XMC
 1lkg==
X-Gm-Message-State: AOAM531AJ+x7Wr0rzpL7Ci6ey8u+Tytre+COw0H28baSd0wzPljC/R5r
 2d3MTfi6iEUkF/VmZEuGvpOgjQ==
X-Google-Smtp-Source: ABdhPJy4E61TiOgL8ul7DC4c/+FWCrsxZZCz2B9hGvExSvs2Nvsx0fgUc5Q+VsNrviJ6rIvH0YvuAg==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr3679464wmc.123.1589544391608; 
 Fri, 15 May 2020 05:06:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w9sm3971545wrc.27.2020.05.15.05.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 05:06:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1369E1FF7E;
 Fri, 15 May 2020 13:06:29 +0100 (BST)
References: <20200513120147.21443-1-f4bug@amsat.org>
 <87a72beuhn.fsf@linaro.org>
 <2839ba1a-f4c4-3a4d-cabe-d6e0e1b6accc@amsat.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] tests/docker: Kludge <linux/swab.h> breakage by pinning
 linux-libc-dev
In-reply-to: <2839ba1a-f4c4-3a4d-cabe-d6e0e1b6accc@amsat.org>
Date: Fri, 15 May 2020 13:06:29 +0100
Message-ID: <87blmpcshm.fsf@linaro.org>
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
 qemu-devel@nongnu.org, Salvatore Bonaccorso <carnil@debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 5/13/20 5:15 PM, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>=20
>>> Linux kernel commit d5767057c9a [1] aimed to fix an issue with the
>>> swab() declaration, but doing so it introduced the BITS_PER_LONG
>>> definition, without using the kernel __ prefix, leading to odd
>>> failures in userland code using kernel uapi headers, such:
>>>
>>>        CC      block/file-posix.o
>>>      In file included from include/qemu/timer.h:4,
>>>                       from include/qemu/timed-average.h:29,
>>>                       from include/block/accounting.h:28,
>>>                       from include/block/block_int.h:27,
>>>                       from block/file-posix.c:30:
>>>      /usr/include/linux/swab.h: In function `__swab':
>>>      include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evalu=
ates to 0 [-Werror=3Dundef]
>>>         20 | #define BITS_PER_LONG           (sizeof (unsigned long) * =
BITS_PER_BYTE)
>>>            |                                  ^~~~~~
>>>      include/qemu/bitops.h:20:41: error: missing binary operator before=
 token "("
>>>         20 | #define BITS_PER_LONG           (sizeof (unsigned long) * =
BITS_PER_BYTE)
>>>            |                                         ^
>>>      cc1: all warnings being treated as errors
>>>      make: *** [rules.mak:69: block/file-posix.o] Error 1
>>>
>>> The issue has been fixed in Linux kernel commit 467d12f5c78 [2].
>>> Some distributions already backported the first commit, but still
>>> lack the second one.
>>>
>>> This is the case for Debian Buster.
>>> The linux-libc-dev package contains the Linux kernel headers.
>>> Kernel commit d5767057c9a has been backported in package
>>> commit 1fb0eb7956 "Update to 4.19.116" [3], see debian/changelog:
>>>
>>>    +linux (4.19.116-1) UNRELEASED; urgency=3Dmedium
>>>    ...
>>>    +    - uapi: rename ext2_swab() to swab() and share globally in swab=
.h
>>>
>>> The previous released update before it is debian/4.19.98-1,
>>> released as debian/4.19.98-1+deb10u1.
>>>
>>> We can find this package in the Debian snapshot archives,
>>> luckily archived on 2020-04-28 21:20:54 (see [4]).
>>>
>>> QEMU use Debian based Docker images for most of its cross-builds,
>>> which are tested by our Shippable CI jobs. The current broken
>>> package makes most of our CI red. We can kludge this by using the
>>> latest package released before the breakage. Do so by pinning
>>> the package version (apt hold), and using the snapshot archives,
>>> similar to commit b4048a7cd1.
>>> We'll revert once the fix is backported on Debian.
>> May as well mention:
>>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D960271
>
> Sure (I remembered you talked about it on IRC, but was lazy to dig).
>
>>=20
>>>
>>> Reference to commits:
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dd5767057c9a
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D467d12f5c78
>>> [3] https://salsa.debian.org/kernel-team/linux/-/commit/1fb0eb7956
>>> [4] http://snapshot.debian.org/package/linux/4.19.98-1%2Bdeb10u1/#linux=
-libc-dev_4.19.98-1:2b:deb10u1
>>>
>>> Cc: Salvatore Bonaccorso <carnil@debian.org>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> Shippable green again:
>>> https://app.shippable.com/github/philmd/qemu/runs/759/summary/console
>>> ---
>>>   tests/docker/dockerfiles/debian10.docker | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/do=
ckerfiles/debian10.docker
>>> index 0769700a41..d7084ac283 100644
>>> --- a/tests/docker/dockerfiles/debian10.docker
>>> +++ b/tests/docker/dockerfiles/debian10.docker
>>> @@ -9,6 +9,15 @@
>>>   #
>>>   FROM debian:buster-slim
>>>   + # Use a snapshot known to work (see
>>> http://snapshot.debian.org/#Usage)
>>> +ENV DEBIAN_SNAPSHOT_DATE "20200428T212054Z"
>>> +RUN sed -i \
>>> +    "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-v=
alid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DAT=
E} \2%" \
>>> +    /etc/apt/sources.list
>>> +RUN sed -i \
>>> +    "s%^deb \(https\?://\)security.debian.org/debian-security/\? \(.*\=
)%deb [check-valid-until=3Dno] \1snapshot.debian.org/archive/debian-securit=
y/${DEBIAN_SNAPSHOT_DATE} \2%" \
>>> +    /etc/apt/sources.list
>>> +
>>>   # Duplicate deb line as deb-src
>>>   RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/=
sources.list
>>>   @@ -35,4 +44,11 @@ RUN apt update && \
>>>           texinfo \
>>>           $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | c=
ut -d\  -f2)
>>>   +# Install common build utilities
>>> +RUN apt update && \
>>> +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>> +    apt install -y --allow-downgrades \
>>> +        linux-libc-dev=3D4.19.98-1+deb10u1 && \
>>> +    apt-mark hold linux-libc-dev
>>> +
>> Do we need this bit? Surely if we have a snapshot URL we don't need
>> to
>> hold the package as it will never get updated?
>
> You are right, it is a remnant from the first approach (pin it without
> using snapshot) which didn't work. I'll remove this line and the
> comment in description.

Hmm it seems this is needed - without it I see other failures:

  https://app.shippable.com/github/stsquad/qemu/runs/1377/8/console

--=20
Alex Benn=C3=A9e

