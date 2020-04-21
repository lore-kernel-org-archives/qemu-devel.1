Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89CBC38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895A72078C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895A72078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQhOc-0003qG-LP
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQhNv-0003Om-K6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQhNu-0000fe-B2
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:07:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:8326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jQhNt-0000YC-RF
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:07:34 -0400
IronPort-SDR: j+t0jJJInE+7j6iXbiRRTcc1FSPw6HrjMgWGRlJm6BneRKRF4X9N0NYrwi8zeuiPl6M4UGXOjT
 c26z25qLsOjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2020 18:07:27 -0700
IronPort-SDR: oOjCgj0lrfF8E/2/G6QjjIZ2K5ifGZ/Mhaqbb5IggVU7LX4veyU1XicxRRsBS7jeSxS4NDp/qi
 cpIW1NfWX29g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; d="scan'208";a="455895704"
Received: from unknown (HELO [10.239.13.113]) ([10.239.13.113])
 by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 18:07:25 -0700
Message-ID: <5E9E48DC.3030609@intel.com>
Date: Tue, 21 Apr 2020 09:14:04 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, 
 quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v1 2/2] migration/xbzrle: add encoding rate
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
 <1587352003-3312-3-git-send-email-wei.w.wang@intel.com>
 <c291eede-8187-5f95-7939-3bdcf4a832e2@redhat.com>
In-Reply-To: <c291eede-8187-5f95-7939-3bdcf4a832e2@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=wei.w.wang@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 21:07:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.126
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
Cc: gloryxiao@tencent.com, kevin.tian@intel.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/20/2020 10:53 PM, Eric Blake wrote:
> On 4/19/20 10:06 PM, Wei Wang wrote:
>> Users may need to check the xbzrle encoding rate to know if the guest
>> memory is xbzrle encoding-friendly, and dynamically turn off the
>> encoding if the encoding rate is low.
>>
>> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>
> In addition to Dan's review comments,
>
>> +++ b/qapi/migration.json
>> @@ -70,6 +70,8 @@
>>   #
>>   # @cache-miss-rate: rate of cache miss (since 2.1)
>>   #
>> +# @encoding-rate: rate of cache miss
>
> This is missing a '(since 5.1)' tag.

OK, will add it, thanks.

Best,
Wei

