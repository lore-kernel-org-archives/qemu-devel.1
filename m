Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2FDC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63EC2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63EC2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSy4v-0002cl-Vj
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 03:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jSy46-0001wE-04
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jSy43-0002wo-4Y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:20:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:53454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jSy42-0002rP-JV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:20:26 -0400
IronPort-SDR: OUhIwkQbDdk2cTk7gS81Ynwh4APQl/gfOhlZqGQ6PeZlyXbAOEXvFRcH+WyEOtp4cySumTDSif
 yfdoxHxqxDEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 00:20:17 -0700
IronPort-SDR: rbmiQS1ZIVGy5o0kukW1Eu/tYdj50FvYMq+4jqaKH7tI9lycLoqKnsshztY0Nc/y/0o0MoPYUU
 6Uv3SI12Bfkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; d="scan'208";a="281617417"
Received: from unknown (HELO [10.239.13.113]) ([10.239.13.113])
 by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2020 00:20:14 -0700
Message-ID: <5EA68941.3040509@intel.com>
Date: Mon, 27 Apr 2020 15:26:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v1 1/2] migration/xbzrle: replace transferred xbzrle bytes
 with encoded bytes
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
 <1587352003-3312-2-git-send-email-wei.w.wang@intel.com>
 <20200421192106.GM3029@work-vm> <5E9FB148.3060906@intel.com>
 <20200424104734.GE3106@work-vm>
In-Reply-To: <20200424104734.GE3106@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=wei.w.wang@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 03:20:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.151
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
 peterx@redhat.com, gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/24/2020 06:47 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> On 04/22/2020 03:21 AM, Dr. David Alan Gilbert wrote:
>>> * Wei Wang (wei.w.wang@intel.com) wrote:
>>>> Like compressed_size which indicates how many bytes are compressed, we
>>>> need encoded_size to understand how many bytes are encoded with xbzrle
>>>> during migration.
>>>>
>>>> Replace the old xbzrle_counter.bytes, instead of adding a new counter,
>>>> because we don't find a usage of xbzrle_counter.bytes currently, which
>>>> includes 3 more bytes of the migration transfer protocol header (in
>>>> addition to the encoding header). The encoded_size will further be used
>>>> to calculate the encoding rate.
>>>>
>>>> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>> Can you explain why these 3 bytes matter?  Certainly the 2 bytes of the
>>> encoded_len are an overhead that's a cost of using XBZRLE; so if you're
>>> trying to figure out whether xbzrle is worth it, then you should include
>>> those 2 bytes in the cost.
>>> That other byte, that holds ENCODING_FLAG_XBZRLE also seems to be pure
>>> oerhead of XBZRLE; so your cost of using XBZRLE really does include
>>> those 3 bytes.
>>>
>>> SO to me it makes sense to include the 3 bytes as it currently does.
>>>
>>> Dave
>> Thanks Dave for sharing your thoughts.
>>
>> We hope to do a fair comparison of compression rate and xbzrle encoding
>> rate.
>> The current compression_rate doesn't include the migration flag overhead
>> (please see
>> update_compress thread_counts() ). So for xbzrle encoding rate, we wanted it
>> not include the migration
>> protocol flags as well (but the 2 bytes xbzrle encoding overhead is kept
>> there, as the compression rate
>> includes the compression header overhead).
>>
>> Or would you think it is necessary to add the migration flag (8 bytes) for
>> compression
>> when calculating the compression rate?
> I don't think the migration flag (8 bytes) matters, because everyone has
> that; but isn't this patch about the 3 bytes (1 byte
> ENCONDING_FLAG_XBZRLE) (2 byte encoded_len) ?
>
> The 2 byte encoded_len in this code, corresponds to the 4 byte blen in
> qemu_put_compression_data;  I'm not sure but I think that 4 bytes is
> included in the length update_compress_thread_counts() sees - if so
> that makes it equivalent including the length.
>

Right, that makes sense, thanks.

Best,
Wei



