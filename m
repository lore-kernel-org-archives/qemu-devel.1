Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC8CC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34255217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34255217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD6Ap-0000C5-9d
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iD69f-0008Ao-23
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iD69d-00074f-SH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iD69d-00074T-FW
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:12:21 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96B9F88305
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 12:12:20 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id q10so2266463wro.22
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qbUTHVHy/QP37Ucf1GaIkawS8nmIz1PUwsyVcGv0CUo=;
 b=lIH/YeLiaLf7i/mIXy3Hvf0H/b43UZpMubHlUlQH+dmhPbQlUJQJxtm+ZL8U7sddLs
 JzAhT9QSd4rzbxsQKgDbmW4R1RgFSWBG7ZvjAYWuyMJ/RhQ8Dj1nuEOc63c8G/Lq24PX
 o02ad8NXPITnr24h8hXi9F+rZcdh0YmQG71+1OnqlTt1MxWGEEzYoUoEjYKGsGrFI9vR
 NefpEjxUsKimXWUHa5FVJx54zGjUofIAqHYVR4gTzM/AcKcqI8/qUMdyKt6pwgsx2PiQ
 rpuTWPOB6k8GnVq+zS/b2KzBKCpXLvKHbilO4MdPDM7zm3FHf/hwSHZvc09vraKFqASR
 tNfQ==
X-Gm-Message-State: APjAAAWYUYYwiKvKrv4CvfE2oYQC/00l5yeTGTuuRKtYS35X1x94WfiC
 rLqI9ZUTVODdIORI2vK7NeyBq0E1kMTQjmJRpH6aOYY+onuu3sZ48T9BY/hMjxZlqlislzV1/y5
 pw6r6fLC+TSsaoqM=
X-Received: by 2002:a1c:c104:: with SMTP id r4mr7873066wmf.64.1569413538871;
 Wed, 25 Sep 2019 05:12:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwylvo99C/kRkR6dYR+EHbYRsUSZXI9fjR2ywxbmT5RXnjKr3JCzMnzDUAwEiPw//vnlDwHSg==
X-Received: by 2002:a1c:c104:: with SMTP id r4mr7873052wmf.64.1569413538688;
 Wed, 25 Sep 2019 05:12:18 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id q19sm8516503wra.89.2019.09.25.05.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 05:12:17 -0700 (PDT)
Subject: Re: [PATCH] docker: fix uid maping with podman
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <4b9204cc8ade1c965dc5412c53c6f7c5b4f019a2.1569413332.git.tgolembi@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1a0ce8c0-123d-6f5b-fbcd-035cc383d611@redhat.com>
Date: Wed, 25 Sep 2019 14:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4b9204cc8ade1c965dc5412c53c6f7c5b4f019a2.1569413332.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 2:09 PM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> Commit 71ebbe09 refactored how uid mapping is performed when invoking
> container. It however introduced a bug in the flow when podman is used
> caused by wrong variable name.

Thanks Tom=C3=A1=C5=A1, but there is already a fix for this on the list:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg647275.html

>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  tests/docker/docker.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
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
> =20
>          ret =3D self._do_check(["run", "--label",
>                               "com.qemu.instance.uuid=3D" + label] + cm=
d,
>=20

