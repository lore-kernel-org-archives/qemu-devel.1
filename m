Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4610CC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 19:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA99206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 19:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgxUJzSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA99206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1xvD-0001Pe-6k
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 14:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j1xuZ-0000xB-1V
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j1xuX-0001YC-SM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:43:02 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j1xuX-0001WR-LU
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:43:01 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so3679661wmb.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 11:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=R80/vbNotE15b70FkzntlH4XnEOxwE4OgxeRrfC1WyA=;
 b=AgxUJzSZGYppCB5zsK69XBMEFWDIUqCqOdCV0GGrqMFAOtmnN+/XE0JazA6OmYhBft
 goAAQ16HeBptdSKr8oBLuhY9q7DdZgJiOoWKvqOm9kIjpkr+4BMg9JN5OBHBtZJrxnju
 hQoPrXQ20YhYVn7xV13O80iIHjijsSUmJa0FTQzjJ8gKD+4knxpawE/B/Aum5oB2ItDp
 pjDUvwCJDcAdirECnr3xekY5W5/GsWNQm6wvm7tQ+0orLEX048mUTfT5qrEP7Ssx2ZF2
 9f2UUCDyJdjMjS431FFv4DkjGWNfw86NZkdmMSriyxGJO0xtvBVtEQGIBn6BoNnGl3sM
 S8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=R80/vbNotE15b70FkzntlH4XnEOxwE4OgxeRrfC1WyA=;
 b=JZlXu68TSr28BrzuvrJmmHL4O9OzYB2gXX4nCdd23NBHd0hTPhx21QcYFuNjUZOi93
 9dJmp0po0q4UeWrCGh06kWEY0CNyoVSwn+JXNIsaHwk/Oe9o1GQ29lIv68sjAO/8y2p4
 3L+FQy4/6ZFjuDCxeaR+bFUxAusQrZhOo6O74Wy2lJE62joaA6OwVUyesxq+2181t8xh
 BN6r4GoQahIaxP4RZuXQCVAcJdC78O7esatC1Vd/y0ftUKDf//HWS/pOFgwFHaaDyi4/
 UtyiIyxYUmrab+EKhGQRM7ylE2hK+UK0TnvAhc8nUbQJt83W0/M1lLynw6pzunTD0nD9
 kcyA==
X-Gm-Message-State: APjAAAW3el3WExpXsuh26dA54mC16/LtsOW7XJA99YY9mSz54+XKDJMr
 XPextxGZNVZE2FCH6tLncZ0StQ==
X-Google-Smtp-Source: APXvYqzsyToMm6BfJ/L57wz5sWF3vEQs5QMciCTCALZvGRO9nd9MDyhLEiR8/lsiV42ahOmnCM67uQ==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr695398wmf.105.1581536580288; 
 Wed, 12 Feb 2020 11:43:00 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s139sm2037701wme.35.2020.02.12.11.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 11:42:59 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 867831FF87;
 Wed, 12 Feb 2020 19:42:58 +0000 (GMT)
References: <20200207113939.9247-1-alex.bennee@linaro.org>
User-agent: mu4e 1.3.8; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH  v1 0/5] testing/next (rcutorture and misc tweaks)
In-reply-to: <20200207113939.9247-1-alex.bennee@linaro.org>
Date: Wed, 12 Feb 2020 19:42:58 +0000
Message-ID: <87blq3y4l9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> The current state of testing/next is mostly a rubber duck exercise as
> I tried to figure out what might cause the rcutorture test to fail.
> The only real practical change is asserting we are never about to
> reset and existing active RCU structure. So far I haven't seen the
> rcutorture crash occur since (although git stability seems to be a
> current problem for Travis).
>
> Alex Benn=C3=A9e (4):
>   tests/tcg: include a skip runner for pauth3 with plugins
>   tests/rcutorture: update usage hint
>   tests/rcutorture: better document locking of stats
>   tests/rcutorture: mild documenting refactor of update thread
>
> Thomas Huth (1):
>   travis.yml: Test the s390-ccw build, too
>
>  tests/rcutorture.c                        | 55 +++++++++++++++++------
>  .travis.yml                               | 10 +++++
>  tests/tcg/aarch64/Makefile.softmmu-target |  2 +
>  3 files changed, 53 insertions(+), 14 deletions(-)

Ping?

I'm particularly interested in the rcutorture changes which so far have
not yielded any:

  ERROR:/home/travis/build/qemu/qemu/tests/rcutorture.c:384:gtest_stress: a=
ssertion failed (n_mberror =3D=3D 0): (1 =3D=3D 0)

in my various test trees.

--=20
Alex Benn=C3=A9e

