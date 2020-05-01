Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB60C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE522076D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tT14CFY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE522076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUTwS-00084T-0S
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 07:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUTvk-0007f4-VF
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUTvj-00055Y-Tu
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:34:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUTvj-00052I-EA
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:34:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id x25so5686641wmc.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 04:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eOxDyz2MTZWRf/nPFMUiIsw+pdNR6GiSY0sW0nUtCh8=;
 b=tT14CFY4LCZui6S89bfcy4cU/XG/iptvdl2/GwuGp6h6NRUH/uvhfmt/V/wszD5l0W
 1fl32QCo5QQdFuFsAhDRW2GLM4BB5ghe07zDGkFCDX3TGrjvFP91qk6P8SwLfvvZKZRU
 YDHv6Uhw8wqOlhzyS+M8lhp/H4HHi6vuNbr2ADk0X0ifDRo1ghD2k+iGs2anhvCt4N0X
 iTgroefJDOB9MQiQRT3GzKpV5K95ZE39h1Z+q9CyG4a0kuJd75KbmXHdo1kHMlb1T0JO
 ZYFenWDAZaEutADIEdej/fF0q0hU8r1q5yRIVGlI752THhUBU/t7JVaxyuWKAlU4AtVn
 KcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eOxDyz2MTZWRf/nPFMUiIsw+pdNR6GiSY0sW0nUtCh8=;
 b=IVuzetIy82wvwoA3jjkxbrPyuAIeAmuMQKV0KNBsDXJEdePE6jQ5MyBWvcedahju++
 RijgBZBQeAagz56u/NlyTB/3j6N5I2EkD0mW52Hf+K+/S6nH8ypfGrT8IX+Yv2cETd97
 13icwo7Pc40oJmzmsmotmepYLpUZwLuFLIIw7u9aeWb2kNoZyibgPtWDxMwVGo6UDSnj
 De28nuW0yueWUGnGwD4W8Z2fCe4bZ8R88/S4Y/KVVtmb/LOu36ccDQm4U30/4QkzhO12
 ROdgM4RX7D2WzeN9tgGN5xu0sOgGpJvqBQtPYfiJb6VFTakXESyk+yMMAO5tNPKAtmC+
 42XA==
X-Gm-Message-State: AGi0PuYctXuW/7Pa5HbUkuKWXdKsrw5ErgNF+KKy7n3HmknH2Y+v9CmJ
 kHL1b8nazGcEjyrsNfvq0xwCmivMOz0=
X-Google-Smtp-Source: APiQypIO+6B4Dt7GNUZw6GXF+ZE4dBH253ehQ8bnOmHrcvKcWYQCrIRddY+1s8hUb/I4UAXgC/FKKw==
X-Received: by 2002:a05:600c:290f:: with SMTP id
 i15mr3360024wmd.167.1588332844801; 
 Fri, 01 May 2020 04:34:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 36sm4158760wrc.35.2020.05.01.04.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 04:34:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CCFF11FF7E;
 Fri,  1 May 2020 12:34:02 +0100 (BST)
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501112321.GK2203114@redhat.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH  v1 0/4] testing/next updates
In-reply-to: <20200501112321.GK2203114@redhat.com>
Date: Fri, 01 May 2020 12:34:02 +0100
Message-ID: <87a72rkhxx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, May 01, 2020 at 12:15:01PM +0100, Alex Benn=C3=A9e wrote:
>> Hi,
>>=20
>> The following updates bring us to green across the board again. MacOSX
>> has been getting continually flakey on Travis but we still have
>> coverage on Cirrus. Please review.
>
> Does anyone ever look at the cirrus jobs ?  They don't notify us
> like the travis jobs so, so I feel like they're basically invisible.

Well the badge shows the current status on:

  https://wiki.qemu.org/Testing/CI

I watch them for all my trees:

  https://wiki.qemu.org/User:Ajb

but we don't have notifications turned on.

>
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

