Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA53EC2BA1E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918FA2080C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTqIR/cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918FA2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0pu-00042J-Pw
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jK0ov-000324-Nn
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jK0ou-0004Hv-Kt
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:27:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36114
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jK0ou-0004HC-EM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585837667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPHCUIhj/QXD4Xl/rF6QD92ZrSwJr/oPspTCZvIK/qo=;
 b=NTqIR/cznsZUejwzA4lovNV8vA/WVQcnZCUj4KQBic9M9Z4wzyF6sAgCYnwp4zClppIvFb
 VHgcrZcZzrPlhU6lnrE6dAznyfiX2yDUV6pwCLzjPtsXEGlq9Ie00PxXuVj4TxT9dynKdy
 jdM/G+j5kNPpZ9YQ1tIb7Zfrl8tJbXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-wnzMImJHPcOHDpy37cPzRw-1; Thu, 02 Apr 2020 10:27:44 -0400
X-MC-Unique: wnzMImJHPcOHDpy37cPzRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 222C3802CAA;
 Thu,  2 Apr 2020 14:27:43 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F3CD10372FC;
 Thu,  2 Apr 2020 14:27:41 +0000 (UTC)
Subject: Re: [RFC 2/5] qmp: add QMP command virtio-status
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200402100302.833267-1-lvivier@redhat.com>
 <20200402100302.833267-3-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <69c564e0-8b3a-c1c3-e0bd-3a0a30fa2c42@redhat.com>
Date: Thu, 2 Apr 2020 09:27:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402100302.833267-3-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 5:02 AM, Laurent Vivier wrote:
> This new command shows the status of a VirtIODevice
> (features, endianness and number of virtqueues)
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

> +++ b/qapi/virtio.json
> @@ -52,3 +52,68 @@
>   ##
>   
>   { 'command': 'query-virtio', 'returns': ['VirtioInfo'] }
> +
> +##
> +# @VirtioStatus:
> +#
> +# @device_id: VirtIODevice status

As this is a new API, it should stick to our naming conventions:

device-id

> +#
> +# @device_endian: VirtIODevice device_endian

device-endian

> +#
> +# @guest_features: VirtIODevice guest_features

guest-features

> +#
> +# @host_features: VirtIODevice host_features

host-features

> +#
> +# @backend_features: VirtIODevice backend_features

backend-features

> +#
> +# @num_vqs: number of VirtIODevice queues

num-vqs

> +#
> +# Since: 5.1
> +#
> +##
> +
> +{ 'struct': 'VirtioStatus',
> +  'data': {
> +    'device_id': 'int',
> +    'device_endian': 'str',
> +    'guest_features': 'uint64',
> +    'host_features': 'uint64',
> +    'backend_features': 'uint64',

A bare int requires subsequent decoding.  Can this instead be an array 
of enum values, with enum values naming each enabled feature?

> +    'num_vqs': 'uint16'
> +  }
> +}
> +
> +##
> +# @virtio-status:
> +#
> +# Return the status of virtio device
> +#
> +# @path: QOBject path of the VirtIODevice
> +#
> +# Returns: status of the VirtIODevice
> +#
> +# Since: 5.1
> +#
> +# Example:
> +#
> +# -> { "execute": "virtio-status",
> +#      "arguments": {
> +#          "path": "/machine/peripheral-anon/device[3]/virtio-backend"
> +#      }
> +#   }
> +# <- { "return": {
> +#          "backend_features": 0,
> +#          "guest_features": 5111807911,

again, this means nothing to me.
   "guest-features": ["feature-a","feature-b"]
is vastly more usable if I'm inspecting the query output, compared to 
decoding the decimal number back into bits then doing a lookup into the 
documentation of which bits mean which features.

> +#          "num_vqs": 3,
> +#          "host_features": 6337593319,
> +#          "device_endian": "little",
> +#          "device_id": 1
> +#      }
> +#    }
> +#
> +##
> +
> +{ 'command': 'virtio-status',
> +  'data': { 'path': 'str' },
> +  'returns': 'VirtioStatus'
> +}
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


