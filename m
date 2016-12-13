Received: from eggs.gnu.org ([2001:4830:134:3::10]:52551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGm92-00068U-Ul
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cGm8z-0002UT-Oh
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:25:20 -0500
References: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
	<1481585316-31612-5-git-send-email-lvivier@redhat.com>
	<877f74w9dm.fsf@dusky.pond.sub.org>
	<c38f9acb-1c74-f698-954c-f8c7a98a8c90@redhat.com>
	<24264c29-f4d7-59f8-6f40-aaefa479ca86@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f6191840-7a80-4eb0-7c7d-d86d32337ed7@redhat.com>
Date: Tue, 13 Dec 2016 13:25:14 +0100
MIME-Version: 1.0
In-Reply-To: <24264c29-f4d7-59f8-6f40-aaefa479ca86@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 4/4] qtest: add ivshmem-test for
 ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>



On 13/12/2016 09:55, Thomas Huth wrote:
> On 13.12.2016 09:18, Laurent Vivier wrote:
>>
>>
>> On 13/12/2016 08:55, Markus Armbruster wrote:
>>> Laurent Vivier <lvivier@redhat.com> writes:
> ...
>>>> @@ -419,7 +426,9 @@ static void test_ivshmem_hotplug(void)
>>>>      opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);
>>>>  
>>>>      qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
>>>> -    qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
>>>> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>>> +        qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
>>>> +    }
>>>
>>> Disables unplug test for ppc64.
> 
> We don't have acpi on POWER ... but PCI unplug should be possible
> without ACPI, too, shouldn't it? So maybe you could add a PCI unplug
> function for ppc64, too?

Good idea, I will check if we can implement this.

Thanks,
Laurent
