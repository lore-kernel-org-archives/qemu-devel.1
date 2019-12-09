Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ED4C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2FA2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+6OgH3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2FA2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieK6b-0000Uu-Io
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1ieK5u-0008Tz-V5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1ieK5t-000571-MA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:33:02 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1ieK5t-00056m-EL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:33:01 -0500
Received: by mail-pj1-x1041.google.com with SMTP id v93so5983973pjb.6
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 06:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uGbO5eA/EvkEthYW5iN8u16ydFfTV3nGR0kns1YSEq8=;
 b=P+6OgH3wRjDpQ2U5Q0rrRheWAfDz6brjGOolhAYrfI+XHpr9AJQXkrzLt5mnTANHHe
 6kjX5lrvWFn+Kzh7mCA2waxwenvqV2z7zOjWnVxPg5kZzDGIzdDBKdauuIKS687GFel4
 lK7kd6xWyU7bCZUz7nx79DGRRGBGE8rneh8ccRlEgXlT9lqhlgFzNMThTeTMquZgkga1
 77j618VNUcC6v9kkNAgOgrstKBJQc/7I2f1rcIHJiSrZfm+by5G7EgSWAtKROXXhSxqu
 kN/3KOK/W8oKCvmZHZjenE/aAPytUZ0+q/o31lIBe87UNs4W3H4i0sbAltwNvF26dfMu
 VmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uGbO5eA/EvkEthYW5iN8u16ydFfTV3nGR0kns1YSEq8=;
 b=QJNNGLyZ5d/rXRsFomnepalxxOkXSTu1dSNvTP04vUHgHua0O2bvEGRfIt/q8il9vy
 GkxMi4y9zSazmSALjFHT2FpGsONIAlRutV0ZWHwl8trNlwglSsZp7KcEQtuSyTq0e3n+
 zvaoQa7BwRWBy7KhRzVcsp+Y0SByil9dpFKqHi6ny1P8rB0HM+100KlMWXRTQb6Epwpg
 dkxHOZLziPWvXTWoqJO4X9mKB53plzgZB5sp8wyVN49jteNFFo9YrA+xX3NCj7m1RsWu
 kbpKNxATilbng3oYZnaxGSiYJ+BYcx9LR+e8k8PNqdVvWbGwbi0NPVKEGl0A1SVRlFC/
 zwxA==
X-Gm-Message-State: APjAAAXqfTeVDMYMYVLMO4DYTGxep730qDJPooEuJxUw61fi+ncue3RJ
 uSFTWPgUXlIsCfT2b2viBYIDLTSV
X-Google-Smtp-Source: APXvYqy4RVacHM5VEz6sKAsm+VK1Q9vv8Q+gX/BUj6bRNoFploDMVpcSqufihDBKA8rygFotaghXYQ==
X-Received: by 2002:a17:90b:8c6:: with SMTP id
 ds6mr18053912pjb.33.1575901980001; 
 Mon, 09 Dec 2019 06:33:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 h3sm12682121pfr.15.2019.12.09.06.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 06:32:58 -0800 (PST)
Subject: Re: [PATCH 1/5] arm64: zynqmp: Add firmware DT node
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <20191018160735.15658-1-m.tretter@pengutronix.de>
 <20191018160735.15658-2-m.tretter@pengutronix.de>
 <20191208223814.GA21260@roeck-us.net>
 <dbba2a25-cbf7-60f4-99f7-056512e28d00@xilinx.com>
 <4821742f-2d60-b722-b954-263de975bf2e@roeck-us.net>
 <20191209074840.GP32392@toto>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d2e63acb-c076-7bfb-c492-0355ec106cbf@roeck-us.net>
Date: Mon, 9 Dec 2019 06:32:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209074840.GP32392@toto>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Rajan Vaja <rajan.vaja@xilinx.com>, qemu-devel@nongnu.org,
 Michal Simek <michal.simek@xilinx.com>,
 Michael Tretter <m.tretter@pengutronix.de>, Edgar Iglesias <edgari@xilinx.com>,
 robh+dt@kernel.org, Rajan Vaja <rajanv@xilinx.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/8/19 11:48 PM, Edgar E. Iglesias wrote:
> On Sun, Dec 08, 2019 at 11:19:33PM -0800, Guenter Roeck wrote:
>> On 12/8/19 10:42 PM, Michal Simek wrote:
>>> Hi, +Edgar
>>>
>>>
>>> On 08. 12. 19 23:38, Guenter Roeck wrote:
>>>> On Fri, Oct 18, 2019 at 06:07:31PM +0200, Michael Tretter wrote:
>>>>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>>>>
>>>>> Add firmware DT node in ZynqMP device tree. This node
>>>>> uses bindings as per new firmware interface driver.
>>>>>
>>>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
>>>>
>>>> With this patch applied in the mainline kernel, the qemu xlnx-zcu102
>>>> emulation crashes (see below). Any idea what it might take to get
>>>> qemu back to working ?
>>>
>>> Driver talks through ATF to PMU unit(microblaze). I don't think A53+MB
>>> concept is working with mainline qemu. But crash is too hard. It should
> 
> Yes, QEMU doesn't support the Cortex-A53s along with the PMU MicroBlaze.
> 
> My workaround when using upstream QEMU is a modified DT without the PMU firmware
> and with fixed-clock nodes.
> 

I can't do that for my boot tests. Normally I would just disable ZYNQMP_FIRMWARE,
but that is hard enabled with ARCH_ZYNQMP. I'll have to drop those tests,
unfortunately, if the firmware driver is considered mandatory.

Guenter

