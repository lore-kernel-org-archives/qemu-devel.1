Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C7BC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF4D2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGdyQdmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF4D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHWgD-0005DL-JN
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHWfU-0004hH-Jy
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHWfT-0008JJ-De
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:51:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHWfT-0008Iy-9C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585245106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNRQ+BPWmjfY68PlDlYVycxYRUH5Qn0PvEOWnmAaT30=;
 b=BGdyQdmMAPlRG7AIi5zBxNPTdA5WYcsyAoFD0nSvBLJCKSA1+NyifovxWwe/AxGvf97wPx
 wcjpXJfwOzcr/3iehrqV/BNlf0ErfHoUY4sZ6H0LCsE7h0cqRF+OBTdn+a9cNybWhHqBzW
 PpkYmvgNmTUVeYbgd2T2vldSVSZ2+JI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278--D4EVnbMOA2A8sEVWMVSoQ-1; Thu, 26 Mar 2020 13:51:39 -0400
X-MC-Unique: -D4EVnbMOA2A8sEVWMVSoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51104800D50;
 Thu, 26 Mar 2020 17:51:37 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 235257E311;
 Thu, 26 Mar 2020 17:51:23 +0000 (UTC)
Subject: Re: [RFC v6 01/24] update-linux-headers: Import iommu.h
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
References: <20200320165840.30057-1-eric.auger@redhat.com>
 <20200320165840.30057-2-eric.auger@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A204428@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b7ff5493-ff80-6a8d-6c99-f09a5d974e9c@redhat.com>
Date: Thu, 26 Mar 2020 18:51:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A204428@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "tnowicki@marvell.com" <tnowicki@marvell.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "bbhushan2@marvell.com" <bbhushan2@marvell.com>,
 "will@kernel.org" <will@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yi,

On 3/26/20 1:58 PM, Liu, Yi L wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Saturday, March 21, 2020 12:58 AM
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-devel@nongnu.org;
>> Subject: [RFC v6 01/24] update-linux-headers: Import iommu.h
>>
>> Update the script to import the new iommu.h uapi header.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  scripts/update-linux-headers.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh index
>> 29c27f4681..5b64ee3912 100755
>> --- a/scripts/update-linux-headers.sh
>> +++ b/scripts/update-linux-headers.sh
>> @@ -141,7 +141,7 @@ done
>>
>>  rm -rf "$output/linux-headers/linux"
>>  mkdir -p "$output/linux-headers/linux"
>> -for header in kvm.h vfio.h vfio_ccw.h vhost.h \
>> +for header in kvm.h vfio.h vfio_ccw.h vhost.h iommu.h \
>>                psci.h psp-sev.h userfaultfd.h mman.h; do
>>      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>>  done
> 
> Hi Eric,
> 
> This patch already got acked by from Cornelia. :-)
> 
> https://patchwork.ozlabs.org/patch/1259643/
thanks for the heads-up! Every little step ... ;-)

Thanks

Eric
> 
> Regards,
> Yi Liu
> 


