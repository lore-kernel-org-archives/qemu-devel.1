Received: from eggs.gnu.org ([2001:4830:134:3::10]:45484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHWUj-0005MN-HS
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHWUb-0004f9-8m
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHWUX-00040r-Oh
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:03:42 -0400
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-20-sameo@linux.intel.com>
	<7023e8f9-a7e3-ae11-e1d7-429434e895d3@redhat.com>
	<20181030141335.GB5291@caravaggio.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e1bb8a9-6812-5b2f-96bb-8cb85e9c3457@redhat.com>
Date: Tue, 30 Oct 2018 17:03:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181030141335.GB5291@caravaggio.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 19/19] hw: i386: Implement the ACPI
 builder interface for PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 30/10/2018 15:13, Samuel Ortiz wrote:
>> Just a quick question before I go and actually apply the patches to look
>> at the resulting code: is there any reason why you didn't add the
>> MachineState and/or AcpiBuilder to AcpiBuildState, similar to how it was
>> in v1?
>
> With v1 I was not adding MachineState to AcpiBuildState, I may be
> missing your point.
> Do you mean adding an AcpiBuilder pointer to AcpiConfiguration?

No, what I was remembering is the FirmwareBuildState, which you have
removed according to my review.  Sorry, KVM Forum was a bit exhausting. :)

I think adding the MachineState or AcpiBuilder to AcpiBuildState instead
of using qdev_get_machine() makes sense, but it is an independent cleanup.

Paolo
