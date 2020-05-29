Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A429C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D4A20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IENz0bF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D4A20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jearO-0000Ag-1M
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 04:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeaqg-0008Bs-7q
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:58:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeaqe-0002Cc-Si
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:58:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id c3so2515892wru.12
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vAvGV90qVg71aXaJ1XSkA1kRxDCyl8i/+JqZXPGB/P8=;
 b=IENz0bF7QDAvBx/F+dajCCj1M4djr8UNnOm9lTFH/KpCuXObrchgopLmAyO5LxPBy+
 eGpayGa2hA5VcJ2mlSF3PnOKQzjj0fo6Rtfse/yCH6oGAoNpCWD60qSNpbD2E2SWZTtk
 hMXXl6Gk43oiHVyzWlo30SkZELkPCMTeRPBLMymH+mYDBx+uTyRo7M5FgBTGw4gBOSHq
 4b7W2uBILUxGJgd7vHqsWl33jyc+cTC1roBHbBUHtWjost1woOWf+SlQhSiksXiyNVeN
 DPiKLxdpncQnWqFgnGWcMesWQqglbBsaiJ/Akc1UKVs+kenPNlceOX1UxDgP3JqjmLNg
 SROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vAvGV90qVg71aXaJ1XSkA1kRxDCyl8i/+JqZXPGB/P8=;
 b=GLt/UIOiFHQkdFzXVJlA5pxwZMhbH4reuj0U4e/0Q3QcM4wpDd+0Zb0hO5xeGmPUjH
 Fi6yXOyon2Y4nzYbWRSZiBErbNdm6yV/0c8oJ7B6DX0uqItLv+jGviyDIzzppvUR5ogO
 /REDFHFYMK0ii6fo/DOcfAjIKRTl6Eaub+tKqhTTZnaRZBOtPolYnER4UC7CLVPeV87X
 YlLbofFs5wBrRHYv0d9sDDOKUKFsloVlYFvGoHuJxL6f00scZIOaSyNE0DerZ0uBmXg4
 IMSUVWnNo1QrgnDDU1WYWDMjsq/zO+2KPfEGe4bk2bisA9ae2tKN2t0uBhGrHbyc09oX
 1Iow==
X-Gm-Message-State: AOAM530s91uk8/ij/QRlZi1ycd5G12uuHu6L1+1Qj1icUAt0GWPyHKMi
 whwl89a2ibVUiozDme/G9+gE9sZq
X-Google-Smtp-Source: ABdhPJw51uRe3XARo83qCxewmEausIxuNeWxGxafN0YFyZ5b8yckm/Xn0hA+TmEiQ9C4sS19HCi69A==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr7722351wru.83.1590742719009;
 Fri, 29 May 2020 01:58:39 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id 1sm10336766wms.25.2020.05.29.01.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 01:58:38 -0700 (PDT)
Subject: Re: [PATCH 0/2] linux-user: Load a vdso for x86_64
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200519194452.9009-1-richard.henderson@linaro.org>
 <CAFEAcA8q-4o3yWX2kwS1inPiajP1yzc3NOLBjzQUubKzDNGhhw@mail.gmail.com>
 <e985a1cb-e4e3-6faa-f158-5e797d0b5e92@vivier.eu>
 <f46f5f0a-3a56-538a-e703-0a6afb78ae3d@linaro.org>
 <069efc7b-9798-0895-22a8-9c72305bd0b7@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <885e5337-499e-54a5-fa4a-0578bdc7e22d@amsat.org>
Date: Fri, 29 May 2020 10:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <069efc7b-9798-0895-22a8-9c72305bd0b7@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 10:50 AM, Laurent Vivier wrote:
> Le 28/05/2020 à 23:42, Richard Henderson a écrit :
>> On 5/28/20 3:32 AM, Laurent Vivier wrote:
>>> Le 28/05/2020 à 12:08, Peter Maydell a écrit :
>>>> On Tue, 19 May 2020 at 20:45, Richard Henderson
>>>> <richard.henderson@linaro.org> wrote:
>>>>>  Makefile                  |   4 +-
>>>>>  linux-user/elfload.c      | 203 +++++++++++++++++++++++++++++++++++++-
>>>>>  pc-bios/Makefile          |   5 +
>>>>>  pc-bios/vdso-linux-x64.S  | 115 +++++++++++++++++++++
>>>>>  pc-bios/vdso-linux-x64.ld |  81 +++++++++++++++
>>>>>  pc-bios/vdso-linux-x64.so | Bin 0 -> 7500 bytes
>>>>
>>>> I'm not really a fan of binaries in source control :-(
>>>
>>> Can't we see that as a firmware or a ROM?
>>> It's only 7,4 KB and needs a cross-compilation env to be rebuilt.
>>>
>>> Do you have another solution?
>>>
>>> If you don't like this I can remove the series. Let me know.
>>
>> I think some more of the questions in the cover letter need answering.  Does
>> this patch set not break your own --static chroot tests, for example?
> 
> I will test my branch with this series in my --static chroot and remove
> the series before the PR.

Another option is to keep patch #1 in your pullreq, but removing the .so
binary...

> 
> Thanks,
> Laurent
> 


