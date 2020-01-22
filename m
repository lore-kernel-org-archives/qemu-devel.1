Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE26C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1999424655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OE4tjEne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1999424655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuCAU-0002QB-AH
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 04:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuC9q-000206-39
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuC9p-0003Wh-5z
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:18:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuC9p-0003WX-1p
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579684720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=hMd3w710m8VocgP0prwCceFlmCb6K9B/EfqJkMWR4xM=;
 b=OE4tjEneqKzN0wcEjriScDRX0g6TabRm/8j1NJlj2wUcQtTCOjQrpBneRC8YXIfZl5VqmT
 8rx6x0twFpXly58Eql9hOVQZHsgwbl1bGU2fo4jXslqkf7XXImxXr65i2lauy7merNWsXc
 HAhdYAHj0dIOioOa/sZIbF81Ezr3BEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-biZ86ndqPJq2hKcQpABMnQ-1; Wed, 22 Jan 2020 04:18:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59751184AD5B
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 09:18:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B89CF8BE31;
 Wed, 22 Jan 2020 09:18:31 +0000 (UTC)
Subject: Re: [PATCH 4/5] bios-tables-test: fix path to allowed diff
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200122080538.591734-1-mst@redhat.com>
 <20200122080538.591734-5-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0557a86b-0088-667b-cbf2-410fee2488e2@redhat.com>
Date: Wed, 22 Jan 2020 10:18:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122080538.591734-5-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: biZ86ndqPJq2hKcQpABMnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/01/2020 09.06, Michael S. Tsirkin wrote:
> Fixes: 1e8a1fae7464 ("test: Move qtests to a separate directory")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 6ec1c5be64..6535ab7f04 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -21,7 +21,7 @@
>   * in binary commit created in step 6):
>   *
>   * After 1-3 above tests will pass but ignore differences with the expected files.
> - * You will also notice that tests/bios-tables-test-allowed-diff.h lists
> + * You will also notice that tests/qtest/bios-tables-test-allowed-diff.h lists
>   * a bunch of files. This is your hint that you need to do the below:
>   * 4. Run
>   *      make check V=1
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


