Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B87C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 22:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB0120774
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 22:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB0120774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jf9fq-0000VU-H0
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 18:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jf9f8-0008Uu-A8
 for qemu-devel@nongnu.org; Sat, 30 May 2020 18:09:06 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:57014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1jf9f6-0005UC-B3
 for qemu-devel@nongnu.org; Sat, 30 May 2020 18:09:05 -0400
Received: from localhost (unknown [192.168.167.32])
 by regular1.263xmail.com (Postfix) with ESMTP id 87CF95CA;
 Sun, 31 May 2020 06:08:54 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.7] (unknown [223.72.93.199])
 by smtp.263.net (postfix) whith ESMTP id
 P3330T139696676001536S1590876532385209_; 
 Sun, 31 May 2020 06:08:54 +0800 (CST)
X-UNIQUE-TAG: <2904b65bafd02acb27b46909e5c479b5>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 223.72.93.199
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v3] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: Laurent Vivier <laurent@vivier.eu>, riku.voipio@iki.fi
References: <20200523132442.22538-1-chengang@emindsoft.com.cn>
 <767ce983-c676-9d0b-3167-5165ceb48262@vivier.eu>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <b06a3611-014b-475c-bcfc-3746a181809b@emindsoft.com.cn>
Date: Sun, 31 May 2020 06:08:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <767ce983-c676-9d0b-3167-5165ceb48262@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.150.70.205;
 envelope-from=chengang@emindsoft.com.cn; helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 18:08:55
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

On 2020/5/28 下午6:25, Laurent Vivier wrote:
>> diff --git a/configure b/configure
>> index e225a1e3ff..2c2c489d1e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3912,6 +3912,24 @@ EOF
>>      fi
>>  fi
>>  
>> +#########################################
>> +# libdrm check
>> +
>> +cat > $TMPC << EOF
>> +#include <libdrm/drm.h>
>> +#include <sys/ioctl.h>
>> +int main(void)
>> +{
>> +        struct drm_version version;
>> +        ioctl(-1, DRM_IOCTL_VERSION, &version);
>> +        return 0;
>> +}
>> +EOF
>> +if ! compile_prog "" ; then
>> +    error_exit "libdrm check failed" \
>> +        "Make sure to have the libdrm/drm.h installed."
>> +fi
> 
> You break the build of qemu if libdrm is not available, not a good idea.
> 
> In fact, you should only check for the include with something like
> "check_include libdrm/drm.h" and then define a HAVE_DRM_H to use it
> around the new code:
> 
> #ifdef HAVE_DRM_H
> #include <libdrm/drm.h>
> #endif
> 
> ...
> #ifdef HAVE_DRM_H
> static inline abi_long target_to_host_drmversion(...
> ...
> #endif
> ...
> 
> #ifdef HAVE_DRM_H
> IOCTL_SPECIAL(DRM_IOCTL_VERSION,...
> ...
> #endif
> 

OK, thanks. I'll send patch v4

Chen Gang



