Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FB4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D66B2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLz226nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D66B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajWj-0006wk-NX
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jajVG-0004WF-PJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:24:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jajVG-0001E1-4h
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:24:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id n18so370633wmj.5
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kWpQaD2wGQ34Zpxhrcq/ZI+v1ZQmqU5R8XiGN8Crc00=;
 b=bLz226nzhyXbmRy43kDTL8WhL3+sAr5AOk4p8knHWhBzy3srPvtIiDMh8tHqk+lbHC
 +OOIOE9UxLOc+SyDiHOumy5BqV1vbapAmaMHQGnORZDoATv3jwXT1xUJtKjcGCx3d53p
 PsX1JQ/SrJkQ2qy+klRSnGGchOF46yeXPNTraBWdrsVDEs6BM9WPb7ZVcBbu8eeDnb+T
 fhz8QaCoSKT/jVruHrecwEk+DLH0//nGKRHkir8Zs+sjFmx70WWgOI59YLXTO/vj13iB
 RjlsR3HOHwIbPOvoN1AUf0GvIqIOuxlB8tLOga0ACpFBB2wGqTWpIGjKu/GwtaEukw6O
 MYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kWpQaD2wGQ34Zpxhrcq/ZI+v1ZQmqU5R8XiGN8Crc00=;
 b=rAZej3//Q5JtDXb/H+AKJZbi9B0z/fp5UbJR5G69LD/y65khQopXxyd8Y7+vJ88Ddm
 T1WWQLpiJ75G8VqKkc7hlN8crcNLLMWa8SYLvvGkqgf0zNxf6sdl8TtnKqk9zdtGiOlg
 o5yb+8r+H4NKpns7+SlhU22UWfajgjcKvpbnwjGiGE2qvYwHkUTBBUhtWieccZ47NIEs
 DUM0856xZOwoj3Ro3JC2L3+r7HMTZ5o5P2EmrbcaxhSZnLigqid6Rr1rkc6b3vrDqGEN
 bImGhSBMDca8g0M9NpPvDn2rZ8JtXi0I2W9Q1bawc7jd7+2xENnwEFHjWmcdrkZ9nZjC
 GZkQ==
X-Gm-Message-State: AOAM531FpgNKkDvk6GV9Zt11PKDgeuQ0JpMFPKiEB7xlbuGvHAz5ySZO
 iAmyY0WRBHHn9VxoEGpokzE=
X-Google-Smtp-Source: ABdhPJwPLOzAMsW7EzGY1rYv4XlvgzHozfy1O2ZSELL5XR9WJLQmvlujw1+E3c6tvccdZ4y5WI4BqA==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr431033wmj.40.1589822676679;
 Mon, 18 May 2020 10:24:36 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 8sm338545wmb.15.2020.05.18.10.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 10:24:35 -0700 (PDT)
Subject: Re: [PATCH] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
To: Thomas Huth <th.huth@posteo.de>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20200518094904.24226-1-f4bug@amsat.org>
 <6a1d8e73-9417-2e52-a2a9-e5d1c00a0a2a@redhat.com>
 <6dc504aa-1fea-e5dd-1ba9-d1d59fbcb198@amsat.org>
 <8092949e-43fc-f45f-a5e4-f16981657967@posteo.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e04d0a1d-25c1-b313-3878-9a6af1279a37@amsat.org>
Date: Mon, 18 May 2020 19:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8092949e-43fc-f45f-a5e4-f16981657967@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 7:17 PM, Thomas Huth wrote:
> On 18/05/2020 19.08, Philippe Mathieu-Daudé wrote:
>> On 5/18/20 6:32 PM, Thomas Huth wrote:
>>> On 18/05/2020 11.49, Philippe Mathieu-Daudé wrote:
>>>> hw_error() calls exit(). This a bit overkill when we can log
>>>> the accesses as unimplemented or guest error.
>>>
>>> Good idea. hw_error() is also mainly for CPU errors, it really should
>>> not be used for non-CPU devices.
>>
>> Are you sure?
>>
>> $ git grep hw_error target | wc -l
>> 5
>> $ git grep hw_error hw | wc -l
>> 137
> 
> Well, the function is defined in cpus.c and it's dumping the state of
> each CPU ... I think it's used in a lot of places during development of
> new code to quickly get some information on where things went wrong in
> the guest, but technically, it really sounds wrong to me that a non-CPU
> device creates CPU dumps in mature code.

OK got it now, thanks.

