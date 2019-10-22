Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BC5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF52E2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Alo42gzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF52E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMy71-0000W9-Le
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iMy61-0008FL-CL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iMy60-0001qF-2T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:37:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iMy5z-0001pU-VG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571765843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ThshHNnBNHhoQbUlHcKNBfF4iSbnYqyzTRvjLHxMHc=;
 b=Alo42gzkTo6UkjLPJRWvZ2xtl0+i2ucHVM8JVP/a/f9GS0pWtT+aog3SYU1xieopCco6F+
 Qry2NBz0xroE6nScYUT4ij5ttzNsWKpCWbQtOQ/AHa9SoGWOrdUH2lXatl7Zh0qAFYbQNt
 0bUM8MwJ84M/+LFUmHstZsn3uHacpuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-xKiJ7TMCMTq6E9SPskkAzg-1; Tue, 22 Oct 2019 13:37:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671E71005509;
 Tue, 22 Oct 2019 17:37:19 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18C515DA8D;
 Tue, 22 Oct 2019 17:37:05 +0000 (UTC)
Subject: Re: [RFC 1/3] acpi: cpuhp: fix 'Command data' description is spec
To: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-2-imammedo@redhat.com>
 <fbbc58a6-7117-c76a-58ae-5e9a78890a8f@redhat.com>
 <cd0713b5-fd64-d3e1-7f83-3a0725b819a3@redhat.com> <m11rv4og2u.fsf@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c08fb6a1-aba4-4366-9366-a85369701060@redhat.com>
Date: Tue, 22 Oct 2019 19:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <m11rv4og2u.fsf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: xKiJ7TMCMTq6E9SPskkAzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(I've been dropped from the address list, not sure why)

On 10/22/19 19:17, Christophe de Dinechin wrote:
>=20
> Laszlo Ersek writes:
>=20
>> On 10/10/19 15:31, Laszlo Ersek wrote:
>>> 2nd round:
>>>
>>> On 10/09/19 15:22, Igor Mammedov wrote:
>>>> QEMU returns 0, in case of erro or invalid value in 'Command field',
>>>> make spec match reality, i.e.
>>>
>>> AHA! so this is exactly where you meant to list the particular cases
>>> when "command data" reads as 0:
>>> - CPU >=3D max_cpus selected,
>>> - CPU with pending events asked for, but none found
>>>
>>>> Also fix returned value description  in case 'Command field' =3D=3D 0x=
0,
>>>> it's in not PXM but CPU selector value with pending event
>>>>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>>  docs/specs/acpi_cpu_hotplug.txt | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hot=
plug.txt
>>>> index ee219c8358..ac5903b2b1 100644
>>>> --- a/docs/specs/acpi_cpu_hotplug.txt
>>>> +++ b/docs/specs/acpi_cpu_hotplug.txt
>>>> @@ -44,9 +44,10 @@ read access:
>>>>             3-7: reserved and should be ignored by OSPM
>>>>      [0x5-0x7] reserved
>>>>      [0x8] Command data: (DWORD access)
>>>> -          in case of error or unsupported command reads is 0xFFFFFFFF
>>>> +          in case of error or unsupported command reads is 0x0
>>>>            current 'Command field' value:
>>>> -              0: returns PXM value corresponding to device
>>>> +              0: returns CPU selector value corresponding to a CPU wi=
th
>>>> +                 pending event.
>>>>
>>>>  write access:
>>>>      offset:
>>>>
>>>
>>> How about:
>>>
>>>     [0x8] Command data: (DWORD access, little endian)
>>>           If the "CPU selector" value last stored by the guest refers t=
o
>>>           an impossible CPU, then 0.
>>>           Otherwise, if the "Command field" value last stored by the
>>>           guest differs from 0, then 0.
>>>           Otherwise, if there is at least one CPU with a pending event,
>>>           then that CPU has been selected; the command data register
>>>           returns that selector.
>>>           Otherwise, 0.
>>
>> Hmmm not exactly. Let me try again.
>>
>>     [0x8] Command data: (DWORD access, little endian)
>>           If the "CPU selector" value last stored by the guest refers to
>>           an impossible CPU, then 0.
>>           Otherwise, if the "Command field" value last stored by the
>>           guest differs from 0, then 0.
>>           Otherwise, the currently selected CPU.
>=20
> How about phrasing it to put the more general case first, e.g.
>=20
>     [0x8] Command data: (DWORD access, little endian)
>=20
>           The currently selected CPU, unless:
>           - The "CPU selector" value refers to an impossible CPU
>           - The "Command field" value last stored by the guest differs
>             from 0
>           In these last two cases, the value is 0.

I prefer my proposal because it translates to source code more directly
(a ladder of "if / else" pairs, or similar).

(I know that some programming languages support "unless"; I could never
wrap my brain around that idea! :) )

Thanks
Laszlo


