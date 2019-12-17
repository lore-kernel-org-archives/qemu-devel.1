Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50249C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9AC206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 13:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2qc10BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9AC206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihCc2-00013D-7P
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 08:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ihCbT-0000bt-9Z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ihCbQ-0005TJ-7K
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:09:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22118
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ihCbQ-0005T0-3F
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 08:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576588167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KeEb/jOGtge3c71ddijoMt/X6UtE2eezWzgOD/HOg8Q=;
 b=g2qc10BWXgsZbr4XZPPxcdI8BdNhcU8APAJSOYC7kI9vlv05ZlDOTlhZLDER3VJqylR0Xh
 5SJZgx78ySQuI+FJ6uH3Q0F5cQVg+U9xygXJTHCNmq+A65c2KvJ+KD6CvRrMjAAhVmyNck
 sc1o2hRhnFhgvvS543vnvjPta4Gc7q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-FcjREGaTMSy35TQRgYQNvA-1; Tue, 17 Dec 2019 08:09:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6195B1809A2B;
 Tue, 17 Dec 2019 13:09:20 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F05D35D9C9;
 Tue, 17 Dec 2019 13:09:19 +0000 (UTC)
Subject: Re: [PULL 34/34] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191217062651.9687-1-armbru@redhat.com>
 <20191217062651.9687-35-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4135813b-af52-b743-858c-a86dbd3ebce3@redhat.com>
Date: Tue, 17 Dec 2019 07:09:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217062651.9687-35-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FcjREGaTMSy35TQRgYQNvA-1
X-Mimecast-Spam-Score: 0
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 12:26 AM, Markus Armbruster wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> All callers of nbd_iter_channel_error() pass the address of a
> local_err variable, and only call this function if an error has
> already occurred, using this function to propagate that error.
> This is already implied by its name (local_err instead of the classic
> errp), but it is worth additionally stressing this by adding an
> assertion to make it part of the function contract.
> 
> The local_err parameter is not here to return information about
> nbd_iter_channel_error failure. Instead it's assumed to be filled when
> passed to the function. This is already stressed by its name
> (local_err, instead of classic errp). Stress it additionally by
> assertion.

Redundant paragraph, but probably too late to worry about it now that we 
have a pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


