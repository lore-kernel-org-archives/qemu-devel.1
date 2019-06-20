Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E1AC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6021A2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6021A2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzOb-0005P2-BO
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdzI6-0008MA-3Z
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdzGq-0006BW-0X
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:46:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdzGp-00069Y-QU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:46:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so2342801wrs.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9H2PzkJn2cqFORBRZy7+j0WNXqsM/n6+yvmL/Jka6PA=;
 b=b9fX7sDLa18fUr3suGjouYQZ+vpYnEuJdaBps9wfL2FPER33jX10D8yGetgQ2Uk/iH
 KyDT652UlbzrDgl4a9mwKikwhohI15YAL1KPXuBVd78Eg8t3GhqzgrUQ3qBpk5ylH2LM
 tDYynPWse4Rw/8FUfSryULCKdcnBbmSOW9HjyD+/SBQ0siIM1Ur7OUrKaOXTb+Ut4U/9
 IARzqnqJSoSG+IbXxnxy6wdHxPOBxKePL9/O/mVi2Y4v+eFHLiVPR3Iupkdk+8OSRWao
 FaJyK9TKXKHdBsRM8hV6dYAAY6+nFP0JGC3ft8znQs/00WWas7A1DzwaYDllbblmknWb
 Fo5w==
X-Gm-Message-State: APjAAAUoAVjlxw3ZxFlm82+znpPmcdygnJmvDPvSxG8XUJ3EtAarGLUD
 8NwRAhY3PyvA60P5Xjow+5rHzQ==
X-Google-Smtp-Source: APXvYqwEWXhE9ES/Ot+DbDXmZi3aD4OdN6m92SqM4KAy+HO8BHd7DLUm3XZGN2wWJgnJ7Dna3NVJ1Q==
X-Received: by 2002:adf:f30b:: with SMTP id i11mr30328155wro.299.1561045598177; 
 Thu, 20 Jun 2019 08:46:38 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t7sm15638457wrn.52.2019.06.20.08.46.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 08:46:37 -0700 (PDT)
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1561028123.git.balaton@eik.bme.hu>
 <5d1fe4db846ab9be4b77ddb0d43cc74cd200a003.1561028123.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c67e48df-925b-a3be-8760-4de0080d8aad@redhat.com>
Date: Thu, 20 Jun 2019 17:46:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5d1fe4db846ab9be4b77ddb0d43cc74cd200a003.1561028123.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v5 1/2] i2c: Move bitbang_i2c.h to
 include/hw/i2c/
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Corey Minyard <cminyard@mvista.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 12:55 PM, BALATON Zoltan wrote:
> The bitbang i2c implementation is also useful for other device models
> such as DDC in display controllers. Move the header to include/hw/i2c/
> to allow it to be used from other device models and adjust users of
> this include. This also reverts commit 2b4c1125ac which is no longer
> needed.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/i2c/bitbang_i2c.c                 | 2 +-
>  hw/i2c/ppc4xx_i2c.c                  | 1 -
>  hw/i2c/versatile_i2c.c               | 2 +-
>  {hw => include/hw}/i2c/bitbang_i2c.h | 2 ++
>  include/hw/i2c/i2c.h                 | 2 --
>  include/hw/i2c/ppc4xx_i2c.h          | 2 +-
>  6 files changed, 5 insertions(+), 6 deletions(-)
>  rename {hw => include/hw}/i2c/bitbang_i2c.h (80%)
> 
> diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
> index 5dfc72d9d7..3cb0509b02 100644
> --- a/hw/i2c/bitbang_i2c.c
> +++ b/hw/i2c/bitbang_i2c.c
> @@ -12,7 +12,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "bitbang_i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index d606d3dbeb..5fb4f86c38 100644
> --- a/hw/i2c/ppc4xx_i2c.c
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -30,7 +30,6 @@
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/ppc4xx_i2c.h"
> -#include "bitbang_i2c.h"
>  
>  #define PPC4xx_I2C_MEM_SIZE 18
>  
> diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
> index e07be9890c..24b6e36b6d 100644
> --- a/hw/i2c/versatile_i2c.c
> +++ b/hw/i2c/versatile_i2c.c
> @@ -23,7 +23,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
> -#include "bitbang_i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  
> diff --git a/hw/i2c/bitbang_i2c.h b/include/hw/i2c/bitbang_i2c.h
> similarity index 80%
> rename from hw/i2c/bitbang_i2c.h
> rename to include/hw/i2c/bitbang_i2c.h
> index 9443021710..3a7126d5de 100644
> --- a/hw/i2c/bitbang_i2c.h
> +++ b/include/hw/i2c/bitbang_i2c.h
> @@ -3,6 +3,8 @@
>  
>  #include "hw/i2c/i2c.h"
>  
> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> +
>  #define BITBANG_I2C_SDA 0
>  #define BITBANG_I2C_SCL 1
>  
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 8e236f7bb4..75c5bd638b 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -81,8 +81,6 @@ uint8_t i2c_recv(I2CBus *bus);
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
>  
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
>  /* lm832x.c */
>  void lm832x_key_event(DeviceState *dev, int key, int state);
>  
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index aa2a2bf9de..8437bf070b 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -28,7 +28,7 @@
>  #define PPC4XX_I2C_H
>  
>  #include "hw/sysbus.h"
> -#include "hw/i2c/i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  
>  #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
>  #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_I2C)
> 

