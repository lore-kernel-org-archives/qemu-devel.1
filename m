Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCBEC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6507420409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EokaQiWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6507420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtKS-0005E2-Eb
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jDrOU-00088V-OO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jDrOT-0004dt-NJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jDrOT-0004Z2-HQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584371465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpjvqKas4y2b/BCytF+DA/jQXRt+9X/sXAyOVsioO4I=;
 b=EokaQiWH546H2g+Q+KjOJi252tXYpy359OJuXluhjeuhZYv1T5Iq2dSCCJGQmvcTvwH1Ac
 51LjYp0bDKYZSQod6TjBwkKTdBcsdMjtWax/2BYn7NFqzIya33Oy8MzgiWlLaTD67JgSUV
 Bn2sK55e4uM94OauL+c14j9wRjkRLHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-dfzUOCylNmeSpMyNYTVzjg-1; Mon, 16 Mar 2020 11:11:01 -0400
X-MC-Unique: dfzUOCylNmeSpMyNYTVzjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED2C1922973;
 Mon, 16 Mar 2020 15:10:59 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A94105D9C9;
 Mon, 16 Mar 2020 15:10:59 +0000 (UTC)
Subject: Re: [PATCH v3 02/34] qapi: Belatedly update doc comment for @wait
 deprecation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <22d56f68-934f-86b4-c746-9fec70132569@redhat.com>
Date: Mon, 16 Mar 2020 10:10:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315144653.22660-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 9:46 AM, Markus Armbruster wrote:
> Commit a9b305ba29 "socket: allow wait=false for client socket"
> deprecated use of @wait for client socket chardevs, but neglected to
> update char.json's doc comment.  Make up for that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/char.json | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/char.json b/qapi/char.json
> index 6907b2bfdb..daceb20f84 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -258,6 +258,7 @@
>   # @server: create server socket (default: true)
>   # @wait: wait for incoming connection on server
>   #        sockets (default: false).
> +#        Silently ignored with server: false.  This use is deprecated.
>   # @nodelay: set TCP_NODELAY socket option (default: false)
>   # @telnet: enable telnet protocol on server
>   #          sockets (default: false)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


