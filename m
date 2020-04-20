Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F37C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1932078C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/BIzNr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1932078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbRQ-0002iY-Nj
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46042 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQbO6-0000hA-Jg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:43:23 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQbO5-0001Xk-GB
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:43:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40050
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQbO5-0001H8-0A
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587408193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YW5PaouN5iYAJU322tIKi0u7iI1fnFoS9Gse0obP/fs=;
 b=K/BIzNr9ErPfdJrvWLkujix41u8a+264W/lZ1wkKTaLvEw1D4wU2ZbzJdgFVliBbHafNnB
 SlGUZjn4PVIHsGJOQTrw1ci5a19AeodTXbTuc/L+dAca+/JRj8P5FOw6Jq8Jc6Eak+Ioxy
 dYrLQvHzt19rxs6kBzPARxJVXhnn59Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-Ca-lOYMAM3ehbTH0XGvaxw-1; Mon, 20 Apr 2020 14:43:07 -0400
X-MC-Unique: Ca-lOYMAM3ehbTH0XGvaxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5C501937FC1;
 Mon, 20 Apr 2020 18:43:05 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 844AC76E66;
 Mon, 20 Apr 2020 18:43:04 +0000 (UTC)
Subject: Re: [PATCH 5/7] qapi: add filter-node-name to block-stream
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ded41c7b-b4aa-9222-991a-e2d75443c574@redhat.com>
Date: Mon, 20 Apr 2020 13:43:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587407806-109784-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org, mreitz@redhat.com, jsnow@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 1:36 PM, Andrey Shinkevich wrote:
> Provide the possibility to pass the 'filter-node-name' parameter to the
> block-stream job as it is done for the commit block job.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c            | 5 +++--
>   blockdev.c                | 8 +++++++-
>   include/block/block_int.h | 7 ++++++-
>   monitor/hmp-cmds.c        | 4 ++--
>   qapi/block-core.json      | 6 ++++++
>   5 files changed, 24 insertions(+), 6 deletions(-)
> 

I haven't reviewed the mechanics of this series yet, but from the 
high-level UI perspective:


> +++ b/qapi/block-core.json
> @@ -2552,6 +2552,11 @@
>   #            'stop' and 'enospc' can only be used if the block device
>   #            supports io-status (see BlockInfo).  Since 1.3.
>   #
> +# @filter-node-name: the node name that should be assigned to the
> +#                    filter driver that the stream job inserts into the graph
> +#                    above @device. If this option is not given, a node name is
> +#                    autogenerated. (Since: 5.0)

This should be 5.1, not 5.0.

> +#
>   # @auto-finalize: When false, this job will wait in a PENDING state after it has
>   #                 finished its work, waiting for @block-job-finalize before
>   #                 making any block graph changes.
> @@ -2581,6 +2586,7 @@
>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>               '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
>               '*on-error': 'BlockdevOnError',
> +            '*filter-node-name': 'str',
>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>   
>   ##
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


