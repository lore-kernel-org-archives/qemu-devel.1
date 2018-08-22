Received: from eggs.gnu.org ([2001:4830:134:3::10]:56301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsUFk-0002PK-6o
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsUFg-00066p-TI
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:36:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsUFg-000660-Ni
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26E3940216E3
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 14:36:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <fdf970ce-baa2-7b87-7e72-bba34d9c1328@redhat.com> (Thomas Huth's
	message of "Wed, 22 Aug 2018 12:26:56 +0200")
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-7-quintela@redhat.com>
	<fdf970ce-baa2-7b87-7e72-bba34d9c1328@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 16:36:43 +0200
Message-ID: <8736v6pix0.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 06/10] check: Only test ivshm when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 2018-08-22 11:54, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  tests/Makefile.include | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 9a918f7655..116e93cdb6 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -243,8 +243,8 @@ gcov-files-pci-y += hw/display/virtio-gpu-pci.c
>>  gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
>>  check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
>>  gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
>> -check-qtest-pci-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
>> -gcov-files-pci-y += hw/misc/ivshmem.c
>> +check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
>> +gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
>>  check-qtest-pci-y += tests/megasas-test$(EXESUF)
>>  gcov-files-pci-y += hw/scsi/megasas.c
>>  
>> @@ -358,7 +358,7 @@ check-qtest-ppc64-$(CONFIG_POSIX) +=
>> tests/test-filter-mirror$(EXESUF)
>>  check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
>>  check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
>>  check-qtest-ppc64-y += tests/numa-test$(EXESUF)
>> -check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
>> +check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
>>  check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
>
> I guess we could add a line a la:
>
> gcov-files-ppc64-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
>
> here, too, but since that's a pre-existing problem:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Done, thanks.

I got even more confused.  check-qtest-pci-y is only tested on x86*, go
figure.

Later, Juan.
