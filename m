Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77985C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43ECD2085A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43ECD2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLr28-0001QP-Fg
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:20:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr01-0000Q9-A6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLqzy-000616-9K
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:18:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLqzy-0005zz-3K
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:18:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so24909763wrs.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5ml9Ah/j1vtN0YZA6csZ4BTES07TKC11dEUWCs/2Yr0=;
	b=WyQohDzXvK2ttpog0ESn0bIoVPk6zvEzUmlAD6w0Dg1xz5VczoGLgo93BuESpTUXHI
	QrbCebRCuvgFmPIukzhfXxpwAm5yrZnkIoTEqheJ793fg8ztGef8K/9b8D05e7OB8VnH
	NzubmREe/yKPAG071ICT6pIOPOHuTAqBESwdMjRG5QEC63BsPJUtUbYWRsuSN529Wy6u
	KW2E0zuTzDftMBPKAsLTjCsZcSlBMwjngxbvd9ZO2a6CS55jQXuM0w2uLAw4AV8xEXeZ
	CLXqAwnxY8GHGnBQWFTJ5WyyBBe4r6Q5R+OMmeQqeTxf/YyZnRES5xQQRoKVJgo6XQFz
	GE1g==
X-Gm-Message-State: APjAAAVNSGiihKHGVigY7JmWKLBWGqIhowNK+KHu5A+xcoAMh+rJvxbH
	gUe3GZIEdaYK64r3cxHyjPEgTg==
X-Google-Smtp-Source: APXvYqxngw8rbtqz7BhtfwIEogAXz4ZyI3ihtX5QNnbZJAFOp5iacWcUdTO7rruVEjqdOlr6ZdoF6A==
X-Received: by 2002:adf:f98f:: with SMTP id f15mr16280686wrr.10.1556723895231; 
	Wed, 01 May 2019 08:18:15 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id u17sm4067723wmj.1.2019.05.01.08.18.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 08:18:14 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b361f969-413b-baa1-4d98-474bf1d7aa57@redhat.com>
Date: Wed, 1 May 2019 17:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428155451.15653-4-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 3/8] tests/qemu-iotests/check: Pick a
 default machine if necessary
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
Message-ID: <20190501151813.zho_4vMES1QmUK5lI8ZIm-YI2Tcj7CTndYpgm2qVgHs@z>

On 4/28/19 5:54 PM, Thomas Huth wrote:
> qemu-system-arm, qemu-system-aarch64 and qemu-system-tricore do not have
> a default machine, so when running the qemu-iotests with such a binary,
> lots of tests are failing. Fix it by picking a default machine in the
> "check" script instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/qemu-iotests/check | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f9c24b6753..922c5d1d3d 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -130,7 +130,6 @@ export CACHEMODE="writeback"
>  export QEMU_IO_OPTIONS=""
>  export QEMU_IO_OPTIONS_NO_FMT=""
>  export CACHEMODE_IS_DEFAULT=true
> -export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
>  export VALGRIND_QEMU=
>  export IMGKEYSECRET=
>  export IMGOPTSSYNTAX=false
> @@ -564,6 +563,18 @@ then
>  fi
>  export QEMU_PROG="$(type -p "$QEMU_PROG")"
>  
> +case "$QEMU_PROG" in
> +    *qemu-system-arm|*qemu-system-aarch64)
> +        export QEMU_OPTIONS="-nodefaults -machine virt,accel=qtest"
> +        ;;
> +    *qemu-system-tricore)
> +        export QEMU_OPTIONS="-nodefaults -machine tricore_testboard,accel=qtest"
> +        ;;
> +    *)
> +        export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
> +        ;;
> +esac
> +
>  if [ -z "$QEMU_IMG_PROG" ]; then
>      if [ -x "$build_iotests/qemu-img" ]; then
>          export QEMU_IMG_PROG="$build_iotests/qemu-img"
> 

