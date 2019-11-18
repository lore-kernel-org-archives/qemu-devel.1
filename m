Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DEEC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF92C20409
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcux48TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF92C20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWbgT-0001Se-VI
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 02:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWbfa-0000wd-IX
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWbfZ-0002CN-Ln
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:41:58 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWbfZ-0002CG-CF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:41:57 -0500
Received: by mail-wm1-x341.google.com with SMTP id q70so16192188wme.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 23:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mseGAk3V15uuv1QReiQK0Z3xKQRCMS/FIuq+6H8qquI=;
 b=jcux48TVjhH3zFkoMZwSNYEGGNqZhnzY0cA6i82G7B1zyBbsNXvTWTHWNmXZ6lqucg
 uA6B8nETPmq+/asDQPR9IVeCQlLKFY/RXxCJ0YdgYJMuaSXHjx3j60QT9KQzovHlVFTz
 It0l+FpHakW//WynEFiL5IBCWOB6q8ojgLpcBroTMg3a7c8T53TVwCxiF8gUI2PxuMQu
 ziLyZ5g8GXtb0YaevEii9C/nhPM5WXh2WkdmEwopaHolNZm7Xeco2ytXdZcLKK474kom
 GJ9TJhtEfyKZ8DVI/1ELzjbjykja3Ret2spfyUHxDIPIxdzhCYgNilgD2qCOjkoxGTSd
 2E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mseGAk3V15uuv1QReiQK0Z3xKQRCMS/FIuq+6H8qquI=;
 b=C2IzUtq9mY0GAPod3SkfoxBGAOajqycVwp5ZMF+sYpgCfLHwuDb+NC/rzrs0LcXigI
 UO+lQaietSKinkf78ohQb4usnJrZZ+wPtP0SMEZyQ9YWECYErk9d717X4kDKLjKfRvHh
 0IK7Abf+n/DVx9yTf19sOWAnDCs/pT2tJJVkG5qr793ozjk1RPKq4GlvI5mUzrb65jQF
 ILxWHQXUmTVM7V7Pu40KVFSe92/hbe+zjMo1bV5RBiptBVzCdqQdiI+9VIInELIsVxbH
 m7iZNk++K4TWHc47UPYo5xx40DplQhIoro0odDjfc9PrxD1g9sgjXkw481AGiz6laD8P
 W57w==
X-Gm-Message-State: APjAAAUeRgoWv26YwtJ46h6AALwPxVgg7QTt2PttGnV5BCwYwqkG66I2
 eosLmaty5FaMYi7oBOzxdiS0BA==
X-Google-Smtp-Source: APXvYqzPzO5IyLIIgP1U7VNopSbyifJI7A6Jk73U2iU3ypEqT/J/AKWgI0mKkENxkulgzthErNnSPQ==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr28556442wmh.81.1574062916304; 
 Sun, 17 Nov 2019 23:41:56 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id f188sm18130485wmf.3.2019.11.17.23.41.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Nov 2019 23:41:55 -0800 (PST)
Subject: Re: [RFC PATCH 01/11] gdbstub: move allocation of GDBState to one
 place
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9f87f9e8-ecc6-398f-62b3-05a7f9af2366@linaro.org>
Date: Mon, 18 Nov 2019 08:41:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

On 11/15/19 6:29 PM, Alex Bennée wrote:
>  
>  static GDBState *gdbserver_state;
>  
> +static GDBState *gdb_allocate_state(void)
> +{
> +    g_assert(!gdbserver_state);
> +    gdbserver_state = g_new0(GDBState, 1);
> +    return gdbserver_state;
> +}
> +

Actually, if we're only going to have one, why are we allocating it
dynamically?  We might as well allocate it statically and drop the pointer
indirection.


r~

