Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B26BC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB78021734
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnVQLrTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB78021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j20UX-0000Y3-Vt
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j20Ty-0008Si-2l
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j20Tw-0007rQ-Rc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:27:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j20Tw-0007r5-NG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581546464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpL7IJLwUL2QKwDIGgNNnKflS4tUNZmi76iHFhrnDvg=;
 b=gnVQLrTrNv4kBSwSkSyrSDUsHrG01pikf3cnBVUbiE3jrQ2J2vc+ro2APG+q9hwAKZ6M4D
 aLouPPpcgus2oLNRvcJEj3G0E/y0C8+hC2m9K3p42oaAR7mtU1P4ph9mwICtepn3d3IgtO
 ZPZFnas9s3C2iTFCbDeTM58+uow6DoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-SWN1QuflNl2aYxUILl_ahQ-1; Wed, 12 Feb 2020 17:27:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A401005502
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 22:27:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-72.ams2.redhat.com
 [10.36.117.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 184EC5C1B2;
 Wed, 12 Feb 2020 22:27:35 +0000 (UTC)
Subject: Re: [PATCH] acpi: cpuhp: document CPHP_GET_CPU_ID_CMD command
To: mst@redhat.com
References: <1580306781-228371-1-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3c6d3232-f5d3-3d42-da19-2aa5a3c7ef02@redhat.com>
Date: Wed, 12 Feb 2020 23:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1580306781-228371-1-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: SWN1QuflNl2aYxUILl_ahQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Igor Mammedov <imammedo@redhat.com>, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael,

On 01/29/20 15:06, Igor Mammedov wrote:
> Commit 3a61c8db9d25 introduced CPHP_GET_CPU_ID_CMD command but
> did not sufficiently describe it. Fix it by adding missing command
> documentation.
> 
> Fixes: 3a61c8db9d25 ("acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command")
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index a8ce5e7..9bb22d1 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -94,6 +94,8 @@ write access:
>                 register in QEMU
>              2: following writes to 'Command data' register set OST status
>                 register in QEMU
> +            3: following reads from 'Command data' and 'Command data 2' return
> +               architecture specific CPU ID value for currently selected CPU.
>              other values: reserved
>      [0x6-0x7] reserved
>      [0x8] Command data: (DWORD access)
> 

can you please merge this?

It's a docs patch, but 3a61c8db9d25 (noted in "Fixes:") had gone in
through your tree.

Thank you!
Laszlo


