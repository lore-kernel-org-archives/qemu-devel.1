Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2315BC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABF6206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABF6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZCq-0007qw-53
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIZCD-0007PX-E3
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIZCB-0002SW-Eq
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:13:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIZCB-0002SA-5U
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:13:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2F63C3082E24;
 Thu, 10 Oct 2019 14:13:34 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-48.rdu2.redhat.com
 [10.10.120.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7073260BE1;
 Thu, 10 Oct 2019 14:13:23 +0000 (UTC)
Subject: Re: [RFC 2/3] acpi: cpuhp: add typical usecases into spec
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-3-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2b10ca48-c734-4f41-9521-136c44060812@redhat.com>
Date: Thu, 10 Oct 2019 16:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191009132252.17860-3-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 10 Oct 2019 14:13:34 +0000 (UTC)
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

On 10/09/19 15:22, Igor Mammedov wrote:
> Clarify values of "CPU selector' register and add workflows for
>   * finding CPU with pending 'insert/remove' event
>   * enumerating present/non present CPUs
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index ac5903b2b1..43c5a193f0 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -54,6 +54,7 @@ write access:
>      [0x0-0x3] CPU selector: (DWORD access)
>                selects active CPU device. All following accesses to other
>                registers will read/store data from/to selected CPU.
> +              Valid values: [0 .. max_cpus)
>      [0x4] CPU device control fields: (1 byte access)
>          bits:
>              0: reserved, OSPM must clear it before writing to register.
> @@ -93,3 +94,24 @@ Selecting CPU device beyond possible range has no effect on platform:
>       ignored
>     - read accesses to CPU hot-plug registers not documented above return
>       all bits set to 0.
> +
> +Typical usecases:
> +   - Get a cpu with pending event
> +     1. write 0x0 into 'Command field' register
> +     2. read from 'Command data' register, CPU selector value (CPU's UID in ACPI
> +        tables) and event for selected CPU from 'CPU device status fields'
> +        register. If there aren't pending events, CPU selector value doesn't
> +        change and 'insert' and 'remove' bits are not set.

Okay, so based on the "Command data" documentation I'm suggesting in
<http://mid.mail-archive.com/cd0713b5-fd64-d3e1-7f83-3a0725b819a3@redhat.com>,
I propose:

1. Store 0x0 to the 'CPU selector' register.
2. Store 0x0 to the 'Command field' register.
3. Read the 'CPU device status fields' register.
4. If both bit#1 and bit#2 are clear in the value read, there is no CPU
   with a pending event.
5. Otherwise, read the 'Command data' register. The value read is the
   selector of the CPU with the pending event (which is already
   selected).

> +   - Enumerate CPUs present/non present CPUs.
> +     1. set iterator to 0x0
> +     2. write 0x0 into 'Command field' register and then iterator
> +        into 'CPU selector' register.
> +     3. read 'enabled' flag for selected CPU from 'CPU device status fields'
> +        register
> +     4. to continue to the next CPU, increment iterator and repeat step 2
> +     5. read 'Command data' register
> +     5.1 if 'Command data' register matches iterator continue to step 3.
> +         (read presence bit for the next CPU)
> +     5.2 if 'Command data' register has not changed, there is not CPU
> +         corresponding to iterator value and the last valid iterator value
> +         equals to 'max_cpus' + 1
> 

How about:

01. Set the present CPU count to 0.
02. Set the iterator to 0.
03. Store 0x0 to the 'Command field' register.
04. Store 0x0 to the 'CPU selector' register.
05. Read the 'CPU device status fields' register.
06. If bit#0 is set, increment the present CPU count.
07. Increment the iterator.
08. Store the iterator to the 'CPU selector' register.
09. Read the 'Command data' register.
10. If the value read is zero, then the iterator equals "max_cpus";
    exit now.
11. Goto 05.

Thanks
Laszlo

