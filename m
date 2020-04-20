Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52570C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D9920A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D9920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSyF-0000jc-Bp
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46650 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQSxc-0000K4-Vv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:43:29 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQSxb-00057k-BS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:43:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:14896)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jQSxa-000572-73
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:43:26 -0400
IronPort-SDR: qmlLsf5w4q0DSv36xy9RzreXnJGbkE/So2KzHbonLN/znT0vQsvD3ZgqQv0Xv3hh3E7kWisC92
 c2Ss+yIX1KHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2020 02:43:20 -0700
IronPort-SDR: 28HyhY3JdnfFdTsd4Gne0KSG7vhJSaVSlMXOW2zGRzVkJxwR1/4wKC4aRtzheIx2O2dWoAyFnD
 SseOOAVe973A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; d="scan'208";a="455639166"
Received: from unknown (HELO [10.239.13.113]) ([10.239.13.113])
 by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 02:43:18 -0700
Message-ID: <5E9D7044.5010205@intel.com>
Date: Mon, 20 Apr 2020 17:49:56 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: =?UTF-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Subject: Re: [PATCH v1 1/2] migration/xbzrle: replace transferred xbzrle bytes
 with encoded bytes
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
 <1587352003-3312-2-git-send-email-wei.w.wang@intel.com>
 <20200420092930.GH346737@redhat.com>
In-Reply-To: <20200420092930.GH346737@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=wei.w.wang@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 05:43:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: kevin.tian@intel.com, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, dgilbert@redhat.com, gloryxiao@tencent.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/20/2020 05:29 PM, Daniel P. Berrangé wrote:
> On Mon, Apr 20, 2020 at 11:06:42AM +0800, Wei Wang wrote:
>> Like compressed_size which indicates how many bytes are compressed, we
>> need encoded_size to understand how many bytes are encoded with xbzrle
>> during migration.
>>
>> Replace the old xbzrle_counter.bytes, instead of adding a new counter,
>> because we don't find a usage of xbzrle_counter.bytes currently, which
>> includes 3 more bytes of the migration transfer protocol header (in
>> addition to the encoding header). The encoded_size will further be used
>> to calculate the encoding rate.
>>
>> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   migration/migration.c |  2 +-
>>   migration/ram.c       | 18 +++++++++---------
>>   monitor/hmp-cmds.c    |  4 ++--
>>   qapi/migration.json   |  6 +++---
>>   4 files changed, 15 insertions(+), 15 deletions(-)
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index eca2981d0a..bf195ff6ac 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -62,7 +62,7 @@
>>   #
>>   # @cache-size: XBZRLE cache size
>>   #
>> -# @bytes: amount of bytes already transferred to the target VM
>> +# @encoded_size: amount of bytes encoded
> Woah, this is part of QEMU's public API, so it isn't permissible to just
> arbitrarily remove a field with no warning, and replace it with a new
> field reporting different data. Adding a new field is allowed, but any
> existing field should be deprecated first, if there is a genuine need
> to remove it. If it isn't costly though, just leave the existing field
> unchanged.
>
> I would also note that the other fields in this struct use a hyphen, not
> an underscore.
OK. Thanks for reviewing and pointing it out.
We can add it as a new filed using hyphen in this case.
Will wait for other comments to post out a new version.

Best,
Wei

