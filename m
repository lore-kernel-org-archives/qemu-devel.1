Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1408EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD021204EA
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD021204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmhh-0000Dm-6y
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 06:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jgmgz-0008Az-1b
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:01:45 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:44018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jgmgw-0000Nc-G9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:01:44 -0400
Received: from localhost (unknown [192.168.167.32])
 by regular1.263xmail.com (Postfix) with ESMTP id 7B0C7932;
 Thu,  4 Jun 2020 18:01:35 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.3] (unknown [223.72.80.61])
 by smtp.263.net (postfix) whith ESMTP id
 P3330T139696696981248S1591264894501838_; 
 Thu, 04 Jun 2020 18:01:35 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ed0f8d72332072a991989fb7adf74ae5>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 223.72.80.61
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH] [PATCH v6] linux-user: syscall: ioctls: support
 DRM_IOCTL_VERSION
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200604014527.7795-1-chengang@emindsoft.com.cn>
 <30eeb463-42d8-5aaa-1741-1cc3bb885fdc@vivier.eu>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <f01ce257-6f2b-782f-8e27-b5237bb7c627@emindsoft.com.cn>
Date: Thu, 4 Jun 2020 18:01:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <30eeb463-42d8-5aaa-1741-1cc3bb885fdc@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.150.70.201;
 envelope-from=chengang@emindsoft.com.cn; helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 06:01:36
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That sounds good, I'll send patch v7, thanks.

On 2020/6/4 下午5:10, Laurent Vivier wrote:
> Le 04/06/2020 à 03:45, chengang@emindsoft.com.cn a écrit :
>> From: Chen Gang <chengang@emindsoft.com.cn>
>>
>> Another DRM_IOCTL_* commands will be done later.
>>
>> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
>> ---
>>  configure                  | 10 ++++
>>  linux-user/ioctls.h        |  5 ++
>>  linux-user/syscall.c       | 95 ++++++++++++++++++++++++++++++++++++++
>>  linux-user/syscall_defs.h  | 15 ++++++
>>  linux-user/syscall_types.h | 11 +++++
>>  5 files changed, 136 insertions(+)
>>
>> diff --git a/configure b/configure
>> index f087d2bcd1..389dbb1d09 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3136,6 +3136,13 @@ if ! check_include "ifaddrs.h" ; then
>>    have_ifaddrs_h=no
>>  fi
>>  
>> +#########################################
>> +# libdrm check
>> +have_drm_h=no
>> +if check_include "libdrm/drm.h" ; then
>> +    have_drm_h=yes
>> +fi
>> +
>>  ##########################################
>>  # VTE probe
>>  
>> @@ -7127,6 +7134,9 @@ fi
>>  if test "$have_ifaddrs_h" = "yes" ; then
>>      echo "HAVE_IFADDRS_H=y" >> $config_host_mak
>>  fi
>> +if test "$have_drm_h" = "yes" ; then
>> +  echo "HAVE_DRM_H=y" >> $config_host_mak
>> +fi
>>  if test "$have_broken_size_max" = "yes" ; then
>>      echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
>>  fi
>> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>> index 0defa1d8c1..f2e2fa9c87 100644
>> --- a/linux-user/ioctls.h
>> +++ b/linux-user/ioctls.h
>> @@ -574,6 +574,11 @@
>>    IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
>>                  MK_PTR(MK_STRUCT(STRUCT_rtentry)))
>>  
>> +#ifdef HAVE_DRM_H
>> +  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
>> +                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
>> +#endif
>> +
>>  #ifdef TARGET_TIOCSTART
>>    IOCTL_IGNORE(TIOCSTART)
>>    IOCTL_IGNORE(TIOCSTOP)
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 7f6700c54e..1744e7acc7 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -112,6 +112,9 @@
>>  #include <linux/if_alg.h>
>>  #include <linux/rtc.h>
>>  #include <sound/asound.h>
>> +#ifdef HAVE_DRM_H
>> +#include <libdrm/drm.h>
>> +#endif
>>  #include "linux_loop.h"
>>  #include "uname.h"
>>  
>> @@ -5276,6 +5279,98 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
>>  }
>>  #endif
>>  
>> +#ifdef HAVE_DRM_H
>> +
>> +static void unlock_drm_version(struct drm_version *host_ver)
>> +{
>> +    unlock_user(host_ver->name, 0UL, 0);
>> +    unlock_user(host_ver->date, 0UL, 0);
>> +    unlock_user(host_ver->desc, 0UL, 0);
>> +}
> 
> This is correct but I would prefer to not have this kind of function
> with 0UL parameter.
> 
> You can use target_ver for the guest pointer and host_ver for the len,
> guest pointer will be ignored if host pointer is NULL.
> 
> You can have a generic function that not copies data in case of error:
> 
> static void unlock_drm_strings(struct drm_version *host_ver,
>                                struct target_drm_version *target_ver,
>                                int copy)
> {
>     unlock_user(host_ver->name, target_ver->name,
>                 copy ? host_ver->name_len : 0);
> ...
> 
>> +
>> +static inline abi_long target_to_host_drmversion(struct drm_version *host_ver,
>> +                                          struct target_drm_version *target_ver)
>> +{
>> +    memset(host_ver, 0, sizeof(*host_ver));
>> +
>> +    __get_user(host_ver->name_len, &target_ver->name_len);
>> +    if (host_ver->name_len) {
>> +        host_ver->name = lock_user(VERIFY_WRITE, target_ver->name,
>> +                                   target_ver->name_len, 0);
>> +        if (!host_ver->name) {
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    __get_user(host_ver->date_len, &target_ver->date_len);
>> +    if (host_ver->date_len) {
>> +        host_ver->date = lock_user(VERIFY_WRITE, target_ver->date,
>> +                                   target_ver->date_len, 0);
>> +        if (!host_ver->date) {
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    __get_user(host_ver->desc_len, &target_ver->desc_len);
>> +    if (host_ver->desc_len) {
>> +        host_ver->desc = lock_user(VERIFY_WRITE, target_ver->desc,
>> +                                   target_ver->desc_len, 0);
>> +        if (!host_ver->desc) {
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +err:
>> +    unlock_drm_version(host_ver);
> 
> unlock_drm_strings(host_ver, target_ver, 0);
> 
>> +    return -EFAULT;
>> +}
>> +
>> +static inline abi_long host_to_target_drmversion(
>> +                                          struct target_drm_version *target_ver,
>> +                                          struct drm_version *host_ver)
>> +{
>> +    __put_user(host_ver->version_major, &target_ver->version_major);
>> +    __put_user(host_ver->version_minor, &target_ver->version_minor);
>> +    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
>> +    __put_user(host_ver->name_len, &target_ver->name_len);
>> +    __put_user(host_ver->date_len, &target_ver->date_len);
>> +    __put_user(host_ver->desc_len, &target_ver->desc_len);
>> +    unlock_user(host_ver->name, target_ver->name, host_ver->name_len);
>> +    unlock_user(host_ver->date, target_ver->date, host_ver->date_len);
>> +    unlock_user(host_ver->desc, target_ver->desc, host_ver->desc_len);
> 
> unlock_drm_strings(host_ver, target_ver, 1);
> 
>> +    return 0;
>> +}
>> +
>> +static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
>> +                             int fd, int cmd, abi_long arg)
>> +{
>> +    struct drm_version *ver;
>> +    struct target_drm_version *target_ver;
>> +    abi_long ret;
>> +
>> +    switch (ie->host_cmd) {
>> +    case DRM_IOCTL_VERSION:
>> +        if (!lock_user_struct(VERIFY_WRITE, target_ver, arg, 0)) {
>> +            return -TARGET_EFAULT;
>> +        }
>> +        ver = (struct drm_version *)buf_temp;
>> +        ret = target_to_host_drmversion(ver, target_ver);
>> +        if (!is_error(ret)) {
>> +            ret = get_errno(safe_ioctl(fd, ie->host_cmd, ver));
>> +            if (!is_error(ret)) {
>> +                ret = host_to_target_drmversion(target_ver, ver);
>> +            }
>> +            unlock_drm_version(ver);
> 
> } else {
>     unlock_drm_strings(host_ver, target_ver, 0);
> }
> 
> Thanks,
> Laurent
> 
> 
> 
> 



