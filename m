Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726DBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C45206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXlbKBix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C45206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVRH-0005mJ-Iv
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsVQR-0005AR-4H; Mon, 06 Jul 2020 14:01:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:37138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsVQO-00011d-ID; Mon, 06 Jul 2020 14:01:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id o2so43036973wmh.2;
 Mon, 06 Jul 2020 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tNykd+kQQq+eNUlSrefBThQO4x6gegzICOk9XXdP+lU=;
 b=uXlbKBixUJbg3te0S56MJc5CiF/YwLkYoxzKb/5ti9liaFNZjAVuqxZkp49T8DLTyV
 SbalIvgTKjfDKY6cm2AoNkD/+OnK1KQk3pS9eW4Xdy0/n3iVUZfu8EeZecAn3ePBju41
 GU2YgTjm/H/gO2bJVV4BV8BkI7Rb7Xt/lBz6vdVVQv5JVIXBR2/pj23cRc8OCycBmRxs
 J5u7eLBuibTV/OY9gmlYkQnwRwCxQOlODhYCX8OIJT/KK9mqNBBarRmGZ/flhBpGCz5W
 mdZOQBY0rxHne/QjHxO54NzeENKDBKpLjNfclo9zuY+axz6/5OvM2BBLURq/3S3lPwuI
 FLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tNykd+kQQq+eNUlSrefBThQO4x6gegzICOk9XXdP+lU=;
 b=DnIeowCx+7ncfNiW5jnfIoz/b5Bh0Zi0Mwb26CtpeDXaPoLYpvWAC5VlSZGZQ3zggm
 c3mUsccdFSyitYzvTGqCNNVhJPSlPZChcSlSG+f4AJPJdyp5SGxdM8aboSdhQKCbBoLX
 8R4IR5HDovMMGyi9tF8MUKBoOnYifdolH8uvDbgwH5IX3XQxb/Y+5/KENbmLn/dFQVbD
 WNr5NUy8uHZOkx7G+DtMYTUc9iYznZ4amd5EKpsjPyJD4kJGPIMFd/t5BDhwo4JH3h0u
 aBhObQWuNBhDoodbB4hLsrkoV4/UJGAAb8cf1LhOSgeWmBmeMN0n7Hj+9zUiAAxazV1e
 OE5Q==
X-Gm-Message-State: AOAM5301pU838ohbozYvEoxH79Db6RVcw3uyMx+QRwGCsP4cK17BELa7
 /H1/Plr+kMC9eNpPdCEInBGUhi/2
X-Google-Smtp-Source: ABdhPJxRQAqrEGryukXSyFGa9buk+MSB1LdT4zwzzaAXp675twRtzbarJZaAiy4nv78435+npF2tFw==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr361972wmh.176.1594058461729; 
 Mon, 06 Jul 2020 11:01:01 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u8sm24232241wrt.28.2020.07.06.11.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 11:01:00 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
To: Alistair Francis <alistair23@gmail.com>
References: <20200605102230.21493-1-philmd@redhat.com>
 <7a456fdc-eb53-063b-1d5e-24472b4057d5@redhat.com>
 <CAKmqyKPaQxw4Gw-Fi5X3PT2kBed+Z+iAAuobSAnfCd9hjZ_3QA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19b9d0ef-bc61-277c-b8c9-05ffa9cefb8a@amsat.org>
Date: Mon, 6 Jul 2020 20:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPaQxw4Gw-Fi5X3PT2kBed+Z+iAAuobSAnfCd9hjZ_3QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 6:31 PM, Alistair Francis wrote:
> On Mon, Jun 8, 2020 at 10:48 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> Hi Alistair,
>>
>> On 6/5/20 12:22 PM, Philippe Mathieu-Daudé wrote:
>>> Patches 2 & 3 fix CVE-2020-13253.
>>> The rest are (accumulated) cleanups.
>>>
>>> Supersedes: <20200604182502.24228-1-f4bug@amsat.org>
>>>
>>> Philippe Mathieu-Daudé (11):
>>>   MAINTAINERS: Cc qemu-block mailing list
>>>   hw/sd/sdcard: Update coding style to make checkpatch.pl happy
>>>   hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
>>>   hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
>>>   hw/sd/sdcard: Update the SDState documentation
>>>   hw/sd/sdcard: Simplify cmd_valid_while_locked()
>>>   hw/sd/sdcard: Constify sd_crc*()'s message argument
>>>   hw/sd/sdcard: Make iolen unsigned
>>>   hw/sd/sdcard: Correctly display the command name in trace events
>>>   hw/sd/sdcard: Display offset in read/write_data() trace events
>>>   hw/sd/sdcard: Simplify realize() a bit
>>
>> I forgot to Cc you.
>>
>> Since you already reviewed a bunch of SD patches in the
>> past, do you mind having a look a this series? It should
>> be quite trivial.
> 
> Hey,
> 
> Sorry I took so long but I have reviewed a few. Let me know if there
> are anymore you want reviewed.

No problem, just in time :)

Thank you a lot for all your reviews!

Phil.

> 
> Alistair

