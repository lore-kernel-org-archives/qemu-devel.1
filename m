Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C6C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791E4206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791E4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44033 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXLf-0007oX-Of
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:57:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYXBQ-00087h-Ur
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYXBN-0001OK-3m
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:46:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYXBL-0001Du-8W
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:46:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so3945685wrv.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 07:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pucGnOk+55CqjUgzL4haQ1hXw35XEWkw0NyQZXByNvU=;
	b=q0FgGv42IO8qZLhVQoFk++5gfQBZokKoT0b5Jm+bNVV6o4Hpc2yj+cSzmijbA/Cemn
	pzut1MqgUapnGgKbGmfNwFRhdV3aCqvdBhp2pBlk5CJ9xp2F9u6qq5re66XMb9UGBv/C
	NiIq+XFdrO6u3iglY49tQSa33VDxyHeAxp93HFh+K+wPr137yHjqe7RY0NdSKy61LH8D
	ZS9WFBD07IfvajqjRBLZkPsW2Skk4luavs9RJqVJJdTNKR6O+Uby7+Ii55dR3p5y285s
	2i97bopFD+cOEbSNCEP6ODsL9xY87TkL7hDCF/ADtlnuO+2/5ec9nnzZbK4POmQBdApP
	f26A==
X-Gm-Message-State: APjAAAU9Ch/Qp1B2v13WMDLQvnpMKwp4jX0b0/yl0mtmKJiUxfqXW51U
	vvYIkeGJvuWyrd5M+DAu3RHO/A==
X-Google-Smtp-Source: APXvYqypimsF/BiMR1P1jGJIKvQUkDF3lZs4Hd1eiCJTXzGyEQxOosuAWyc9FnAEekzr0eMQoWdZ1Q==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr21997077wrv.228.1559745985733; 
	Wed, 05 Jun 2019 07:46:25 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	d10sm25111449wrh.91.2019.06.05.07.46.24
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 07:46:25 -0700 (PDT)
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org,
	Laszlo Ersek <lersek@redhat.com>
References: <20190530192812.17637-1-olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3e79c06b-cffb-977d-1f08-f1bb46dad795@redhat.com>
Date: Wed, 5 Jun 2019 16:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530192812.17637-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v1] Makefile: remove DESTDIR from firmware
 file content
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Odd, I'm pretty sure I replied to this last week but can't find it, so
again]
Cc'ing Laszlo since he wrote this.

On 5/30/19 9:28 PM, Olaf Hering wrote:
> The resulting firmware files should only contain the runtime path.
> Fixes commit 26ce90fde5c ("Makefile: install the edk2 firmware images
> and their descriptors")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index f0be624f47..61267bf1a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -844,7 +844,7 @@ ifneq ($(DESCS),)
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
>  	set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
>  	for x in $(DESCS); do \
> -		sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
> +		sed -e 's,@DATADIR@,$(qemu_datadir),' \

I'm fine with this patch.
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Laszlo, did you use the full path for a particular reason?

>  			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
>  		$(INSTALL_DATA) "$$tmpf" \
>  			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
> 

