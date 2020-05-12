Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2296C47255
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 02:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E0D20675
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 02:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E0D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYKFs-0003a7-R7
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 22:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jYKEv-0002nV-6B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 22:01:49 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jYKEt-0003bH-1Z
 for qemu-devel@nongnu.org; Mon, 11 May 2020 22:01:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1723538|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_social|0.0954109-0.000910089-0.903679; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03309; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.HX7DxE7_1589248891; 
Received: from 30.225.208.71(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HX7DxE7_1589248891)
 by smtp.aliyun-inc.com(10.147.40.233);
 Tue, 12 May 2020 10:01:32 +0800
To: pavel.dovgaluk@ispras.ru
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: Questions about record & replay for RISC-V
Message-ID: <30f3e5ff-fd20-5005-a033-d8c93a0f3194@c-sky.com>
Date: Tue, 12 May 2020 10:01:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 22:01:33
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pavel,

I am developing a profiling tool depending on record & replay feature of 
QEMU for  RISC-V.
Here I'd like to ask you some questions.

First, is it possible to record & replay a Linux system by this feature 
in theory? I mean keep the strict instruction
sequence of each process and kernel, for a very simple image,  with only 
timer and UART.

Second, is it planed to support RISC-V?

Thanks very much.

Best regards,
Zhiwei

