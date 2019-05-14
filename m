Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62E8C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAFF2166E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAFF2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQb00-0006Pj-PR
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:13:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQau8-0001D5-0S
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQakM-0005mq-7g
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:57:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQakI-0005Xq-I2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:57:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so2208321wrr.13
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3RpATJY4t7mffsI0H5xJyZeNDAapvNxe81KENkoywFY=;
	b=Wh9/4y/uLBC3UvPplxFtpXZ5+tyqMMqOat31p6MwNpUijxI3II4h1Ts+XlF9QXbMLy
	MJxTwDqE0cxzXO/jmgm/a9THyeQz8kDClHp4EBi/FdRWhGwd2Xk8JxgHHzGazgrZNP0A
	7eKc0eQN0o27KeXxLN08lCVgT7OgpQwfviAtlFYOueJg349A/fDHhJ071YftZc27U36h
	j72/5zlaBL4rWLmH6Dwjl/hbZbnT2Nfe0c7AAs6eER+F5CxFjbF0ox+ZzW7aE5LiWXIJ
	63q4O4Xjytq0pLcbdvG55svZATdRb8LetevVab9iLpmEmoOEcrWXUSx0JDbesJvBHDD4
	ZRMg==
X-Gm-Message-State: APjAAAWBMVRYam8/352j1jWBsyz7t9o5mNKoPIJ/dtWhnHG60sChG6eb
	tgzFuncIKQQP1piDTuYc6i2AsA==
X-Google-Smtp-Source: APXvYqy0xcKJO2KLFoe2tc9eaDZSgvPIrzRFSbPBTVnfHHtM4SW6zdj8fcDY4MOAbWT1dzMPOK+YbA==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr21842871wrp.281.1557853060601;
	Tue, 14 May 2019 09:57:40 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	y130sm5572332wmc.44.2019.05.14.09.57.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 09:57:40 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <84dde5b2-e2f5-504d-be03-0ef888957a0a@redhat.com>
Date: Tue, 14 May 2019 18:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514155301.16123-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] target/arm: correct return
 values for WRITE/READ in arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:52 PM, Alex Bennée wrote:
> The documentation says the write should return the number of bytes not
> written on an error (0 means everything was written). Read provides a
> buffer length and the return value should be the buffer length - bytes
> actually read. Remove the incorrect FIXME's and return the correct
> values.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/arm-semi.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index a3bbef18ef7..3ae8f05d51b 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -334,13 +334,15 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>          } else {
>              s = lock_user(VERIFY_READ, arg1, len, 1);
>              if (!s) {
> -                /* FIXME - should this error code be -TARGET_EFAULT ? */
> -                return (uint32_t)-1;
> +                /* Return bytes not written on error */
> +                return len;
>              }
>              ret = set_swi_errno(ts, write(arg0, s, len));
>              unlock_user(s, arg1, 0);
> -            if (ret == (uint32_t)-1)
> -                return -1;
> +            if (ret == (uint32_t)-1) {
> +                ret = 0;
> +            }
> +            /* Return bytes not written */
>              return len - ret;
>          }
>      case TARGET_SYS_READ:
> @@ -355,15 +357,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>          } else {
>              s = lock_user(VERIFY_WRITE, arg1, len, 0);
>              if (!s) {
> -                /* FIXME - should this error code be -TARGET_EFAULT ? */
> -                return (uint32_t)-1;
> +                /* return bytes not read */
> +                return len;
>              }
>              do {
>                  ret = set_swi_errno(ts, read(arg0, s, len));
>              } while (ret == -1 && errno == EINTR);
>              unlock_user(s, arg1, len);
> -            if (ret == (uint32_t)-1)
> -                return -1;
> +            if (ret == (uint32_t)-1) {
> +                ret = 0;
> +            }
> +            /* Return bytes not read */
>              return len - ret;
>          }
>      case TARGET_SYS_READC:
> 

