Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B25C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 21:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99EE20811
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 21:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99EE20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJPhe-0007wH-5y
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 17:45:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJPeE-00056A-Uy
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 17:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJPSj-00017Y-Vm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 17:29:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>)
	id 1hJPSi-00015d-DO; Wed, 24 Apr 2019 17:29:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0126AC071896;
	Wed, 24 Apr 2019 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-118.rdu2.redhat.com
	[10.10.122.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E791600C1;
	Wed, 24 Apr 2019 21:29:44 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-5-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
Date: Wed, 24 Apr 2019 18:29:43 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190424103747.10173-5-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 24 Apr 2019 21:29:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/6] cirrus / travis: Add gnu-sed and bash
 for macOS and FreeBSD
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424212943.Vc_h6vbvJokJcAdZGkx-e6qdz5tSyrhgl1BSUJdfInc@z>

Hello Thomas,

On 04/24/2019 07:37 AM, Thomas Huth wrote:
> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .cirrus.yml | 4 ++--
>   .travis.yml | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)

It needs to get the Freebsd image [1] updated too, in order to `make 
BUILD_TARGET=check vm-build-freebsd` passes. Here it failed with:
---
env: bash: No such file or directory
gmake: *** [/var/tmp/qemu-test.6OlDFH/tests/Makefile.include:1101: 
check-tests/qemu-iotests-quick.sh] Error 1
gmake: *** Waiting for unfinished jobs....
---

I'm not sure about the netbsd and openbsd images, they might need bash 
and gnu-sed as well.

[1] http://download.patchew.org/freebsd-11.1-amd64.img.xz

- Wainer

>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 47ef5bc604..8326a3a4b1 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -7,7 +7,7 @@ freebsd_12_task:
>       cpu: 8
>       memory: 8G
>     install_script: pkg install -y
> -    bison curl cyrus-sasl git glib gmake gnutls
> +    bash bison curl cyrus-sasl git glib gmake gnutls gsed
>       nettle perl5 pixman pkgconf png usbredir
>     script:
>       - mkdir build
> @@ -20,7 +20,7 @@ macos_task:
>     osx_instance:
>       image: mojave-base
>     install_script:
> -    - brew install pkg-config python glib pixman make sdl2
> +    - brew install pkg-config python gnu-sed glib pixman make sdl2
>     script:
>       - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
>       - gmake -j$(sysctl -n hw.ncpu)
> diff --git a/.travis.yml b/.travis.yml
> index 2e06aee9d0..ba94644192 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -42,6 +42,7 @@ addons:
>       packages:
>         - glib
>         - pixman
> +      - gnu-sed
>   
>   
>   # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu


