Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AA0C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEDC20868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMwgmAlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEDC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFoh-00011Y-Dr
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48135)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZFSq-0001VX-Rb
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZFSp-0005Q5-W9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:03:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZFSp-0005Nv-Mu
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:03:27 -0400
Received: by mail-ot1-x342.google.com with SMTP id j19so1948593otq.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nyXT5Ue0Y94DnC8f9elpeDgFvGtk+3tUE33UOb51E+k=;
 b=ZMwgmAlrIYYW7rSenDFYBJCLbG98Wj+c7MGbayAA7K11JsejDhz3YEDNWLbPmOnmnT
 Eo7AIbZz2RZMBS7rARQiq2QIILwH5ux+l1YR5pgZmZqKhFjyCIORFDmuv5NQyuC1PxPg
 CL97L3NLmIw4wjOmmUh8UW4JLoWJ+NA+eSRNnPU7xDWQl/sI/H9IGDQr6LsNSuXkt9lS
 zLoy2ulY32emk1ozBCmDsSyw2BKqh9CGbvkdJTOu0Kqd8j2+fJPmsSHAxrSNiFlWEVVi
 j7XU3cn36NBPpXnfm0sMhCaXukzD35A2oc2jh/5EgZSFeNIoOc1uq+XWrjc/C+lQRGFm
 EA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nyXT5Ue0Y94DnC8f9elpeDgFvGtk+3tUE33UOb51E+k=;
 b=rVr43rNF1FlD3VP3860z5E96FCrTTfwHkD7AeTxYC6SFD/T4lxR19MpwuS5bluJO3c
 kQgi+1GhMl7aosf533nx7izNThzvL2eQR0nX7izjhMlIbcCLJh3FfEovQ8emP77G4XpU
 cB609QdW2jWZXc9IfdlfbmeO4WNAsMjKBDZVLqrUxRKkAnRI6bYDj1VNROwtZOiHqQ8+
 UmUFyA3l5M8x1E/OQ3n5UEbyeZYq/q5v/3q2nhCM7M28JaZFlLctZRVsaQDYCs1hO7GD
 HDMBsdrQWwFSf8/wd5ZNdTTEVzyWuvJiVGNwYceqKI61/j0RYGQlT8YgzobE5V1+HH9q
 N1bQ==
X-Gm-Message-State: APjAAAX0ZEXhIn6enX4ZLid2dO+wHK+eYZBNq3XqRDEpntelIgyLxftO
 QGJ6+6vHMYf5AYx+6j4S4yq2Gw==
X-Google-Smtp-Source: APXvYqzHAOn39yNWWFF4TJa3G2nWlD/8MmsqJ0N8RhWlUUApqWJZnmZwONwaAaiJ9K7OFnMdn95FGg==
X-Received: by 2002:a9d:7190:: with SMTP id o16mr18850130otj.78.1559916206009; 
 Fri, 07 Jun 2019 07:03:26 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id w18sm724788oiw.24.2019.06.07.07.03.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:03:25 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-17-ysato@users.sourceforge.jp>
 <6e4b77b4-f05c-74e8-e128-1555ead951fc@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <04a5b9b8-7b33-5ad9-f8e1-f5752ec97607@linaro.org>
Date: Fri, 7 Jun 2019 09:03:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6e4b77b4-f05c-74e8-e128-1555ead951fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v17 16/24] Add rx-softmmu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 8:44 AM, Philippe Mathieu-Daudé wrote:
> Again:
> 
> Please squash in:
> 
> -- >8 --
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -26,6 +26,7 @@
>  #pragma GCC poison TARGET_PPC
>  #pragma GCC poison TARGET_PPC64
>  #pragma GCC poison TARGET_ABI32
> +#pragma GCC poison TARGET_RX
>  #pragma GCC poison TARGET_S390X
>  #pragma GCC poison TARGET_SH4
>  #pragma GCC poison TARGET_SPARC

Done.  Any I've picked up all of your r-b tags.


r~

