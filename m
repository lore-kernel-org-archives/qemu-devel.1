Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBD2C33CB6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B5C24655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 09:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If7Ea73b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B5C24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuC9U-0001XL-7e
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 04:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuC8t-00017S-GL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuC8s-0003DM-5H
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:17:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54204
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuC8s-0003DA-1M
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 04:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579684661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5bBAXv+Kj1zsZ30HLdJrMRk6P2GBasKHAhuff5kAKF4=;
 b=If7Ea73bWD4isaPfEvd8w0UppiC+catoZClrQxBF0ePsbU1vbFI9At7dtV18naCc2izPHi
 OzsKjKcSI/cUNn9iYAWLYTvTbyJkXMNDlvC6eVXcQUrhJvoLy8v+kl+lGn/332J2dOYA4+
 FR8g3Ki/tVRkUX7+mYX2yH/tvn6gn5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-bc8rfrHtM-iNIwQlMKFZ6g-1; Wed, 22 Jan 2020 04:17:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 228D7107ACC5
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 09:17:39 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B7615DA75;
 Wed, 22 Jan 2020 09:17:31 +0000 (UTC)
Subject: Re: [PATCH 1/5] bios-tables-test: tell people how to update
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200122080538.591734-1-mst@redhat.com>
 <20200122080538.591734-2-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <55b3d88e-3426-9f8c-a11e-88ab7a1af815@redhat.com>
Date: Wed, 22 Jan 2020 10:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122080538.591734-2-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: bc8rfrHtM-iNIwQlMKFZ6g-1
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

On 22/01/2020 09.05, Michael S. Tsirkin wrote:
> For now just a pointer to the source file.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 3ab4872bd7..6b5f24bf62 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -426,7 +426,9 @@ static void test_acpi_asl(test_data *data)
>  
>          fprintf(stderr,
>                  "acpi-test: Warning! %.4s binary file mismatch. "
> -                "Actual [aml:%s], Expected [aml:%s].\n",
> +                "Actual [aml:%s], Expected [aml:%s].\n"
> +                "See source file tests/qtest/bios-tables-test.c "
> +                "for instructions on how to update expected files.\n",
>                  exp_sdt->aml, sdt->aml_file, exp_sdt->aml_file);
>  
>          all_tables_match = all_tables_match &&
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


