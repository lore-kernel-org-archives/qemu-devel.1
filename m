Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74753C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 11:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2DB2245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 11:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAQpCIeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2DB2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icpfz-0004Ne-A8
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 06:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1icpel-0003y1-JH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1icpei-0008NF-U9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:50:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1icpei-0008GA-KA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575546647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXQOmLEz2kX864QF322qqYDBqbtezdCDgu4BlNc/lRU=;
 b=DAQpCIePsR1sIss0xlrhYk9dSD2UVc+6L+TrE1RHP0cN1QeMZbvN+0R+wdcRVYOB5YIQqM
 ntq4HyCsejKRAG4TXsJT2pDUI36//3+iKDBQujTEmahFQtiOl3GRgw9FLa36xHj1r0WvTi
 6zZLqfHCbsge7fcM5S0Ij0F/FG6Rips=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-BGzzT2h7NsSF53gSXj9O9A-1; Thu, 05 Dec 2019 06:50:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B186800EBD
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 11:50:45 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A01619481;
 Thu,  5 Dec 2019 11:50:38 +0000 (UTC)
Subject: Re: [PATCH for-5.0 3/8] acpi: cpuhp: spec: clarify 'CPU selector'
 register usage and endianness
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-4-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ebaf30fd-0821-ca5c-2bc1-b2dff9b058cb@redhat.com>
Date: Thu, 5 Dec 2019 12:50:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575479147-6641-4-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BGzzT2h7NsSF53gSXj9O9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> * Move reserved registers to the top of the section, so reader would be
>   aware of effects when reading registers description.
> * State registers endianness explicitly at the beginning of the section
> * Describe registers behavior in case of 'CPU selector' register contains
>   value that doesn't point to a possible CPU.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index ee219c8..4e65286 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -30,6 +30,18 @@ Register block base address:
>  Register block size:
>      ACPI_CPU_HOTPLUG_REG_LEN = 12
>  
> +All accesses to registers described below, imply little-endian byte order.
> +
> +Reserved resisters behavior:
> +   - write accesses are ignored
> +   - read accesses return all bits set to 0.
> +
> +The last stored value in 'CPU selector' must refer to a possible CPU, otherwise
> +  - reads from any register return 0
> +  - writes to any other register are ignored until valid value is stored into it
> +On QEMU start, 'CPU selector' is initialized to a valid value, on reset it
> +keeps the current value.
> +
>  read access:
>      offset:
>      [0x0-0x3] reserved
> @@ -86,9 +98,3 @@ write access:
>                   ACPI_DEVICE_OST QMP event from QEMU to external applications
>                   with current values of OST event and status registers.
>              other values: reserved
> -
> -Selecting CPU device beyond possible range has no effect on platform:
> -   - write accesses to CPU hot-plug registers not documented above are
> -     ignored
> -   - read accesses to CPU hot-plug registers not documented above return
> -     all bits set to 0.
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


