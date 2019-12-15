Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878CFC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D0D205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tW5F+Zd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D0D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igMTO-0005Rg-9w
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 00:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1igMSf-00052W-6M
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1igMSe-0001oC-3V
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:28:57 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:43594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1igMSd-0001mw-T7
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:28:56 -0500
Received: by mail-pj1-x1043.google.com with SMTP id g4so1521744pjs.10
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 21:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VArzzSYeZEnpsaB9lSQeUL2zfIxu29Y0Zz4FR1tu7JY=;
 b=tW5F+Zd5b48NbircyveTalm3eEyXXvDX8uDfvz88xAzAwDaT8J0Re2vrTvVcLwZ9M3
 vxDPYkpLYoJl8UHGMgbTkJPutIhO+kBbIzpFTp7zA9MFR+UFkvJMvXDyxi/ShlE4MRGE
 SIF6FIvwY22x6q2C5udfBWCTRyU/hmnwrIw1IFQtFWoGrZIl8PASzNODgHp3vfZPakJn
 9opaNNNcdVVzCT79+U3OMO33Jm9wDp4f2SoMmd7prQ+00iwE1TV8qoSL8H8NBgHYtIFd
 cuOJGmKfjLnjasI0pwYp3DmoC/R52MA1On2GVW4lRp9DO6+/3KCK1L4vJhfX7VMr5RW9
 jq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VArzzSYeZEnpsaB9lSQeUL2zfIxu29Y0Zz4FR1tu7JY=;
 b=B83k9sQtKRGiOhQrMA8zssarh59FvJLeKrTLd3ZRGH+kCVwMcWD3rZUOOt0BfghjgF
 2dCz8sU/VVVUHbRL7BIodi3lIEGaHN1KLTTEduR02NM7o9ZV9TLHibfnZj8IUgsUpw21
 3kcI66uCeuFPV5/oPRtLrU6x30CSpKE2ITsh7+rEjQ0HagzjbXDweaaKFO3EK34sONN5
 2WmqC/QeiSSLzjsw/Bp+px7JqoXxvLrohqk2f6J/K5fAutGrtL0SHvwd3C2FWZM10blI
 WorL8f09huPu8zhz9x/Ud1GlUBOojGMRk1gJWmIu9Ka07UREdC2znDHO0eVdz8Hq7M3X
 DQuA==
X-Gm-Message-State: APjAAAVo2DEUy2JtxryTzKPbdx1WKfhhqxUcFVsUEA4z43LohUeabV9Z
 QXNdirgoUIpW0eEQ1pH/xDfBD/MC
X-Google-Smtp-Source: APXvYqwSSKqqUXTBl3k08aWoi2vzBg3H+3mYhqmyTE9INsm/dJratjDB0m+59ebJf0tP26Egm92aYg==
X-Received: by 2002:a17:90a:1b45:: with SMTP id
 q63mr10587989pjq.118.1576387733685; 
 Sat, 14 Dec 2019 21:28:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 a15sm17884108pfh.169.2019.12.14.21.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 21:28:52 -0800 (PST)
Subject: Re: [PATCH 1/5] arm64: zynqmp: Add firmware DT node
To: Michal Simek <michal.simek@xilinx.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <20191018160735.15658-1-m.tretter@pengutronix.de>
 <20191018160735.15658-2-m.tretter@pengutronix.de>
 <20191208223814.GA21260@roeck-us.net>
 <dbba2a25-cbf7-60f4-99f7-056512e28d00@xilinx.com>
 <4821742f-2d60-b722-b954-263de975bf2e@roeck-us.net>
 <20191209074840.GP32392@toto>
 <d2e63acb-c076-7bfb-c492-0355ec106cbf@roeck-us.net>
 <fa36a9e9-9e44-d1ff-cfdc-22d0484318ff@xilinx.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <573f0472-9779-c5df-f199-4e0958753fd8@roeck-us.net>
Date: Sat, 14 Dec 2019 21:28:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fa36a9e9-9e44-d1ff-cfdc-22d0484318ff@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
 Rajan Vaja <rajan.vaja@xilinx.com>, Michael Tretter <m.tretter@pengutronix.de>,
 qemu-devel@nongnu.org, Edgar Iglesias <edgari@xilinx.com>, robh+dt@kernel.org,
 Rajan Vaja <rajanv@xilinx.com>, linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 7:02 AM, Michal Simek wrote:
> On 09. 12. 19 15:32, Guenter Roeck wrote:
>> On 12/8/19 11:48 PM, Edgar E. Iglesias wrote:
>>> On Sun, Dec 08, 2019 at 11:19:33PM -0800, Guenter Roeck wrote:
>>>> On 12/8/19 10:42 PM, Michal Simek wrote:
>>>>> Hi, +Edgar
>>>>>
>>>>>
>>>>> On 08. 12. 19 23:38, Guenter Roeck wrote:
>>>>>> On Fri, Oct 18, 2019 at 06:07:31PM +0200, Michael Tretter wrote:
>>>>>>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>>>>>>
>>>>>>> Add firmware DT node in ZynqMP device tree. This node
>>>>>>> uses bindings as per new firmware interface driver.
>>>>>>>
>>>>>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>>>> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
>>>>>>
>>>>>> With this patch applied in the mainline kernel, the qemu xlnx-zcu102
>>>>>> emulation crashes (see below). Any idea what it might take to get
>>>>>> qemu back to working ?
>>>>>
>>>>> Driver talks through ATF to PMU unit(microblaze). I don't think A53+MB
>>>>> concept is working with mainline qemu. But crash is too hard. It should
>>>
>>> Yes, QEMU doesn't support the Cortex-A53s along with the PMU MicroBlaze.
>>>
>>> My workaround when using upstream QEMU is a modified DT without the
>>> PMU firmware
>>> and with fixed-clock nodes.
>>>
>>
>> I can't do that for my boot tests. Normally I would just disable
>> ZYNQMP_FIRMWARE,
>> but that is hard enabled with ARCH_ZYNQMP. I'll have to drop those tests,
>> unfortunately, if the firmware driver is considered mandatory.
> 
> We can make it optional.
> Rajan: please send a patch for it.
> 

I'll disable the related boot tests for now. If/when this is fixed, let me know,
and I'll re-enable it.

Guenter

