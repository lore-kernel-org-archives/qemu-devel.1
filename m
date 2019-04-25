Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077CC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 23:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AFE206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 23:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AFE206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJnS0-0002ip-9L
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 19:06:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJnQ1-0000sq-M0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJnH9-0002fU-2q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:55:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJnH7-0002b9-0m
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:55:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so1660362wrs.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 15:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GBnR7hhSI1h1Wl1I61bB5TonHhPbCOcQK5Tu5KslEms=;
	b=plG3bITtboSYWyOKLJCeWrWL50CbAZKR/51FNCvHBj3A+qmZjoZ4eLKs8U2ZLxIKEV
	s625D0uN4GPlN6XpXS2P4PuLeXxbwAiF/lETAHX0etwwp0/AFqUtPVpGg29bNyI046d3
	cFBk19ys9YqSbzVrFKPlbWIKc+2cvKGLuS3IzcNetEvO96B9wHwaqasRClWcpSjSZtCM
	xyBjYTQjj2DZP6jc7ZiYmsdX9QYm1RDk4vscm/E4tOMOTMCPV6u1U2tl5SMpJr+U3zc9
	ye5VADzLP1RZKq3sIj7YlWkt2KPrGLj1VJwC2esU+fx7IbG2lRwfrE6afLVIPLDSfdPP
	giCw==
X-Gm-Message-State: APjAAAXfIykbcIuRC2qqiv7eIncTGfOvjSATs9MiYKwZKV8twQ80sKGp
	C6znWLY83ZiQTB4Ce+fKpHQVJw==
X-Google-Smtp-Source: APXvYqwrzlDY2UtlKyQtIPp3X43hkY2yZ7W7gNSQV3FsHnWGaN0C3a6j8cAWxQth3oniI/neO0a5SQ==
X-Received: by 2002:adf:9e86:: with SMTP id a6mr18133522wrf.178.1556232927202; 
	Thu, 25 Apr 2019 15:55:27 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	s12sm20560396wmj.42.2019.04.25.15.55.25
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 15:55:26 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
References: <20190419075625.24251-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c0ce7a39-9e9f-a7be-c73b-a9c2c05da3af@redhat.com>
Date: Fri, 26 Apr 2019 00:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419075625.24251-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1 0/2] Fix ohci_die() and move PCI
 code to separate file
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425225525.SktgpqAMzhYY5xQyMqOLU_bMlH51Z60iqMaCaJ5xa-8@z>

Hi Thomas,

On 4/19/19 9:56 AM, Thomas Huth wrote:
> First patch fixes a problem with ohci_die(), second patch moves PCI code into
> a separate file, so that the sysbus OHCI device can also be used without
> the dependency on the PCI code.
> 
> v2: Split the patch into two patches, one for the ohci_die() fix and one
>     for the PCI code movement.

Way cleaner. I wonder why you don't use a typedef for the void
(*ohci_die_fn)(struct OHCIState *) prototype.
Anyway to this series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Thomas Huth (2):
>   hw/usb/hcd-ohci: Do not use PCI functions with sysbus devices in
>     ohci_die()
>   hw/usb/hcd-ohci: Move PCI-related code into a separate file
> 
>  hw/sh4/Kconfig        |   2 +-
>  hw/usb/Kconfig        |   6 +-
>  hw/usb/Makefile.objs  |   1 +
>  hw/usb/hcd-ohci-pci.c | 163 +++++++++++++++++++++++++++++++
>  hw/usb/hcd-ohci.c     | 219 ++++--------------------------------------
>  hw/usb/hcd-ohci.h     | 104 ++++++++++++++++++++
>  6 files changed, 293 insertions(+), 202 deletions(-)
>  create mode 100644 hw/usb/hcd-ohci-pci.c
>  create mode 100644 hw/usb/hcd-ohci.h
> 

