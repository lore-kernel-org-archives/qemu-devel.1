Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE8C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6895F26544
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6895F26544
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38195 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWcQE-0007Ja-Iz
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 03:57:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWcPD-0006nY-EL
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWcPC-0003np-Dh
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:56:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hWcPA-0003N5-Fj
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:56:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so5400433wmm.2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 00:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=lwD2G415a0u//9k7r7xgkxom1P0YqcZrKoyvUAq6TFk=;
	b=iDXkTL3wtWbJAdDjDTeZB3WKDiJKxhYFKhfd+X3VubxDQEhAXIcDhAt0XwJ1P3prtk
	MEvOOIL+2XTq0wW0zMTe+Dj7ZnKupiD2quZYMAC8pFyyp4+pqazNwWnzw/OZbP3S78wL
	peiKP7VN/2zECSboR5hiKCpEYHFbeX4W72flOw4+aYbLRJ10oIaUxn92yjdF+Hzc5gAr
	cABkfMEUxGWKeGd+FYdvdoAOai/KWozcE19QzOqAoXxxLgWRFX7zzsxZtFpwzc3Af+AC
	aCJNyRfvS01bQwBrwalIoAiWBEDyJPKEi+CzeFqgcMhzJPdSK91mW92Kwh3rDeZS2Mzo
	j8Cw==
X-Gm-Message-State: APjAAAWOOLpwXF0gXL00i47GMnPusoAQgw1Nod21CVKnCclvW5Qs6AK0
	OG/OPKiicCzIHDZpRc28bHKCIQ==
X-Google-Smtp-Source: APXvYqwy87SMjbjL2rHGBfiMWu7ZPt/YjJJYtVZqsjCXeiVzWNMUpoHEKWTjVZXVtJ5RkmzlBYx59g==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr4730486wma.147.1559289401332;
	Fri, 31 May 2019 00:56:41 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253]) by smtp.gmail.com with ESMTPSA id
	v19sm2164612wml.42.2019.05.31.00.56.39
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 00:56:40 -0700 (PDT)
Date: Fri, 31 May 2019 09:56:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190531075638.thjpihktz7zxplvy@steredhat.homenet.telecomitalia.it>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530101603.22254-8-alex.bennee@linaro.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v1 07/26] .travis.yml: bump gcc sanitiser
 job to gcc-9
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
Cc: Fam Zheng <fam@euphon.net>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 11:15:44AM +0100, Alex Bennée wrote:
> The toolchain PPA has it so we might as well use it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index b053a836a32..f0aa37f2d12 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -240,8 +240,8 @@ matrix:
>              - ubuntu-toolchain-r-test
>            packages:
>              # Extra toolchains
> -            - gcc-7
> -            - g++-7
> +            - gcc-9
> +            - g++-9
>              # Build dependencies
>              - libaio-dev
>              - libattr1-dev
> @@ -270,11 +270,11 @@ matrix:
>        language: generic
>        compiler: none
>        env:
> -        - COMPILER_NAME=gcc CXX=g++-7 CC=gcc-7
> -        - CONFIG="--cc=gcc-7 --cxx=g++-7 --disable-pie --disable-linux-user"
> +        - COMPILER_NAME=gcc CXX=g++-9 CC=gcc-9
> +        - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-pie --disable-linux-user"
>          - TEST_CMD=""
>        before_script:
> -        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
> +        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
>  

What about describing in the commit message that we are adding
'-Wno-error=stringop-truncation' in the cflags?

Thanks,
Stefano

