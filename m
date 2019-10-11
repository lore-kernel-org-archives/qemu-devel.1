Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7350C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 06:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A089214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 06:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A089214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIomq-0003YO-Kn
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 02:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIokz-00034X-G9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIokx-0001zC-1I
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIokw-0001wr-NA
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:50:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 230E389F38E;
 Fri, 11 Oct 2019 06:50:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-177.rdu2.redhat.com
 [10.10.120.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D788060167;
 Fri, 11 Oct 2019 06:50:22 +0000 (UTC)
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
 <20191008175931.483af366@redhat.com>
 <20191010055733-mutt-send-email-mst@kernel.org>
 <20191010144812.20fd8b5d@redhat.com>
 <0032ef80-4e75-5802-8a7a-098e9ff57cfa@redhat.com>
 <20191010140724-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2d8022a1-e2f0-bd7c-76f2-f7e47327adea@redhat.com>
Date: Fri, 11 Oct 2019 08:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191010140724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 11 Oct 2019 06:50:29 +0000 (UTC)
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
 qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 20:08, Michael S. Tsirkin wrote:
> On Thu, Oct 10, 2019 at 06:23:00PM +0200, Laszlo Ersek wrote:
>> On 10/10/19 14:48, Igor Mammedov wrote:
>>
>>> it doesn't really matter if it's ACPI blob or fw_cfg,
>>> what firmware needs is a table of possible CPUs with APIC IDs.
>>
>> To repeat my previous point:
>>
>> Not necessarily taking sides between "data table" and "register block",
>> but *if* we opt for "data table", then it *must* be fw_cfg.
>>
>>> But if we go this route (i.e. not reuse CPU hotplug interface),
>>> the table alone is not enough, one would need to build a protocol
>>> between ACPI and firmware to communicate what CPUs to (un)hotplug.
>>
>> That's for sure, yes -- for finding out what CPU has been hotplugged,
>> the hotplug SMI handler in the firmware has to look at the register
>> block no matter what.
> 
> I thought all that's done by ACPI, with ACPI returning an event
> to the OSPM reporting what happened.

That works if only the OS needs to care -- the OS can rely on ACPI.

But with SMM in the picture, the firmware has to care too (the new CPU's
SMBASE has to be relocated, and the SMM data structures need to account
for the new CPU). The firmware cannot rely on any AML generated by QEMU.

Thanks
Laszlo

> 
>> The "data table" vs "register block" question only arises *afterwards*,
>> for translating the CPU selector (fetched from the register block) to
>> the APIC-ID domain. (The generic edk2 infrastructure requires APIC-IDs).
>>
>> Thanks
>> Laszlo


