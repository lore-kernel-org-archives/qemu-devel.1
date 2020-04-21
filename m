Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD58C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E452076C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D19ci51d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E452076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsQi-0002Ls-FL
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQsPw-0001Mv-Jr
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQsPv-0001qE-0R
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:54:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQsPu-0001np-D4
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587473661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYI0vty0r8MgMQ6+Z8aCvBCFr5zHIMshM26h6y2pO28=;
 b=D19ci51ds361aiB7VRXkhXc/EGhJIBDW3RDdq/gzuwYBmasIJ8PUKafpWT392ardF61KuQ
 eiZ9LQJe5q5xOlQ4x0XiBWNf1Jy0LHTiZYfuqk4SB17u/WHd9L47uepZYQszg5cXG73TWJ
 CpWxQhbp3X2L1cBt0IcmYG6/ttz1EBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-AW5dIUBPNt282wCUWFE84A-1; Tue, 21 Apr 2020 08:54:09 -0400
X-MC-Unique: AW5dIUBPNt282wCUWFE84A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29C6E18CA244;
 Tue, 21 Apr 2020 12:54:08 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD316B3A6B;
 Tue, 21 Apr 2020 12:54:06 +0000 (UTC)
Subject: Re: [PATCH v3 01/10] iotests/277: use dot slash for
 nbd-fault-injector.py running
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <80af4905-332c-228c-cf3d-0b00d098a7d3@redhat.com>
Date: Tue, 21 Apr 2020 07:54:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421073601.28710-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 2:35 AM, Vladimir Sementsov-Ogievskiy wrote:
> Somehow, this doesn't work if you just call ./277. But check 277 works.
> We are going to new iotests running framework, which will consider test
> files as self-executable, so let's just change it now.

This is a rather vague explanation.  I'd prefer something a bit more 
forthcoming, maybe:

If you run './check 277', check includes common.config which adjusts 
$PATH to include '.' first, and therefore finds nbd-fault-injector.py on 
PATH.  But if you run './277' directly, there is nothing to adjust PATH, 
and if '.' is not already on your PATH by other means, the test fails 
because the executable is not found.  Adjust how we invoke the helper 
executable to avoid needing a PATH search in the first place.


At any rate, while the commit message could be improved, the fix itself 
is reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/277 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
> index 04aa15a3d5..a4ef1a38c6 100755
> --- a/tests/qemu-iotests/277
> +++ b/tests/qemu-iotests/277
> @@ -40,7 +40,7 @@ def make_conf_file(event):
>   def start_server_NBD(event):
>       make_conf_file(event)
>   
> -    srv = subprocess.Popen(['nbd-fault-injector.py', '--classic-negotiation',
> +    srv = subprocess.Popen(['./nbd-fault-injector.py', '--classic-negotiation',
>                              nbd_sock, conf_file], stdout=subprocess.PIPE,
>                              stderr=subprocess.STDOUT, universal_newlines=True)
>       line = srv.stdout.readline()
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


