Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B4CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4D3204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="Vuj7F7LQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4D3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbhx7-0005sS-Gb
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jbhw3-0004ss-9b
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:56:19 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:35504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jbhw2-0005as-8P
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:56:18 -0400
Received: by mail-pj1-x1035.google.com with SMTP id 5so2816368pjd.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:subject:to:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=Pi6MfxT/dZ7F7Ipj8H60MtgaLEzF+Qv42PQYEC97aHg=;
 b=Vuj7F7LQTR/RLM2g5vVXLrXgTBtwPTxL/UBALQUWOlNbgp9chkRLY5Y9FFFV4RTW8T
 m6GnZVD7KiLEuNveFGkrboxKXrfeQ/Xe+p7gA4/SHsGLsV1DguQ4Zv9YZfxhlQBis0BB
 JKyXxLalkMOwghsqY/3e7LgTSYgq71eNcNlOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=Pi6MfxT/dZ7F7Ipj8H60MtgaLEzF+Qv42PQYEC97aHg=;
 b=Bs+0y3iZ6D2Fkmebk1KVuklcv2RK/xwAWrjhZeeH7BacUAFqq06wTy/tGULefjEb4x
 DstfHLfu1NFttxeTYVigDNaCk0nN6poZ8iUO2Y2jvUygGXGxC+ifd7mShz/yrk8gMV25
 N4WdRrwk/RwRRhuZTGnB2OM0gFQrC2TMaMAGOACRMWwVYsTRvYKn3EBaTuPg+3XsUX4V
 pUFaWXgnS03oQSYlhXEjV4Dt+EXsVGaxY/ObIWBswaHsMccF3KprS5Uxj5d6sYlbeBh5
 aMHPfFA807qIqOYq/3zdKIzIhMmPrKdvjsuHPK31dCmk/Pz+H+ClbFN1FQp8Po4P0+/G
 ug+g==
X-Gm-Message-State: AOAM531mgu9zHKXQJErsY3uG3pr/DEp1+WIGtjkEbQB0No3ZpygiqszI
 YhcEtog7QzgYKUv/N8O8gJfTRPPZGZE=
X-Google-Smtp-Source: ABdhPJzMLlnITw5/3XH1agN2RSp6ysqMlOUfYhile7nvjd1szmCvSiiIstU3LwLf9VHWmcWwN2Cszg==
X-Received: by 2002:a17:90a:1a17:: with SMTP id
 23mr5980766pjk.198.1590054975834; 
 Thu, 21 May 2020 02:56:15 -0700 (PDT)
Received: from Jing-Weide-MacBook-Pro-3.local
 (202-39-79-13.HINET-IP.hinet.net. [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id j17sm3724353pgk.66.2020.05.21.02.56.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 02:56:14 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
Subject: cluster_size got from backup_calculate_cluster_size()
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <7b96191b-2c16-7257-9ae3-50457bf82e27@qnap.com>
Date: Thu, 21 May 2020 17:56:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=dereksu@qnap.com; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The cluster_size got from backup_calculate_cluster_size(),
MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size), is 64K regardless
of the target image's cluster size.


For example:

If the cluster size of source and target qcow2 images are both 16K, the 
64K from backup_calculate_cluster_size() results in unwanted copies of 
clusters.

The behavior slows down the backup (block-copy) process when the
source image receives lots of rand writes.


Is the following calculation reasonable for the above issue?


```
static int64_t backup_calculate_cluster_size(BlockDriverState *target,
                                              Error **errp)
{
     ...

     ret = bdrv_get_info(target, &bdi);

     ...

     return (bdi.cluster_size == 0 ?
                 BACKUP_CLUSTER_SIZE_DEFAULT : cluster_size);
}

```

Thanks.
Regards,

Derek

