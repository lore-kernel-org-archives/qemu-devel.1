Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A9FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF64206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ky9Z457I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF64206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1rY-00005Y-OG
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO0p0-0001Hf-RB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO0oz-0004Qh-Jp
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:44:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO0oz-0004QC-C2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:44:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id e11so2648543wrv.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=A4sciDHxO1W5JUOTQfMe9vaz1h3bb9xUJm4mUHbzCBQ=;
 b=Ky9Z457IYK3krRfzDuYAXpHPsGHGEeFBpcYm5LZSUnXuacmDCTXxMlVmo3tfFv+Sfq
 P2pvsjfCCN6VxBXwyftPLqE+0MBvymDKXKhjsBuurIPutRRDUMXOYg5X6waSbBkYhvnN
 lqz1ZNSh1yEawrDo1h0dBTbdR1CK/bk7feUkDe7JgtPXyQUV++fEs/1Q1OEmq1aoHxyi
 A+RzGq1cT9lNXa0585cwJYiWMGPmBU3sfu7ZDilYI0WMSID0hVRTSNIzwz1jQYk5ZCRa
 w+EgGU1lCWCeasqogeDeHkO5EQFp7EmC53AYq93Zdf4dG9lu4unwj93pGZoMwoJPOztA
 rc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=A4sciDHxO1W5JUOTQfMe9vaz1h3bb9xUJm4mUHbzCBQ=;
 b=DFd8s12MeECY0pI7sArJ0BRG2n2KKE7CNSHxwR1Q9OE1PbIwysOplqb6XD6IGt5D2G
 D9YNd1Jl+dFBQITvR82uqAwouxmG2HqdtGHsnjponcNcgtKnVTOwlSftqbG8F+o2x5JB
 sC8SzmBn4883fXfuNUm5g0YnkQ5gQo4wRgmPQ1GR3wlNwkPYnXdd1/WVOWhasrSB7ils
 q8VgsIu2WDFdxOA8fCTJb/5F180fnftQPlxyZDAm+WXZX5dzijFMi8AKfqbuPyaYnmFW
 DhMI3xCUq30Vx+pdFlQOBva6/pOkGmRbrpSs7W9zCYwuZEvwLxlylWtoGCI/9jPdHvQi
 w4lQ==
X-Gm-Message-State: APjAAAUHGD4SSIIR9fVdiKbWgqApFXkvCF5FKJ+TC76d4jjT7NK9qGSp
 NJZenzRqTgeY29vqiDdeJv5KsQ==
X-Google-Smtp-Source: APXvYqx/YGpY08ohZJ4+vutLRNM4wEkxX1nxdPlFsT4DilGEZmNRBPF1/J9FVvVVmmonaSsVYa1hQw==
X-Received: by 2002:a5d:4885:: with SMTP id g5mr3703480wrq.219.1572014647716; 
 Fri, 25 Oct 2019 07:44:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z9sm2622944wrv.1.2019.10.25.07.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:44:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 824441FF87;
 Fri, 25 Oct 2019 15:44:06 +0100 (BST)
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 5/7] exec: Restrict TARGET_PAGE_BITS_VARY assert to
 CONFIG_DEBUG_TCG
In-reply-to: <20191023154505.30521-6-richard.henderson@linaro.org>
Date: Fri, 25 Oct 2019 15:44:06 +0100
Message-ID: <87o8y4lwax.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This reduces the size of a release build by about 10k.
> Noticably, within the tlb miss helpers.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu-all.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 76515dc8d9..d3e4660d50 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -219,7 +219,11 @@ extern const TargetPageBits target_page;
>  #else
>  extern TargetPageBits target_page;
>  # endif
> -#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
> +# ifdef CONFIG_DEBUG_TCG
> +#  define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bit=
s)
> +# else
> +#  define TARGET_PAGE_BITS target_page.bits
> +# endif
>  #else
>  #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
>  #endif


--
Alex Benn=C3=A9e

