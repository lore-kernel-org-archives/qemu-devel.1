Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AA9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 04:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A02206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 04:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A02206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtObS-00034U-7E
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 00:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jtOZD-0002BA-Hu
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 00:53:51 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:60584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jtOZA-0005wM-HB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 00:53:51 -0400
Received: from localhost (unknown [192.168.167.235])
 by regular1.263xmail.com (Postfix) with ESMTP id C8AF837E;
 Thu,  9 Jul 2020 12:53:36 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.17] (unknown [223.72.96.108])
 by smtp.263.net (postfix) whith ESMTP id
 P6414T140039679895296S1594270416754862_; 
 Thu, 09 Jul 2020 12:53:36 +0800 (CST)
X-UNIQUE-TAG: <f309611ddd731e3433c2fff25848b874>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 223.72.96.108
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v7] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200605013221.22828-1-chengang@emindsoft.com.cn>
 <2f90b61a-b671-6f9c-a4a3-d031e3fbb56a@vivier.eu>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <5054a1a0-876b-26f1-c08b-c7e3b149ab7e@emindsoft.com.cn>
Date: Thu, 9 Jul 2020 12:53:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2f90b61a-b671-6f9c-a4a3-d031e3fbb56a@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.150.70.206;
 envelope-from=chengang@emindsoft.com.cn; helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 00:53:38
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I shall try to send another DRM_IOCTL_* patches within this weekend.

Thanks.

On 2020/6/29 下午7:05, Laurent Vivier wrote:
> Le 05/06/2020 à 03:32, chengang@emindsoft.com.cn a écrit :
>> From: Chen Gang <chengang@emindsoft.com.cn>
>>
>> Another DRM_IOCTL_* commands will be done later.
>>
>> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
>>
...
> 
> Applied to my branch linux-user-for-5.1
> 
> Thanks,
> Laurent
> 




