Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200F4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71FF206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8dAG05R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71FF206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1Sx-0007bz-UP
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iv1SG-00076m-14
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iv1SD-0002ZC-98
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:05:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48373
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iv1SC-0002WV-VS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579881904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GE4uj/mcUi/1pU7izGoiIfH3HPVnNAkWsQ0yNZrw24Y=;
 b=B8dAG05RrUSkzcFvGELet1UWpLMJX3PZQlCPxVINFiWo9aWMtDWsaGAp2FkpYFnIilm7Cq
 FfPhIHRygGODVkNokyaXAOsjK4SgaITncjPq/bmzvjvV/VKeKcCGJJcR8YQ2szwHOftPqf
 zUcKpwNIE0jQSfOifOm39PadkgkRQMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-ZnEiu1KHN0SuhnM0Mrm47A-1; Fri, 24 Jan 2020 11:05:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 598FF8010D8
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 16:05:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-77.ams2.redhat.com
 [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DB7B5DDB1;
 Fri, 24 Jan 2020 16:04:55 +0000 (UTC)
Subject: Re: [PATCH] acpi: cpuhp: document how to use CPHP_GET_CPU_ID_CMD
 command
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579879065-3873-1-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5e8dcfed-b2ba-9e7f-c80b-0b9dcb4c79b3@redhat.com>
Date: Fri, 24 Jan 2020 17:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1579879065-3873-1-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ZnEiu1KHN0SuhnM0Mrm47A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 01/24/20 16:17, Igor Mammedov wrote:
> Commit 3a61c8db9d25 introduced CPHP_GET_CPU_ID_CMD command but
> did not sufficiently described how to use it. Fix it by adding
> missing command documentation and suggested work-flow to enumerate
> possible architecture specific CPU IDs.
> 
> Fixes: 3a61c8db9d25 ("acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command")
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index a8ce5e7..81b4534 100644
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

Looks good.

> @@ -147,3 +149,16 @@ Typical usecases:
>        11. Otherwise store 0x0 to the 'CPU selector' register, to put it
>            into a valid state and exit.
>            The iterator at this point equals "max_cpus".
> +
> +    - Enumerate present/non present CPUs architecture specific IDs
> +      (in case of x86: ACPIC IDs)
> +      01: Use "Enumerate CPUs present/non present CPUs" to get max_cpus

OK, this includes the last step of that procedure too, i.e.:

      11. Otherwise store 0x0 to the 'CPU selector' register, to put it
          into a valid state and exit.
          [...]

> +      02: Store 0x3 in the 'Command field' register
> +      03: Set 'current cpu selector' iterator to 0x0
> +      04: Store the iterator to the 'CPU selector' register
> +      05: Read from registers 'Command data' and 'Command data 2' parts of ID,
> +          combine them into ID like following:
> +             'Command data 2' << 32 | 'Command data'
> +          and store pair 'current cpu selector' : ID for further processing
> +      06: Increment the iterator and if the iterator < max_cpus go to step 4
> +      07: Otherwise store 0x0 to the 'CPU selector' register and exit.
> 

This looks good as well.

I'm happy to R-b this patch, with one caveat: in edk2, I might not want
to -- or have to -- fetch the full array of arch-specific CPU IDs in
advance. That's one possibility, yes -- but it's also possible that I'll
only fetch the arch CPU ID for the freshly hotplugged CPU in the SMI
handler. I don't know yet.

So, as long as OVMF is not expected to *only* implement the typical use
case here, I'm OK with this algorithm, because it looks valid to me.

I'd just like to keep the option open to use the CPHP_GET_CPU_ID_CMD
command for such a CPU as well that has been selected with -- say --
CPHP_GET_NEXT_CPU_WITH_EVENT_CMD.

With that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

(If you like, you could also split this patch in two -- repost the first
half (with the register documentation update) with my R-b at once, and
delay the second half (the typical use case for CPHP_GET_CPU_ID_CMD)
until I "get there" in edk2. Up to you.)

Thanks!
Laszlo


