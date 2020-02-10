Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90111C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD082080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lL5uOFkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD082080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1BbV-0006cS-GY
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Bas-00068l-CS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Baq-0004Ng-TP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:07:30 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:33247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1Baq-0004MS-OJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:07:28 -0500
Received: by mail-oi1-x231.google.com with SMTP id q81so9701818oig.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 08:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9D/a105fOETl1AhxCfnMIXBacjXNjRSN+uNsme3oCNY=;
 b=lL5uOFkK1eaw7mLfII4NewQGIgbrySSW6OXouAkp2BzGlcj4tgngd5G7IcFhlGQRV+
 YyzGug/NNr0+t73MAE5B2qUMZxgssoDDsq+2eIqXV+/rg+xZ/CVcmTfBeZhBbl0ohpvR
 +llVUo7F2xlO8Npj+Cf5taNPYsU26WnZPiS5XqmygwiHgCdq1nFTMfWCVasftO8Y0ylb
 UhIDCp5wpZy2Vqtr1g3qJJDsVVvO+Aix5YRloaSVSXQX2os4z6tVLfeccV+/H4Uoickb
 UspS3eIc7DdZa+Nhkc4KjfF377/tO72AKgQ5v+/yrhBHRBDN6DodTeF6oiGHx6iNDiJ+
 Vttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9D/a105fOETl1AhxCfnMIXBacjXNjRSN+uNsme3oCNY=;
 b=DjDvKjy1ermNT2uA8EmBYmWat795zf7NL6TAqtPGsnqQiX67I4zsAddec5Hhk1VIJ8
 pA3tVe634vZV5BEDk9uVlqg3UstEV6UvwYOHWloW341vogIK0SVsdkLeP6RL7dXCfvXq
 DPkZyT7nij3+xmyQaGYzSCcFh+lwUv+TmdU8FWURVQLCa6pmVAJttHgmVqmI4cnNI4OT
 woo/UM5nD8UzO0eOlaPSb8oZIgbhzIEJpQMVa4wsx9dJb5Iuw6WQeHF+DT/mvqr9+7oB
 j4qaOd7aXKBRY6/ZGnoEIBDFj+7TO5iSTlLfRgEux9VJ5imCGVSEK697NTVADKC4y2/E
 kaNQ==
X-Gm-Message-State: APjAAAVh4fOxrX/JDY+0texYp5K9dRE1OxF45dzeRm8z52POXnn08jAH
 q4+ibIFfY14TtSDAdn15GP87uqKZ+2s1ZBvnEwgX3w==
X-Google-Smtp-Source: APXvYqyQeEtV6Gtvw+8FeIl52jI4gfTBi37GalpNURrfNYHDrpOQ6kZ6Z8Rri+DDk6PRITV/15+OwN5XortjDPncJgM=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr1306174oiy.170.1581350847519; 
 Mon, 10 Feb 2020 08:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20200207151113.29349-1-philmd@redhat.com>
In-Reply-To: <20200207151113.29349-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 16:07:16 +0000
Message-ID: <CAFEAcA-DupbdJ+9eo-EtttGGFr6S4j-+Eux_k23gWUPwgdBjXQ@mail.gmail.com>
Subject: Re: [PULL v2 00/46] Python queue 2020-02-07
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 15:14, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Peter,
>
> I prepared this series on behalf of Eduardo and
> Cleber.
>
> Eduardo already ack'ed yesterday version (2020-02-06) cover:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg677636.html
>
> Since 2020-02-06 (v1):
> - rebased to cover new iotests #283 (merged yesterday).
>
> Regards,
>
> Phil.
>
> The following changes since commit 863d2ed5823f90c42dcd481687cc99cbc9c4a1=
7c:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-02-=
06' into staging (2020-02-06 16:22:05 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/python-next-20200207
>
> for you to fetch changes up to 66e7dde18cc4085ca47124be4ca08fa8e6bcdd3a:
>
>   .readthedocs.yml: specify some minimum python requirements (2020-02-07 =
15:15:16 +0100)
>
> ----------------------------------------------------------------
> - Python 3 cleanups:
>   . Remove text about Python 2 in qemu-deprecated (Thomas)
>   . Remove shebang header (Paolo, Philippe)
>   . scripts/checkpatch.pl now allows Python 3 interpreter (Philippe)
>   . Explicit usage of Python 3 interpreter in scripts (Philippe)
>   . Fix Python scripts permissions (Paolo, Philippe)
>   . Drop 'from __future__ import print_function' (Paolo)
>   . Specify minimum python requirements in ReadTheDocs configuration (Ale=
x)
> - Test UNIX/EXEC transports with migration (Oksana)
> - Added extract_from_rpm helper, improved extract_from_deb (Liam)
> - Allow to use other serial consoles than default one (Philippe)
> - Various improvements in QEMUMonitorProtocol (Wainer)
> - Fix kvm_available() on ppc64le (Wainer)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

