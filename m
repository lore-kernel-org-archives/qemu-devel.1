Received: from eggs.gnu.org ([2001:4830:134:3::10]:39816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cTpNo-0005hm-CO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cTpNl-0007Tt-00
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:30:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cTpNk-0007Te-Pv
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:30:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC5F3C06C9E9
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 12:30:28 +0000 (UTC)
References: <1484137136-8021-1-git-send-email-marcel@redhat.com>
	<1484585201.4091.12.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <a266dcf4-7f04-2bdb-e3d1-bd9cacdd073e@redhat.com>
Date: Wed, 18 Jan 2017 14:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <1484585201.4091.12.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 0/3] hw/pcie: Introduce Generic PCI
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
Cc: mst@redhat.com

On 01/16/2017 06:46 PM, Andrea Bolognani wrote:
> On Wed, 2017-01-11 at 14:18 +0200, Marcel Apfelbaum wrote:
>> v1 -> v2:
>>   - Rebased on master.
>>
>> The Generic Root Port behaves the same as the
>> Intel's IOH device with id 3420, without having
>> Intel specific attributes.
>>
>> The device has two purposes:
>>   (1) Can be used on both X86 and ARM machines.
>>   (2) It will allow us to tweak the behaviour
>>      (e.g add vendor-specific PCI capabilities)
>>       - something that obviously cannot be done
>>         on a known device.
>>
>> Patch 1/3: Introduce a base class for Root Ports - most of the code
>>             is migrated from IOH3420 implementation.
>> Patch 2/3: Derives the IOH3420 from the new base class
>> Patch 3/3: Introduces the generic Root Port.
>>
>> Tested with Linux and Windows guests only on x86 hosts.
>
> I tested this both on x86/q35 (Debian guest) and on
> aarch64/virt (Fedora guest) very briefly, eg. started
> the guest, performed some network I/O and shut it down.
>
> It seems to be working fine :)

Thanks for testing it! A tested-by tag would be appreciated for the next version :)
Marcel

>
> --
> Andrea Bolognani / Red Hat / Virtualization
>
