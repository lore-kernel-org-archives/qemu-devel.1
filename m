Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F33AC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D98820714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOcC+gG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D98820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1soj-0007Ct-96
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 09:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1sns-0006lg-U9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1snq-00086D-Sj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:15:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1snq-00085R-Or
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581516945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSkdPzSn5W9gbal889e/j3PMOwO8kbt4xBqo0+NPN58=;
 b=QOcC+gG5Vr03WQWL3v8yt60ClFa6nCVnPwcG/k+rWA7DJUNkMEH6myMQ2Z+56gadn67hsF
 taWP8Ne4J5HPx+Ln+mVgWZ7HbKHD6CcKD40jvzrdw+asyNHyWyjZkRnocbaH5j30abUdU0
 0u5+AEs61sVLxolEGwT2NqFmrpQhEbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-2mKafRRBNruq56eUlHTfag-1; Wed, 12 Feb 2020 09:15:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D60518A8C80;
 Wed, 12 Feb 2020 14:15:39 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5355C1B0;
 Wed, 12 Feb 2020 14:15:33 +0000 (UTC)
Subject: Re: [PATCH v2 01/16] virtio-mem: Prototype
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200212133601.10555-1-david@redhat.com>
 <20200212133601.10555-2-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <58037773-2a49-fb5d-d6d6-cfe9dbf9be71@redhat.com>
Date: Wed, 12 Feb 2020 08:15:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212133601.10555-2-david@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 2mKafRRBNruq56eUlHTfag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 7:35 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

It's at least worth mentioning VirtioMEMDeviceInfo in the commit 
message, to make it easier to find which commit introduces a given QAPI 
struct when searching the git log.

> +++ b/qapi/misc.json
> @@ -1557,19 +1557,56 @@
>             }
>   }
>   
> +##
> +# @VirtioMEMDeviceInfo:
> +#
> +# VirtioMEMDevice state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @requested-size: the user requested size of the device
> +#
> +# @size: the (current) size of memory that the device provides
> +#
> +# @max-size: the maximum size of memory that the device can provide
> +#
> +# @block-size: the block size of memory that the device provides
> +#
> +# @node: NUMA node number where device is assigned to
> +#
> +# @memdev: memory backend linked with the region
> +#
> +# Since: 4.1

5.0

> +##
> +{ 'struct': 'VirtioMEMDeviceInfo',
> +  'data': { '*id': 'str',

Does it make sense for id to be optional, or should it be mandatory?

> +            'memaddr': 'size',
> +            'requested-size': 'size',
> +            'size': 'size',
> +            'max-size': 'size',
> +            'block-size': 'size',
> +            'node': 'int',
> +            'memdev': 'str'
> +          }
> +}
> +
>   ##
>   # @MemoryDeviceInfo:
>   #
>   # Union containing information about a memory device
>   #
>   # nvdimm is included since 2.12. virtio-pmem is included since 4.1.
> +# virtio-mem is included since 4.2.

5.0

>   #
>   # Since: 2.1
>   ##
>   { 'union': 'MemoryDeviceInfo',
>     'data': { 'dimm': 'PCDIMMDeviceInfo',
>               'nvdimm': 'PCDIMMDeviceInfo',
> -            'virtio-pmem': 'VirtioPMEMDeviceInfo'
> +            'virtio-pmem': 'VirtioPMEMDeviceInfo',
> +            'virtio-mem': 'VirtioMEMDeviceInfo'
>             }
>   }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


