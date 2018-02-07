Received: from eggs.gnu.org ([2001:4830:134:3::10]:59794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSid-0004jz-7H
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSiY-0005Xz-6o
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:37:11 -0500
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com
	([104.47.38.52]:54320
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejSiY-0005XT-0L
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:37:06 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-13-brijesh.singh@amd.com>
	<6a28048e-fed5-c197-05df-c1f14d6e2b5f@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <94cd7702-c99a-fb5b-d8a7-f8e3f5ae0337@amd.com>
Date: Wed, 7 Feb 2018 10:36:53 -0600
MIME-Version: 1.0
In-Reply-To: <6a28048e-fed5-c197-05df-c1f14d6e2b5f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v7 13/26] qmp: add query-sev command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>



On 2/7/18 10:22 AM, Eric Blake wrote:
>> +#
>> +# @enabled: true if SEV is active
>> +#
>> +# @api_major: SEV API major version
>
> New QMP structures should prefer '-' over '_'; this should be
> 'api-major'.

I will fix it. thanks

....

>> +##
>> +# @query-sev:
>> +#
>> +# Returns information about SEV
>
> It would be worth expanding the acronym here, for someone that is
> reading the documentation but not familiar with the term.
>

Will do.
