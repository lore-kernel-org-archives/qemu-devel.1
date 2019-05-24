Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6479C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6F0217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6F0217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4qx-0006ei-B2
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:42:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4po-000675-9N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4pn-0004jH-3T
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:41:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU4pm-0004ij-U3
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:41:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id e2so111888wrv.6
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 00:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+BuB5NQi2KAU8VgbSCJgZYp19P0mdLwuzhV7Feo8hXU=;
	b=cSSoVkrnCB4bCjG9bZdVckm/Qth8ycDeA1x8gRNvtJn0q7GrGw4y1Xxhee8bRDlVqF
	ncghlcAnnCXm1GoEoqHaH02ZcZgd7q72MDGKLfSrVnfzZJgiBLCVHdp9m1yPWDNXUIfE
	OIwBg9bfKGFXdlSEAY18A67RnRfy1rO3+TPuGjjPyk1k4dtoWJZS4vQgNMiWtIsu1mwq
	qFu0pKEWvF+AEyk5Mncd0ZFkshH9dP9RWdidLQAkx+76BmXFv0GtDgSpBW3tDT3nzDUY
	n6fZXa+PUva2mj+M672zIoeuC+eDn9JKRbBceVLd9nFBtVOHajoMQHheB4fZAg4Ve58r
	/trg==
X-Gm-Message-State: APjAAAUrM7xZLZkVWOCGPdd7fXq/qJjmUGipQDnRVvdW5/O4QLLeq3nH
	J3asTm+wgXMRy7RSykTY2VbyHA==
X-Google-Smtp-Source: APXvYqz+yDDqreHsbrE2kPrCWgtIDj13TCZZQ7kkcq7PvlPPTyiuIzLiziMHdOhZ57VWj5OGH9RKvw==
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr37021591wrt.217.1558683705908; 
	Fri, 24 May 2019 00:41:45 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	z202sm3273991wmc.18.2019.05.24.00.41.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 00:41:45 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
	<20190523234011.583-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e0cf3112-62f6-aaff-0821-f472297dbb93@redhat.com>
Date: Fri, 24 May 2019 09:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523234011.583-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 3/4] docker: update fedora to f30
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
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 1:40 AM, Marc-André Lureau wrote:
> Released last month.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
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

Hmm this patch is pending for review:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00819.html

>  ENV PACKAGES \
>      bc \
>      bison \
> 

