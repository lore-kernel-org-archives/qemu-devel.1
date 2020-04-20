Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C92C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C772206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ1zKXPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C772206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXt7-00050w-83
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53812 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQXsV-0004aq-A4
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:58:31 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQXsU-0000AO-VX
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:58:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQXsU-00008o-Ji
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587394709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pf4U/emyFjdZsvfsPZgjqALA2IlrRZA2bYgis+tbI+I=;
 b=aZ1zKXPc2sNiuyTmDbqABu5Zs+k+hT69K//biw/FVzhGkZZTmhdxnFzWHSMVWadXz5YWII
 apxqAectlICdjhkHSjDz98skj+S//RsxuFd7YFtUkGxSEgPKa1A2zQZgrny0n7VcTKlwTv
 IVzRZ6irP9DHPiuUAFOlq8gi3QYY/b8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-4KohU0qfNO6VT5whKQuOvQ-1; Mon, 20 Apr 2020 10:58:23 -0400
X-MC-Unique: 4KohU0qfNO6VT5whKQuOvQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4363CDBA6;
 Mon, 20 Apr 2020 14:58:22 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B5255DDA5;
 Mon, 20 Apr 2020 14:57:42 +0000 (UTC)
Subject: Re: [RFC v2 1/6] qmp: add QMP command query-virtio
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200420104145.205297-1-lvivier@redhat.com>
 <20200420104145.205297-2-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a6db97cd-b3e0-9373-48db-5535322f5b10@redhat.com>
Date: Mon, 20 Apr 2020 09:57:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420104145.205297-2-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>,
 David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 5:41 AM, Laurent Vivier wrote:
> This new command lists all the instances of VirtIODevice with
> their path and virtio type
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 

> +++ b/qapi/virtio.json
> @@ -0,0 +1,68 @@
> +##
> +# = Virtio devices
> +##
> +
> +##
> +# @VirtioType:
> +#
> +# An enumeration of Virtio device types.
> +#
> +# Since: 5.1.0

This is a less-frequent spelling,...

> +##
> +{ 'enum': 'VirtioType',
> +  'data': [ 'unknown', 'virtio-9p', 'virtio-blk', 'virtio-serial',
> +            'virtio-gpu', 'virtio-input', 'virtio-net', 'virtio-scsi',
> +            'vhost-user-fs', 'vhost-vsock', 'virtio-balloon', 'virtio-crypto',
> +            'virtio-iommu', 'virtio-pmem', 'virtio-rng' ]
> +}
> +
> +##
> +# @VirtioInfo:
> +#
> +# Information about a given VirtIODevice
> +#
> +# @path: VirtIO device canonical path.
> +#
> +# @type: VirtIO device type.
> +#
> +# Since: 5.1

...and inconsistent with this more typical spelling.

Otherwise, the interface looks reasonable to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


