Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73C5C2BA12
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956442078E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMNdYVLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956442078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0lg-0000Jn-Qp
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jK0l2-0008Le-Qm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jK0kx-00011e-Le
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:23:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jK0kx-000113-HW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585837422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBJDMYxgPBUfMYZPFw5pEe60+63tR3mo5xdlTTjjJWQ=;
 b=jMNdYVLy8gb0oV+RSuUcsV5wCbFVyqyH5i3FURJCArUwWyTnkrk0lZ5pi1ahxwZ0c0K74H
 MzKbQyqnPyRxn5u2vGFLLz9bhWX/f9L3l1rHkbeQwuFnRx7C2q4yyaLikbZotIbQqwrJ21
 1xQU+gyEkVg2aIWwkzL+xEOWuyKDLig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103--LaKrhZzOmiTYCo5ML4SdQ-1; Thu, 02 Apr 2020 10:23:38 -0400
X-MC-Unique: -LaKrhZzOmiTYCo5ML4SdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A7B190A7A7;
 Thu,  2 Apr 2020 14:23:37 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1DD76EF97;
 Thu,  2 Apr 2020 14:23:34 +0000 (UTC)
Subject: Re: [RFC 1/5] qmp: add QMP command query-virtio
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200402100302.833267-1-lvivier@redhat.com>
 <20200402100302.833267-2-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1cf29e6d-36b9-09c8-35bb-a6e343aa0cb2@redhat.com>
Date: Thu, 2 Apr 2020 09:23:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402100302.833267-2-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> This new command lists all the instances of VirtIODevice with
> their path and virtio type
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

> +++ b/qapi/virtio.json
> @@ -0,0 +1,54 @@
> +##
> +# = Virtio devices
> +##
> +
> +##
> +# @VirtioInfo:
> +#
> +# Information about a given VirtIODevice
> +#
> +# @type: VirtIO device type.
> +#
> +# @path: VirtIO device canonical path.

One order here,

> +#
> +# Since: 5.1
> +#
> +##
> +{ 'struct': 'VirtioInfo',
> +  'data': {
> +    'path': 'str',
> +    'type': 'str'

and another here.  I don't think our doc generator cares, but it is nice 
to document things in the same order they are declared.

Why are we using open-coded 'type':'str' instead of an enum type? 
Aren't there only a finite number of virtio types, in which case an enum 
is a better representation (not to mention making it introspectible when 
we add a new virtio type)?

> +  }
> +}
> +
> +##
> +# @query-virtio:
> +#
> +# Return the list of all VirtIO devices
> +#
> +# Returns: list of @VirtioInfo
> +#
> +# Since: 5.1
> +#
> +# Example:
> +#
> +# -> { "execute": "query-virtio" }
> +# <- { "return": [
> +#        {
> +#            "path": "/machine/peripheral-anon/device[3]/virtio-backend",
> +#            "type": "virtio-net"
> +#        },
> +#        {
> +#            "path": "/machine/peripheral-anon/device[1]/virtio-backend",
> +#            "type": "virtio-serial"
> +#        },
> +#        {
> +#            "path": "/machine/peripheral-anon/device[0]/virtio-backend",
> +#            "type": "virtio-blk"
> +#        }
> +#      ]

The resulting QMP will still be the same with an enum type (as the 
on-the-wire format is still the string name of the enum constant), but 
using an enum will have knock-on effects to the C code; it may be better 
to convert to an enum in one patch, then add the query-virtio command in 
a second.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


