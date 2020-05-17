Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFFC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788752075F
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788752075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaJ2r-0001J5-IB
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 09:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jaJ2J-0000tF-MR
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:08:59 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:53538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jaJ2H-0005pn-A2
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:08:59 -0400
Received: from localhost (unknown [192.168.167.13])
 by regular1.263xmail.com (Postfix) with ESMTP id 116C63FE;
 Sun, 17 May 2020 21:08:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.8] (unknown [120.244.106.114])
 by smtp.263.net (postfix) whith ESMTP id
 P7431T140153104365312S1589720923176868_; 
 Sun, 17 May 2020 21:08:43 +0800 (CST)
X-UNIQUE-TAG: <93572c9dacd8efc6ea123af485f53d50>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 120.244.106.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200315122051.9360-1-chengang@emindsoft.com.cn>
 <15f9b7ec-5608-a009-1be7-42a351a9e93f@vivier.eu>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <0bde506a-8270-db58-b44d-8d4c86f38815@emindsoft.com.cn>
Date: Sun, 17 May 2020 21:08:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <15f9b7ec-5608-a009-1be7-42a351a9e93f@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.150.70.200;
 envelope-from=chengang@emindsoft.com.cn; helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 09:08:43
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001 autolearn=_AUTOLEARN
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

On 2020/5/12 上午2:43, Laurent Vivier wrote:
>>  
>> +  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
>> +                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
> 
> Add a blank line here.
>

OK, thanks.

>>  #ifdef TARGET_TIOCSTART
>>    IOCTL_IGNORE(TIOCSTART)
>>    IOCTL_IGNORE(TIOCSTOP)
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 8d27d10807..2eb7c91ab4 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -112,6 +112,7 @@
>>  #include <linux/if_alg.h>
>>  #include <linux/rtc.h>
>>  #include <sound/asound.h>
>> +#include <libdrm/drm.h>
> 
> I think you should check in configure that this file is available on the
> system.
> 

OK, I'll check in configure in patch v3.

>> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
>> index 152ec637cb..3c261cff0e 100644
>> --- a/linux-user/syscall_defs.h
>> +++ b/linux-user/syscall_defs.h
>> @@ -1167,6 +1167,9 @@ struct target_rtc_pll_info {
>>  #define TARGET_DM_TARGET_MSG          TARGET_IOWRU(0xfd, 0x0e)
>>  #define TARGET_DM_DEV_SET_GEOMETRY    TARGET_IOWRU(0xfd, 0x0f)
>>  
>> +/* drm ioctls */
>> +#define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
> 
> Why do you use the TARGET_IOWRU variant?
> 
> Can't you use TARGET_IOWR('d', 0x00, struct target_drm_version)?
> 

Because qemu will automatically set the size with the target structure
size in syscall_init(). It'll be more easier. e.g. usb ioctls and device
mapper ioctls also do like this.

Thanks.



