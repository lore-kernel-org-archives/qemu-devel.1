Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF96CC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F1C2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pelwgNvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F1C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtm2-0004H5-G8
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hgsQI-0003f1-0J
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hgsQG-0005st-02
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:04:21 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1hgsQ5-0005nI-H2; Fri, 28 Jun 2019 11:04:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id l15so6250455otn.9;
 Fri, 28 Jun 2019 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SLWVSstXS2Sofga0QanyOrm+IhhXN9pkZsd/wfQpgOo=;
 b=pelwgNvqYUzDrXr9D6RVTNL5Usgn5RofRo+IPbJINngs5VAGwX7FPTMwi24EIFkTxS
 AIuL+dPeNfFV1nwVUQiXBsF+GeiWE/eKJGHnaouHUiF3wdJh7j7vtujbOCDVAAJ3vjRK
 sdGVvieku/KGXKlUP6QOf5HdhfjuXYeFYRGpxeJzwE0UsOMdnV0j/0kgb8E7Bwn9V1Xd
 Cdfo9QUA2FOmCiSSbDypeY5nxg509Y/jcLR+SxXbCwCToYfpdYm/Q17sBk9WeSCyzRxY
 H9W6vbERlYKmniEW5bTbCWIObgckmhjdVBzTgbvpiwX4PBRT9d+J34TST6dsvG+RDbA2
 nZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SLWVSstXS2Sofga0QanyOrm+IhhXN9pkZsd/wfQpgOo=;
 b=W0AXUK4QN8GYc9UB9rqInFLVkfCam2ezvH8Pgjt64w7LWJm1go7rQaBGDgXOyVvp0n
 C2wf4RfIhoBo1+hMOUtbeKUwfb08N1c3wvnfdbfnP0QD4z7FiJ0MfepP3vEGzdQ7FLVR
 ptCfawzNjfWNWAbqGfR2asNHj4Ojnd7+yD2+NNTdzu+vhZA6pa51/TYBUARhoHSRvRtp
 avT1Rhh3ds0fFJvHWS+JyWJv2/4YFslVI1UjaaNibK632tUxQ7iJ01gChYN0bduHppbc
 kCyz5FgSa2gkBjqotMa2/AnuJmGFIoEfz3dwuqX3WrZzf8IaD2pwuyLxyZeNqtYMrpod
 PK2w==
X-Gm-Message-State: APjAAAUuSPOcpYZBapYYgy79W0OU4GhX7n0hvyVh5I1VcDMypz9JZtJO
 BIXlGoRdfjF+ewym2zTdnxPXM4pgGwtDUCeUvXc=
X-Google-Smtp-Source: APXvYqwG4azZQ9gwztBNx7MTwpdqyGOOV/G48NInC5WHGO6dUpaaEEd98nQvMiZTGc7CCiTBnNrSWTxGF/q6OhS80xg=
X-Received: by 2002:a05:6830:1291:: with SMTP id
 z17mr8861511otp.194.1561734248526; 
 Fri, 28 Jun 2019 08:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <1561727317-30655-1-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1561727317-30655-1-git-send-email-liam.merwick@oracle.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 28 Jun 2019 23:03:32 +0800
Message-ID: <CAKXe6S+iv8ND-+w0DWXq9t61xkNFW2U19fJQTykaV_GXEZy27A@mail.gmail.com>
To: Liam Merwick <liam.merwick@oracle.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] docs/devel/testing: Fix typo in dockerfile
 path
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
Cc: qemu-trivial@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Liam Merwick <liam.merwick@oracle.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:38=E5=86=99=E9=81=93=EF=BC=
=9A

> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  docs/devel/testing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index da2d0fc9646f..3ef50a61db4d 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -327,7 +327,7 @@ Images
>  ------
>
>  Along with many other images, the ``min-glib`` image is defined in a
> Dockerfile
> -in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make
> docker``
> +in ``tests/docker/dockerfiles/``, called ``min-glib.docker``. ``make
> docker``
>  command will list all the available images.
>
>  To add a new image, simply create a new ``.docker`` file under the
> --
> 1.8.3.1
>
>
>
