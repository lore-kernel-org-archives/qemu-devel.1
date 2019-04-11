Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB23C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374242084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374242084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45829 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEX1B-0002hL-BQ
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:33:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWsS-0002Xe-Ug
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWeK-0007W5-QW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWeK-0007VR-Ee
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so6509851wrq.8
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 03:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UXyU+TdlfB8FVRvWnG4CnKxM8nSRL9aJrpjFErxjaLw=;
	b=sUJFrVW7oXJuip/pzrTuCAZIbcpIuDjOFJlAe/AraiHvaqtyqouZjJfqUQO300kE4a
	kC0HHTZYn5G+zuMgdhv+3foOhVitYk6vG6blrOq7eeIV/quke4h3uAFCi9SQ6JxqwTUg
	ISuv6H+nwra8JNbGmkrVhQrOG39ZQsBAf6X0Vb4rpAiW4GyOpJ9ED0m8BMFngH693k9g
	G3i8WSC0WFNTwZpL0Uq+oIuhDOGSMFBYYQ4GNOmkJBoKLGDdrVkRb6whXRTUwwjGv5VK
	uGYxKVSwjP3Z976b9IY8HWca05hCJK8DizMT/mzW7ADKfZ6pbG/9w+G2HqtVgom31BGK
	JnRA==
X-Gm-Message-State: APjAAAXqb1FWK09Pk/BTbT5JrI8/77S79VZ87qBVmsQcpZzc3zXy8Yte
	relFw/4sy/10fvVVn80fSk3ERA==
X-Google-Smtp-Source: APXvYqyz6M7/5HFeUpWflzj8U16NdyvvZwdBdumumIGqjwDS407AIiDe1ay6nyIY5qzvQYOafFYmbw==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr8766874wrs.126.1554977379446; 
	Thu, 11 Apr 2019 03:09:39 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	h18sm46490781wrt.97.2019.04.11.03.09.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 03:09:38 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190325090047.122981-1-ysato@users.sourceforge.jp>
	<20190401140318.80498-1-ysato@users.sourceforge.jp>
	<20190401140318.80498-13-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <09399349-5134-7347-b86d-d28c9fd1803d@redhat.com>
Date: Thu, 11 Apr 2019 12:09:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401140318.80498-13-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH RFC v6 12/12] include/hw/regiserfields.h:
 Add 8bit and 16bit registers
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411100938.8vge_uTKajtuzEZ7DRvAlWU8hqd2M672VbZgAWs0Fn8@z>

Hi Yoshinori,

Note about the patch subject:
- typo in regiserfields (missing 't') -> registerfields
- I'd simply use "hw/registerfields: Add 8bit and 16bit register macros"

On 4/1/19 4:03 PM, Yoshinori Sato wrote:
> Some RX peripheral using 8bit and 16bit registers.
> Added 8bit and 16bit APIs.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/registerfields.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index 2659a58737..f6bf911990 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -22,6 +22,14 @@
>      enum { A_ ## reg = (addr) };                                          \
>      enum { R_ ## reg = (addr) / 4 };
>  
> +#define REG8(reg, addr)                                                  \
> +    enum { A_ ## reg = (addr) };                                          \
> +    enum { R_ ## reg = (addr) };
> +
> +#define REG16(reg, addr)                                                  \
> +    enum { A_ ## reg = (addr) };                                          \
> +    enum { R_ ## reg = (addr) / 2 };
> +
>  /* Define SHIFT, LENGTH and MASK constants for a field within a register */
>  
>  /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_LENGTH
> @@ -40,6 +48,8 @@
>  #define FIELD_EX64(storage, reg, field)                                   \
>      extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
>                R_ ## reg ## _ ## field ## _LENGTH)
> +#define FIELD_EX8  FIELD_EX32
> +#define FIELD_EX16 FIELD_EX32
>  
>  /* Extract a field from an array of registers */
>  #define ARRAY_FIELD_EX32(regs, reg, field)                                \

For completeness, what about adding FIELD_DP8() and FIELD_DP16()?

Regards,

Phil.

