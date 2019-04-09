Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2E9C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF94C20830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF94C20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38203 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDnJf-0005k6-Vn
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:45:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDnIc-00059q-CX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hDnIb-0001gg-DB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hDnIb-0001ek-2P; Tue, 09 Apr 2019 05:44:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73BA4C049E22;
	Tue,  9 Apr 2019 09:44:11 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 938DB19C7B;
	Tue,  9 Apr 2019 09:44:01 +0000 (UTC)
Date: Tue, 9 Apr 2019 11:44:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Message-ID: <20190409114400.12258e41@redhat.com>
In-Reply-To: <20190409053320.14612-1-sw@weilnetz.de>
References: <20190409053320.14612-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 09 Apr 2019 09:44:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Update configure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409094400.c3eg3kWuWkwS5QIcbqpR-L5gIpYv2cYSQThyktGxt-4@z>

On Tue,  9 Apr 2019 07:33:20 +0200
Stefan Weil <sw@weilnetz.de> wrote:

> The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a7027..9c5d9a8c96 100755
> --- a/configure
> +++ b/configure
> @@ -7886,7 +7886,6 @@ LINKS="$LINKS python"
>  for bios_file in \
>      $source_path/pc-bios/*.bin \
>      $source_path/pc-bios/*.lid \
> -    $source_path/pc-bios/*.aml \
>      $source_path/pc-bios/*.rom \
>      $source_path/pc-bios/*.dtb \
>      $source_path/pc-bios/*.img \


