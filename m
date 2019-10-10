Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B921DC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D160208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D160208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYLs-0002V5-4Q
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIYIW-0007g8-A4
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIYIU-0001vj-Qh
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:16:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIYIU-0001vW-HT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:16:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5A60898106;
 Thu, 10 Oct 2019 13:16:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-48.rdu2.redhat.com
 [10.10.120.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCF485D6A5;
 Thu, 10 Oct 2019 13:15:52 +0000 (UTC)
Subject: Re: [RFC 2/3] acpi: cpuhp: add typical usecases into spec
From: Laszlo Ersek <lersek@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-3-imammedo@redhat.com>
 <e97f3e1c-651f-ca81-d38d-c184e3db7697@redhat.com>
Message-ID: <82e2a266-84bd-8e09-f86b-3b82281d4fdf@redhat.com>
Date: Thu, 10 Oct 2019 15:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e97f3e1c-651f-ca81-d38d-c184e3db7697@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 10 Oct 2019 13:16:01 +0000 (UTC)
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

On 10/10/19 15:04, Laszlo Ersek wrote:
> On 10/09/19 15:22, Igor Mammedov wrote:
>> Clarify values of "CPU selector' register and add workflows for
> 
> mismatched quotes (double vs. single)
> 
>>   * finding CPU with pending 'insert/remove' event
>>   * enumerating present/non present CPUs
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  docs/specs/acpi_cpu_hotplug.txt | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
>> index ac5903b2b1..43c5a193f0 100644
>> --- a/docs/specs/acpi_cpu_hotplug.txt
>> +++ b/docs/specs/acpi_cpu_hotplug.txt
>> @@ -54,6 +54,7 @@ write access:
>>      [0x0-0x3] CPU selector: (DWORD access)
> 
> Please clarify the endianness.
> 
>>                selects active CPU device. All following accesses to other
>>                registers will read/store data from/to selected CPU.
>> +              Valid values: [0 .. max_cpus)
> 
> Nice; appreciate the bracket on the left side vs. the paren on the right
> side!
> 
>>      [0x4] CPU device control fields: (1 byte access)
>>          bits:
>>              0: reserved, OSPM must clear it before writing to register.
>> @@ -93,3 +94,24 @@ Selecting CPU device beyond possible range has no effect on platform:
>>       ignored
>>     - read accesses to CPU hot-plug registers not documented above return
>>       all bits set to 0.
>> +
>> +Typical usecases:
>> +   - Get a cpu with pending event
>> +     1. write 0x0 into 'Command field' register
>> +     2. read from 'Command data' register, CPU selector value (CPU's UID in ACPI
>> +        tables)
> 
> OK.
> 
> I suggest putting this as: "read the CPU selector value (the CPU's UID
> in the ACPI tables) from the 'Command data' register"
> 
>> and event for selected CPU from 'CPU device status fields'
> 
> OK.
> 
>> +        register. If there aren't pending events, CPU selector value doesn't
> 
> OK.
> 
> I suggest s/aren't/are no/
> 
>> +        change
> 
> So this feels important: *change* is relative to a previous value. In
> order to determine change, I have to
> 
> - either read the "command data" register before writing 0x0 to
> "command", and then compare the old value against the new value
> 
> - or even set "command data" to a bogus value myself (against which I
> can compare the new value, after writing the command register).
> 
> So, what is the previous selector value that the change is relative to?
> 
>> and 'insert' and 'remove' bits are not set.
> 
> Ah, so is the order of steps actually this:
> 
> 1. write 0x0 to command
> 
> 2. read device status field
> 
> 3. if bit#1 or bit#2 is set (insert or remove event), read CPU selector
> affected by those event(s) from the command data field
> 
> 4. otherwise, no pending event
> 
> ?
> 
>> +   - Enumerate CPUs present/non present CPUs.
>> +     1. set iterator to 0x0
> 
> OK
> 
>> +     2. write 0x0 into 'Command field' register
> 
> ... this may update the device status field, and the command data field
> (to a selector with pending events)
> 
>> and then iterator
>> +        into 'CPU selector' register.
> 
> ... so in case command 0x0 selected a CPU with pending events, we ignore
> that, and select our iterator anyway. OK.
> 
>> +     3. read 'enabled' flag for selected CPU from 'CPU device status fields'
>> +        register
> 
> OK
> 
>> +     4. to continue to the next CPU, increment iterator
> 
> OK
> 
>> and repeat step 2
> 
> not sure why writing 0x0 to "command" again is useful, but I'll see it
> below; OK
> 
>> +     5. read 'Command data' register
> 
> oookay... so if writing 0x0 to command selected a CPU with pending
> events, we get the selector of *that* CPU (regardless of what iterator
> we have presently)
> 
> Otherwise we get an indeterminate value.
> 
>> +     5.1 if 'Command data' register matches iterator continue to step 3.
> 
> uhhh... what? :) At this point, the command data register can be in two
> states:
> 
> - if the last 0x0 command selected a CPU with events pending, then that
> selector is available in the command data register.
> 
> I don't understand why comparing that against the iterator is helpful.
> 
> - If there was no CPU with pending events, we're comparing an
> indeterminate value against the iterator. Why?
> 
> I think the "command data" field must change under some circumstances
> that are currently not documented. (I.e. it seems like "command data"
> does not *only* change when command 0x0 can find a CPU with pending events.)

After looking at cpu_hotplug_rd(), I think I know what's going on.

Every time command 0 is written, and there is no CPU with pending
events, the command data register will read as 0!

This seems like a core piece of information, and it's not documented in
the text file anywhere. It only says (with patch#1 applied),

  in case of error or unsupported command reads is 0x0

Command 0 is *not* unsupported. Therefore, this documentation is only
self-consistent if:

- selecting a non-existent (>=max_cpus) CPU via the selector register is
an *error*

- asking for a CPU with pending events (with command 0x0), and finding
none, is also an *error*.

Let me re-read the patch set with this information in mind.

Thanks
Laszlo


>> +         (read presence bit for the next CPU)
>> +     5.2 if 'Command data' register has not changed, there is not CPU
>> +         corresponding to iterator value and the last valid iterator value
>> +         equals to 'max_cpus' + 1
>>
> 


