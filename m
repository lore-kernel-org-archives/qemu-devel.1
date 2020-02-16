Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E8C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDDE20857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcI6o5Qv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDDE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3GAH-0001Ba-Je
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 04:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3G9j-0000k7-OS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3G9i-0003V4-Kb
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:24:03 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3G9i-0003UX-DJ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:24:02 -0500
Received: by mail-pj1-x1042.google.com with SMTP id q39so5915475pjc.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 01:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c9HcxgkkC7cr46R8FgLI+dVW4VksHnj11ibKvg4qmVA=;
 b=pcI6o5QvhCVXygTp97+BkErJ1gZBQ9ckTEWHuncSahwHTiZmla1Xos7Vn3+lmk5wZ8
 n5XdJM8Xskd9n/bQrn8Vej9xCmxqSONUi0xyCAga9Sy2e/3/lT9acYJpAGtudqigUy8Y
 x2OxEKwZ3UtHN1STnkL6TnqKUXfAFMmcQcRASBZ70S6VM+hzRtuWT4AZg8LWUpxdXCzn
 Dbb+QZrmFOq+YQTGviq/doPn8FLGaVNzhQ9NepGHvoyvqyjKPuAIZTg5HhdEYwsX5bsX
 X2+50y04z23TFOeHbY1/zIhreykscoKc7onAWZVLQYQh97XaUHOp3GeL56k8Za4dKBlt
 jMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c9HcxgkkC7cr46R8FgLI+dVW4VksHnj11ibKvg4qmVA=;
 b=NXu2UJxMjXlld4trHu8s3HecNts3oxwls0ILzk4l2dZ8j/r0eIuhSvv8USVCU6WhSq
 5CiCBqmK4qCXNuqrQajwnSXuCEkeuEbS4TY/O2fp1IqJvQqKkGlyY4NmfZ7Jp8aPuO84
 CnXM/gcxGWVqaoTBni8tEYYSVAzIsh8XeVb119gprkNqWN8/Lbg4xYT2MEYlGolc/C/x
 rWdiGwETOk3kBtxxxmXLZe4Z/RDTkm9H69rbe0awy48aaWFNKX4793Bxo6k9hJ1t3vMc
 /kxKSFHT+vT5sLsNbAcBtkhLgNxOKSZVlcaU0BQTl3F0y1dXvNOF/rjqPEWN4YIuxL/e
 J2mg==
X-Gm-Message-State: APjAAAUkMmxp9nCQgIJFXvFExlFZ5S/liCqWVdek1MTL/V6v4HPKHAPo
 EHtmPG8wNc9uuL4f81HxlB/n5Q==
X-Google-Smtp-Source: APXvYqxhBoaGKXYBElN9uEipo10dNIM/xzFyBWowvES5utv3vpYf/3zT5Qv0L+NaOkyKeZU/LhHXWQ==
X-Received: by 2002:a17:902:6948:: with SMTP id
 k8mr10919705plt.223.1581845041174; 
 Sun, 16 Feb 2020 01:24:01 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q187sm12570314pfq.185.2020.02.16.01.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 01:24:00 -0800 (PST)
Subject: Re: [PATCH v2 17/19] tcg: save vaddr temp for plugin usage
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c997838-12f3-96f1-6da5-aa6253d0f7ae@linaro.org>
Date: Sun, 16 Feb 2020 01:23:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213225109.13120-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com, f4bug@amsat.org,
 robhenry@microsoft.com, qemu-stable@nongnu.org, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 2:51 PM, Alex Bennée wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> While do_gen_mem_cb does copy (via extu_tl_i64) vaddr into a new temp
> this won't help if the vaddr temp gets clobbered by the actual
> load/store op. To avoid this clobbering we explicitly copy vaddr
> before the op to ensure it is live my the time we do the
> instrumentation.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>  tcg/tcg-op.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

