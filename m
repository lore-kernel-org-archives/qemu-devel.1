Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E46C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0D3206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS5jjPYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0D3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf8r-0004Dz-Dl
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqf7Q-0002ki-Fa
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:57:52 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqf7O-0003XE-Va
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:57:52 -0400
Received: by mail-ed1-x541.google.com with SMTP id dg28so20392121edb.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K+Z4gOBEo24SWBd8SGzeOFjVkM7ccFKwd0BqNjzJ8ak=;
 b=BS5jjPYAepF0WWqRHb/h3iJqRo9xwDbylEVX4oIr45m9Tx/ziz+YyGzdnFs4znMLiE
 UovReB1Tk9w083pPGjQba8jo9sN3f+g+nGI9/B1vD8/zHrGs6ctiBQRZTd/svMbUTLOh
 +mCCzcoCwwjUW7rAIyH0XHB8p9VrRr1ukx3IytsCe1L4f2yr5RlcNPiyG1+92Os9w800
 sLdKFKUipLnrezS/sW0J64ipAgzjArhujF3GF580cWIxzuLECNIp8PJoEtky2FSzqnUF
 d+bKGXonROkaOFDG3WHl2smUNT1X9//KfQowD+i/5E4SANMASNOKmk9LvcC8M02lnuw6
 GbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K+Z4gOBEo24SWBd8SGzeOFjVkM7ccFKwd0BqNjzJ8ak=;
 b=Ztlo06LBuCIT+cI9s6km8ZoDBKgthGR1//yzf2LrvREOnNDl/e57hQooxxzj/giOkp
 1NoiSDJ4l6VkzomSjyYHIu6vnZG1x8iobNhZqw8VwleexUzofL+JugLYtf2q/3MrvrWs
 OsGG9mVJcofryrxmaisqFsAybh4iHW6SR/4mKmtOtQmVcdcnqyu146ZYfNpSRMkSF/IJ
 +KP8A5X8ylj7n2mXpbVE4qt3RSwJxeKmTkj7qGfZGftI88GvpCcrBAOECNUwH9fjDSyI
 fmMldnL8xnm6FG427F12CiEIFgNxl2sUgZ0zGwiVCTdxPPyejds8JfggtYhweeMVUZL+
 7ajA==
X-Gm-Message-State: AOAM530MYI0DyBptaP8x5EFD7OFOsCbCn1/uiexwdA6C4fyrCcf8P9L/
 TF/uzIWKO9tiUA7IXxadfNI=
X-Google-Smtp-Source: ABdhPJzBmFpjtt+1spe7VmhdCY+75PT+KBRfhcKBdBP1yfOmEvfoLyA07XQnBhnpJ/I/Sq19U6p2DA==
X-Received: by 2002:aa7:ce84:: with SMTP id y4mr28676533edv.113.1593619069209; 
 Wed, 01 Jul 2020 08:57:49 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id n2sm6754945edq.73.2020.07.01.08.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:57:48 -0700 (PDT)
Subject: Re: [PATCH v4 29/40] tests/acceptance: skip LinuxInitrd 2gib with
 v4.16 on GitLab
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-30-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <112ee597-9c01-494a-3fd2-6f772e04d345@amsat.org>
Date: Wed, 1 Jul 2020 17:57:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701135652.1366-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 3:56 PM, Alex Bennée wrote:
> This fails on GitLab but not when run locally on the same container
> image. It's very confusing.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/acceptance/linux_initrd.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
> index a3e54d3fc91..a249e2f14a2 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -8,10 +8,12 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> +import os
>  import logging
>  import tempfile
>  
>  from avocado_qemu import Test
> +from avocado import skipIf
>  
>  
>  class LinuxInitrd(Test):
> @@ -51,6 +53,7 @@ class LinuxInitrd(Test):
>                  max_size + 1)
>              self.assertRegex(self.vm.get_log(), expected_msg)
>  
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_with_2gib_file_should_work_with_linux_v4_16(self):
>          """
>          QEMU has supported up to 4 GiB initrd for recent kernel
> 

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

