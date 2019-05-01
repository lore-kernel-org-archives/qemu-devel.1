Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B08C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A2D2085A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A2D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLr29-0001TQ-Kl
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:20:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr0o-0000m0-CM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr0l-0006Mz-BM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:19:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLr0l-0006MW-4r
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:19:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so24914414wrt.8
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4CRwk97uNl3ahFEgh3mZBs+31QeoD8jtKznudMHdODE=;
	b=Hnq7okpVl3H5pvn+4d9agE1M3uUBVD0CaSyqmzhTjjEoH5k/BOBshfuN20X9/9iygG
	MMzwl/n6CsVAPfsxB4o5Tukaw7vMvES/ixYG/dGJduON9NFPV8//EwbBoO92qutbSKlr
	FNZLP+GepOskKWWs9z2naaAmZBwJf1PedHRKZoRA9CFKxTNIRW1flglY8YudDQlFDhHu
	juilpIwHreF1pEUd2XSWFfhTSo20aotNh1mMFZ38d9SAVLYO4lvxunCoWsUQoLGlP0rG
	cYTjRowy3YFWCjfpOLAmfFRWCyl6HvM2w4RS0vxPb2uRPExrLDQe7Rr+ixZk77saMR0W
	W/aw==
X-Gm-Message-State: APjAAAVkdGFLPLYsaftdFJqi3GTZ+P7comUsLdE+XwUgpvOc4HJdkKTI
	dSp3le8gAaQmy6uPzz27GtCNIQ==
X-Google-Smtp-Source: APXvYqxUHzSv1UR/DTvQy4WD6GviChQ++ba5/YC22YyleilHmu+pdQgvXUHHV4j9m8p1LOG9vdbgeQ==
X-Received: by 2002:adf:8567:: with SMTP id 94mr4645645wrh.286.1556723946140; 
	Wed, 01 May 2019 08:19:06 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v5sm11694098wra.83.2019.05.01.08.19.04
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 08:19:05 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1ced40c7-a81f-eb9c-2cd6-9682f80e09aa@redhat.com>
Date: Wed, 1 May 2019 17:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428155451.15653-6-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 5/8] cirrus / travis: Add gnu-sed and
 bash for macOS and FreeBSD
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
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501151904.384lrz55FgEliPBfdgBEcMrpcNND62YJBvudGqFMgAs@z>

On 4/28/19 5:54 PM, Thomas Huth wrote:
> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  .cirrus.yml | 4 ++--
>  .travis.yml | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 47ef5bc604..8326a3a4b1 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -7,7 +7,7 @@ freebsd_12_task:
>      cpu: 8
>      memory: 8G
>    install_script: pkg install -y
> -    bison curl cyrus-sasl git glib gmake gnutls
> +    bash bison curl cyrus-sasl git glib gmake gnutls gsed
>      nettle perl5 pixman pkgconf png usbredir
>    script:
>      - mkdir build
> @@ -20,7 +20,7 @@ macos_task:
>    osx_instance:
>      image: mojave-base
>    install_script:
> -    - brew install pkg-config python glib pixman make sdl2
> +    - brew install pkg-config python gnu-sed glib pixman make sdl2
>    script:
>      - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
> diff --git a/.travis.yml b/.travis.yml
> index 2e06aee9d0..ba94644192 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -42,6 +42,7 @@ addons:
>      packages:
>        - glib
>        - pixman
> +      - gnu-sed
>  
>  
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
> 

