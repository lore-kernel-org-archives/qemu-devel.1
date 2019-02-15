Received: from eggs.gnu.org ([209.51.188.92]:36152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gulgG-0007ip-G9
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 17:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gulgE-0000q0-RU
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 17:10:00 -0500
References: <20190215133005.15955-1-david@redhat.com>
	<20190215162652-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1fd9fd75-6bd3-c120-22cf-495c1aab0652@redhat.com>
Date: Fri, 15 Feb 2019 23:09:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190215162652-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tests: Add device unplug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 15.02.19 22:27, Michael S. Tsirkin wrote:
> On Fri, Feb 15, 2019 at 02:29:59PM +0100, David Hildenbrand wrote:
>> This is a set of tests to test basic device unplugging functionality for
>> - some PCI implementations
>> - CCW devices on s390x
>> - spapr memory and cpu core devices
>>
>> I plaed with ACPI CPU unplug but getting that to run with qtest is more
>> involved. (remove devices on reset, trick cpu-hotplug-legacy property,
>> somehow create cpu hotplug state objects ...). Well we no have at least
>> one unplug test for DIMMs and one for CPUs.
>>
>> @David, I dropped you t-b and r-b due to many changes but would be happy
>> to readd them ;)
> 
> 
> Series:
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> I think it's mostly spapr things so feel free to merge through
> that tree.

Thanks, I'll address the minor review comments next week and most
probably resend on Monday. I also agree that spapr would be a good fit.


-- 

Thanks,

David / dhildenb
