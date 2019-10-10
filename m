Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86809C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57894206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57894206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYmQ-0007gR-EZ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIYXR-00023K-LP
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIYXQ-0001Xr-EN
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIYXQ-0001Xe-6c
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:31:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6ED5F7BDDA;
 Thu, 10 Oct 2019 13:31:27 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-48.rdu2.redhat.com
 [10.10.120.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A29F75DA2C;
 Thu, 10 Oct 2019 13:31:25 +0000 (UTC)
Subject: Re: [RFC 1/3] acpi: cpuhp: fix 'Command data' description is spec
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-2-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fbbc58a6-7117-c76a-58ae-5e9a78890a8f@redhat.com>
Date: Thu, 10 Oct 2019 15:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191009132252.17860-2-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 10 Oct 2019 13:31:27 +0000 (UTC)
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

2nd round:

On 10/09/19 15:22, Igor Mammedov wrote:
> QEMU returns 0, in case of erro or invalid value in 'Command field',
> make spec match reality, i.e.

AHA! so this is exactly where you meant to list the particular cases
when "command data" reads as 0:
- CPU >= max_cpus selected,
- CPU with pending events asked for, but none found

> Also fix returned value description  in case 'Command field' == 0x0,
> it's in not PXM but CPU selector value with pending event
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index ee219c8358..ac5903b2b1 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -44,9 +44,10 @@ read access:
>             3-7: reserved and should be ignored by OSPM
>      [0x5-0x7] reserved
>      [0x8] Command data: (DWORD access)
> -          in case of error or unsupported command reads is 0xFFFFFFFF
> +          in case of error or unsupported command reads is 0x0
>            current 'Command field' value:
> -              0: returns PXM value corresponding to device
> +              0: returns CPU selector value corresponding to a CPU with
> +                 pending event.
>  
>  write access:
>      offset:
> 

How about:

    [0x8] Command data: (DWORD access, little endian)
          If the "CPU selector" value last stored by the guest refers to
          an impossible CPU, then 0.
          Otherwise, if the "Command field" value last stored by the
          guest differs from 0, then 0.
          Otherwise, if there is at least one CPU with a pending event,
          then that CPU has been selected; the command data register
          returns that selector.
          Otherwise, 0.

Thanks
Laszlo

