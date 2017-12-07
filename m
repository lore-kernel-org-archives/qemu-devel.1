Received: from eggs.gnu.org ([2001:4830:134:3::10]:43701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eN4zp-0001BL-Ex
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eN4zk-00051w-A2
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:50:25 -0500
Received: from mail-bl2nam02on0054.outbound.protection.outlook.com
	([104.47.38.54]:15776
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eN4zj-00050T-S0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:50:20 -0500
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-24-brijesh.singh@amd.com>
	<20171207110342.GB2439@work-vm>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <d09bf4f2-8b2a-f7a7-eae7-3483708834f0@amd.com>
Date: Thu, 7 Dec 2017 16:50:11 -0600
MIME-Version: 1.0
In-Reply-To: <20171207110342.GB2439@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>



On 12/07/2017 05:03 AM, Dr. David Alan Gilbert wrote:
.......

>>   
>>   #define SEV_FW_MAX_ERROR      0x17
>>   
>> @@ -460,6 +462,7 @@ static void
>>   sev_launch_finish(SEVState *s)
>>   {
>>       int ret, error;
>> +    Error *local_err = NULL;
>>   
>>       ret = sev_ioctl(KVM_SEV_LAUNCH_FINISH, 0, &error);
>>       if (ret) {
>> @@ -470,6 +473,16 @@ sev_launch_finish(SEVState *s)
>>   
>>       s->cur_state = SEV_STATE_RUNNING;
>>       DPRINTF("SEV: LAUNCH_FINISH\n");
> 
> (from a previous patch)
> Please use the tracing facility rather than new DPRINTF's
> if possible - if you've not used it before, then
> --enable-trace-backends=log   is the easy way to get going
> and you can turn on and off the stuff you're interested in
> tracing at run time without having to rebuild.


Thanks for review, I will look into converting those DPRINTF's in trace 
logging.
