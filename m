Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4FBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF9D206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF9D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgRDu-0001D0-FU
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 07:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jgRD6-0000hX-Oh
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 07:05:28 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:58368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jgRD4-0001gm-F6
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 07:05:28 -0400
Received: from localhost (unknown [192.168.167.225])
 by regular1.263xmail.com (Postfix) with ESMTP id C572D30E;
 Wed,  3 Jun 2020 19:05:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.3] (unknown [223.72.80.61])
 by smtp.263.net (postfix) whith ESMTP id
 P28610T140398603249408S1591182318233491_; 
 Wed, 03 Jun 2020 19:05:18 +0800 (CST)
X-UNIQUE-TAG: <136796fbd855c437a5d3947abe938a1e>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 223.72.80.61
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: Chen Gang <chengang@emindsoft.com.cn>
Subject: Re: [PATCH v5] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200603010809.32139-1-chengang@emindsoft.com.cn>
 <02add5c5-e1ad-050e-229e-c5a7d2afdf2b@vivier.eu>
Message-ID: <ce96cb20-80e7-e561-1eee-fcdca38d376f@emindsoft.com.cn>
Date: Wed, 3 Jun 2020 19:05:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <02add5c5-e1ad-050e-229e-c5a7d2afdf2b@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.150.70.202;
 envelope-from=chengang@emindsoft.com.cn; helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 07:05:19
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

On 2020/6/3 下午5:49, Laurent Vivier wrote:
> Le 03/06/2020 à 03:08, chengang@emindsoft.com.cn a écrit :
>> +#ifdef HAVE_DRM_H
>> +
>> +static void unlock_drm_version(struct drm_version *host_ver)
>> +{
>> +    if (host_ver->name) {
>> +        unlock_user(host_ver->name, 0UL, 0);
> 
> unlock_user() allows to have a NULL host pointer parameter, so you don't
> need to check. But you must provide the target pointer, with the length.
> The same below.
> 

As far as I know, the unlock_user is defined in
include/exec/softmmu-semi.h, which only checks the len before calling
cpu_memory_rw_debug, and only calls free() for the host pointer.

So we have to be sure that the host pointer must be valid. When we pass
0 length to unlock_user, we want it to free host pointer only.

>> +    if (host_ver->desc_len) {
>> +        host_ver->desc = lock_user(VERIFY_WRITE, target_ver->desc,
>> +                                   target_ver->desc_len, 0);
>> +        if (!host_ver->desc) {
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    unlock_user_struct(target_ver, target_addr, 0);
>> +    return 0;
>> +err:
>> +    unlock_drm_version(host_ver);
>> +    unlock_user_struct(target_ver, target_addr, 0);
>> +    return -ENOMEM;
> 
> In fact it should be -TARGET_EFAULT: it has failed because of access rights.
> 

As far as I know, the lock_user is defined in
include/exec/softmmu-semi.h. If the parameter 'copy' is 0 (in our case),
lock_user will only malloc a host pointer and return it.

In our case, I guess the only failure from malloc() is "no memory".

>> +}
>> 
>> +static inline abi_long host_to_target_drmversion(abi_ulong target_addr,
>> +                                                 struct drm_version *host_ver)
>> +{
>> +    struct target_drm_version *target_ver;
>> +
>> +    if (!lock_user_struct(VERIFY_WRITE, target_ver, target_addr, 0)) {
> 
> I think you should not unlock_struct() in target_to_host_drmversion() so
> you don't have to lock it again here.
> 

OK, thanks.

>> +static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
>> +                             int fd, int cmd, abi_long arg)
>> +{
>> +    struct drm_version *ver;
>> +    abi_long ret;
>> +
>> +    switch (ie->host_cmd) {
>> +    case DRM_IOCTL_VERSION:
>> +        ver = (struct drm_version *)buf_temp;
> 
> you should lock the structure here (rather than in
> target_to_host_drmversion())...
> 

OK, thanks.

>> +        ret = target_to_host_drmversion(ver, arg);
>> +        if (is_error(ret)) {
>> +            return ret;
>> +        }
>> +        ret = get_errno(safe_ioctl(fd, ie->host_cmd, ver));
>> +        if (is_error(ret)) {
>> +            unlock_drm_version(ver);
>> +            return ret;
>> +        }
>> +        return host_to_target_drmversion(arg, ver);
> 
> and unlock the structure here (rather than in host_to_target_drmversion()).
> 
> You should return "ret" too.
> 

OK, thanks.

>> +    }
>> +    return -TARGET_EFAULT;
> 
> Why -TARGET_EFAULT? -TARGET_ENOSYS would be better.
> 

OK, thanks.

Chen Gang.



