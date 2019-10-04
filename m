Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E94C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B07C2077B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B07C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGRyG-0004BW-J0
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 14:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iGRxQ-0003eq-J1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iGRxP-0005Wb-HE
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iGRxK-0005SE-7W; Fri, 04 Oct 2019 14:05:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DC9DC065116;
 Fri,  4 Oct 2019 18:05:29 +0000 (UTC)
Received: from [10.3.117.6] (ovpn-117-6.phx2.redhat.com [10.3.117.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D322710018F8;
 Fri,  4 Oct 2019 18:05:25 +0000 (UTC)
Subject: Re: [PATCH v9 3/3] iotests: test nbd reconnect
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-4-vsementsov@virtuozzo.com>
 <7f0a7890-7b3d-9fd7-954d-389a8e28106f@redhat.com>
 <88a7e9c9-caf2-b114-93c4-7c99036c9b33@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7854fa11-5c2d-4b88-16f8-2bbb2679efa2@redhat.com>
Date: Fri, 4 Oct 2019 13:05:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <88a7e9c9-caf2-b114-93c4-7c99036c9b33@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 04 Oct 2019 18:05:29 +0000 (UTC)
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 3:31 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> +def qemu_nbd_popen(*args):
>>> +    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
>>> +    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
>>> +
>>
>> Should you also use a pid file here, and wait for the existence of the
>> pid file before returning (rather than hard-coding sleep(1))?
> 
> What do you mean / how to do it?
> 
> We want to wait until listening socket is prepared..

In shell:

qemu-nbd --pid-file=/path/to/file ...
while [ ! -e /path/to/file ]; do
   sleep ... # fractional second, or exponential, or whatever...
done
# Now the listening socket is indeed prepared

You'd have to translate that idiom to python.

Or:

pre-open Unix socket at /path/to/socket
LISTEN_PID=... LISTEN_FDS=1 qemu-nbd ... 3<>/path/to/socket

Now the socket is pre-created and passed into qemu-nbd via systemd 
socket activation, so you know the listening socket is ready without 
having to do any loop at all.  Here's a patch in libnbd where we just 
switched from waiting for the port to appear (because the test predated 
qemu-nbd pidfile support) to instead using socket activation, for reference:
https://github.com/libguestfs/libnbd/commit/352331d177

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

