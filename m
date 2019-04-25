Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF76C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9747F20679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9747F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56979 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeEB-0008SI-TZ
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:15:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJeCw-0007kN-U5
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJeCv-0005M6-1t
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:14:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJeCu-0005LO-S6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:14:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so195357wmc.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=x0FrXQQ1Nr1IMkCWJWAO95PWEZEMSCqzHfvpOBRPIlk=;
	b=FaVVijvhvhDMLhyKuSL/DLY/tPoeTbnVR90P2W+bESoJLNPqUEsxb0GUTWUGjJ94MH
	wqQ9YOmFQVFIMu97TT3SLkCGXQU7+RwqY3h3YYAYA09IdAdiCyUF7p1pCnoYUVsuIgFt
	KMxv7vsi8YjqUDdlr5u/z1yE1EooalIRNviNWVRb40Mhlir1b624lA805opSfld0mMif
	LAIAKNqj9CEFMcp/cbNBos5nALPauF24ScDRMg5n+zwcY12HkaUQ+AxiB6zDugopQUxu
	/a3ormYHmHPufsk6+xZyplsJ03hmuGUSzBXBYm3yBQX2xzrJV5vXCaeJ/PC9eXsoJgqk
	5LXQ==
X-Gm-Message-State: APjAAAV9krXo9cEA6oXpOrSrin/WYgMBqUiBPKHjUoyx2qI6UlRl/9yn
	KJrXwudYrRa0pqUb5Kfl3kJ2xA==
X-Google-Smtp-Source: APXvYqzYsUqS2w7jtYcnQ6xJACCKDgPaZKrn4hHY4dUKfEKnKFQkwOyVuw4vgZLThim4cRpPybGfYA==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr1819227wmb.65.1556198071781; 
	Thu, 25 Apr 2019 06:14:31 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	d18sm5662479wrx.56.2019.04.25.06.14.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 06:14:31 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190425125650.28846-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e06ee86a-b1bf-6d4b-6a43-f349925787b1@redhat.com>
Date: Thu, 25 Apr 2019 15:14:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425125650.28846-1-stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] gitmodules: use qemu.org git mirrors
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425131429.G8FvB-5xh7LEiNWwBR7yLHjM0MO1EDI0FVvXBxCO4gw@z>

Hi Stefan,

On 4/25/19 2:56 PM, Stefan Hajnoczi wrote:
> qemu.org hosts git repository mirrors of all submodules.  Update
> .gitmodules to use the mirrors and not the upstream repositories.
> 
> Mirroring upstream repositories ensures that QEMU continues to build
> even when upstream repositories are deleted or temporarily offline.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Based-on: <20190424110041.8175-1-marcandre.lureau@redhat.com>
>           "[PATCH v2 0/2] slirp: move slirp as git submodule project"
> 
> Peter: Please apply Marc-André's series.  I have set up the necessary
> mirrors and this patch will fix up the libsirp URL as well as the
> other URLs.
> 
>  .gitmodules | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/.gitmodules b/.gitmodules
> index aa77ce6f50..84b260031c 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -39,19 +39,19 @@
>  	url = https://git.qemu.org/git/capstone.git
>  [submodule "roms/seabios-hppa"]
>  	path = roms/seabios-hppa
> -	url = https://github.com/hdeller/seabios-hppa.git
> +	url = https://git.qemu.org/git/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>  	path = roms/u-boot-sam460ex
>  	url = https://git.qemu.org/git/u-boot-sam460ex.git
>  [submodule "tests/fp/berkeley-testfloat-3"]
>  	path = tests/fp/berkeley-testfloat-3
> -	url = https://github.com/cota/berkeley-testfloat-3
> +	url = https://git.qemu.org/git/berkeley-testfloat-3.git
>  [submodule "tests/fp/berkeley-softfloat-3"]
>  	path = tests/fp/berkeley-softfloat-3
> -	url = https://github.com/cota/berkeley-softfloat-3
> +	url = https://git.qemu.org/git/berkeley-softfloat-3.git
>  [submodule "roms/edk2"]
>  	path = roms/edk2
> -	url = https://github.com/tianocore/edk2.git
> +	url = https://git.qemu.org/git/tianocore/edk2.git

I'm getting:

Entering 'roms/edk2'
fatal: repository 'https://git.qemu.org/git/tianocore/edk2.git/' not found

OK, got it, the correct URL is https://git.qemu.org/git/edk2.git
(without 'tianocore')

With the URL or the path locally updated:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  [submodule "slirp"]
>  	path = slirp
> -	url = https://gitlab.freedesktop.org/slirp/libslirp.git
> +	url = https://git.qemu.org/git/libslirp.git
> 

