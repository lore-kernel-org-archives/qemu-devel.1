Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE96C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB16920859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQHgVP2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB16920859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haJuH-0007cf-0J
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haJt9-00079Q-UN
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haJt8-0001ab-W8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:59:03 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:35211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haJt8-0001Zn-Pt
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:59:02 -0400
Received: by mail-oi1-x235.google.com with SMTP id y6so6147549oix.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mIF4tCWxTOXZcdBOa7biJqY33xVCSgmvQ17bRlLI3QM=;
 b=DQHgVP2uotPw++77R17nn6B4IBzkvbakjLx6ogig1/wL8xtwXlfba0y+8F+Ta+6inJ
 RlTNR5oY6xYyJn6zXy/lUdUrH423dVMYVnvPOBMg8FysZfJBh9vQt3mPfySA2NwpRpbq
 CG148Tes/MJVLUB9skqb8A/xMbdP5DzyCr1SoSR99nKdE3tKQyMjYrllX7RpyUeKKLTn
 pLuCaH2lVh//9qblDHT+M1fd24oCuxuenTcRUwjMeJQkb45Cxxb5zJbbbA3upqo/ZOO6
 pgw/7TPcklQHpb79/BJvaZ4U+IxHcZp6ZvvffTMSFduFg2mhwDgh98Y1RQmcA4azbjaR
 rNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mIF4tCWxTOXZcdBOa7biJqY33xVCSgmvQ17bRlLI3QM=;
 b=AaxOXGJY+U6pT84iFLVx983OBuu/vo80+vuLl29LD2dRn4yQGC9resaU3c3t1dOqPo
 sUKhdz8Ed16IoZG9FQMIpkdrfV3OwR5iuz2FPXSYkF/sRQE10FDWD/MZgsFj0uiv4rSq
 x8Ij/sAgS2R5Lx06/RaKlrtIMqHEU7/2C4S4BqrUQ8/bgEUrlEwb5gqE+Y5yxuq9j5mL
 vmbt270+T2HMfakaH83n8MNRxjyxQwgEv5t+OkTbilnp++lVJhA3wozXlwxPf9vHwcOD
 3e9IZH3EFj6uwkP6yiZONBclQPExtaBsBjn1wk05K98GPchCQ6DTgUPGVBoGCs8iY1yf
 WDNw==
X-Gm-Message-State: APjAAAVOzQFLQLBQJi7ipYGbtS7aLswUi/EsXsxxHzC+Z03wzbUyyihP
 xejvi8GAVsXzS1fhK/pUNZ1jmW7XQ3P+Ft4SbI/ftg==
X-Google-Smtp-Source: APXvYqxuuIx2bLxg/D2weOQeR4zsckU7MbWrkVCguFXkhx8XV/ur8TeXm4zyQ3ZwEtcX3DvyRnUaWr3ilO46Czk4q8c=
X-Received: by 2002:a05:6808:8f1:: with SMTP id
 d17mr12094150oic.170.1560171541431; 
 Mon, 10 Jun 2019 05:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190607211544.7964-1-ehabkost@redhat.com>
In-Reply-To: <20190607211544.7964-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 13:58:50 +0100
Message-ID: <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 22:16, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 185b7ccc11354cbd69b6d53bf8d831dd964f6c=
88:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190607-2' int=
o staging (2019-06-07 15:24:13 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 8297719709f1339506d6da93ec69e6118ace8676:
>
>   travis: Make check-acceptance job more verbose (2019-06-07 18:11:02 -03=
00)
>
> ----------------------------------------------------------------
> Python queue, 2019-06-07
>
> * New boot_linux_console test cases (Philippe Mathieu-Daud=C3=A9)
> * Deprecate Python 2 support (Eduardo Habkost)
> * Require python3 >=3D 3.5 (Eduardo Habkost)
> * Make check-acceptance Travis job more verbose (Eduardo Habkost)
>
> ----------------------------------------------------------------

Hi. This fails to build on one of my buildtest machines:

ERROR: Cannot use 'python3', Python 2 >=3D 2.7 or Python 3 >=3D 3.5 is requ=
ired.
       Use --python=3D/path/to/python to specify a supported Python.

The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
box; it's one of the gcc compile farm machines so upgrades to its
OS are not really under my control.)

The configure check also spits out deprecation warnings for
the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be nice
to get those updated.

thanks
-- PMM

