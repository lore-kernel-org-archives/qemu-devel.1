Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9098AC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C90D207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzHHrzTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C90D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWicg-0003MN-Ii
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWibu-0002WP-Qk
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:38:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWibu-0007JH-5E
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588865933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOgNcHKYgXFcaHcNh1iTpHECttzanKYWcnUskx93+Ec=;
 b=HzHHrzTog4xLRsLHnWxgc74DhP0odGfKRroy/s7Fb3mu/4lBhk0X6JGInh6c8JtjaST6Fk
 bDQRLTnv0GK01vCqdJkyD/VQ+A+H504wq0bE+KvJyazZ0532aVqidWq1gJWFu8HFZBpKC6
 MWq1dqgLku3ZSaLm/VMao3BianKLXX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-IbxgYCpxMs6cFdPcdmGj_Q-1; Thu, 07 May 2020 11:38:47 -0400
X-MC-Unique: IbxgYCpxMs6cFdPcdmGj_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06F57876E05;
 Thu,  7 May 2020 15:38:46 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E72B579AD;
 Thu,  7 May 2020 15:38:25 +0000 (UTC)
Subject: Re: [RFC v3 1/6] qmp: add QMP command x-debug-query-virtio
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200507114927.6733-1-lvivier@redhat.com>
 <20200507114927.6733-2-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c496da5b-447b-eb09-5a18-f51229f489d9@redhat.com>
Date: Thu, 7 May 2020 10:38:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507114927.6733-2-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 6:49 AM, Laurent Vivier wrote:
> This new command lists all the instances of VirtIODevice with
> their path and virtio type
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

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

Inconsistent on x.y.z vs.

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

x.y.  Most of our QAPI seems to have settled on just x.y these days.

The x-debug- prefix is nice; it gives us more flexibility to mess with 
this later as needed.

Otherwise:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


