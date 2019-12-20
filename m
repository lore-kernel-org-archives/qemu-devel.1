Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE70C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DA020716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjD8R7eF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DA020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLHi-0002ay-6a
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiLH2-0001yL-Cg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiLH0-0005Cl-Qe
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:37:07 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:37630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiLH0-0005Bq-KI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:37:06 -0500
Received: by mail-ot1-x32a.google.com with SMTP id k14so12526250otn.4
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 08:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cBkJTbeTwbvc6OYowZOi0m7HR56+yzNDiodw81/ZqdI=;
 b=xjD8R7eF7gAAj+z8YK67j7OqyXFmu26TS3WJV91UTZKn3T9vhaR8O05KerbJJdmonP
 xYSqg/wcO0tk5WJAmmB18WKIFmHDS5283GIq6stpdNWaezPpbMSpT4+NYviaVmCh+KCb
 p7W0cfUk5/Vv1hxtrUpNXspaVv97+8n2aXeBWS3zHMyaciarYmX6Eco2PwAcFPcom0tM
 AG1wBkFUdP6Ckzt71ykxFoV6jg2nzESBV0PrCkX48DckSfiyqHiD6HUugBNfa4lWYw4v
 T5cj9MYHqQc0UtA7QVxEHaJyjD5bVX4TwspJvMD4J6XFPJjwxwBnLlN/nYZzyv54MNkF
 ZVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cBkJTbeTwbvc6OYowZOi0m7HR56+yzNDiodw81/ZqdI=;
 b=JouDXE0jNoTRGCbZciWrk1ijWIdBYFBgJ3zunZ9DI2xNsLxGtNctRu/jUbu+36d79x
 MmZ5tJuueXJTBNf0JpPCZ0bOi3m1WGdA87MKUkPGlCrBI4U9V9KVTaeSmhhYy5tr/U3a
 BzxK954+YuqrO/dmqNhkaV/N4DvWBjM0/dHGX1no/kVKCkVZxVWzzvPFVRNqO+hUO0vX
 ffeb/2FF6X9VUqOw3OwCa0qS/yS5rlttYpcu4cZ6THLdPdjLGjQewOnXKOE9kLbxW91X
 0vVKunzRjcscK3hhs+BhbmoeHBjKhM/ai6KE1rmGllGke1xCUiKReI5+oJ4/9WPcjYbx
 R21A==
X-Gm-Message-State: APjAAAWxEJnfAMuipGQzPhlzUQpbAxKGNF6ZW3EczP3LpE7IdKJIZ/7/
 +5nr3kg3jn4nOqd/9onx7/CwsQSK+UvfQeeSmbMxkA==
X-Google-Smtp-Source: APXvYqzmRGstT/GkrSfvq9HoySUhvmaEyd4omvaX3WNyK1yOW62c0dD3PNSJFiz3Pae76XudlYbK1/mMUBJmt8zHXOQ=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr16063483otd.91.1576859825518; 
 Fri, 20 Dec 2019 08:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20191219104934.866-1-alex.bennee@linaro.org>
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Dec 2019 16:36:54 +0000
Message-ID: <CAFEAcA_YEUZgz3f-CAnsTunhMdEYf_xjUQY5D+hkk4os9_ibzA@mail.gmail.com>
Subject: Re: [PULL 00/25] testing and logging updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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

On Thu, 19 Dec 2019 at 10:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a6=
81:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-tesing-and-misc-191219-1
>
> for you to fetch changes up to 380976f40f909b735acb60d5d424de7eb1b7107e:
>
>   tests/tcg: ensure we re-configure if configure.sh is updated (2019-12-1=
9 08:20:16 +0000)
>
> ----------------------------------------------------------------
> Various testing and logging updates
>
>   - test tci with Travis
>   - enable multiarch testing in Travis
>   - default to out-of-tree builds
>   - make changing logfile safe via RCU
>   - remove redundant tests
>   - remove gtester test from docker
>   - convert DEBUG_MMAP to tracepoints
>   - remove hand rolled glob function
>   - trigger tcg re-configure when needed
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

