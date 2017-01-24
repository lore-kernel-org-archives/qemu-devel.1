Received: from eggs.gnu.org ([2001:4830:134:3::10]:33876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cW3RF-0005Pb-8j
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cW3RD-0001SU-BD
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:55:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cW3RD-0001S4-55
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:55:15 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEECD624A4
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 15:55:14 +0000 (UTC)
References: <1485199220-3298-1-git-send-email-marcel@redhat.com>
	<1485273174.4350.10.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <886da504-60d1-f715-d6aa-f77e1bbd8dca@redhat.com>
Date: Tue, 24 Jan 2017 17:55:11 +0200
MIME-Version: 1.0
In-Reply-To: <1485273174.4350.10.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 0/3] hw/pcie: Introduce Generic PCI
 Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, kraxel@redhat.com

On 01/24/2017 05:52 PM, Andrea Bolognani wrote:
> On Mon, 2017-01-23 at 21:20 +0200, Marcel Apfelbaum wrote:
>> v2 -> v3:
>>  - Keep only the root port base class code in pcie_root_port.c (Michael)
>>  - Use msix for the generic root port implementation (Michael and Gerd)
>>    - The task required some refactoring like having some common
>>      init/uninit interrupts functions to be implemented by both
>>      generic and Intel Root Ports.
>>
>> v1 -> v2:
>>  - Rebased on master.
>>
>> The Generic Root Port behaves the same as the
>> Intel's IOH device with id 3420, without having
>> Intel specific attributes.
>>
>> The device has two purposes:
>>  (1) Can be used on both X86 and ARM machines.
>>  (2) It will allow us to tweak the behaviour
>>     (e.g add vendor-specific PCI capabilities)
>>      - something that obviously cannot be done
>>        on a known device.
>>
>> Patch 1/3: Introduce a base class for Root Ports - most of the code
>>            is migrated from IOH3420 implementation.
>> Patch 2/3: Derives the IOH3420 from the new base class
>> Patch 3/3: Introduces the generic Root Port.
>>
>> Tested with Linux and Windows guests only on x86 hosts.
>
> (on aarch64, Fedora guest)
>
> Tested-by: Andrea Bolognani <abologna@redhat.com>
>

Much appreciated!
Marcel
