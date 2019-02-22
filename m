Received: from eggs.gnu.org ([209.51.188.92]:38067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gx6bq-00043I-8k
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gx6bo-00031B-UY
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:55:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:33745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gx6bo-0002TR-Ij
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:55:04 -0500
Date: Fri, 22 Feb 2019 16:53:55 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190222085355.GA30665@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190219080826.9812-1-richardw.yang@linux.intel.com>
	<20190221154551.5ab655f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221154551.5ab655f4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] i386,
 acpi: check acpi_memory_hotplug capacity in pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com

On Thu, Feb 21, 2019 at 03:45:51PM +0100, Igor Mammedov wrote:
>On Tue, 19 Feb 2019 16:08:26 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> Currently we do device realization like below:
>> 
>>    hotplug_handler_pre_plug()
>>    dc->realize()
>>    hotplug_handler_plug()
>> 
>> Before we do device realization and plug, we should allocate necessary
>> resources and check if memory-hotplug-support property is enabled.
>> 
>> At the piix4 and ich9, the memory-hotplug-support property is checked at
>> plug stage. This means that device has been realized and mapped into guest
>> address space 'pc_dimm_plug()' by the time acpi plug handler is called,
>> where it might fail and crash QEMU due to reaching g_assert_not_reached()
>> (piix4) or error_abort (ich9).
>> 
>> Fix it by checking if memory hotplug is enabled at pre_plug stage
>> where we can gracefully abort hotplug request.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> CC: Igor Mammedov <imammedo@redhat.com>
>> CC: Eric Blake <eblake@redhat.com>
>patch refuses to be applied to current master
>

Could latest upstream compile successfully?

-- 
Wei Yang
Help you, Help me
