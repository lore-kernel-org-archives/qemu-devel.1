Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A612C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FE820888
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPB7dfJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FE820888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSxy-00059v-Hr
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLSxA-0004Vc-Ht
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLSx7-0003Qr-Mw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600960469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ggz5Y8Vl9sfdbXK7THxfrpqSdxojXztkGJxGH/eKpk=;
 b=GPB7dfJCbxV2wXe8jmgfaDI95XWiI6vxocImUid9543xcwhbQfFzoxsLLRtVJrNfdbwgGc
 WNnVWbr0Wo6WNbQxi02mzdZCBQxH1NAOyHUntQKcFqNGp6Eb5YuEmC2GH+cBeAK78cGrO9
 C8lMkPDqey9xFSj6fC1uYD0jbiBJ9E0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-_SkgWKiTOq2wQa8EO9_6aA-1; Thu, 24 Sep 2020 11:14:21 -0400
X-MC-Unique: _SkgWKiTOq2wQa8EO9_6aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE29E8030A2;
 Thu, 24 Sep 2020 15:14:18 +0000 (UTC)
Received: from [10.3.114.148] (ovpn-114-148.phx2.redhat.com [10.3.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 082EF73672;
 Thu, 24 Sep 2020 15:14:09 +0000 (UTC)
Subject: Re: [PATCH v26 17/17] qapi: Add VFIO devices migration stats in
 Migration stats
To: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com,
 cjia@nvidia.com
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-18-git-send-email-kwankhede@nvidia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4d39ffb9-9dce-d364-37e7-73c65d82e6aa@redhat.com>
Date: Thu, 24 Sep 2020 10:14:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600817059-26721-18-git-send-email-kwankhede@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 6:24 PM, Kirti Wankhede wrote:
> Added amount of bytes transferred to the target VM by all VFIO devices
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
> 
> Note: Comments from v25 for this patch are not addressed yet.
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg715620.html
> 
> Alex, need more pointer on documentation part raised Markus Armbruster.
> 
> 

> +++ b/qapi/migration.json
> @@ -147,6 +147,18 @@
>               'active', 'postcopy-active', 'postcopy-paused',
>               'postcopy-recover', 'completed', 'failed', 'colo',
>               'pre-switchover', 'device', 'wait-unplug' ] }
> +##
> +# @VfioStats:
> +#
> +# Detailed VFIO devices migration statistics
> +#
> +# @transferred: amount of bytes transferred to the target VM by VFIO devices
> +#
> +# Since: 5.1

This should be Since: 5.2

> +#
> +##
> +{ 'struct': 'VfioStats',
> +  'data': {'transferred': 'int' } }
>   
>   ##
>   # @MigrationInfo:
> @@ -208,11 +220,16 @@
>   #
>   # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
>   #
> +# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
> +#        only returned if VFIO device is present, migration is supported by all
> +#         VFIO devices and status is 'active' or 'completed' (since 5.1)

and here

> +#
>   # Since: 0.14.0
>   ##
>   { 'struct': 'MigrationInfo',
>     'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
>              '*disk': 'MigrationStats',
> +           '*vfio': 'VfioStats',
>              '*xbzrle-cache': 'XBZRLECacheStats',
>              '*total-time': 'int',
>              '*expected-downtime': 'int',
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


