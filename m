Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560AFC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F92C2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPLGzJZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F92C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEw4S-00046J-70
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEw3a-0003be-DC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEw3Z-0000Ce-36
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:21:58 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:45586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEw3Y-0000Bh-Tl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:21:57 -0400
Received: by mail-oi1-x22f.google.com with SMTP id 9so2780583oiq.12
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aG77IBpCC5KAmVM1iJaZi746c9+NcIaVm6mQq0nvxaU=;
 b=tPLGzJZp7cfr/IvmbKC1nveqbxI/bFKeX2NdPp08I8AwwNSqrHdh5w0DrsS/tdzgy+
 Zeba1bYx19sEscq2W2VmDgIm15Z5Z6Q+imXzFL40GcX2d4AZUgUc/9aGutxPBCq/S280
 rKEuwssb312vmWfvWCmxweQtd9XqjxwNcYeNbC4KoKWXqZALp5M+45fXlDunBc0Bbj0a
 NwOU0DrTbzraAcFmHIAAcKYcK/+8q17tQmp6N97vu2sKu4K0I760CN6l6ZxY2rwbzsSh
 1rTCGRU3x3nTVa6/sb728J0GsikKOSTvuLtMz+k4l6gZuMRlEpf0F7MyoYS2GHWif876
 wCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aG77IBpCC5KAmVM1iJaZi746c9+NcIaVm6mQq0nvxaU=;
 b=nhynGBHqgaDqlbHpA4+/kba4shBLswVT445qAZuPU6W/DGppfjGX83XYOd1dvnJ0m5
 keGVJog5LtuqXqAp9x+XXUF0WjY9bz4XUMJIp0fe8ggXTkWyyffE8kJTFJY1B8MYEfgp
 QrNWgCtEiFDuqFwwRngl50hLf+8s7NIldwf0IfEIsoYcpK5RWNQ1yC7QoilxXcmUywuD
 Ud2n6gm+rUrZGpurwMeGD32D4ri6pZGeGtR5C9CMrAIAj7P+MbAK6+3uqr8JxEBJU4Zm
 xs3d250j3RStqrIBGohIX7IMt7EIfklwGX1cLyA6yaxX8iInXOM6H4cwy8rrDZ9hbk/Q
 dgQw==
X-Gm-Message-State: ANhLgQ3uYzYqyjs0UkN4d0Q05eZY2R60Pt1otvqDSaZMZuuD96E5sA+Y
 /T5evwqkJ8OINNnBQKpCAKCGVuHWrvoIkmg7QaUGjg==
X-Google-Smtp-Source: ADFU+vvhu7yjCaT6+1I0F0BBqpaBFrrPPne6Y75WRr5NIi/CFJhmmByH/w/pCxvkmu14vd+2JLxJuultyeZh3X1mHg4=
X-Received: by 2002:aca:c608:: with SMTP id w8mr2540498oif.163.1584627715604; 
 Thu, 19 Mar 2020 07:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200318001932.180617-1-crosa@redhat.com>
In-Reply-To: <20200318001932.180617-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 14:21:44 +0000
Message-ID: <CAFEAcA_5z6-rkgOwsCNQC6sXun6Qj205=TnJOdrX8S-bRR6UBQ@mail.gmail.com>
Subject: Re: [PULL 0/6] Python and tests (mostly acceptance) patches 2020-03-17
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 at 00:19, Cleber Rosa <crosa@redhat.com> wrote:
>
> The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c299cb17:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-03-17 18:33:05 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to a51d6a549361fd1a20dd2ac1d6a42ac0a4c708c7:
>
>   tests/docker: make "buildah bud" output similar to "docker build" (2020-03-17 19:16:16 -0400)
>
> ----------------------------------------------------------------
> Python and tests (mostly acceptance) patches 2020-03-17
>
> ----------------------------------------------------------------
>
> Cleber Rosa (5):
>   Acceptance tests: introduce BUILD_DIR and SOURCE_DIR
>   Acceptance test: add "boot_linux" tests
>   Acceptance tests: add make targets to download images
>   tests/docker: add CentOS 8 Dockerfile
>   tests/docker: make "buildah bud" output similar to "docker build"
>
> Oksana Vohchana (1):
>   python/qemu/qmp.py: QMP debug with VM label


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

