Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D439DC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FB920873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bu37mJXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44805 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBub0-0004Zx-Sp
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuaJ-00046s-J5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuaI-00029m-Ej
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:11:15 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuaI-00026S-8X
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:11:14 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ca13so459673pjb.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r/4csHuRz32dD1ptMUYotFgGyQxG3BSvg3TqAVVrHy0=;
 b=bu37mJXUsIYjQIuBS3Ai1MfTqIavXkF2boPdQ+Lwc6eQdtnMTteR15ossWreqwY+Ky
 AIqR+mVPxsKZyRo/9Nk3NsUk398oh8D7BYpXGunE2Kkvvos8kuOVwdrL59Lx2IKPUJFK
 YFZej8kR/lhBYIGzGwf0hQ6oOVZ+fv3+86XbIkNutTjuQDMkMcyCLIZVyBEFfG7ekMWF
 B8iVfHDR7Okf6n1qxEU6nl5UcTeA4kwJvnu3k+CgOMlMGm3Ro/QQ05KyuRFkVJYc57PR
 9hGXZDt5Z1CpDYg51v0oTQqjjudWW33iCkJ9QAdWTMPkVdmP4olnNQx+V02kRJelKXIS
 XnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r/4csHuRz32dD1ptMUYotFgGyQxG3BSvg3TqAVVrHy0=;
 b=WpKgI4Djs2OlfrdnZTwgJOfy+BNEC4bRmOBbxlXAe+57KKK2edbO54vIAbRQHpey76
 aN0JLEeUsXJQggBrYTtoMIGPKz3Dxc/6lW7dvHboJ48Sb8Fxzk+Iq9ypCODEwCIKL7tV
 Nyi2z+4RU30MG0bl4CUg0AAnydG8Jh1gcc73S1b/LBj40Mk6K3HjBXCqgUbaisbS+LQI
 0nCK7maxdDgwX2rXrU7ugV5zjE7zDnH0OoSwOBQ1TXZUONau4VrEdooX250JyJtLWm8S
 M6S4j2IwvVACx9ZtDsswaC4Gi7HihGI4cLP2oTSbfaag93FeqYM6pdqRZFUuLJtwx72H
 MQ1g==
X-Gm-Message-State: ANhLgQ2zaqyy9DOjxae5zn1/qWxix8ajC75u6/T5Aa1aaUGO1s0XHze3
 XVZmutvebredTYeMKCjVWOQQxXNn2aw=
X-Google-Smtp-Source: ADFU+vu4DqLFEh3A4quGw5p3gOEDnW08sKY9SF76spXcpIQHvuPSTYCunWC7ND4LeVgba5KXCMx2OQ==
X-Received: by 2002:a17:902:d207:: with SMTP id
 t7mr1593750ply.91.1583907073247; 
 Tue, 10 Mar 2020 23:11:13 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 m18sm47038324pgd.39.2020.03.10.23.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:11:12 -0700 (PDT)
Subject: Re: [PATCH v4 09/18] docs/interop: Convert qemu-qmp-ref to rST
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7fe55fba-8de7-6ce9-3dbf-820effcc1b83@linaro.org>
Date: Tue, 10 Mar 2020 23:11:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:43 AM, Peter Maydell wrote:
> Convert qemu-qmp-ref to rST format. This includes dropping
> the plain-text, pdf and info format outputs for this document;
> as with all our other Sphinx-based documentation, we provide
> HTML and manpage only.
> 
> The qemu-qmp-ref.rst is somewhat more stripped down than
> the .texi was, because we do not (currently) attempt to
> generate indexes for the commands, events and data types
> being documented.
> 
> Again, we drop the direct link from index.html.in now that
> the QMP ref is part of the interop manual.
> 
> This commit removes the 'info', 'txt' and 'pdf' Makefile
> targets, because we no longer generate any documentation
> except for the Sphinx HTML manuals and the manpages.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile                       | 39 ++++-------------
>  docs/index.html.in             |  1 -
>  docs/interop/conf.py           |  2 +
>  docs/interop/index.rst         |  1 +
>  docs/interop/qemu-qmp-ref.rst  |  4 ++
>  docs/interop/qemu-qmp-ref.texi | 80 ----------------------------------
>  6 files changed, 16 insertions(+), 111 deletions(-)
>  create mode 100644 docs/interop/qemu-qmp-ref.rst
>  delete mode 100644 docs/interop/qemu-qmp-ref.texi

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

