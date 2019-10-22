Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4288CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3E4218AE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVgnSFCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3E4218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMtSi-0006Cv-Le
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 08:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iMtRz-0005hl-3R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iMtRw-0006qp-PO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:39:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iMtRw-0006qa-M9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571747983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ql5P9mwZ5VLeWNvq3MlILfk9BzfbDzngn60Ok5k5zOo=;
 b=bVgnSFCbG5m34bOOzK4l+Oz3zBzzZ1EdK+c8pcugsIAHaf4R+CaODT2/AOPZRw+BR/pLWU
 Wl2bV+djq+CXHPEb+wMLVAgCAReN65PrLdnun03PUMxPuc4wIj+DHdkyFJk20OvyEwK9RB
 1w4RNDm699lSuWTrWvQwxqjHIYTSNNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-lR3YXp0lM5G8sew4bDQ7ZQ-1; Tue, 22 Oct 2019 08:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7E1D800D4E;
 Tue, 22 Oct 2019 12:39:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55A6960856;
 Tue, 22 Oct 2019 12:39:25 +0000 (UTC)
Subject: Re: [RFC 3/3] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
From: Laszlo Ersek <lersek@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-4-imammedo@redhat.com>
 <802d0d69-d478-76f5-2bd6-5ad2f1ac4474@redhat.com>
 <20191018181841.6459533a@redhat.com>
 <78f49b7d-6fd9-c977-8fe9-2de78025003d@redhat.com>
Message-ID: <0f2a4b26-b900-08af-aa3e-f9779ae6b55f@redhat.com>
Date: Tue, 22 Oct 2019 14:39:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <78f49b7d-6fd9-c977-8fe9-2de78025003d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: lR3YXp0lM5G8sew4bDQ7ZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 15:06, Laszlo Ersek wrote:
> On 10/18/19 18:18, Igor Mammedov wrote:
>> On Thu, 10 Oct 2019 16:56:18 +0200
>> Laszlo Ersek <lersek@redhat.com> wrote:

[...]

>>> Can I use the following sequence to detect whether the interface is
>>> available?
>>>
>>> 1. Store 0x0 to command register.
>>> 2. Store 0x0 to selector register.
>>> 3. Read 'command data' register.
>>> 4. If value read is 0, the interface is available.
>>
>> By default legacy register block layout is in place
>> (i.e. present cpus bitmap) where 1st byte is guarantied to be ">0" as it=
 has
>> at least the boot CPU bit set and writes to legacy bitmap are ignored.
>>
>> Currently AML code code does switching to modern interface, see
>> docs/specs/acpi_cpu_hotplug.txt:
>> "
>>   The first DWORD in bitmap is used in write mode to switch from legacy =
        =20
>>   to new CPU hotplug interface, write 0 into it to do switch.
>> "
>> related code "if (opts.has_legacy_cphp) {" and cpu_status_write()
>>
>> Considering firmware runs the first, it should enable modern interface
>> on its own
>>   1. Store 0x0 to selector register (actually it's store into bitmap to =
attempt switch).=20
>> and to check if interface is present
>>   2. Store 0x0 to selector register (to ensure valid selector value (oth=
erwise command is ignored))
>>   3. Store 0x0 to command register (to be able to read back selector fro=
m command data)
>>   4. Store 0x0 to selector register (because #3 can select the a cpu wit=
h events if any)
>>       be aware libvirt may start QEMU in paused mode (hotplug context) a=
nd hotplugs extra CPUs
>>       with device_add and then let guest run. So firmware may see presen=
t CPUs with events
>>       at boot time.
>>   5. Read 'command data' register.
>>   6. If value read is 0, the interface is available.
>=20
> Perfect!
>=20
> Basically this is prepending two "write 0 to selector register" steps to
> what I suspected. I certainly couldn't figure out the "switch to modern"
> step, and whether initializing the selector to something valid was
> needed at boot. Now I know. :) Thanks!
>=20
>>
>>> (Because I assume that unmapped IO ports read as all-bits-one. Is that
>>> right?)
>> that's right but ports are mapped to legacy CPU bitmap, you can't count =
on all-bits-one case here.

It seems I rejoiced too soon.

When we read the command data register in the last step, that is at
offset 0x8 in the register block. Considering the legacy "CPU present
bitmap", if no CPU is present in that range, then the firmware could
read a zero value. I got confused because I thought we were reading at
offset 0, which would always have bit0 set (for CPU#0).

Can we detect the modern interface like this:

1. store 0x0 to selector register (attempt to switch)
2. read one byte at offset 0 in the register block
3. if bit#0 is set, the modern interface is unavailable;
   otherwise (=3D bit#0 clear), the modern interface is available

Here's why:

- if even the legacy interface is missing, then step 2 is an unassigned
  read, hence the value read is all-bits-one; bit#0 is set

- if only the legacy interface is available, then bit#0 stands for
  CPU#0, it will be set

- if the switch-over in step 1 is successful, then offset 0 is reserved,
  hence it returns all-bits-zero.

With this, if we ever assigned offset 0 for reading, then we'd have to
define it with bit#0 constantly clear.

Thanks,
Laszlo


