Received: from eggs.gnu.org ([2001:4830:134:3::10]:36917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPDh3-0008Oc-H8
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPDh1-0003bG-F4
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:36:25 -0500
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181116172919.43f3e27d@redhat.com>
	<d4f6f0ef-1333-a917-e3eb-d9bad47c9648@redhat.com>
	<20181119163110.2f357f40@redhat.com>
	<c09214f5-85fa-bb64-7c7e-2e9435ea4279@redhat.com>
	<20181120135719.3965e33b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df790ea7-332c-66b1-63a3-052e1e7a2432@redhat.com>
Date: Tue, 20 Nov 2018 22:36:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181120135719.3965e33b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/24] ACPI reorganization for
 hardware-reduced API addition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On 20/11/18 13:57, Igor Mammedov wrote:
> On Mon, 19 Nov 2018 18:14:26 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 19/11/18 16:31, Igor Mammedov wrote:
>>> I've tried to give suggestions how to restructure series
>>> on per patch basis. In my opinion it quite possible to split
>>> series in several smaller ones and it should really help with
>>> making series cleaner and easier/faster to review/amend/merge
>>> vs what we have in v5.  
>>
>> This is true, on the other hand the series makes sense together and,
>> even if the patches are more or less independent, they also all follow
>> the same "plan".  For reviewing v6, are you aware of Patchew's series
>> diff functionality?  It can tell you which patches had comments in v5,
>> reorder patches if applicable, and display deleted and new patches at
>> the right point in the series.
> Thanks, I'll give it a try.
> 
> Suggestion to split series mostly comes from contributor's point of view,
> it much easier to amend small series than a larger one.

That's true, on the other hand rules exist to have exceptions. :)  IIRC
your AML builder patch was also a huge series, this is not very different.

Paolo
