Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF805C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 23:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF1B21741
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 23:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF1B21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwwBy-0001aB-Nu
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 19:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jwwBR-0001Ag-Dj
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 19:23:57 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:60810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jwwBO-0003WW-R0
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 19:23:57 -0400
Received: from localhost (unknown [192.168.167.13])
 by regular1.263xmail.com (Postfix) with ESMTP id 4EE574AB;
 Sun, 19 Jul 2020 07:23:44 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.17] (unknown [223.72.78.183])
 by smtp.263.net (postfix) whith ESMTP id
 P17845T139821028726528S1595114623509895_; 
 Sun, 19 Jul 2020 07:23:44 +0800 (CST)
X-UNIQUE-TAG: <65ea31153528f2e7a3d1ce0117f766f8>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 223.72.78.183
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH] linux-user: syscall: ioctls: support
 DRM_IOCTL_I915_GETPARAM
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200712034102.23355-1-chengang@emindsoft.com.cn>
 <1e64eed1-509f-3b8d-112f-58c02794496a@vivier.eu>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <a97fd023-9f5f-3cca-0502-0e3f06105dc4@emindsoft.com.cn>
Date: Sun, 19 Jul 2020 07:23:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1e64eed1-509f-3b8d-112f-58c02794496a@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.150.70.198;
 envelope-from=chengang@emindsoft.com.cn; helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/18 19:23:45
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

On 2020/7/14 上午2:46, Laurent Vivier wrote:
>> +    gparam->value = lock_user(VERIFY_WRITE, target_gparam->value,
>> +                             sizeof(*gparam->value), 0);
> 
> I don't think you should use directly the guest memory.
> You should have something like that:
> 
>      int value;
> 
>      gparam->value = &value;
> 
>> +    if (!gparam->value) {
>> +        unlock_user_struct(target_gparam, arg, 0);
>> +        return -TARGET_EFAULT;
>> +    }
>> +
>> +    ret = get_errno(safe_ioctl(fd, ie->host_cmd, gparam));
> 
> and then:
> 
> put_user_s32(value, target_gparam->value);
> 

OK, thanks. It will be better.

>> +
>> +    unlock_user(gparam->value, target_gparam->value, sizeof(*gparam->value));
>> +    unlock_user_struct(target_gparam, arg, 0);
>> +    return ret;
>> +}
>> +
>> +static abi_long do_ioctl_drm_i915(const IOCTLEntry *ie, uint8_t *buf_temp,
>> +                                  int fd, int cmd, abi_long arg)
>> +{
>> +    switch (ie->host_cmd) {
>> +    case DRM_IOCTL_I915_GETPARAM:
>> +        return do_ioctl_drm_i915_getparam(ie,
>> +                                          (struct drm_i915_getparam *)buf_temp,
>> +                                          fd, arg);
>> +    default:
>> +        return -TARGET_ENOSYS;
>> +    }
>> +}
> 
> There is a better way to register a struct with convertion functions:
> you might use STRUCT_SPECIAL() to declare the structure rather than
> IOCTL_SPECIAL() to declare the ioctl command.
> (I think STRUCT_SPECIAL() could also be used with DRM_IOCTL_VERSION)
> 

For me, STRUCT_SPECIAL sounds good for the complex structures, but for
drm_i915_getparam which is simple enough, it is not quite suitable.

For me, STRUCT_SPECIAL is much suitable for DRM_IOCTL_VERSION.

Welcome your additional ideas.

>>  
>>  static IOCTLEntry ioctl_entries[] = {
>> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
>> index 3c261cff0e..9082f6c2bc 100644
>> --- a/linux-user/syscall_defs.h
>> +++ b/linux-user/syscall_defs.h
>> @@ -1170,6 +1170,9 @@ struct target_rtc_pll_info {
>>  /* drm ioctls */
>>  #define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
>>  
>> +/* drm i915 ioctls */
>> +#define TARGET_DRM_IOCTL_I915_GETPARAM              TARGET_IOWRU('d', 0x46)
> 
> why do you use the U variant?
> 
> TARGET_IOWR('d', 0x46, struct target_drm_i915_getparam)
> 

Because qemu will automatically set the size with the target structure
size in syscall_init(). It'll be more easier. e.g. usb ioctls and device
mapper ioctls also do like this.



