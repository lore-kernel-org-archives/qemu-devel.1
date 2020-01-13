Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF2C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2AE2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W21W8Zym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2AE2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2RG-0007cB-Ep
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ir2PJ-0005p3-QW
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ir2PH-0007eT-GN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:17:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ir2PH-0007dN-C0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578932254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=2RxZKuZt+vHanAK7hlmDsmq7jeFh99krBzlU7r4HNww=;
 b=W21W8ZymcHp1OIOmlU4spbBKi7UAcZ/hvRJKRk84vkg2xAiWt68IO+xwOK1LM4XDHEMeDq
 6dTeoCyKTcc8bTqCU20nYrFeG7crWEKOCsjd7l+ETwnE8opXXjBwBxApDJIU0tKDXd8nCO
 wSWQmRWfJcyU9M1Dwbqk57+065HehZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-8-TtXdXlPWekabF6WBYFDw-1; Mon, 13 Jan 2020 11:17:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00468800D48;
 Mon, 13 Jan 2020 16:17:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-87.ams2.redhat.com [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78CE7843D4;
 Mon, 13 Jan 2020 16:17:26 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] gitlab-ci.yml: Add jobs to build the EDK2 firmware
 binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200107153154.21401-1-philmd@redhat.com>
 <20200107153154.21401-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <383abe53-5286-10b6-0318-47cc62ff5cf0@redhat.com>
Date: Mon, 13 Jan 2020 17:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107153154.21401-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8-TtXdXlPWekabF6WBYFDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 16.31, Philippe Mathieu-Daud=C3=A9 wrote:
> Add two GitLab job to build the EDK2 firmware binaries.
>=20
> The first job build a Docker image with the packages requisite
> to build EDK2, and store this image in the GitLab registry.
> The second job pull the image from the registry and build the
> EDK2 firmware binaries.
>=20
> The docker image is only rebuilt if the GitLab YAML or the
> Dockerfile is updated.
> The second job is only built when the roms/edk2/ submodule is
> updated, when a git-ref starts with 'edk2' or when the last
> commit contains 'EDK2'. The files generated are archived in
> the artifacts.zip file.

Don't you build the EDK2 QEMU binaries in the tianocore CI yet? ...
Feels a little bit weird to build EDK2 as part of the QEMU CI, too...?

> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index ebcef0ebe9..f799246047 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,3 +1,6 @@
> +include:
> +  - local: '/.gitlab-ci-edk2.yml'
> +
>  before_script:
>   - apt-get update -qq
>   - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geni=
soimage
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd2dc137a3..93620ed406 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2358,6 +2358,8 @@ F: roms/edk2
>  F: roms/edk2-*
>  F: tests/data/uefi-boot-images/
>  F: tests/uefi-test-tools/
> +F: .gitlab-ci-edk2.yml
> +F: .gitlab-ci.d/edk2/
> =20
>  Usermode Emulation
>  ------------------
> @@ -2701,7 +2703,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
>  GitLab Continuous Integration
>  M: Thomas Huth <thuth@redhat.com>
>  S: Maintained
> -F: .gitlab-ci.yml
> +F: .gitlab-ci*.yml

I don't think that I want to be responsible for the .gitlab-ci-edk2.yml
file, so could you please drop that hunk from the patch? Thanks.

With that hunk removed, FWIW:

Acked-by: Thomas Huth <thuth@redhat.com>


