Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFAC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F6220989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F6220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53459 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOhvI-0005Kd-91
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:13:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOhuK-0004Wb-4N
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOhuJ-0008L8-55
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:12:16 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOhuI-0008Kd-Uy
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:12:15 -0400
Received: by mail-wm1-f54.google.com with SMTP id j187so2910421wmj.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 05:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kDcd8XJcNq6n5HSxTB+85eJOg19oYHS7Fa56aLAXDdg=;
	b=kySZQ4fqyyvUpilsWjEIWiynAhTsTteOs+pD6kqnN8xOLOjlQhyL73Vv1XpBEawvvD
	e5GbDRx2uFVQsEU3YMrdG4wzFJI+UInsx4tXAFz8OkTDVQKcdl7EpmJcfIejwOaxHEfb
	98N5nRADUCxmrdxhYnaABS3LquG14cTNyX6Bg1xVjIUxV3FJ3ehwSgt6PkrbL0aoevmq
	Ytruyzh8e5JDK0lT3haRr4/UgeJHFtTBZPhXOaiprxpisvBmZQA+DbyoYeSG9W7RgPr8
	jZYpbErnl4yoehzQExUaMFnN5yc1ZvvU/zHiqxKHBK35VqQsNI0UPNxLPX4Kx6zCHWzh
	pAHw==
X-Gm-Message-State: APjAAAWajMcESC2oSrqIWbi61ZNq45vguQXsOOGJOONVynLx9vdt5WYJ
	kPwu6eVCChiZwf3redGU+n4FSw==
X-Google-Smtp-Source: APXvYqzdPn6aM5P79OMp9CUxr7L7UKQDHXtTMNLpCQHLSCB2DXjvoPiP2Kk69zKZx/2hT5Up2GQuUw==
X-Received: by 2002:a1c:9e04:: with SMTP id h4mr2817454wme.135.1557403933862; 
	Thu, 09 May 2019 05:12:13 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id f7sm2076343wrv.17.2019.05.09.05.12.12
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 05:12:12 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-14-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <99dc6f33-851c-cc01-89b9-44c68f07c199@redhat.com>
Date: Thu, 9 May 2019 14:12:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508085645.11595-14-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.54
Subject: Re: [Qemu-devel] [PATCH 13/13] tests/vm: ubuntu.i386: apt proxy
 setup
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 10:56 AM, Gerd Hoffmann wrote:
> Configure apt proxy so package downloads
> can be cached and can pass firewalls.

Yay \o/

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/ubuntu.i386 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index a22d137e76df..b869afd212fa 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -51,6 +51,10 @@ class UbuntuX86VM(basevm.BaseVM):
>                            "    ssh-authorized-keys:\n",
>                            "    - %s\n" % basevm.SSH_PUB_KEY,
>                            "locale: en_US.UTF-8\n"])
> +        proxy = os.environ.get("http_proxy")

Some users only use 'https_proxy' (or FTP):
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08413.html

> +        if not proxy is None:
> +            udata.writelines(["apt:\n",
> +                              "  proxy: %s" % proxy])
>          udata.close()
>          subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
>                                 "-volid", "cidata", "-joliet", "-rock",
> 

