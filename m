Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12011C43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D602073F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZnkMdzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D602073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf6HW-0003ur-2e
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 13:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37315)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hf68V-0004Hd-5S
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hf68T-0002TI-D0
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:18:38 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hf68O-0002DL-09
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:18:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id n5so11234616otk.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=StNw1w7qh0pKRBMracOseZbSTKTUsSVpfScuOln+xLg=;
 b=NZnkMdzYWS1fERKEJYe/5fhoEfgmjePXywPxzg4/1H/TyhIQmyG11pYsjSTFB6lSNG
 2E33mkosLYSoxISBlc5ZDDYcRQ/JbdTzEvGRNWdA0/zkun6dblQhWPVkx+WWwTebKQod
 NgtoXlFiDlCq+L1t3PiN0JzMJ3Wpq7H0XEnkDHLu4OBv4PQwGP/MExYc6h7moEke6d3k
 pSgYjl7Y1qhKUwn5W5CFWk1/vWJWEJJb7QFlliCo2BIqEba785O6g/E3aqMfJ87dDSqk
 myqp9/jHEFaRATqPtfuigN3hdDFik8HlQ2xhmABT2+MHehu2J22DBCRq2MebMXUehma/
 rZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=StNw1w7qh0pKRBMracOseZbSTKTUsSVpfScuOln+xLg=;
 b=YHu8X9vuHoBJ7fcSJX6hAWid6Vhzc36gdvuPqbmqsoVwoZx5mqyne/72uo38kpmczz
 4ic/sGV1Ua/zi+FMPgvlU+Q0i2Ai6Qaw3V2lRToVXdQzHzIubJaSHEZff3Nzzj03TPaG
 dMAfGycAOKu0FrGs/h77ilvYy+4vw4vGBswvBnMtCyv2GJz6WTsc0bmU5LvVEw03DopL
 STCzjdU/qNo9coBdvqfJJboncRCZqrW+lTnCcYpH1+G6xNveJA1WE5Tx9neD9baguwiV
 XrGbQL9alDqRAXcPayn9/K+Zb1sS7CZ8quP4qRFq4JTrUaELN6Zk52OxevuRmPHlpjFm
 Jnxg==
X-Gm-Message-State: APjAAAU3hZ48he+lAFydC3Im36O3+7xPb2Blp3+xw4NkIW9BmPAjZKVW
 AENDy0kft/k4NAFWc85fHjjyp9TUB7BC9+kwS4dn1Q==
X-Google-Smtp-Source: APXvYqzjJTHrZhMDG7V//tl4xYFlBv3X1n2bKXKb0avFn0uDit0GZYEiCXciCeC9WZunR8/bgQHMBM9VvvcmDFVRX1U=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr27697964oti.91.1561310305211; 
 Sun, 23 Jun 2019 10:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190621132324.2165-1-mreitz@redhat.com>
In-Reply-To: <20190621132324.2165-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jun 2019 18:18:14 +0100
Message-ID: <CAFEAcA9tPUcZ5BZmasT=GpccGw1EAqMTHRJhsq9cGZjJUhGs=Q@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 0/8] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Jun 2019 at 14:23, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 33d609990621dea6c7d056c86f707b8811320a=
c1:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-06-18 17:00:52 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-06-21
>
> for you to fetch changes up to e2a76186f7948b8b75d1b2b52638de7c2f7f7472:
>
>   iotests: Fix 205 for concurrent runs (2019-06-21 14:40:28 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - The SSH block driver now uses libssh instead of libssh2
> - The VMDK block driver gets read-only support for the seSparse
>   subformat
> - Various fixes
>

Hi; this failed to build on my s390 box:

/home/linux1/qemu/block/ssh.c: In function =E2=80=98check_host_key_knownhos=
ts=E2=80=99:
/home/linux1/qemu/block/ssh.c:367:27: error: implicit declaration of
function =E2=80=98ssh_get_fingerprint_hash=E2=80=99
[-Werror=3Dimplicit-function-declaration]
             fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HASH_SH=
A1,
                           ^
/home/linux1/qemu/block/ssh.c:367:13: error: nested extern declaration
of =E2=80=98ssh_get_fingerprint_hash=E2=80=99 [-Werror=3Dnested-externs]
             fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HASH_SH=
A1,
             ^
/home/linux1/qemu/block/ssh.c:367:25: error: assignment makes pointer
from integer without a cast [-Werror=3Dint-conversion]
             fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HASH_SH=
A1,
                         ^

It looks like that function was introduced in libssh 0.8.3, and this box
has 0.6.3. (configure has correctly not defined HAVE_LIBSSH_0_8
but this usage is inside a bit of code that's compiled even when
that is not defined.)

thanks
-- PMM

