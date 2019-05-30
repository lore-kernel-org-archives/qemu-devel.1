Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C199C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BD325FDE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vF9LGRwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BD325FDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWQ3p-0002hQ-Hl
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 14:45:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWQ2A-0001nR-Qo
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWQ28-0000rz-HY
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:44:14 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWQ25-0000mJ-82
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:44:11 -0400
Received: by mail-oi1-x241.google.com with SMTP id v2so5761387oie.6
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=lc8u/EajSuaEvWYEXXd071ItnL6DryglgdpvMVDXhS0=;
	b=vF9LGRwiwBjROBx82Aa+AeGhpqOGJUYcWwLT8aWDhjbkW+9KEdKshB0yr9q2sBo/Yf
	iQvb6lJYYTsEKtfwRULkN2uPprdVLqx6p4Af43MGy+0EuOxBzAwCUEPjA09/Y94For7i
	RUs30s3DvXgiPk8v/2kTWK9DmEtz5mn/sdzqqqBvkS72uCfs4FoJ+Icu8QyLbKRH/Y7q
	ZBhtoZLMKmWMuaQVnsdRk0Ji1r8BJIy1aRvjDGGgksPzIrZEs2OzUuc1WDFeEpiG61V3
	lwlqmdAIJnaiepfB+QrRgg2a4nbKpeYFdQ9Fd/EufYgFZcDAkp29WlrKWShSoDuuE52N
	rCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lc8u/EajSuaEvWYEXXd071ItnL6DryglgdpvMVDXhS0=;
	b=jNOzJDXC977gdc/RxbG8J4BrajhQBjY8CU4gVkWtKPD/aMX2PRAVUe2E4Qt308zOcF
	QbghTaCWBIcv395mbbyJPD3GaDW8U1yWP5PUJiHgb2ECflPxqWyZrxjN+U9dgC6itsR1
	4eXNix/Ia1w7s2DtvEvbHKKQaA1sms/Ee3mC9IUfcSQ4MGZ9VZrL9iuFin6XZXv5M33T
	qAR0ExA6WAiFAX+nuLNrkD9s9pY+g6w8IEIaQO0YXvCIiYb8mIAKOxly8c9tkp4bpAhJ
	E98GvXVXSQR+Z6w1Ofq+clTQPN8U/EvOZWr3NKKd5Y2GDX9XEiDDdzrYSJam+/LNNPT/
	wBFA==
X-Gm-Message-State: APjAAAX1+HwDxWSb+sY+LJSQvO9wGs2JA975aoa9te/e01eEyd8fS6r9
	aRj4AuivQ9emAy+TjZ+QrZYj4A==
X-Google-Smtp-Source: APXvYqzqKuFGQqA05vr4KMUBv0TSWhroFZ/FM560j5cXmjGBIcu4NiYtT6OzQ18EtlClApbOFjETTA==
X-Received: by 2002:aca:dcc2:: with SMTP id t185mr3568210oig.158.1559241847280;
	Thu, 30 May 2019 11:44:07 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id p8sm1231579otl.36.2019.05.30.11.44.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 11:44:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <54988d49-e8a8-d264-609e-cacaf9dba739@linaro.org>
Date: Thu, 30 May 2019 13:44:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 06/26] tests/docker: Update the Ubuntu
 image to 19.04
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
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 5:15 AM, Alex Bennée wrote:
> This has aged a little and we have a separate LTS image for testing on
> the older distros. Update it to a more recent release like its Fedora
> cousin.
> 
> Besides it is useful to have something with gcc-9 on it for squashing
> those stringop truncation errors.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/ubuntu.docker | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

