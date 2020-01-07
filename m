Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A9EC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 02:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6B120715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 02:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCqiSZuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6B120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioeJi-0001TL-9a
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 21:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ioeHY-00083a-Sw
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 21:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ioeHX-0007xP-EY
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 21:07:44 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ioeHX-0007rM-4R
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 21:07:43 -0500
Received: by mail-pf1-x441.google.com with SMTP id n9so19932139pff.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 18:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V8ESGksRlQHUv0CJRwlSb78JSSfoh7CbMOqAAuvjtBA=;
 b=nCqiSZuCWJb0Cp5vRUOybYhoJFpArOCewF7XfZCsLDLR1iJPSURycVBD2ePSAbHoWY
 Vue0A6awRWQoBDJTaLjjUmDLF2ED3i8X2INJ+Kz6Ot4ZVNF4Mn3Y9gOe+uQXdPkLBJpq
 CJryLe9URzBu3C7zsSIkwv14L28fcEnqC7thbZJp0mG7yFyZVp0xxzqDN1MyssLm8V5u
 qZakRM0SDrD/8SGbRr9Hia9gaXUchboU916NNNS51eZkbFa6fRsbpNIy7AVqsjRN6K3z
 gQjGx5x8YrlZzUcVQW6IlixkBbfewh+mGjJggC1+tYGiixmP2idXPXeTW5eqGzLDZp2v
 2EOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V8ESGksRlQHUv0CJRwlSb78JSSfoh7CbMOqAAuvjtBA=;
 b=sgKzu+nCca9wH9ZB3ypgTddJ+ej9TTpuT2jddoxVs5mbX0GiuukiNZ1vKzEPVYi83s
 6BE3iN16t7HMbGF1fydk51ABn6bvQMOv3o2x1q7XFqPcMXu9oN3s7KdKzgLm2s8O83v8
 DV3Xhjdc/P7gTaKBHW0rg7BMdN+D0NyNQBluR41CfMP/qFtym04z69MXrbBaElXq1Hnr
 LhT6pyfgJjY06Ny0TS5cEOqZWVxOpLLtNU5Y02IbDFusmEuRSfjhvKerhYwGgJjbWkph
 30l9mhkYtp28SMtEf4wS59ufG64/uiZSL0d2JBMW1Ah6KZl86J0sutK7/UcxTxFI7eW0
 Jbug==
X-Gm-Message-State: APjAAAVs4pLxSj1Jf6SYsRWx4cMfCIbh24JeLK4x0ZTgRj37EQG1SR+3
 09O+A6lFfK7XmB+r7Q6D5Wi+4Q==
X-Google-Smtp-Source: APXvYqyw/+Z8CsNQnHtSXeEmyE1eux7QfJ/c13mxStEgoR5vLj7+tN4GiZrU0DKZgLzEj4ZezrxY2A==
X-Received: by 2002:a63:1e47:: with SMTP id p7mr112256843pgm.339.1578362860949; 
 Mon, 06 Jan 2020 18:07:40 -0800 (PST)
Received: from [10.7.11.213] ([203.47.88.82])
 by smtp.gmail.com with ESMTPSA id l21sm59805504pff.100.2020.01.06.18.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 18:07:40 -0800 (PST)
Subject: Re: [PATCH 0/3] Raspi sd-bus cleanup and multiphase reset
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191220144616.911466-1-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70fdcb1a-fad9-c76e-2c40-429783b5a866@linaro.org>
Date: Tue, 7 Jan 2020 12:07:33 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220144616.911466-1-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 Andrew.Baumann@microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 12:46 AM, Damien Hedde wrote:
> Hi All,
> 
> This series is a follow-up of my reset series,
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04664.html
> 
> I've extracted the raspberry-pi related patches. As suggested by Peter
> in the previous version of the reset serie, these patches do a cleanup
> of the raspberry-pi sd-bus then does the multiphase reset switch of the
> gpio soc part.
> 
> Patch 1 remove the bcm2835_gpio sd-bus which is only used to host the
> sd-card before the machine initial reset. As the soc exhibits the "default"
> sd-bus to the machine using an alias, we can simply exhibit the sdhci instead.
> Patch 2 prepare the multiphase reset switch by isolating the sd-card parent
> change. Patch 3 finally does the multiphase transition of the bcm2835_gpio.
> 
> Thanks for your feedback,
> Damien
> 
> Based-on: <20191220115035.709876-1-damien.hedde@greensocs.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


