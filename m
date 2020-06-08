Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D71C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 21:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03A22068D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 21:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6f+/tNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03A22068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiOwf-0001QW-Ma
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 17:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiOu2-0000gc-Fz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 17:01:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31159
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiOu0-0008Uy-O1
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 17:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591650110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ve5hxuSZTi8WLtadxUsaCc9ttp96eonQYxMD85lEVPk=;
 b=I6f+/tNUiL4bbO0/pz0zi/r9FHg5TuxFkQSEEa+OL90ZgZc2vv2c2/ym+RZfji2yKin71B
 UJ+8bzdI3kdJDjuC1TVfmT0CBYCgtkZW7CYuQDVlIaJqAfh2RnWXCX7npImgYY0KKYnphc
 0nhOHMl5/XW/rkJShPB+qirPuEyc7Uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-zMoEmiVSPZ2Q-RI1H7T6bg-1; Mon, 08 Jun 2020 17:01:32 -0400
X-MC-Unique: zMoEmiVSPZ2Q-RI1H7T6bg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85B9F1005510;
 Mon,  8 Jun 2020 21:01:31 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE3E81C8;
 Mon,  8 Jun 2020 21:01:27 +0000 (UTC)
Subject: Re: [PATCH v5 02/13] qcow2.py: add licensing blurb
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>
 <20200606081806.23897-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <518f19e0-79d8-6d8a-ac83-28f4d724d9a0@redhat.com>
Date: Mon, 8 Jun 2020 16:01:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200606081806.23897-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, andrey.shinkevich@virtuozzo.com,
 den@openvz.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/20 3:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add classic heading, which is missing here. Keep copyright place empty,
> for anyone who have added (or will add) some intellectual property
> here.

It's not so much intellectual property (since that term is at odds with 
open source), but authorship rights.

Looking at git history, the file has been touched by:

Kevin Wolf
Stefan Hajnoczi (while at IBM)
Eduardo Habkost
Max Reitz
Philippe Mathieu-Daudé
Paolo Bonzini

where Stefan was the only contributor without a redhat.com address at 
the time.  So if anything, a Red Hat copyright is most likely; but you 
are also correct that it is incorrect to add a copyright line on someone 
else's behalf without their permission.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index d99f4ee3e8..2da434a013 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -1,4 +1,20 @@
>   #!/usr/bin/env python3
> +#
> +# Manipulations with qcow2 image
> +#

I've cc'd all prior authors; if Kevin agrees, and unless anyone speaks 
up to the contrary, I'm willing to add:

# Copyright (C) 2012 Red Hat, Inc.

for Kevin's initial contribution, without worrying about subsequent 
contributions.

> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
>   
>   import sys
>   import struct
> 

Adding a copyright line could be a followup patch, so in the meantime, 
making what was previously an implicit license now explicit is fine even 
if it is odd to assert GPL without also asserting Copyright.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


