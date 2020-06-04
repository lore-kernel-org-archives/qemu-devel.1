Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 01:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C1020738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 01:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C1020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgeKI-0005sK-DG
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 21:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jgeJP-0005ML-SO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 21:04:51 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:40342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jgeJO-0004uU-3b
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 21:04:51 -0400
Received: from localhost (unknown [192.168.167.225])
 by regular1.263xmail.com (Postfix) with ESMTP id 123D11498;
 Thu,  4 Jun 2020 09:04:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.3] (unknown [223.72.80.61])
 by smtp.263.net (postfix) whith ESMTP id
 P28610T140398613739264S1591232680577465_; 
 Thu, 04 Jun 2020 09:04:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <779ccfd5905222a8281c3f02d3aa036b>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 223.72.80.61
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v5] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200603010809.32139-1-chengang@emindsoft.com.cn>
 <02add5c5-e1ad-050e-229e-c5a7d2afdf2b@vivier.eu>
 <ce96cb20-80e7-e561-1eee-fcdca38d376f@emindsoft.com.cn>
 <1e1a2b6d-39ea-04aa-80ea-bcccdfd84a49@vivier.eu>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <5ecf3a5e-06bf-e9b5-12ee-465bd82ec946@emindsoft.com.cn>
Date: Thu, 4 Jun 2020 09:04:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1e1a2b6d-39ea-04aa-80ea-bcccdfd84a49@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.150.70.196;
 envelope-from=chengang@emindsoft.com.cn; helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 21:04:42
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

OK, thanks. I'll send patch v6. :)

On 2020/6/3 下午8:03, Laurent Vivier wrote:
> Le 03/06/2020 à 13:05, Chen Gang a écrit :
>> On 2020/6/3 下午5:49, Laurent Vivier wrote:
>>> Le 03/06/2020 à 03:08, chengang@emindsoft.com.cn a écrit :
>>>> +#ifdef HAVE_DRM_H
>>>> +
>>>> +static void unlock_drm_version(struct drm_version *host_ver)
>>>> +{
>>>> +    if (host_ver->name) {
>>>> +        unlock_user(host_ver->name, 0UL, 0);
>>>
>>> unlock_user() allows to have a NULL host pointer parameter, so you don't
>>> need to check. But you must provide the target pointer, with the length.
>>> The same below.
>>>
>>
>> As far as I know, the unlock_user is defined in
>> include/exec/softmmu-semi.h, which only checks the len before calling
>> cpu_memory_rw_debug, and only calls free() for the host pointer.
>>
>> So we have to be sure that the host pointer must be valid. When we pass
>> 0 length to unlock_user, we want it to free host pointer only.
> 
> No, it is defined in our case in linux-user/qemu.h, and associated
> comment is:
> 
> /* Unlock an area of guest memory.  The first LEN bytes must be
>    flushed back to guest memory. host_ptr = NULL is explicitly
>    allowed and does nothing. */
> 
>>
>>>> +    if (host_ver->desc_len) {
>>>> +        host_ver->desc = lock_user(VERIFY_WRITE, target_ver->desc,
>>>> +                                   target_ver->desc_len, 0);
>>>> +        if (!host_ver->desc) {
>>>> +            goto err;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    unlock_user_struct(target_ver, target_addr, 0);
>>>> +    return 0;
>>>> +err:
>>>> +    unlock_drm_version(host_ver);
>>>> +    unlock_user_struct(target_ver, target_addr, 0);
>>>> +    return -ENOMEM;
>>>
>>> In fact it should be -TARGET_EFAULT: it has failed because of access rights.
>>>
>>
>> As far as I know, the lock_user is defined in
>> include/exec/softmmu-semi.h. If the parameter 'copy' is 0 (in our case),
>> lock_user will only malloc a host pointer and return it.
> 
> No, in linux-user/qemu.h:
> 
> /* Lock an area of guest memory into the host.  If copy is true then the
>    host area will have the same contents as the guest.  */
> 
>> In our case, I guess the only failure from malloc() is "no memory".
> 
> See use-cases in syscall.c, they all fail with -TARGET_EFAULT.



