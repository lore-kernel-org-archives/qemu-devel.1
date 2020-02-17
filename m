Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7FBC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6B1214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGkOwMz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6B1214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lJJ-0006wj-OK
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lIj-0006Et-RV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lIi-0006cK-Sx
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:39:25 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lIi-0006bS-M5
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:39:24 -0500
Received: by mail-pl1-x642.google.com with SMTP id y1so7057138plp.7
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mFADpJED4oawmFGwTQ06nNtQBqGryrrR/riklreJLW0=;
 b=hGkOwMz7olsMuaIj+ofzTHZweTHbooeSQAYdgit3HZNX5SEifNCDap5uTNb1D8YTpr
 f/AB3s+O09gpBiSPwamWUnZN15aYjZ2lBWiOus3ri06UrKainQZVojmt7VCaFciTvesU
 Snw/0DI7Aphwb78y2aQg5oTcyfTq1fd2ljCI8Kmw9h1v1F1uDlzaAY9PLvO8Eu2WQ0Ig
 Cpy5AwkIZBNfJt5EYihpXCbmeA/HLU/CSeAFza2PlHN7/vMqP3mnMyHtoFT/d+AtCsGN
 nn3VxdcV1NJzZIgCX0HOBwelzSwu+dLQoCqsNAjxmWZU38fN9uMx4dVcI0RdyASc/sNz
 OhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mFADpJED4oawmFGwTQ06nNtQBqGryrrR/riklreJLW0=;
 b=lEsqmwNXJe9Y3fdQwMhIGt/p/QDHzImIxhfoRben7jpiXE47LxxGh3gCwg/UkpHh/M
 xlrThuxvIoaBZnytvUhr8TxdwfghPHHh+bYJpFLa8cV7bbGEXKx4m9WVyigCL7D7yixH
 ilvbPmb3cSZaU2X+XXjRzXD2vSJJDbIeUwy8GtY5PCIKfpvYLcTJTH0C4BrMdwNZEQgt
 glrHv6HZgzrMWLg5wdZuGWEIZMCsDE9godmAaT1U45utfITEWDLzwJoPJObDUx/zF3MG
 6cipBL2IkvdPVxwW9LzTAegPepvCep3Wp7lYTAtCrKEq7dF+MqlZy4mxTiIpuIJw7zyV
 cSWw==
X-Gm-Message-State: APjAAAVQ+CNxR3xgu/oz7oA0Lnd+ibUp/k7R+HEBnrs6GilCShPbJpGK
 K0FiElSvlQKlsQ+2KyLXhTyjNw==
X-Google-Smtp-Source: APXvYqxjvRn/qbJcNtrC4ooAiQ1PulO9yPas4QZ+adNHErfQsM+1Ql23n3+5uBQr3g3A1biAOvyEpQ==
X-Received: by 2002:a17:902:ff07:: with SMTP id
 f7mr16678430plj.52.1581964762780; 
 Mon, 17 Feb 2020 10:39:22 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 133sm1171272pfy.14.2020.02.17.10.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:39:22 -0800 (PST)
Subject: Re: [PATCH v5 73/79] exec: cleanup
 qemu_minrampagesize()/qemu_maxrampagesize()
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-74-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b155471-c441-d9f7-3c70-1ac7f559b101@linaro.org>
Date: Mon, 17 Feb 2020 10:39:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-74-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: thuth@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 david@gibson.dropbear.id.au, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> Since all RAM is backed by hostmem backends, drop
> global -mem-path invariant and simplify code.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> v4:
>   * fix access to uninitialized pagesize/hpsize
>     (David Gibson <david@gibson.dropbear.id.au>)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

