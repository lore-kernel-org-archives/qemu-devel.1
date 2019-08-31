Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEFAC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 15:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7546621874
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZBpb0uB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7546621874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i45hg-00075D-Jl
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 11:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1i45gs-0006dX-Vo
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1i45gr-0000O5-IF
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:53:26 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1i45gr-0000Ne-CE
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:53:25 -0400
Received: by mail-ot1-x343.google.com with SMTP id o101so9777171ota.8
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Opso9VDvjtSmuXcBakFZZrI2Cpx2O8yEEuOrz93gILM=;
 b=XZBpb0uBc58JdcLD/2cuAM8SG+QzdzD4o4V9WL6UnvlfBaFiphsgpXSdp5wMcDcxAl
 aLQuQkwmvTOTzfVYVVilUwTWgwQ5SP2pW/I98S5gYxdHSrJZZWRepc/bwSn4GQY0xbv+
 5z2LDiSSXnQsIVk1JPQSJcpQ+VUmx6WyruzUp7z/Am50Wo/KGJVGYxkjJZiHRpALNtSn
 UDFJ8Z+UJMWRlM+FNIt3PKx2+WBZUgabbLN567pyE0EPLnJF962YWLtzZLby2sTjxhBE
 swMrHi0QiBJrbES8p9P4vqcpAgN8/lS8K7PUe/kzFDd0CqNk+1Jd9GaoE7KRCFOhf0BN
 CyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Opso9VDvjtSmuXcBakFZZrI2Cpx2O8yEEuOrz93gILM=;
 b=MXzbh55KwbsZOIQEl3JFbHopmq6BOrw0KLIxpUtKI19MQuKja11qMKjD8OiEVJzBJ1
 7rcIprDHI8JnWkx3atwZMMkARW+J51GeXAGvhCyXDosUTPLhY64a31QbbhcPnA5HiPrF
 6bZVsAsCnQA/X5QN528Y/gmcGxaMfYca5jTmDMd6SfoLpXlmE09lvT06S4S0gw3KfZj+
 MBTF45NdnZvwDF1XEffAMJMrpE/ShV161CMCa9LcIG3W3a5OVVjZEhUzdG9zwXoJ/+7J
 k4Nx3bO0pZGlxRaOFd9/D5Kx1c+tWU5zNSBA4UZbAxTJ3HjYFQUe8yYQUPgU6NPZ+rEz
 Nlqg==
X-Gm-Message-State: APjAAAXLvehiVLKLpaie8JGqnhzoHf3cWSZqe9aNYwy9r0FnSW4BR4G1
 VV9DHehwLeiCVlLigrCRlYlbRr8OmNaudCPVqf81sVEq8jjLtg==
X-Google-Smtp-Source: APXvYqx1GVCupi9Ex5DE4+dlH6wIR2VtmJHz2I8XDhTkm9WigMGBIOXk3st4RQgz/l78P0Mt+6e5gGg15gtfye7WAF4=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr16386583otq.181.1567266803939; 
 Sat, 31 Aug 2019 08:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190831153922.121308-1-liq3ea@163.com>
 <156726640099.4971.12196429235488580695@5dec9699b7de>
In-Reply-To: <156726640099.4971.12196429235488580695@5dec9699b7de>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 31 Aug 2019 23:52:47 +0800
Message-ID: <CAKXe6SKO60x5MGW22iDQuKh=JLByQVULJpwD+0DffpzeG231xw@mail.gmail.com>
To: Qemu Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] vnc: fix memory leak when vnc disconnect
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
Cc: Ying Fang <fangying1@huawei.com>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<no-reply@patchew.org> =E4=BA=8E2019=E5=B9=B48=E6=9C=8831=E6=97=A5=E5=91=A8=
=E5=85=AD =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=93=EF=BC=9A

> Patchew URL:
> https://patchew.org/QEMU/20190831153922.121308-1-liq3ea@163.com/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>
> Type: series
> Message-id: 20190831153922.121308-1-liq3ea@163.com
> Subject: [Qemu-devel] [PATCH] vnc: fix memory leak when vnc disconnect
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> fb52b49 vnc: fix memory leak when vnc disconnect
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> ERROR: spaces required around that '*' (ctx:WxB)
> #118: FILE: ui/vnc-enc-tight.c:355:
> +        data =3D (uint##bpp##_t *)vs->tight->tight.buffer;              =
  \
>                                ^
>
>

Hello Paolo and the Checkpatch maintainers,

I also see this error in scripts/checkpatch.pl.
However when I add sapces around '*". I got following error:

ERROR: space prohibited before that close parenthesis ')'

#124: FILE: ui/vnc-enc-tight.c:355:

+        data =3D (uint##bpp##_t * )vs->tight->tight.buffer;               =
\



So I'm confused how to make checkpatch.pl happy.


Any one has suggests? Or we need a patch for checkpatch.pl?



Thanks,

Li Qiang






> total: 1 errors, 0 warnings, 869 lines checked
>
> Commit fb52b492757a (vnc: fix memory leak when vnc disconnect) has style
> problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 1
>
>
> The full log is available at
>
> http://patchew.org/logs/20190831153922.121308-1-liq3ea@163.com/testing.ch=
eckpatch/?type=3Dmessage
> .
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
