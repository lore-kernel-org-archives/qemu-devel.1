Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86682C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 18:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A5821848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 18:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A5821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFj9C-0000yb-Id
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 14:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFj8B-0000Su-TD
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 14:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFj8A-0007e9-S0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 14:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iFj88-0007b8-Gy; Wed, 02 Oct 2019 14:13:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43363307D974;
 Wed,  2 Oct 2019 18:13:38 +0000 (UTC)
Received: from [10.3.117.6] (ovpn-117-6.phx2.redhat.com [10.3.117.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBB1E5D9D3;
 Wed,  2 Oct 2019 18:13:37 +0000 (UTC)
Subject: Re: [PATCH] iotests/162: Fix for newer Linux 5.3+
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191002174052.5773-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bd4b86b6-2a4f-78ed-6930-890292190575@redhat.com>
Date: Wed, 2 Oct 2019 13:13:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002174052.5773-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 02 Oct 2019 18:13:38 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 12:40 PM, Max Reitz wrote:
> Linux 5.3 has made 0.0.0.0/8 a working IPv4 subnet.  As such, "42" is
> now a valid host, and the connection to it will (hopefully) time out
> over a long period rather than quickly return with EINVAL.
> 
> So let us use a negative integer for testing that NBD will not crash
> when it receives integer hosts.  This way, the connection will again
> fail quickly and reliably.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/162     | 2 +-
>   tests/qemu-iotests/162.out | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm happy to take this through my NBD tree, or it can go with other 
batched iotests, whichever path is easier.

> 
> diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
> index 2d719afbed..c0053ed975 100755
> --- a/tests/qemu-iotests/162
> +++ b/tests/qemu-iotests/162
> @@ -46,7 +46,7 @@ echo '=== NBD ==='
>   # NBD expects all of its arguments to be strings
>   
>   # So this should not crash
> -$QEMU_IMG info 'json:{"driver": "nbd", "host": 42}'
> +$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}'
>   
>   # And this should not treat @port as if it had not been specified
>   # (We need to set up a server here, because the error message for "Connection
> diff --git a/tests/qemu-iotests/162.out b/tests/qemu-iotests/162.out
> index 3c5be2c569..5a00d36d17 100644
> --- a/tests/qemu-iotests/162.out
> +++ b/tests/qemu-iotests/162.out
> @@ -1,7 +1,7 @@
>   QA output created by 162
>   
>   === NBD ===
> -qemu-img: Could not open 'json:{"driver": "nbd", "host": 42}': Failed to connect socket: Invalid argument
> +qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address resolution failed for -1:10809: Name or service not known
>   image: nbd://localhost:PORT
>   image: nbd+unix://?socket=42
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

