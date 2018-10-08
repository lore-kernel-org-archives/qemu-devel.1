Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9avg-0000f5-LI
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9avd-00030m-BE
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9avd-00030R-53
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:10:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D07608666D
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 19:10:51 +0000 (UTC)
References: <20180925160248.30801-1-kchamart@redhat.com>
	<20180925160248.30801-3-kchamart@redhat.com>
	<20180926172427.05a2de94@redhat.com>
	<87zhw33t8z.fsf@dusky.pond.sub.org>
	<20181001081845.GD25720@paraplu> <20181001105904.4c155ffd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53871bae-5b1c-df8c-f6d2-b2ce81be831c@redhat.com>
Date: Mon, 8 Oct 2018 14:10:50 -0500
MIME-Version: 1.0
In-Reply-To: <20181001105904.4c155ffd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docs: Document vCPU hotplug
 procedure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com

On 10/1/18 3:59 AM, Igor Mammedov wrote:

>>> Anyway, what about this:
>>>
>>>      The command returns an object with a "qom-path" member for each
>>>      present CPU.  In this case, it shows an IvyBridge-IBRS-x86_64-cpu in
>>>      socket 0.
>>>
>>>      It returns an object without a "qom-path" for every possibly CPU
>>>      hot-plug.  In this case, it shows you can plug an
>>>      IvyBridge-IBRS-x86_64-cpu into socket 1, and the additional
>>>      properties you need to pass to device_add for that.
> not really sure my English (CCed Eric) but to match 'an object' with
> the rest of sentence:
> 
>   It returns an object without a "qom-path" for a possible to hot-plug CPU.
>   +
>   In this case, it shows you can plug an  IvyBridge-IBRS-x86_64-cpu
>   into socket 1/core = 0/thread 0, where 'props' list describes
>   additional properties you need to pass to device_add for hot-pluging
>   that CPU.

Maybe:

The command returns an object for CPUs that are present (containing a 
"qom-path" member) or which may be hot-plugged (no "qom-path" member). 
In this example, an IvyBridge-IBRS-x86_64-cpu is present in socket 0, 
while hot-plugging a CPU into socket 1 requires passing the listed 
properties to device_add.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
