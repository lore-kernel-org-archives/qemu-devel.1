Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2B5C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07285206E4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4yZ2MOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07285206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbEx-0008E4-52
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbE8-0007cS-44
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbE7-00009H-0G
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:14:15 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:42046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibbE6-00008n-Os
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:14:14 -0500
Received: by mail-pj1-x1042.google.com with SMTP id o11so1611098pjp.9
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 18:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SJ2MJfd9EYZLDnDIJJqEXSWiXxR4AuyzlNGG+Al9jYM=;
 b=T4yZ2MOmFADR7NV0VBdSSjmMnB4hTbzHL/2ySg+5FvdsXMdPjJNe3vvCT5mbLYMKfA
 BhBjIuKo2Jqt/AyuSFHz1x03kxuI9CvXvjxgHBLmEv7IubCfPdUBhinj4uqSvqjYodHi
 6Q73xB9sZ0dm6CBeO5DEauDi6FmzZ2/gfGVZf/dd2ARO+8FzOE+L8Zg1XF0P+XTgEJir
 egGKtH1ycdkeFeWmoCNOVA2ZCfv7J4T1u2yM5nQprNyDDnEPje0hKJMNZCMaptTEAWW3
 enYPEoIpmreJuBBTdgdj0brCKn2rKII7fgYXAqrKz3q2vcyhEZpQtt4ah8OhsarWlaER
 B0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SJ2MJfd9EYZLDnDIJJqEXSWiXxR4AuyzlNGG+Al9jYM=;
 b=WKfScpc1eINgo61N6PN4Str0FAgZtKwH0DvKIwwCc9K0uEjUhjhqIzRAg013tnPD+F
 39UWcLrH8IEjxc/RsS/5clvFMX02CvymStWVn0I38k1s9ZQhR4jfwA8OehD0NUtjzFjL
 C7sNXQ65m6AXCkghuWn1U0nmt+XHedoSfX4OVpxsxmxiTY8yYfcjk+VtckY5IiJIxopY
 MMzNt7LWN3cT/8Lq+Po4PqXI85HmVPz5hgWD4REVhxaLg2aTFjCibpVyPL5JM5yWwlAh
 sHvp0lR3NzKxnWxBGfz9EOVcubMBDtnL8RHtWbVuylbzU8c2Z205X2EiULDDWGjXYDQT
 LmkA==
X-Gm-Message-State: APjAAAVbgF/XiWUnMBbMBwECWwd5fFSPnxegvHkCpUvcU4UCHSg6HX7i
 ykz6HTk0E15ZvnB3FZdxPYLw4Q==
X-Google-Smtp-Source: APXvYqxY7Hz8Cr55qyz2hdf3TnsruC9zriAPYyv5+CMIe6yfQZ8D8dZ1df3vNX7JCQyy9BMeHLl+UA==
X-Received: by 2002:a17:902:6b45:: with SMTP id
 g5mr19324004plt.159.1575252853391; 
 Sun, 01 Dec 2019 18:14:13 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o8sm18253541pjo.7.2019.12.01.18.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 18:14:12 -0800 (PST)
Subject: Re: [PATCH v2 01/14] gdbstub: make GDBState static and have common
 init function
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <32b0424b-a878-87eb-7a93-dda084c01bc9@linaro.org>
Date: Sun, 1 Dec 2019 18:14:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-2-alex.bennee@linaro.org>
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
Cc: damien.hedde@greensocs.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:45 AM, Alex Bennée wrote:
> -static GDBState *gdbserver_state;
> +static GDBState gdbserver_state;
> +
> +static void init_gdbserver_state(void)
> +{
> +    g_assert(!gdbserver_state.init);
> +    memset(&gdbserver_state, 0, sizeof(GDBState));
> +    gdbserver_state.init = true;
> +}

At no point does init transition from true to false, afaict.  Therefore the
memset is unnecessary, as the effect is had from the default
zero-initialization of the static variable.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

