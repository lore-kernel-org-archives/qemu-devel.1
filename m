Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C94C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA53E21835
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxJJTA4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA53E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ics6G-00047L-KI
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1ics2C-0008M6-6i
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1ics2B-0003Wc-0M
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:23:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ics2A-0003Up-Qy
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575555790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9k3MibFLh40LprRlfXDBRlhCAPdk1SwVWkRGlPDdYA=;
 b=bxJJTA4BVYHMU9ROAq03TsI9wNH3TSYh+VOvTP6akOerpCMt7SKsaLQnY/rQMDwPgGVchk
 rCsM/j9jJt+MU47nmy3E1r9zocET6W+pTfGCQunELStXGJSAQaN9hSt2NDsUaQ1730VGzw
 CefDV7z69nehrPYE8V9mWfql9SP+hFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-0Cchx1Z6PIyiUHnUhFKYiw-1; Thu, 05 Dec 2019 07:22:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E7F08017DF
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 12:22:00 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEC685D9C9;
 Thu,  5 Dec 2019 12:21:54 +0000 (UTC)
Subject: Re: [PATCH for-5.0 5/8] acpi: cpuhp: spec: clarify store into
 'Command data' when 'Command field' == 0
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-6-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <aef3bad3-37cb-86c7-50dc-f6162c3030d6@redhat.com>
Date: Thu, 5 Dec 2019 13:21:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575479147-6641-6-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 0Cchx1Z6PIyiUHnUhFKYiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/04/19 18:05, Igor Mammedov wrote:
> Write section of 'Command data' register should describe what happens
> when it's written into. Correct description in case the last stored
> 'Command field' value equals to 0, to reflect that currently it's not

s/equals to/equals/

or

s/equals to/is equal to/

With that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> supported.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index 19c508f..f3c552d 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -90,8 +90,7 @@ write access:
>              other values: reserved
>      [0x6-0x7] reserved
>      [0x8] Command data: (DWORD access)
> -          current 'Command field' value:
> -              0: OSPM reads value of CPU selector
> +          if last stored 'Command field' value:
>                1: stores value into OST event register
>                2: stores value into OST status register, triggers
>                   ACPI_DEVICE_OST QMP event from QEMU to external applications
> 


