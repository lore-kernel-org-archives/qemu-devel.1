Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCCEC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0844D207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qb2Mycoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0844D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKCR-0003Hl-00
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieKAu-0001yj-Ah
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieKAr-0000Rn-JN
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:38:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26441
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieKAr-0000QO-6l
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575902288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=b59s9HZxAcJ3zTJx4UeXT1loJHMjnSxDwqKp0eyH8Bg=;
 b=Qb2MycooC3hFBBsdi5oEZAlm3yfn8bQ0SefllKmu8OefnMez8C4AHZViAd0D1DDP8o0xb2
 TsJt7yURwyYuwlJ/Ke8p8+jn2gIOWkba3mQn63IzYiABUfZ+JYYzwDrUmSLXi2W6am/kaI
 JYqo/ZMqrTLy9F8dNZNoLCC4CSW36Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-OTLCjiJ7O42ld9ptYZ1sXg-1; Mon, 09 Dec 2019 09:38:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97EEB188355A;
 Mon,  9 Dec 2019 14:38:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B79D3817C;
 Mon,  9 Dec 2019 14:37:58 +0000 (UTC)
Subject: Re: [PATCH v6 04/21] qtest: add qtest_server_send abstraction
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-5-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <440322cd-5ac9-c941-fcb0-82fcacb34384@redhat.com>
Date: Mon, 9 Dec 2019 15:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-5-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: OTLCjiJ7O42ld9ptYZ1sXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 22.34, Oleinik, Alexander wrote:
> qtest_server_send is a function pointer specifying the handler used to
> transmit data to the qtest client. In the standard configuration, this
> calls the CharBackend handler, but now it is possible for other types of
> handlers, e.g direct-function calls if the qtest client and server
> exist within the same process (inproc)
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/sysemu/qtest.h |  3 +++
>  qtest.c                | 18 ++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>


