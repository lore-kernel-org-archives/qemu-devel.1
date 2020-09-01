Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BBEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312AF206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjFSQNT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312AF206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6md-0003xW-9G
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6lB-0001hu-Ty; Tue, 01 Sep 2020 09:55:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6lA-0001iY-7m; Tue, 01 Sep 2020 09:55:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id v4so1243414wmj.5;
 Tue, 01 Sep 2020 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yYj87MKllDEVc9OuExPdXbUKOlq8/L2fn2QYZMR3YcM=;
 b=mjFSQNT17rmCxkZb8+rNH+MnVqQLcrgPvCl3jsha8w3SCSZpY1dwUqqB6pP25n/8f/
 4k/HDhOUBFD3xDEMS1V5tpSwPCLj7+bZY/yNxRsqpcwTt71I05qK5q96BCChPm6fvyod
 L57pQnbYtxojbDwcpiy3XAUyRrEzVoZgwaCCf7aeYB5YU80wWcUZuc4ue2glCxsOBAjV
 oGp3qpP7tJd7p8i+iMQBYIQgJR30ITxaAFVW7+vkdMA1+teXpyRKgBGYCXc58GaDKeRV
 ri9fz5CI+Ngk/xz5JI2RvbqnTtQTB7uDoTdshniH5jYPJj7frpH3z1XaYJkNTs964CnM
 Obww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yYj87MKllDEVc9OuExPdXbUKOlq8/L2fn2QYZMR3YcM=;
 b=GmjLSDPUjosTDQmpej5htRXn5cLOycffw/4Nr3rVJiWx8SajWKzQDHvKbTzPVYnmPm
 BAHdN3AO1J56t7SBga/PemVi8qNZlewBeG6D3bQyv60VCsZlv2kd6emy05TKcBdebKa9
 Sd2SgSIVXFLmQ2NM5lYwKN06zTNU4ktCsBH2xLHSH29LUZ8a43vsbFedaoBhr9JlCdft
 AAvVDhEQ/fbQfzjZaI2ZJjjM9mYAywFQROKxhqqsX+Ggs0cC47I3O6NJOR8Jf5OFtT1G
 C6YcEfcgYZtSHNDdLxNVA8r3PLzht2BK92qipGEiXi86/oxhg7s6AHgy2RCvwIDjCBTF
 1M5Q==
X-Gm-Message-State: AOAM531TsN9aZw6ECbo6o/nax4U8Db/XONgPX/07H8CfGZNGsvcR8Hxj
 jk3Sl3fg0DKZLRTADap4BdQ=
X-Google-Smtp-Source: ABdhPJyxkYSdPuGkUeLF4BiMRf2NIC5TaeTCrIXR4OnV/GZmFHy2KEQp7NVe6pQ90WNGk0tGQ9vigw==
X-Received: by 2002:a1c:2646:: with SMTP id m67mr1890817wmm.177.1598968537867; 
 Tue, 01 Sep 2020 06:55:37 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q12sm2325018wrn.94.2020.09.01.06.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 06:55:37 -0700 (PDT)
Subject: Re: [PATCH 0/7] block: Use definitions instead of magic values
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200814082841.27000-1-f4bug@amsat.org>
 <e232bf0a-1362-a90d-31ff-95d90ad7ebc8@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6bb8b9a1-10fb-bb62-f895-f3d7164339de@amsat.org>
Date: Tue, 1 Sep 2020 15:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e232bf0a-1362-a90d-31ff-95d90ad7ebc8@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 11:27 AM, Laurent Vivier wrote:
> Le 14/08/2020 à 10:28, Philippe Mathieu-Daudé a écrit :
>> Trivial block patches:
>> - Fix a typo
>> - Replace '1 << 30' by '1 * GiB' in null-co
>> - Replace 512 by BDRV_SECTOR_SIZE when appropriate.
>>
>> Philippe Mathieu-Daudé (7):
>>   block/null: Make more explicit the driver default size is 1GiB
>>   hw/ide/core: Trivial typo fix
>>   hw/ide/core: Replace magic '512' value by BDRV_SECTOR_SIZE
>>   hw/ide/ahci: Replace magic '512' value by BDRV_SECTOR_SIZE
>>   hw/ide/atapi: Replace magic '512' value by BDRV_SECTOR_SIZE
>>   hw/ide/pci: Replace magic '512' value by BDRV_SECTOR_SIZE
>>   hw/scsi/scsi-disk: Replace magic '512' value by BDRV_SECTOR_SIZE
>>
>>  block/null.c        |  4 +++-
>>  hw/ide/ahci.c       |  5 +++--
>>  hw/ide/atapi.c      |  8 ++++----
>>  hw/ide/core.c       | 25 +++++++++++++------------
>>  hw/ide/pci.c        |  2 +-
>>  hw/scsi/scsi-disk.c | 44 +++++++++++++++++++++++---------------------
>>  6 files changed, 47 insertions(+), 41 deletions(-)
>>
> 
> Applied to my trivial-patches branch.
> 
> Except the following ones that have comment from Kevin:
> 
> [PATCH 1/7] block/null: Make more explicit the driver default size is 1GiB
> [PATCH 3/7] hw/ide/core: Replace magic '512' value by BDRV_SECTOR_SIZE

Thanks!

Phil.

