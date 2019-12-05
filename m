Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF5C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D55E24651
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzJBwAfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D55E24651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icsBA-0008VD-J8
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1ics8P-0006pa-Hv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1ics8N-0004ku-JR
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:29:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39496
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ics8N-0004gj-E9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575556174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ofnyLJgG4HElUV5bY8FrVx48/hc3zmf7avqdIO6EMQ=;
 b=EzJBwAfg1jT2Zs23d3L8yNMo2qap4M5+pI4Mr/YOkS0stNHbJrI4v0EWgHdoVGYb/4XqHP
 xmU8TzNpNXluVnxx8cRwJjhEjdgu9sZblnmd8ihJjqmjbzkwCyWHG/u2P1kxCaFFu5SK8d
 yLjftQuXrbqLFjZCpYkbc4E2oHU6IAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-xztiHO7AOMSO-kPIKJr3uw-1; Thu, 05 Dec 2019 07:29:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95919107ACC4
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 12:29:14 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08A3E10013D9;
 Thu,  5 Dec 2019 12:29:08 +0000 (UTC)
Subject: Re: [PATCH for-5.0 6/8] acpi: cpuhp: spec: add typical usecases
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-7-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3c3c7f82-7070-40e5-2573-5be0737012eb@redhat.com>
Date: Thu, 5 Dec 2019 13:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575479147-6641-7-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xztiHO7AOMSO-kPIKJr3uw-1
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
Cc: pbonzini@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/04/19 18:05, Igor Mammedov wrote:
> Document work-flows for
>   * finding a CPU with pending 'insert/remove' event
>   * enumerating present and possible CPUs
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index f3c552d..58c16c6 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -64,6 +64,7 @@ write access:
>      [0x0-0x3] CPU selector: (DWORD access)
>                selects active CPU device. All following accesses to other
>                registers will read/store data from/to selected CPU.
> +              Valid values: [0 .. max_cpus)
>      [0x4] CPU device control fields: (1 byte access)
>          bits:
>              0: reserved, OSPM must clear it before writing to register.
> @@ -96,3 +97,31 @@ write access:
>                   ACPI_DEVICE_OST QMP event from QEMU to external applications
>                   with current values of OST event and status registers.
>              other values: reserved
> +
> +    Typical usecases:
> +        - Get a cpu with pending event
> +          1. Store 0x0 to the 'CPU selector' register.
> +          2. Store 0x0 to the 'Command field' register.
> +          3. Read the 'CPU device status fields' register.
> +          4. If both bit#1 and bit#2 are clear in the value read, there is no CPU
> +             with a pending event and selected CPU remains unchanged.
> +          5. Otherwise, read the 'Command data' register. The value read is the
> +             selector of the CPU with the pending event (which is already
> +             selected).
> +
> +        - Enumerate CPUs present/non present CPUs
> +          01. Set the present CPU count to 0.
> +          02. Set the iterator to 0.
> +          03. Store 0x0 to the 'CPU selector' register, to ensure that it's in
> +              a valid state and that access to other registers won't be ignored.
> +          04. Store 0x0 to the 'Command field' register to make 'Command data'
> +              register return 'CPU selector' value of selected CPU
> +          05. Read the 'CPU device status fields' register.
> +          06. If bit#0 is set, increment the present CPU count.
> +          07. Increment the iterator.
> +          08. Store the iterator to the 'CPU selector' register.
> +          09. Read the 'Command data' register.
> +          10. If the value read is not zero, goto 05.
> +          11. Otherwise store 0x0 to the 'CPU selector' register, to put it
> +              into a valid state and exit.
> +              The iterator at this point equals "max_cpus".
> 

Nice!

I suggest unindenting the entire new text, to the leftmost column
(column#0) in the text file. Otherwise "Typical usecases" falls under
the scope of "write access".

With that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo


