Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF6C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 01:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59389207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 01:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWo9ESRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59389207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irApj-0001nG-GF
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 20:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irAp3-0001KG-LP
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irAp2-0000HL-II
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:16:45 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:34181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irAp2-0000Fr-AG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:16:44 -0500
Received: by mail-pl1-x634.google.com with SMTP id g9so2325817plq.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 17:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l12jUgoZqAtvH/3+kJ8RPVsbu9MReQUH53PMXsDkoAs=;
 b=XWo9ESRj3wIIGMA3gGWvK/NxC1tmLxoo3q64YsKz/cgLUIuY4oQoDoIB0vqTMH56bK
 8G4fJS4AzVcJY8HgbZ4hXLOLRGjjxNjVwrkiWnDOWMvHc9DWggzM4I+s2dVWpuTrlDmo
 TUkj8LoUo+gD9S7p0j52Wrj6XM6Fdv7bEOEQE5o/1mDfeF+mcmEVseLl6Kg1weVf6AJz
 fR2YE0xKLZo5yg0S+bRlOa57PJYs99AlbcPx8OLDULrQeMTOWUkJtpWs6RZ156SRaR+L
 LQUV2SFoIcIVryqq4ztV0HZeBVr1fKA62cSQpj+ce5U7voAgEv3fVoUvDeJ2PxVInIhN
 I6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l12jUgoZqAtvH/3+kJ8RPVsbu9MReQUH53PMXsDkoAs=;
 b=s0CgeNVxWpZhc5yaqoC50/Egd1w4mHnimvYumH39LBEO3DKYfAtq1OoUTZFRwZasTM
 MZEG9MTZQJ0jp/Lk3mreaXJ7WKI+IwOjkhhZnspcFb2LJ8IhVMZugxikemo5qrYkUgd3
 zyXU5wDgAlzf2JupncwLs7Y7NLjmEIaMzuEhCh5Ndcbigl/MSO5lj/qWnIjI7Sejxkj6
 4a51n43eyRgq+DXCQoykIiiUN06IMtQnpqJrOI+62kII6qzNmnCxhC1CrXCLpTm193oC
 CnravR80rtSZ0nvVUUZ0Dri2p12lN76AYEGWbstmvebnbo5OOkO22O+wxfsbTb2ZUKCS
 lbZQ==
X-Gm-Message-State: APjAAAXJ8pQzKKwh86AW3DJ8DLCmKTXYCyVg4X9AUsTJMaPyZkB3l1NB
 WJRy+i58tEELFKONApDeBBz0MjPquHk=
X-Google-Smtp-Source: APXvYqw/OY2vWItzVWSBAyyStFenj7IDR5MMoSK0uR2ULgAO4cJ58q5406mh35csp340NYR8dSYCsg==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id
 z15mr26086992pjt.131.1578964602454; 
 Mon, 13 Jan 2020 17:16:42 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id 11sm15800108pfz.25.2020.01.13.17.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 17:16:41 -0800 (PST)
Subject: Re: [PULL 00/41] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
 <CAFEAcA9P_3enu_M-55aoqWScFFAhw=Jfs92+vCc+yY-2nXUehA@mail.gmail.com>
 <df405ec5-190e-946d-fc2f-b52c695a39d4@linaro.org>
 <d115421a-497d-42d2-5dc5-6a3d4b19b0b0@linaro.org>
 <67615704-a1e9-1d2f-752f-7ab84178e060@linaro.org>
Message-ID: <7fe29487-f902-1879-2f18-83af30cd2eec@linaro.org>
Date: Mon, 13 Jan 2020 15:16:38 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <67615704-a1e9-1d2f-752f-7ab84178e060@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::634
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/13/20 12:06 PM, Richard Henderson wrote:
> On 1/13/20 11:50 AM, Richard Henderson wrote:
>> On 1/13/20 11:10 AM, Richard Henderson wrote:
>>> Details of this test system?
>>>
>>> I suppose I'll grab your tarball just to see if the binaries are different...
>>
>> Ho hum.  Something is different.  I reproduce the problem with your tarball.
> 
> Well, yes and no.  Your tarball also fails for me with master, v4.2.0, and
> v4.1.1, so I can't see how I can trust it at all.

One final note for today -- your tarball works for me on all branches
(tcg-next, master, v4.2.0) on Centos 7.

I was previously using my desktop, Ubuntu 19.10.

So, there's certainly something odd going on...


r~

