Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FCDCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5522080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5522080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhYe-0004wv-UN
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRhY0-0004UM-Po
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRhXy-0003Xe-SI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:57:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRhXy-0003WM-4A
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:57:50 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04D2887638
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 18:57:48 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id y3so3933314wrm.12
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:57:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9f/J3as5YH8+eaHzctuyCRdELM9Hy1KZc7qoW69FGAU=;
 b=o1U3WI1tWr8i3RAwVANuVnC2xHllFfPKRPF7o0NTgYsJ1kSLaElOOC1tfOkQeLT4x4
 ksxD7W5lTF9+OVIcjOF/W8sMn00IKVKRhk2NG8P7vVW9Lj7alQdkBJvVSEoxwAO8b4EH
 JD/P3j8rz+dQsZH4E1q0GdnS6Fe9ENH8l/a6A2t6kXAImst1TUq2g1fYgpWzkH9XN51d
 I+OrAKsca+z6DbTVPtjkeCaHXoWFBqkwqKDLweSzgXDbB2TNmlo99B3zlQHufFfJjXBe
 6xuOA6Odk0POYtXcplljOlaSzdCFTBJuKjGFOrobTrgm3S44P6TNth5F0hQxL+dAYifw
 iERA==
X-Gm-Message-State: APjAAAVsRfa0JpgZLlQ9zyYU1H9pdtys18G014SkskjyRi2UF7DdwYxM
 75t4ZVP0YOSDpYhzKh50l/hakBL0gXqMkzjYQT7+jK8DKmPicCGPQ+7zPIV8XCpQpB/IvnyLxAb
 /VPT//crUjB5O0PQ=
X-Received: by 2002:a05:600c:22cb:: with SMTP id
 11mr502104wmg.117.1572893866757; 
 Mon, 04 Nov 2019 10:57:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGxwBER/GpVouGRHgeFaEvnhJ63M2A8iLyfE8Bu0qN5TJpH+cMY2x22dZtxgQxWjWDJ1FrsQ==
X-Received: by 2002:a05:600c:22cb:: with SMTP id
 11mr502070wmg.117.1572893866534; 
 Mon, 04 Nov 2019 10:57:46 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id i71sm23941132wri.68.2019.11.04.10.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:57:45 -0800 (PST)
Subject: Re: [PATCH v1 1/6] tests/vm: netbsd autoinstall, using serial console
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bdfdd76b-464a-eae9-b2de-0f939adf8b24@redhat.com>
Date: Mon, 4 Nov 2019 19:57:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104173654.30125-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 Kamil Rytarowski <n54@gmx.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 6:36 PM, Alex Benn=C3=A9e wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Instead of fetching the prebuilt image from patchew download the instal=
l
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.

It would be nice to be able to mount some host directory as target=20
ccachedir and use ccache within the VM.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> [ehabkost: rebased to latest qemu.git master]
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Message-Id: <20191031085306.28888-2-kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/netbsd | 189 +++++++++++++++++++++++++++++++++++++++++++++--=
-
>   1 file changed, 179 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 18aa56ae826..5e04dcd9b16 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -2,10 +2,11 @@
>   #
>   # NetBSD VM image
>   #
> -# Copyright 2017 Red Hat Inc.
> +# Copyright 2017-2019 Red Hat Inc.
>   #
>   # Authors:
>   #  Fam Zheng <famz@redhat.com>
> +#  Gerd Hoffmann <kraxel@redhat.com>
>   #
>   # This code is licensed under the GPL version 2 or later.  See
>   # the COPYING file in the top-level directory.
> @@ -13,20 +14,53 @@
>  =20
>   import os
>   import sys
> +import time
>   import subprocess
>   import basevm
>  =20
>   class NetBSDVM(basevm.BaseVM):
>       name =3D "netbsd"
>       arch =3D "x86_64"
> +
> +    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetB=
SD-8.0-amd64.iso"
> +    size =3D "20G"
> +    pkgs =3D [
> +        # tools
> +        "git-base",
> +        "pkgconf",
> +        "xz",
> +        "python37",
> +
> +        # gnu tools
> +        "bash",
> +        "gmake",
> +        "gsed",
> +        "flex", "bison",
> +
> +        # libs: crypto
> +        "gnutls",
> +
> +        # libs: images
> +        "jpeg",
> +        "png",
> +
> +	# libs: ui
> +        "SDL2",
> +        "gtk3+",
> +        "libxkbcommon",
> +    ]
[...]

