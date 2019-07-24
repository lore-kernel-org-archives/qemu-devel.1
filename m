Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE63C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 10:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A40229ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 10:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A40229ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqEnc-0001tQ-E8
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 06:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqEnQ-0001Sk-E3
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqEnP-000161-C0
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:46:56 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqEnP-00015X-3s
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 06:46:55 -0400
Received: by mail-wm1-f49.google.com with SMTP id v19so41191872wmj.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 03:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vUSgmpYgu6XJfkWUE0yfmVCKZoTeuXhUBCIdw3Suh4A=;
 b=ObMtj3AfU1wqCzhE86nUwYYZ9P2v6KUGpeK34Vu9AKaryZBUjn0q5Sr9s5/XTkz5m6
 INeUMONSCIN+tEyKfWaot+mqnheP7sO7/FYLjKnZq5mm0/FA5L+1lwUhyYc5zj4iReAs
 1Pk5NPlzE74JBpjR7xvvvqOkPi7ONop03BReKANuc4JNvIxkBoiSFEUoukRtBuwKp2qf
 yFrq1bcTvegBZ3OeWbM0aB6DLghYyLKwHbG+HT9YuyRXd1LiRbq9dfZ9mENRtADiQecv
 RnEwGGT8c0EEbif620NqLgnIALQ8HS/eKYLtYBLM1Mwr2PR8kxOnqeTQe629BDzQRjj4
 KO1A==
X-Gm-Message-State: APjAAAWtxAwt9dkDT7qzXzN4b3fXQ19xtaV8888uV/tQA6HJf40/irpZ
 skAKf8hTLPB4wjAJViOemgADdQ==
X-Google-Smtp-Source: APXvYqxdprEA/O7NgKE1QCcOnwmp7Zxi1LzGCMegzkcPFVjMT6Jbn48MJACRz8T9FDeZGmbH9kLYvg==
X-Received: by 2002:a05:600c:2311:: with SMTP id
 17mr71644384wmo.18.1563965214016; 
 Wed, 24 Jul 2019 03:46:54 -0700 (PDT)
Received: from [10.201.33.105] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id f1sm31373136wml.28.2019.07.24.03.46.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 03:46:53 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <156390240449.12764.14466682904037881386@c4a48874b076>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d4992f3d-489a-644e-093f-dfbff27bdda8@redhat.com>
Date: Wed, 24 Jul 2019 12:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156390240449.12764.14466682904037881386@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.49
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Refresh APT cache before
 installing new packages on Debian
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
Cc: fam@euphon.net, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Xiao Guangrong <xiaoguangrong@tencent.com>,
 Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the qtest maintainers and Xiao since I have no clue about this test.

On 7/23/19 7:20 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190723141528.18023-1-philmd@redhat.com/
> ---
> PASS 4 pxe-test /x86_64/pxe/ipv4/q35/virtio-net-pci
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/rtc-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="rtc-test" 
> **
> ERROR:/tmp/qemu-test/src/tests/rtc-test.c:173:check_time: assertion failed (ABS(t - s) <= wiggle): (3 <= 2)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/rtc-test.c:173:check_time: assertion failed (ABS(t - s) <= wiggle): (3 <= 2)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:899: check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
> 
> The full log is available at
> http://patchew.org/logs/20190723141528.18023-1-philmd@redhat.com/testing.asan/?type=message.

