Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B7EC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944B720873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8tGLJ4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944B720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBua0-0003hq-Rm
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuZQ-0003EA-KQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuZP-00087x-IF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:10:20 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuZP-00084l-BN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:10:19 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a16so456266pju.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dfS61ghwybS6PalzScu/i5GjsxnAJrYZ04f8gzz4Zgo=;
 b=A8tGLJ4kAvvxjTzp9bvTyEarz+WK6nBMCz4k+wLyfRRm4V9VYP/XOdRuHxk+ddAHZE
 h5iWCoS7VUBLhDXwVdYn01ZvBVWl8r4FoRMziY/P7hmn+uoK4F02KgUOtCaqqyNzQAem
 nkV7e6RHF2gH9cjss0ZWfCH8Z3RnNAiGG71AqTHGCNQAykBZWBtf5SLqgt193TliVIu6
 2h8ph87hbZqeeFmkJCjf2C+o/qg8tZvTJcxYnsXhBs0OfLl6E2DD6P9nfeNU2ZB7Eihg
 Bc61PBgfe1etljYPy3kVlhUWXAVf8fS33LzncNxrHV7XK3/KkIhrzcYRANuzik4ScWEM
 wX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dfS61ghwybS6PalzScu/i5GjsxnAJrYZ04f8gzz4Zgo=;
 b=RmoIAwDeYcYEob/6OkT2+r1aaGPTF9WImzd+4hdQXdnSWJbrpLUGiqr/lEN5fQPF7L
 QDcOmwbb2vj2fGfsNhC+pQk5YjkQ9RxyueK3ACmGO/ja11bOmnizJ9czSAl4JXUJIDhZ
 FA17w6UOB/S9J2LsRR2eMh0zeau+I4VGTiPFSGbP59dRypHyj+HpnCYf2/uIqjerpBpl
 d4+9GHr5Hq1CpNs9D7tcjLhoDtOWltB7HFw6/4lgjH50uvecEIR7GUQB9oasUqTlsars
 QG4yNPM8romJHNtKL/HAL8TpSAaaCaYulV6UUDA6cUe7LyOQZOmvbaR5h0KqICmfI7P/
 XmwQ==
X-Gm-Message-State: ANhLgQ0AhaXTFc0gLzKeTOs0DL40TvPT9SKdEaRKIp1gBZcIvey0Wm1P
 9phksrjEYTQZwO7eSV8pVn37gg==
X-Google-Smtp-Source: ADFU+vsJCTNGtsYj2U1Km6NvQOqg+6NXX6mgNfa7T47U17Qlon6IZXm6Y5lC37AztLO+8VmlbIxIJA==
X-Received: by 2002:a17:90a:33c1:: with SMTP id
 n59mr1740513pjb.4.1583907017889; 
 Tue, 10 Mar 2020 23:10:17 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z3sm4106854pjr.46.2020.03.10.23.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:10:17 -0700 (PDT)
Subject: Re: [PATCH v4 08/18] docs/interop: Convert qemu-ga-ref to rST
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <88ec680c-078a-42e9-3737-e8a58eaf00b4@linaro.org>
Date: Tue, 10 Mar 2020 23:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
> Convert qemu-ga-ref to rST format. This includes dropping
> the plain-text, pdf and info format outputs for this document;
> as with all our other Sphinx-based documentation, we provide
> HTML and manpage only.
> 
> The qemu-ga-ref.rst is somewhat more stripped down than
> the .texi was, because we do not (currently) attempt to
> generate indexes for the commands, events and data types
> being documented.
> 
> As the GA ref is now part of the Sphinx 'interop' manual,
> we can delete the direct link from index.html.in.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile                      | 41 ++++++++----------
>  MAINTAINERS                   |  2 +-
>  docs/index.html.in            |  1 -
>  docs/interop/conf.py          |  2 +
>  docs/interop/index.rst        |  1 +
>  docs/interop/qemu-ga-ref.rst  |  4 ++
>  docs/interop/qemu-ga-ref.texi | 80 -----------------------------------
>  7 files changed, 25 insertions(+), 106 deletions(-)
>  create mode 100644 docs/interop/qemu-ga-ref.rst
>  delete mode 100644 docs/interop/qemu-ga-ref.texi

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

