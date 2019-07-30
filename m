Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB2C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2AA2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2AA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsYl8-0003hi-PD
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 16:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsYkh-0003HB-04
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsYkf-0001gB-N9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:29:42 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsYkf-0001fZ-I5
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:29:41 -0400
Received: by mail-vk1-f196.google.com with SMTP id v68so9397453vkd.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 13:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6lxOQuf9cOgkjJ7SlAXxaNPHuPIp1gbvGyy/KMjETto=;
 b=SUjNK6vJul0OO4nTNh9XsQraaQvSDSNLXENjO/vjK77DZA6lMZtRJ3aufsEcZ3Ul2o
 Gx5FoVYkCODj0Tc2YNeVfNNvMpSTTuAsqi4F9bE8NWv0yjAEwpJMQ7g8B15WYVlIQfZM
 6qd30C11qkG01/JuAVtVB5OQb5T4OJBi3FBjRBHwFr4Png1THJ8zDZmS6wrpS15l4Ihc
 Q3Lus2NRRGQYc6PUJWwL82ZFV+B9QRJguZ9DI706NTBD5gX8t8RE50GgHleQpuXIhsQA
 nBqzts7uxxJk5rUHnFGlRwe4vcYWAqWnr0kbSEZ8mO0ZWS+ZJNfnySIhhcpDQ9bFEvKP
 IvjA==
X-Gm-Message-State: APjAAAVQ2+QBz7tHFU7bDtDeQftmXeesIGWRFDU69iZOLsWDsK550VrK
 5JCLaBMr34Mu5N+wxIMlMS5e7Q==
X-Google-Smtp-Source: APXvYqyT+1IqbTJwbMpKbIMJkrQgQdcEpqdQJqXIapG/RD3fhsdffBfg4XMUZkqPxCPUf9ZF2dLNYw==
X-Received: by 2002:a1f:50c1:: with SMTP id e184mr46653546vkb.86.1564518580900; 
 Tue, 30 Jul 2019 13:29:40 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 d67sm19444867vkd.25.2019.07.30.13.29.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 13:29:39 -0700 (PDT)
Date: Tue, 30 Jul 2019 16:29:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "N. B." <n.b@live.com>
Message-ID: <20190730162803-mutt-send-email-mst@kernel.org>
References: <HK2PR04MB38595779EA521C94675599F981DC0@HK2PR04MB3859.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR04MB38595779EA521C94675599F981DC0@HK2PR04MB3859.apcprd04.prod.outlook.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.196
Subject: Re: [Qemu-devel] [PATCH] vhost-vsock: report QMP event when set
 running
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
Cc: Ning Bo <ning.bo9@zte.com.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, stefanha@redhat.com,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 12:24:27PM +0000, N. B. wrote:
> From: Ning Bo <n.b@live.com>
> 
> Report vsock running event so that the upper application can
> control boot sequence.
> see https://github.com/kata-containers/runtime/pull/1918
> 
> Signed-off-by: Ning Bo <ning.bo9@zte.com.cn>

Cc Stefan.

Stefan, are you willing to maintain virtio/vhost-vsock in qemu, too?

If yes let's add an entry to MAINTAINERS, ok?

> ---
>  hw/virtio/vhost-vsock.c |  3 +++
>  qapi/char.json          | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 0371493..a5920fd 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -22,6 +22,7 @@
>  #include "qemu/iov.h"
>  #include "qemu/module.h"
>  #include "monitor/monitor.h"
> +#include "qapi/qapi-events-char.h"
>  
>  enum {
>      VHOST_VSOCK_SAVEVM_VERSION = 0,
> @@ -68,6 +69,8 @@ static int vhost_vsock_set_running(VHostVSock *vsock, int start)
>      if (ret < 0) {
>          return -errno;
>      }
> +    qapi_event_send_vsock_running(vsock->conf.guest_cid, start != 0);
> +
>      return 0;
>  }
>  
> diff --git a/qapi/char.json b/qapi/char.json
> index a6e81ac..0958dd1 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -570,3 +570,25 @@
>  { 'event': 'VSERPORT_CHANGE',
>    'data': { 'id': 'str',
>              'open': 'bool' } }
> +
> +##
> +# @VSOCK_RUNNING:
> +#
> +# Emitted when the guest be set running.
> +#
> +# @cid: guest context ID
> +#
> +# @running: true if the vsock be set running
> +#
> +# Since: v4.1.0
> +#
> +# Example:
> +#
> +# <- { "event": "VSOCK_RUNNING",
> +#      "data": { "cid": "123456", "running": true },
> +#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
> +#
> +##
> +{ 'event': 'VSOCK_RUNNING',
> +  'data': { 'cid': 'uint64',
> +            'running': 'bool' } }
> -- 
> 2.9.5

