Received: from eggs.gnu.org ([2001:4830:134:3::10]:36455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etd3t-0000zC-Rf
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etd3p-0004x1-Uv
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:41:09 -0500
Received: from mail-bl2nam02on0069.outbound.protection.outlook.com
	([104.47.38.69]:58400
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etd3p-0004wo-GH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:41:05 -0500
References: <20180307165038.88640-1-brijesh.singh@amd.com>
	<20180307165038.88640-22-brijesh.singh@amd.com>
	<20180307172703.GH3089@work-vm>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <6b8bf293-4a3c-5832-8617-a2b957f97a83@amd.com>
Date: Wed, 7 Mar 2018 11:40:54 -0600
MIME-Version: 1.0
In-Reply-To: <20180307172703.GH3089@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 21/28] sev/i386: add debug encrypt and
 decrypt commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>



On 03/07/2018 11:27 AM, Dr. David Alan Gilbert wrote:

[...]

>> +{
>> +    SEVState *s = (SEVState *)handle;
>> +
>> +    /* If policy does not allow debug then no need to register ops */
>> +    if (s->policy & SEV_POLICY_NODBG) {
>> +        return;
>> +    }
> 
> So what happens if someone tries to use a gdb or monitor command when
> policy didn't allow debug?  Does it end up with an obvious error
> somehow?
> 

In those cases caller will get encrypted bytes, leading to 
unintelligible data. It can sometime translate into  obvious errors e.g 
caller tries to walk guest pagtable and it gets garbage and will have 
trouble dumping the pgtables etc. Many times qemu calls ldphys_* 
functions to access the data it may get tricky to report the errors.


-Brijesh
