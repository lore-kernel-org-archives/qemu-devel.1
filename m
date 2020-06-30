Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D09C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB536206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVaXpy0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB536206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJLm-0002jL-2O
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJKt-0002AJ-Ab; Tue, 30 Jun 2020 12:42:19 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:32942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJKr-0007Fz-5Z; Tue, 30 Jun 2020 12:42:18 -0400
Received: by mail-ed1-x535.google.com with SMTP id h28so16876790edz.0;
 Tue, 30 Jun 2020 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=buVjnKtsgM/hiikKP5YdIW+PSfTeTQ7j1E2XzUxbNdc=;
 b=GVaXpy0yWaoT/s8aKNh51iLkXSb0H+ujLZdeVJyNAb+3J8B++jtfj62Bzb60Eo/sAD
 4IzKWmZPJwWOr316T5PIKPDtJGjHklbFcTBC95uf3uoyZj6BSvD/9AM6uPGaT4bJVKhU
 o28QOVPBRJ7OiW/mSfcbCep6Ma0atZX7zHy1Kt5Cb5oD1LV2NUqWxeD0qZTHsUlguEC1
 xONUndMoSExhOtR25i2jqSEVC9EjLHJEgR1/5Nu3vRgWZ7Tfa3HXQ3EvvNZrXuEMrhLm
 ERTYFoVMWQcKcnv4dxh0HSF0XS8WkENtxPVhdLWj1tlN8UQWP6a/fyBj822kkH0YGWI5
 BXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=buVjnKtsgM/hiikKP5YdIW+PSfTeTQ7j1E2XzUxbNdc=;
 b=qvF9hgAN12l2fiptgDAX6dpa8gSTiYX7mINDtrxqvLNynIc6XLhTzwASwAR2WmYSFb
 myLbNJbPoGMtCzVQ7Mh7FHZ7hxrqsGHSf8dEgtLN0I0tWHtpPZz2b3B2ePqWDZZ/+TK0
 rel/g9AwQ4oinFRHRPLzfBS/5xNNGmEDbTsI2G1kWyb2PVI+0X683UGjoiKEnswRFmK0
 vNtEzrsvKuSY/fLOqI8cMSHRwCS5KYvDf6TKr5dyexcQ8hENNV2v3Fk16os/HL/vgYPk
 zPmsLB6hxMV3kAZkgJp+fwudO4H8fg0dOfUDy1Fi7Isohfz4Mctvs8uj9kjkmGBwzamO
 pAEg==
X-Gm-Message-State: AOAM531hnIYtBhIugf+EyUbbRWT6ijiyujsYoTFSE52k5Tn1dzVcpkmE
 bDXEqgAHsuY3UlSKPWoaA/1uFi3VTi0=
X-Google-Smtp-Source: ABdhPJzkEdufy+P5WWM9HnNyru1orq6sKqjlfvNVQ/3N68Bje4ArFiXHg4FLhJIjN4DOYDJdOfd0LA==
X-Received: by 2002:a50:f109:: with SMTP id w9mr23061308edl.277.1593535335139; 
 Tue, 30 Jun 2020 09:42:15 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id be2sm3311728edb.92.2020.06.30.09.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 09:42:14 -0700 (PDT)
Subject: Re: hw/misc/aspeed_scu: 5d971f9e breaks Supermicro AST2400
To: Erik Smit <erik.lucas.smit@gmail.com>
References: <CA+MHfoubt1g2FzcjTw3a0vNr7X2T8Jb+nYoc4_x=Z2TP51afKg@mail.gmail.com>
 <a7acba46-5a9a-5dd2-71c6-7e4586485823@amsat.org>
 <CA+MHfot6FdS2yT0mEsCW36bCfwy-WY-1KPQ-KDfYBKzTy=Gd7w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f67f8c26-3ae9-72c9-9404-7c28e09deb18@amsat.org>
Date: Tue, 30 Jun 2020 18:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfot6FdS2yT0mEsCW36bCfwy-WY-1KPQ-KDfYBKzTy=Gd7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 5:32 PM, Erik Smit wrote:
> Hi Philippe,
> 
> On Tue, 30 Jun 2020 at 17:29, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Erik,
>>
>> On 6/30/20 5:11 PM, Erik Smit wrote:
>>> Hello,
>>>
>>> 5d971f9e memory: Revert "memory: accept mismatching sizes in
>>> memory_region_access_valid" breaks Supermicro AST2400 u-boot.
>>> Supermicro AST2500 u-boot is fine.
>>>
>>> The u-boot tries to make a 2-byte read from address 0x84, but
>>> aspeed_ast2400_scu_ops has min_access = 4. When I change min_access to
>>> 2 or revert above commit, u-boot boots again.
>>>
>>> Is changing min_access to 2 the right way to fix this?
>>
>> If you have access to the datasheet and can verify, then yes.
>> Else I suppose Cédric, Andrew or Joel can check for you.
> 
> I do not have a datasheet. Aspeed seems quite picky about sharing this
> and I'm just a random researcher.

Neither I have them. The I suggest to open a bug on
https://bugs.launchpad.net/qemu/+filebug and we'll ask the Aspeed folks
to write a patch.

> 
> Best regards,
> 
> Erik Smit
> 

