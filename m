Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2EC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC6724695
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHOD5XMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC6724695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46792 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWl9Z-0006VO-9J
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:17:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWl7l-0005Xu-9V
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWl7j-0008Vi-DK
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:15:25 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWl7g-0008Rt-GM
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:15:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id k24so4797655otn.6
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=FZRU5XvA/IdSKcjjKlqPIqG0nKdwaUs2Diump3KApP4=;
	b=QHOD5XMu8Q3j4Mdgdnlnt08Ga1Ql/6K5ksnRexdHtCMllULYSweIWI8wP7O9oBBUe+
	yPJAJtzweXPP7/CPTlT/JIkxG1KuzHb+TvqNsy+s+FoLqJvAO8KQb5KuLdDknrtOOuw6
	CFMhxj5TzSIwpeBMuZGyDacF7zLJA4FNoRGQwJAEgkfoBe3ycPIZoRmDq2R0FgApi2xV
	oCAZV7YxOVkdpnyhMKGPpV86eXPKgJsE2/XzvCQ8Gpa9s+ymOF+T+jeI9e9wOLabBuDU
	/VQoyvZF/qAeyHd3Pil697cHCZq4wHvnyoODYAjKHRMCZk4H+VQt4y+1IgktshMcp9cD
	zouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FZRU5XvA/IdSKcjjKlqPIqG0nKdwaUs2Diump3KApP4=;
	b=n/7xpUscuFFVeupD+Rz6Gar5K9axO9vrQ4jkyjl2xR+XeJ9MB5Q8WCkomj0416+UKX
	WO7EwgzHvPqvvdlLLQj4LmlzfZC57guu4vlZ0GWajj4cG9OIfkrrjNdijlU2x4GxcNEX
	c+UCxTCduT/5hFaV2FQyatTNTRCIBwGo7pBIB5BjEMGHbRaaa6V6dvk3oFuNdVjMjnP0
	+6E8YFElV+f7LjApHmOwAvQ+g6EtqgRFYwit4bxYD07RSOfe7UCR9tnoP6EPZdWWaMLc
	co+nOR+zFDXlec8UMvRbaOMomJnJuW9iex2qiKYmQo9+I6MExn8DxzXE9+gmbbnXRyC6
	2s9Q==
X-Gm-Message-State: APjAAAUA/YKpDjMlFolhjHgxHHlUrsHuMgNgdGAdggc6NHECTToFaQZV
	cR7LUreQaLWBZ9wi2Zcbbq4T5Q==
X-Google-Smtp-Source: APXvYqzod+/KDVm5k3eipdvzMWVYY4qlfK8bOlxwvt2kAMUMcGFYYv6H85ciECoWzyFM5vlAa/qLsw==
X-Received: by 2002:a9d:d22:: with SMTP id 31mr2683189oti.304.1559322917512;
	Fri, 31 May 2019 10:15:17 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id b81sm803918oia.38.2019.05.31.10.15.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:15:16 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <acb47220-23da-dcf8-1177-0b5240e9628f@linaro.org>
Date: Fri, 31 May 2019 12:15:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 08/23] s390x/tcg: Implement VECTOR FP
 CONVERT FROM LOGICAL 64-BIT
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c |  3 +++
>  target/s390x/vec_fpu_helper.c   | 23 +++++++++++++++++++++++
>  4 files changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



