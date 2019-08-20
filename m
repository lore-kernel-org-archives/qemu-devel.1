Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00362C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE91A22DBF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8eHLak8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE91A22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05X2-0006OG-Sw
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1i05WL-0005hE-4I
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1i05WK-0007Le-8A
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:54:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1i05WI-0007HP-05; Tue, 20 Aug 2019 10:53:58 -0400
Received: by mail-pg1-x543.google.com with SMTP id u17so3395809pgi.6;
 Tue, 20 Aug 2019 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8XrptPr0YeXBkfbqu0cuLcnDeqgk6So/l9Vyuw324jY=;
 b=p8eHLak8VRnIFGWtRCxq+g/asU/O29heyzMXQnRxvuJokfRCBsgRExz81KYXPhDxff
 xBVbbiqGi9cR1IW0njiq1ZUMhy85cUSHY+na+XJz/58ncV8CTztuPMruPvYajaiNR6IU
 KqsFM6IqTTeToVaWgvxboMatPFUxQmZKX4HbOBvvPZ69wxY82+umfHxX3MtSXoCeFaVX
 hEQZozP97e7SKIpc6db3ZdrvK+aG9n97s/R9YGyhOnCoJy4Wg6nr14Y4ckn14a6FSKWd
 71OLEmb7O5y/AohEC9zb2CqmSs+fd2l0trjP80oQowLiezh0gNdrcRV0iQkGIZsC3wcf
 iNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8XrptPr0YeXBkfbqu0cuLcnDeqgk6So/l9Vyuw324jY=;
 b=tqOBupqWRznPKtdRDZCyryWVEpLs+ZrX+ymR9lFXgpFhQ9y4POHkPM9QZL9KMtrouU
 XX9ev/iljxUS1RkEp8Vaci7rs9l1z3GvJtTFa6RZESIt02ZMxdle/BBS6W6zAsPXa0HA
 gsOM7qV518rBhl3FSGgCWKS6nYSDRRyDbEn8N+Bbr9DJ5WO8yV/qkyBJ1GtMCYrncSDN
 XsYgJNYcQfrgM5dlAiPOmA8qtxKQBgr1LRgHj4b6vypjhmo0rgCIQkc4t6yj1Zv1CahR
 RvsJzjcM+F7d6UDEalXJ7HwX6nes+oGHKfu7dbEILEYIZz/z3+VDHQLvEr0xV9Bkkuax
 7M5w==
X-Gm-Message-State: APjAAAVrhae/nSuabWuzvxR+fT4QDu9zpLjLWh7kIJ/4SAVQE2VxfwIR
 1x0zRt3dtnU5TvsJbhJwcNA=
X-Google-Smtp-Source: APXvYqx6NsxluSVwwnDXxlZ7Z8bwul/uhH0fx0e5PIbzibFTUChYPZh+LRi+WThf8qXSFfkri/S2Jg==
X-Received: by 2002:a65:4507:: with SMTP id n7mr24154914pgq.86.1566312836684; 
 Tue, 20 Aug 2019 07:53:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 h17sm20397426pfo.24.2019.08.20.07.53.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 07:53:55 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190820123417.27930-1-philmd@redhat.com>
 <3e3fcb30-1e12-eaf4-07a2-47d09aea2511@roeck-us.net>
 <CAFEAcA99kKzWL89gCQ8NZi4XKL=YzKDCJR1tLbXwQDLLmZyZJA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b71974e0-868d-0f8c-e344-ec9bf4be9d07@roeck-us.net>
Date: Tue, 20 Aug 2019 07:53:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99kKzWL89gCQ8NZi4XKL=YzKDCJR1tLbXwQDLLmZyZJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full
 16550 UART support
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 7:34 AM, Peter Maydell wrote:
> On Tue, 20 Aug 2019 at 15:31, Guenter Roeck <linux@roeck-us.net> wrote:
>> I tested with qemu 4.0, 4.1, and mainline (with my patch series applied on top of each).
>> One problem I do see is that booting mainline (as of right now) is _slow_ compared
>> to released versions of qemu. It takes some 35 seconds to get to "Unpacking initramfs",
>> compared to ~8 seconds for v4.1 and earlier. Otherwise it works.
> 
> Hmm, slow compared to v4.1.0 ? That's not so long in the past so
> that seems worth trying to bisect to find the culprit...
> 

Turns out it was the "usual" problem: "--enable-debug" specified as
configuration option. Sorry for the noise.

Guenter

