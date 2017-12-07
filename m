Received: from eggs.gnu.org ([2001:4830:134:3::10]:43475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eN3fr-0002B5-8x
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eN3fo-0006yI-2u
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:25:43 -0500
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com
	([104.47.33.40]:6752
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eN3fn-0006y8-Sw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:25:40 -0500
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-24-brijesh.singh@amd.com>
	<20171207110342.GB2439@work-vm>
	<CAFEAcA9J35+cC1cZr2U1aJERP6=_DtoHZ-ukvQQ8Ngj37ZGARA@mail.gmail.com>
	<20171207112729.GC2439@work-vm>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ccba5b64-893e-9977-2671-3623dc41186b@amd.com>
Date: Thu, 7 Dec 2017 15:25:29 -0600
MIME-Version: 1.0
In-Reply-To: <20171207112729.GC2439@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 23/23] sev: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: brijesh.singh@amd.com, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>



On 12/07/2017 05:27 AM, Dr. David Alan Gilbert wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 7 December 2017 at 11:03, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>>> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>>>> SEV guest migration is not yet implemented yet.
>>
>> Is there at least a plan for how migration of a guest with
>> encrypted memory would be implemented?
> 
> It's something I've discussed with Brijesh and co and I've read
> through the spec and it does look doable; I understand wanting to
> get the basics of SEV going first though.
> 

Yes this is something I have in plans. Both the spec and firmware 
supports encrypted guest migration. Lets get the basics enabled first.

thanks!

-Brijesh
