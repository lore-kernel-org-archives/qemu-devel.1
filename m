Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3CBC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B8920665
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B8920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htD1v-0005VU-PK
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37604)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1htCxd-0003Cx-Lm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1htCxZ-0006bT-6T
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:25:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1htCxQ-0006Nk-Bt
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:25:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EC1430BD1BC;
 Thu,  1 Aug 2019 15:25:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B2035D9CD;
 Thu,  1 Aug 2019 15:25:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B86BB1138619; Thu,  1 Aug 2019 17:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ning Bo <ning.bo9@zte.com.cn>
References: <1564644533-28850-1-git-send-email-ning.bo9@zte.com.cn>
Date: Thu, 01 Aug 2019 17:25:04 +0200
In-Reply-To: <1564644533-28850-1-git-send-email-ning.bo9@zte.com.cn> (Ning
 Bo's message of "Thu, 1 Aug 2019 15:28:53 +0800")
Message-ID: <87v9vgoqlr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 01 Aug 2019 15:25:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ning Bo <ning.bo9@zte.com.cn> writes:

> Report vsock running event so that the upper application can
> control boot sequence.
> see https://github.com/kata-containers/runtime/pull/1918

Please provide a more complete summary of the use case in the commit
message.  What exactly is the problem?  What is the proposed solution,
and how does it make use of the new event?

> Signed-off-by: Ning Bo <ning.bo9@zte.com.cn>
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
> index a6e81ac..7b746e3 100644
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
> +# Emitted when the guest changes the vsock status.
> +#
> +# @cid: guest context ID
> +#
> +# @running: true if the vsock is running
> +#
> +# Since: v4.2
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

Can you explain why you put this into char.json?

The event traces successful calls of vhost_vsock_set_running().  I have
no idea what vhost_vsock_set_running() does (pardon my ignorance).  Can
you point me to a specification?

Its @start parameter is int.  The event's @running is bool.  Zero gets
mapped to false, non-zero to true.  Are you sure all non-zero values are
equivalent, and will remain equivalent?

