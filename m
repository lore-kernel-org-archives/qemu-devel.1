Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7752FC41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 11:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC8C206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 11:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="G3/iuyi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC8C206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOg7c-00084c-Og
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 07:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kOg6s-0007WO-FM; Sat, 03 Oct 2020 07:53:54 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kOg6q-0006J5-9Q; Sat, 03 Oct 2020 07:53:54 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 41FF2C60F16;
 Sat,  3 Oct 2020 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601726026;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91TQFNV43aOMH4iXLd+vKMbxmiHWPTBV9D9iUJS+qd0=;
 b=G3/iuyi5JwmRsJXf58sOFP2cUrWrqJOhlGIJ6BDN2Dn2tJ9COPh7rNi5SL9Bw7iDKbDcKU
 4Ia7EdFHK97y5AfrSkmqZEWmv1zyROMQwu1NGlelToizJ7N15v6Sz4wcGTzBxRzlQoeN7j
 I/Ve4raV94ACda/cpV5nc9PSt/slg3sdPsLtOT2ryguCuP/mwTu81xoDVM3Y72msTL7lMO
 sXmhtfmpmw6Ik3Eixm0szwLwtu92lHC7B5U3PdbG9eWXICkbglGy6LcdId0MX6oDTVjrLT
 qjIMlmYW9K3/DvQGTpQ4YBwoElYky6uB7YVYZo65KfudDtOzjynqu8A5zl+SPw==
Date: Sat, 3 Oct 2020 13:54:44 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 04/14] hw/arm/raspi: add a skeleton implementation of the
 cprman
Message-ID: <20201003115444.m2woqcpit34vfv3u@sekoia-pc.home.lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-5-luc@lmichel.fr>
 <85ccb491-8d4a-caf3-595d-7415471f5dc7@amsat.org>
 <20200928084515.r7s3cl6jlzm465iw@sekoia-pc.home.lmichel.fr>
 <4aa9f0c3-dc4b-1e87-d601-87b0498de8b1@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aa9f0c3-dc4b-1e87-d601-87b0498de8b1@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601726026;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91TQFNV43aOMH4iXLd+vKMbxmiHWPTBV9D9iUJS+qd0=;
 b=JQsOKki1cLZJHh8SAwQMRbqfkTKxKeo4UYPo8Bf0EV6L73+bM8Cj3Zo97AG1B9ywAccAjj
 O5z42Q5x77LKu63xE9hBNzXt7Dgq/9HQq7dAiPYXJt32gp9eFLWgDjikGOQ13G8fegqzkG
 DV0Sv96SSVDQAkqT95pY5sub7HdxYOkR29AY8tYuAcywXc74vxLGReytXdn/yCkfUJjeL3
 d6IIvhdXVlq+2TBVPkSIzST9wPiIBASI7e9BghxEJe25rrS1yqN3Gv/ssHr2bwZqRKD76r
 N9ODeGk89LesA/CVaqVf4YKwoK/NQ2JUVbbeVMOwVXKsiADe0HQd/UPXZyLKDg==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601726026; a=rsa-sha256; cv=none;
 b=RqRpzzJrAAi8Bk04Buw4NX27gWnP7KzcZRk2cJU87SYvkJ2PXmkVBkyyGcpfrNlI01v5LJcs12O8X7npnbM6XLt9y8f5WaFyynpqq+/VtRCxFLvgcBWCleefqbRLb2SXoezf4YZcvMErftb+VnteOBY+5g6yFGwagew/NvT85Wzte7QJclmqXBZqV3wiNbNOjVIokc3vKjFOApwunZzLs3PPNPBDKBAmdyXu91qulmn7Xf4Ahpu8RnCPNwWBW5+6s/M33VOJNNhIRoDLIBxttwitXVa/yVPumJAgpdmM8qjQ5PpgQf2gYkK95k4vr5gsmEv/SkWXF+ut31EuBVZ9UQ==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 07:53:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16:37 Fri 02 Oct     , Philippe Mathieu-Daudé wrote:

[snip]

> >>> +struct BCM2835CprmanState {
> >>> +    /*< private >*/
> >>> +    SysBusDevice parent_obj;
> >>> +
> >>> +    /*< public >*/
> >>> +    MemoryRegion iomem;
> >>> +
> >>> +    uint32_t regs[CPRMAN_NUM_REGS];
> >>> +    uint32_t xosc_freq;
> >>> +
> >>> +    Clock *xosc;
> 
> Isn't it xosc external to the CPRMAN?
> 
Yes on real hardware I'm pretty sure it's the oscillator we can see on
the board itself, near the SoC (on the bottom side). This is how I first
planned to implement it. I then realized that would add complexity to
the BCM2835Peripherals model for no good reasons IMHO (mainly because of
migration). So at the end I put it inside the CPRMAN for simplicity, and
added a property to set its frequency.

> >>> +};

[snip]

> >>> +static const MemoryRegionOps cprman_ops = {
> >>> +    .read = cprman_read,
> >>> +    .write = cprman_write,
> >>> +    .endianness = DEVICE_LITTLE_ENDIAN,
> >>> +    .valid      = {
> >>> +        .min_access_size        = 4,
> >>> +        .max_access_size        = 4,
> >>
> >> I couldn't find this in the public datasheets (any pointer?).
> >>
> >> Since your implementation is 32bit, can you explicit .impl
> >> min/max = 4?
> > 
> > I could not find this information either, but I assumed this is the
> > case, mainly because of the 'PASSWORD' field in all registers.
> 
> Good point. Do you mind adding a comment about it here please?
> 

OK

> > 
> > Regarding .impl, I thought that having .valid was enough?
> 
> Until we eventually figure out we can do 64-bit accesses,
> so someone change .valid.max to 8 and your model is broken :/

OK, I'll add the .impl constraints.

[snip]

-- 
Luc

