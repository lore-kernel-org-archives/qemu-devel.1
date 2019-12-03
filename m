Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A114FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2202068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gge1iNbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2202068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7wl-0002Ti-9O
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ic7oG-0006HD-OE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ic7o5-00043u-7s
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:01:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ic7o5-0003uv-35
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575378086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=2fFnz/Aj1Pp+kEJTzCgNJw48MFTE8Uwes9027KPoL0E=;
 b=Gge1iNbo8exZzMlKDCpWL8Ffe/8h9RZes+gLGBk2+qLj19liXd5l96ApU98A7BmrK6Dnlh
 fA5LwOca5hiXTnrWCamyBAn/sVR0Gi90aZ85acbm8RuhSiaDh1iRtlCK7OgIyoPFXNmdRS
 20tixW5RENOwr1qVhSQVi5kIqhhUs7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-nbF3ed9yMV-7zY4bN5cvjg-1; Tue, 03 Dec 2019 08:01:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAAF08024CC;
 Tue,  3 Dec 2019 13:01:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3267667E5D;
 Tue,  3 Dec 2019 13:01:20 +0000 (UTC)
Subject: Re: [PATCH 0/5] tests: Enable fw_cfg tests on AArch64
To: Xiang Zheng <zhengxiang9@huawei.com>, peter.maydell@linaro.org,
 lvivier@redhat.com
References: <20191203122753.19792-1-zhengxiang9@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b5ef73c8-fa23-8efe-ef03-1d223a49bb93@redhat.com>
Date: Tue, 3 Dec 2019 14:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191203122753.19792-1-zhengxiang9@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nbF3ed9yMV-7zY4bN5cvjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: lersek@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kraxel@redhat.com, wanghaibin.wang@huawei.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/2019 13.27, Xiang Zheng wrote:
> There are quite a few tests disabled on AArch64 such as fw_cfg-tests.
> This patch series fix some problems in test code and adapt it to
> virt machine.
> 
> Xiang Zheng (5):
>   tests: fw_cfg: Rename pc_fw_cfg_* to fw_cfg_*
>   tests: fw_cfg: Support read/write of fw_cfg registers on aarch64
>   tests: fw_cfg: Use virt as default machine in fw_cfg-test.c
>   hw/arm/virt: Add FW_CFG_RAM_SIZE and FW_CFG_MAX_CPUS into fw_cfg
>   tests: Enable fw_cfg test on aarch64

 Hi,

this breaks "make check-qtest-ppc64":

  TEST    check-qtest-ppc64: tests/boot-order-test
**
ERROR:tests/boot-order-test.c:40:test_a_boot_order: assertion failed
(actual == expected_boot): (0x00000000 == 0x00000063)

Please make sure that "make check" continuous to work with all other
targets, too.

 Thanks,
  Thomas


