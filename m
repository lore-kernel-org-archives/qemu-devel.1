Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C231C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E714223FD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3O2c46E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E714223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyDd-0007Eb-Nw
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWyBm-0005Lb-Hb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWyBj-0002r9-Gr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603702148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcNtC6ZuRRhQPrbDQcYraK2z+kfnyAwIJi/r/S9RxBU=;
 b=S3O2c46EpjZHCaHxp8WwOf0AjQooqT2d8plsDnPOo1C8UcKIxGapltJTAVVSqRrOe48D9X
 dECj5zKqQsqwW+v/Ivc1z3n9dRpRfimvnXTqFa3cvvt4oUywp7UayfiZv1QopvccFF1opq
 JNgMDGhfGQ6IF4EZg1qxLZuBNYwN9DI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-wuXGePBJPremEoZX8gUorQ-1; Mon, 26 Oct 2020 04:49:03 -0400
X-MC-Unique: wuXGePBJPremEoZX8gUorQ-1
Received: by mail-wr1-f72.google.com with SMTP id m20so8055971wrb.21
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 01:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QcNtC6ZuRRhQPrbDQcYraK2z+kfnyAwIJi/r/S9RxBU=;
 b=p6ju+OAiItkVmRq2KF3qwdVdeHDnZfeLTo8+V44WpGMgKQ3bQTG+LMGYQ36oyKwOVQ
 AluqXC2TGOHPNqIroTpsqRbYtXiCTNPmy7svMUStgFIvwWtYtxyzG7di+z3ncowuDNPo
 jNQqRL4EwDiFpbtqIfQA4OpYhzs3+xuX2fuHdToA2XkruyvURfO2d+Ek0BHr94JoDyuu
 mtobh715Y7Vpx19XHA1X4fdXZ4Byf3gPKojtlWNDVWpb5UUHDaNR2Lva5x7fCJP4qwgy
 g4ruMpXgByHnQKO5oXrpAmcamRUk+4WTdvoT/56Rq+CEpyXiKxngKlWoP9Emq0AE8325
 QlbA==
X-Gm-Message-State: AOAM533s7qfIAClNldnsWYTIake20L/N2oEMFzsldZGk8JGQNCqjzwi3
 D3ZK6F29oFet4WVc0CFJrQbozdSNqbetuA2LlCDOQV/tTOSh282A6XnBQUeZcZ0jH00E/Oi2lZ0
 lOVFKV9hJUszgRzU=
X-Received: by 2002:adf:f810:: with SMTP id s16mr15848354wrp.424.1603702142215; 
 Mon, 26 Oct 2020 01:49:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcL2YJ7nmrXIPhMLpvuLIMgPwfE2QZMoh9t2BKDR0//u1nGPzdwUNyi+1lv9XGafT+u8de4Q==
X-Received: by 2002:adf:f810:: with SMTP id s16mr15848330wrp.424.1603702142019; 
 Mon, 26 Oct 2020 01:49:02 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t19sm18179094wmj.42.2020.10.26.01.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 01:49:01 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from Armbian
 20.08 on Orange Pi PC
To: qemu-devel@nongnu.org
References: <20201023131808.3198005-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <50dff910-20a5-5efe-4094-954d5e40802e@redhat.com>
Date: Mon, 26 Oct 2020 09:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023131808.3198005-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 3:18 PM, Philippe Mathieu-Daudé wrote:
> Series meant to help Bin Meng to debug the SD card issue
> reported by Michael Roth.
> 
> Philippe Mathieu-Daudé (4):
>    Revert "hw/sd: Fix incorrect populated function switch status data
>      structure"
>    tests/acceptance: Allow running Orange Pi test using cached artifacts
>    tests/acceptance: Extract do_test_arm_orangepi_armbian_uboot() method
>    tests/acceptance: Test U-Boot/Linux from Armbian 20.08 on Orange Pi PC
> 
>   hw/sd/sd.c                             |  3 +-
>   tests/acceptance/boot_linux_console.py | 68 +++++++++++++++++++-------
>   2 files changed, 50 insertions(+), 21 deletions(-)

Thanks, patch #2 applied to my acceptance-testing tree.


