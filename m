Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD874C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29E3206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29E3206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg7me-0003Wk-NV
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 10:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jg7lm-00034S-HW
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 10:19:58 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:53270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jg7lg-0000O9-EJ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 10:19:58 -0400
Received: from localhost (unknown [192.168.167.32])
 by regular1.263xmail.com (Postfix) with ESMTP id 6B18766C;
 Tue,  2 Jun 2020 22:19:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.7] (unknown [223.72.72.58])
 by smtp.263.net (postfix) whith ESMTP id
 P3330T139696954926848S1591107579997202_; 
 Tue, 02 Jun 2020 22:19:40 +0800 (CST)
X-UNIQUE-TAG: <86cc055959d251ef175fba387569a682>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 223.72.72.58
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v4] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200602120023.5963-1-chengang@emindsoft.com.cn>
 <5525a258-7e9e-d52f-736c-db51ea2ea9cc@vivier.eu>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <b62f1fc9-5f4a-5157-96c6-9c9d26e5b6c2@emindsoft.com.cn>
Date: Tue, 2 Jun 2020 22:19:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5525a258-7e9e-d52f-736c-db51ea2ea9cc@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.150.70.197;
 envelope-from=chengang@emindsoft.com.cn; helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 10:19:44
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

On 2020/6/2 下午9:40, Laurent Vivier wrote:
>> +static inline abi_long target_to_host_drmversion(struct drm_version *host_ver,
>> +                                                abi_long target_addr)
>> +{
>> +    struct target_drm_version *target_ver;
>> +
>> +    if (!lock_user_struct(VERIFY_READ, target_ver, target_addr, 0)) {
>> +        return -TARGET_EFAULT;
>> +    }
>> +    __get_user(host_ver->name_len, &target_ver->name_len);
>> +    host_ver->name = host_ver->name_len ? g2h(target_ver->name) : NULL;
>> +    __get_user(host_ver->date_len, &target_ver->date_len);
>> +    host_ver->date = host_ver->date_len ? g2h(target_ver->date) : NULL;
>> +    __get_user(host_ver->desc_len, &target_ver->desc_len);
>> +    host_ver->desc = host_ver->desc_len ? g2h(target_ver->desc) : NULL;
> 
> but I think the string buffers must be locked and access rights must be
> checked.
> 
> So I think you should have something like:
> 
> host_ver->name = lock_user(VERIFY_WRITE, target_ver->name,
>                            target_ver->name_len, 0);
> ...
> 

OK, thanks.

>> +    unlock_user_struct(target_ver, target_addr, 0);
>> +    return 0;
>> +}
>> +
>> +static inline abi_long host_to_target_drmversion(abi_ulong target_addr,
>> +                                                 struct drm_version *host_ver)
>> +{
>> +    struct target_drm_version *target_ver;
>> +
>> +    if (!lock_user_struct(VERIFY_WRITE, target_ver, target_addr, 0)) {
>> +        return -TARGET_EFAULT;
>> +    }
>> +    __put_user(host_ver->version_major, &target_ver->version_major);
>> +    __put_user(host_ver->version_minor, &target_ver->version_minor);
>> +    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
>> +    __put_user(host_ver->name_len, &target_ver->name_len);
> 
> unlock_user(host_ver->name, target_ver->name, host_ver->name_len);
> ...
> 

OK, thanks.

I'll send patch v5.



