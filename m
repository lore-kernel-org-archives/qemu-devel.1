Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F7CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CDF20854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CDF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLYtG-0000xv-E2
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 16:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLYri-0007wn-OU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLYrh-0000gD-Ei
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iLYrh-0000fg-8b
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 16:28:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30A3F11A2D;
 Fri, 18 Oct 2019 20:28:48 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA82F5DAAE;
 Fri, 18 Oct 2019 20:28:36 +0000 (UTC)
Subject: Re: [PATCH 05/11] qapi: add unplug primary event
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-6-jfreimann@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <186357a6-3b91-51eb-1daf-2ea9ef6071f5@redhat.com>
Date: Fri, 18 Oct 2019 15:28:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018202040.30349-6-jfreimann@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 18 Oct 2019 20:28:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 3:20 PM, Jens Freimann wrote:
> This event is emitted when we sent a request to unplug a
> failover primary device from the Guest OS and it includes the
> device id of the primary device.
> 
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>   qapi/migration.json | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 82feb5bd39..52e69e2868 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1448,3 +1448,22 @@
>   # Since: 3.0
>   ##
>   { 'command': 'migrate-pause', 'allow-oob': true }
> +
> +##
> +# @UNPLUG_PRIMARY:
> +#
> +# Emitted from source side of a migration when migration state is
> +# WAIT_UNPLUG. Device was unplugged by guest operating system.
> +# Device resources in QEMU are kept on standby to be able to re-plug it in case
> +# of migration failure.
> +#
> +# @device_id: QEMU device id of the unplugged device
> +#
> +# Since: 4.2
> +#
> +# Example:
> +#   {"event": "UNPLUG_PRIMARY", "data": {"device_id": "hostdev0"} }

Unless there is a strong reason in favor of 'device_id' (such as 
consistency with a similar event), our naming convention prefers this to 
be 'device-id'.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

