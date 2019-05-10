Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D886CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D962175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3bldp/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D962175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45209 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7Ym-0005Bd-4G
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:35:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7R5-0006oq-UF
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7R4-0006c2-15
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:27:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:46378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7R1-0006T7-9c
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:27:45 -0400
Received: by mail-pg1-x52e.google.com with SMTP id t187so3173543pgb.13
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hOmXjXRXzSLzeSUc8z6qUIQRioL0TfTMPhZKPkWGtJ0=;
	b=g3bldp/XWeB1sM68pxjtteV4GFR1YrFim8/e7bj1hrcBdowCDkD6+9PP1owcIYUGXr
	C5OOdXLhFiFMgu1PlMuycynO73o3Ztfr5uBTlE2pdMfcKBacTjsUAQBpdmAENxOJNMSz
	Wzn5DVRcyr2KzrUurSRQ8T0+Mr7AbGJDFdNLX7uuGn4Q7QEuBmVNJib/VRN5OE1UebBD
	sgZaeewdJYf7QgY+MPcUQNFBlDRgxI7W4Ueetb3SqPU5IUORhx/8i/buDKmXEyoswA8r
	fLr/lnz6d3JiJ0+J8L2btuXAH1+dYx75K4rM02T1bM5LmguCNGgu7Sgfi8l3brPYkWGZ
	PmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hOmXjXRXzSLzeSUc8z6qUIQRioL0TfTMPhZKPkWGtJ0=;
	b=i90B1G6VSlbj/5q2K31iisnUZTs9vQLA84EjJucHndwNXbURS/C16flCk/WE3l/ZRH
	qpofQNVNELdWsdbVgqZ3BY/UBAkzco2KyER5oRE6eoi8zYRgLW33iOcKVw3pfarLzPEO
	qKdGlW7Xthhl0nLRoCcG5jk2C5nM88jRm/IN5RXZbPbvkUoVtnVKseKMaU7OoY0VDi0z
	Oi4u0k2sXQh9cKWYMFoyIH7sdrarlgGMG2e3Pn93EmTqk6RH0SD7p2vaoP7WPK/hjWDW
	bey29WeP3uysA/bTRTRd00WaTWZDd1JyT5KWOkjeNcuvH19BGXZEyODgcjwLXUpwGvFa
	UDtA==
X-Gm-Message-State: APjAAAUpclQM4vRCcEWZIpXa4KbIkKcJSGfuCkyd44RjaLdB2Njmvcj7
	XRZIjU6NHmLnjLPKd4EtXejS27uzsJk=
X-Google-Smtp-Source: APXvYqwtQxPAHUHs0uJhlpKmO5tWDrRVH5QonDgfxysrs30NDkKtrMlmJfhhUjGIL16Bu0CXGdh9nA==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr14332462pgg.379.1557502060729;
	Fri, 10 May 2019 08:27:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	n26sm9382390pfi.165.2019.05.10.08.27.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:27:40 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190510012458.22706-1-richard.henderson@linaro.org>
	<20190510012458.22706-3-richard.henderson@linaro.org>
	<0aa9a93d-ae2c-d993-c241-bbbee82f2d15@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d68e91fb-1e2d-94a8-5e47-68a0dfbc7e7c@linaro.org>
Date: Fri, 10 May 2019 08:27:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0aa9a93d-ae2c-d993-c241-bbbee82f2d15@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52e
Subject: Re: [Qemu-devel] [PATCH v5 02/24] crypto: Merge crypto-obj-y into
 libqemuutil.a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/19 2:57 AM, Laurent Vivier wrote:
> There is a remaining crypto-aes-obj you should remove:
> 
> $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
>         $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))

Fixed, thanks.


r~

