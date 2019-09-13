Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E3C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 21:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706C8206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 21:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeZO+LSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706C8206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8t3M-00088p-LE
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 17:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8t2W-0007OF-T2
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8t2V-0006qo-Dd
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:23:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8t2V-0006qH-6h
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:23:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id l16so33286550wrv.12
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h6KM61y6rAjs4cyUPbMtdzjyoGqrT/FFlpAw/2+ZpPA=;
 b=KeZO+LSDGFwqOfpO0fRszsKKuXZOgFM9RdIcm32UgLDy9S3IQXNX0e9zrN/OdPXwJu
 TTvLPx390g8M6NKOV4IvqswVj3Q29KSHQaCclHlQDZ+1YTH1C4/fYi7Kmv52Dy6SHr5g
 plJsE+wxcK3cKc/kl4tiMF61KIGFudyl2VqFrPiZqKfFPvEOFjLldMd6f0ifA+xCAnXT
 aKSdzvdx3tRtKxg36xnCqEElePNSwAx7E+9LDmFuWHPnLJzC06TRQXO9USzvagwDP2a7
 y6j4mjC5MjAvi+5MXx6hinZn7b67/krwNrNjVQk5Ndqfh/xx8YlVachZRmSBcfjQJKeA
 IbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h6KM61y6rAjs4cyUPbMtdzjyoGqrT/FFlpAw/2+ZpPA=;
 b=CmDXvbeqW0xdAWsaXZaVpZm3aGsiVwogdSd2I/sm2kdqEpWpyR9ri7PBm6WbX7JTL6
 Z2GhPH474ysDkHmUVOT63s0p45Z6RkSx6z6snEN+nzPsqNGi54t5onlBtT/SPa32ja2i
 elHHKx5lc08gNuf8wJ2opB5EK0WPef0EPCZ1A1mbrympN5jIBBDqN+KNK7RcGmpeCUwU
 rujv/a3EWePF52+JseMUrzJQ697W0G/Wkx8Wz4EQHgPaXq+SjIItTglvd+ODZA996+tm
 i59rqeh0pgKXimD898JamMKdd8yOLOgF/46nsFLA3NluUm7DRScssppZUF/hNmj9idYY
 N1CQ==
X-Gm-Message-State: APjAAAXNIL+b0ITAqFOFF1sOXlKIpOLZ7ZOWueWU1mSYcnA6olyodpAI
 DjT5ifQ1D1P+zcK9kTmeQGZ7QA==
X-Google-Smtp-Source: APXvYqzHiqLeBHjDNS0hO3+OUK2rmX6UWz5cYht/T7xBl9zx49QeaDjtzGuKuWpBdHwOBNyniX0bPw==
X-Received: by 2002:adf:e947:: with SMTP id m7mr2385825wrn.178.1568409813600; 
 Fri, 13 Sep 2019 14:23:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm54002326wra.70.2019.09.13.14.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 14:23:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 482571FF87;
 Fri, 13 Sep 2019 22:23:32 +0100 (BST)
References: <20190913193821.17756-1-jsnow@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
In-reply-to: <20190913193821.17756-1-jsnow@redhat.com>
Date: Fri, 13 Sep 2019 22:23:32 +0100
Message-ID: <87y2yrao17.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] podman: fix command invocation
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> Oops; there's no argv here.

Oops indeed. Queued to testing/next, thanks.

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/docker.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 29613afd48..bc7a470ca2 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -334,7 +334,7 @@ class Docker(object):
>              cmd =3D [ "-u", str(uid) ] + cmd
>              # podman requires a bit more fiddling
>              if self._command[0] =3D=3D "podman":
> -                argv.insert(0, '--userns=3Dkeep-id')
> +                cmd.insert(0, '--userns=3Dkeep-id')
>
>          ret =3D self._do_check(["run", "--label",
>                               "com.qemu.instance.uuid=3D" + label] + cmd,


--
Alex Benn=C3=A9e

