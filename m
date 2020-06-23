Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A91C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6869820738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IS2D0V6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6869820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnqIk-0006c9-MX
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jnqHy-0005k1-FT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 17:17:06 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jnqHw-00042Y-0G
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 17:17:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ef270f10001>; Tue, 23 Jun 2020 14:15:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 23 Jun 2020 14:17:01 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 23 Jun 2020 14:17:01 -0700
Received: from [10.40.100.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 21:16:43 +0000
Subject: Re: [PATCH QEMU v25 17/17] qapi: Add VFIO devices migration stats in
 Migration stats
To: Markus Armbruster <armbru@redhat.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-18-git-send-email-kwankhede@nvidia.com>
 <87zh8ucknj.fsf@dusky.pond.sub.org>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <fa9c879c-f062-7589-231c-b34fb0a107a7@nvidia.com>
Date: Wed, 24 Jun 2020 02:46:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <87zh8ucknj.fsf@dusky.pond.sub.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592946930; bh=J4c/5QjQ8PAtG8fiZpNUzPrrJ+J1jKduR4VAxX5WV+k=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=IS2D0V6QtdLMIBSACUen3OJGxKhrLBL/4vLa/PH4J/pOukSapw6AsMH4SPS1X3RDG
 1KUpxe3qzhK2DCxBS2gKv4y9EHXoH2yNIWCAStdBQsk72p0VSbJAqYZkjQgutMWKfu
 p1YhvxyGUesteg0CSMY2ErOgnBBfFYbSucT9i9pz7jD0PZGWEsTKQfxI2t130sFesG
 6tcAm6gxqOwf+MM89A8kh+VhsRI3ITRO2z/Y98dueENrbLZjSn3uj4pkbDFSK1KM2r
 hs25f4MGn/S4jBlIw0Z8DhmX6a+74Z4NPtxMB7On+hKe23uaFI9GEd0kUlRxnN9FVF
 qO1EdZEIIGk8Q==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 16:34:47
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com, Ken.Xue@amd.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, quintela@redhat.com,
 zhi.a.wang@intel.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/23/2020 12:51 PM, Markus Armbruster wrote:
> QAPI review only.
> 
> The only changes since I reviewed v23 is the rename of VfioStats member
> @bytes to @transferred, and the move of MigrationInfo member @vfio next
> to @ram and @disk.  Good.  I'm copying my other questions in the hope of
> getting answers :)
> 
> Kirti Wankhede <kwankhede@nvidia.com> writes:
> 
>> Added amount of bytes transferred to the target VM by all VFIO devices
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> [...]
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d5000558c6c9..952864b05455 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -146,6 +146,18 @@
>>               'active', 'postcopy-active', 'postcopy-paused',
>>               'postcopy-recover', 'completed', 'failed', 'colo',
>>               'pre-switchover', 'device', 'wait-unplug' ] }
>> +##
>> +# @VfioStats:
>> +#
>> +# Detailed VFIO devices migration statistics
>> +#
>> +# @transferred: amount of bytes transferred to the target VM by VFIO devices
>> +#
>> +# Since: 5.1
>> +#
>> +##
>> +{ 'struct': 'VfioStats',
>> +  'data': {'transferred': 'int' } }
> 
> Pardon my ignorance...  What exactly do VFIO devices transfer to the
> target VM? How is that related to MigrationInfo member @ram? 
> 

Sorry I missed to reply your question on earlier version.

VFIO device transfer vfio device's state, data from VFIO device and 
guest memory pages pinned for dma operation.
For example in case of GPU, vfio device state is GPUs current state to 
be saved that will be restored during resume and device data is data 
from onboard framebuffer. Pinned memory is marked dirty and transferred 
to target VM as part of global dirty page tracking for RAM.
VFIO device can add significant amount of data in migration stream 
(depending on FB size in GB), transferred byte count is important 
parameter to be monitored.

> MigrationStats has much more information, and some of it is pretty
> useful to track how migration is doing, in particular whether it
> converges, and how fast.  Absent in VfioStats due to "not implemented",
> or due to "can't be done"?
>

Vfio device migration interface is same as RAM's migration interface 
(using SaveVMHandlers). Converge part is already take care by 
.save_live_pending hook where *res_precopy_only is set to vfio devices 
pending_bytes, migration->pending_bytes

How fast - I'm not sure how this can be calculated.

Thanks,
Kirti

> Byte counts should use QAPI type 'size'.  Many existing ones don't.
> Since MigrationStats uses 'int', I'll let the migration maintainers
> decide whether they want 'int' or 'size' here.
> 
>>   ##
>>   # @MigrationInfo:
>> @@ -207,11 +219,16 @@
>>   #
>>   # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
>>   #
>> +# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
>> +#        only returned if VFIO device is present, migration is supported by all
>> +#         VFIO devices and status is 'active' or 'completed' (since 5.1)
>> +#
>>   # Since: 0.14.0
>>   ##
>>   { 'struct': 'MigrationInfo',
>>     'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
>>              '*disk': 'MigrationStats',
>> +           '*vfio': 'VfioStats',
>>              '*xbzrle-cache': 'XBZRLECacheStats',
>>              '*total-time': 'int',
>>              '*expected-downtime': 'int',
> 

