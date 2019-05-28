Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316ABC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0486A2075C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0486A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVeAk-0005dE-Aj
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 11:37:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVe9r-0005Aa-BH
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVe9q-0000ys-96
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:36:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVe9p-0000uW-T5
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:36:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id 15so3374414wmg.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 08:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=jmrJ3+pWJQ4Cnycl/vsrl5puQfhaEuR6ULhpMdeB+Pg=;
	b=NztpJG89CvbEkwnYmhzKmJUWd70mO3zxkjSX1qYBZyBNhsl4HhXXWS2p4RWyJIucu7
	c2ZNYRTI4tkII6E0PeUeR/IyDdhvANNksdB15A/LinDO+ykYBh4OX7EF0N/4Bt5s5Wcy
	feiPQuaowTwnpgvSyKMRWHMgxIhSo6on50nYOCt2tbVqk5TOZtw9ZD/sPN4N7oxOMblM
	aJKFGoyh50tEHekqLFhUjfG1KbYR2BhsYEhnhZzPw9iPSHwzseu7sJ/oRadeJAb78Qcc
	P2oc9zXEuergh7LM/c7Pq1qPNmBVsIMrwP4y6B63U023lCmqrk+PPmVYqAD51XTjO1V+
	Hf7g==
X-Gm-Message-State: APjAAAWr2G5o7GF5nLV9BpAQoi3kh0NvN0xnurS+Qp7e80izQb0ehn5P
	K4AUR7gpI+5eWT9hucR18a+yJg==
X-Google-Smtp-Source: APXvYqyi7NrKuuxT2YoTBlwXsjlZcVU41AoDH3PMqSvxN+gh8wJL8eW9Lh4Le7EuSh4I7Vi85eJWZQ==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr3496333wmc.98.1559057816292; 
	Tue, 28 May 2019 08:36:56 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	x6sm20212085wru.36.2019.05.28.08.36.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 08:36:55 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190528153304.27157-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eb44b164-aabe-d072-b2a8-392bdb37dc7e@redhat.com>
Date: Tue, 28 May 2019 17:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528153304.27157-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2] tests/docker: Update the Fedora image
 to Fedora 30
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Michael/Igor/Stefan about git comment format.

On 5/28/19 5:33 PM, Philippe Mathieu-Daudé wrote:
> Fedora 30 got released:
> 
>   https://fedoramagazine.org/announcing-fedora-30/
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2: Added Marc-André and Stefano tags

^ This is my local commit

> ---

^ This line was added by git publish via format-patch

Michael is that what break your patch workflow?

>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 69d4a7f5d7..1496b68ba1 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,4 +1,4 @@
> -FROM fedora:29
> +FROM fedora:30
>  ENV PACKAGES \
>      bc \
>      bison \
> 

