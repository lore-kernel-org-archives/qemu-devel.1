Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFC1C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE082086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE082086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFQah-0000xu-3e
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 18:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iFP6H-0007nD-Fg
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iFP6G-0008UF-8P
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:50:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iFP6B-0008RK-Fl; Tue, 01 Oct 2019 16:50:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A88FE10C0944;
 Tue,  1 Oct 2019 20:50:18 +0000 (UTC)
Received: from [10.3.116.201] (ovpn-116-201.phx2.redhat.com [10.3.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B272E5C1D4;
 Tue,  1 Oct 2019 20:50:12 +0000 (UTC)
Subject: Re: [PATCH 5/6] block-stream: add compress option
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1569958040-697220-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b20bf05a-40b2-a300-5513-a7d225f7d3ba@redhat.com>
Date: Tue, 1 Oct 2019 15:50:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569958040-697220-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 01 Oct 2019 20:50:18 +0000 (UTC)
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 2:27 PM, Andrey Shinkevich wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---

The commit summary says 'what', but left out a body stating 'why'. 
Reading the whole series makes it obvious, but landing on this commit in 
isolation during a future 'git bisect' less so.  It's not necessarily a 
show-stopper, but food for thought in writing future commit messages.


> +++ b/qapi/block-core.json
> @@ -2544,6 +2544,9 @@
>   #
>   # @speed:  the maximum speed, in bytes per second
>   #
> +# @compress: true to compress data, if the target format supports it.

Looking at neighbors, it would be more consistent to drop the trailing dot.

> +#            (default: false). Since 4.1.
> +#

4.2, now.

>   # @on-error: the action to take on an error (default report).
>   #            'stop' and 'enospc' can only be used if the block device
>   #            supports io-status (see BlockInfo).  Since 1.3.
> @@ -2576,7 +2579,7 @@
>   { 'command': 'block-stream',
>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>               '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
> -            '*on-error': 'BlockdevOnError',
> +            '*compress': 'bool', '*on-error': 'BlockdevOnError',
>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>   
>   ##
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

