Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233FC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C9521924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C9521924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAv0C-0007Yg-Fn
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAuyT-0005tT-2a
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAuiP-0007CV-8h
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAuiP-0007C9-0x
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:35:13 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC974806CD
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 11:35:11 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id z17so910094wru.13
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AHLdMWn2aXs8m9cRDOdIn6AU4fbNMy64SbmMF2Vrkz8=;
 b=s778i8sNKIAW20UElSBI7nlJXUZnNFKikq4oo4ZNvm31i0Jh1K3kJOC4K/dlht9IiZ
 K+hLI7+eg+yczPC2zIRM0mT7NNsGMsk5N/xXGpwlHa78eNSzu3whNZJLdz4faOVUcfb5
 w+hFQb6bcTNMi5lash9ptXamvzZ7x84Va5Wfvot8OjfAIWeBZztmvM35jG2TZMs9c9rW
 sZN3BLG/2vy3GVbSE6nOQ1pKqZClAPRlngSdzY41bNDN4lnWqRY3uoeVSaNRld83i+QS
 NnNRGgI7GildlsppXQNv1nVy6PwL8TJln/fKwA1WnI13iAJcoTLt0fw7PfZAA07Ax1jG
 76mg==
X-Gm-Message-State: APjAAAXaip37lleOtxUGmFNzrVgPU9xCwuEd72i+iyN11nBNw4xWC8Pb
 j0fPmkrckZZNTn5obDA8pHX3QnAr4FGfhkD2tvviLWg3VXqBXCZUXqdgqPb9wOc57koL84y9tX5
 FRv40tzBYlt90X8s=
X-Received: by 2002:a05:600c:351:: with SMTP id
 u17mr2430367wmd.1.1568892910472; 
 Thu, 19 Sep 2019 04:35:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZ6QDophaFvxjAjJ4tdmtr9m7NvXjA1RBTFqDusBPk18Y45Bdz1GJ4i82IBxZOLUyUrszlWQ==
X-Received: by 2002:a05:600c:351:: with SMTP id
 u17mr2430347wmd.1.1568892910278; 
 Thu, 19 Sep 2019 04:35:10 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c132sm7638387wme.27.2019.09.19.04.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:35:09 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190919105932.19412-1-philmd@redhat.com>
 <20190919105932.19412-2-philmd@redhat.com> <87pnjwzfra.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8cccc320-c7f6-599f-de3c-c4c7d6a319d9@redhat.com>
Date: Thu, 19 Sep 2019 13:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87pnjwzfra.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/docker: Add
 fedora-win10sdk-cross image
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Lucian Petrut <lpetrut@cloudbasesolutions.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Justin Terry <juterry@microsoft.com>,
 Ilias Maratos <i.maratos@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 1:28 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  tests/docker/Makefile.include                 |  1 +
>>  .../dockerfiles/fedora-win10sdk-cross.docker  | 21 ++++++++++++++++++=
+
>>  2 files changed, 22 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.doc=
ker
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inc=
lude
>> index 50a400b573..0df72a810b 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -125,6 +125,7 @@ docker-image-debian-ppc64-cross: docker-image-debi=
an10
>>  docker-image-debian-riscv64-cross: docker-image-debian10
>>  docker-image-debian-sh4-cross: docker-image-debian10
>>  docker-image-debian-sparc64-cross: docker-image-debian10
>> +docker-image-fedora-win10sdk-cross: docker-image-fedora
>>
>>  docker-image-travis: NOUSER=3D1
>>
>> diff --git a/tests/docker/dockerfiles/fedora-win10sdk-cross.docker b/t=
ests/docker/dockerfiles/fedora-win10sdk-cross.docker
>> new file mode 100644
>> index 0000000000..1aafdad483
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
>> @@ -0,0 +1,21 @@
>> +#
>> +# Docker MinGW64 cross-compiler target with WHPX header installed
>> +#
>> +# This docker target builds on the Fedora 30 base image.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +FROM qemu:fedora
>> +
>> +# Install headers extracted by the Android folks from the win10sdk.is=
o:
>> +# https://developer.microsoft.com/en-us/windows/downloads/windows-10-=
sdk
>> +ENV WIN10SDK_INCDIR /usr/local/include/win10sdk
>> +RUN mkdir ${WIN10SDK_INCDIR} && \
>> +    for hdr in WinHvEmulation.h WinHvPlatformDefs.h WinHvPlatform.h; =
do \
>> +        curl -s "https://android.googlesource.com/platform/prebuilts/=
gcc/linux-x86/host/x86_64-w64-mingw32-4.8/+/1bde9c3b14f3a3b081ada6e32da9f=
2870671b46f/x86_64-w64-mingw32/include/${hdr}?format=3DTEXT" | base64 --d=
ecode > ${WIN10SDK_INCDIR}/${hdr}; \
>> +    done
>=20
> Hmm I guess this is a stable URL as Google never deletes anything?

This is not ideal indeed, but way less painful than using the msiextract
tools (and much quicker, the win10sdk.iso is >800MiB).

I dunno about the license issue, this file has "Copyright (c) Microsoft
Corporation.  All rights reserved." but we are not storing its content.

>> +
>> +ENV QEMU_CONFIGURE_OPTS ${QEMU_CONFIGURE_OPTS} \
>> +    --cross-prefix=3Dx86_64-w64-mingw32- \
>> +    --extra-cflags=3D"-I ${WIN10SDK_INCDIR}" --disable-werror \
>> +    --enable-hax --enable-whpx
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20

