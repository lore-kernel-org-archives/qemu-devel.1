Received: from eggs.gnu.org ([2001:4830:134:3::10]:33873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cj6Mf-00007S-2d
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cj6MY-000827-0K
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:40:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cj6MX-00081e-MZ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:40:21 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21FduWj012767
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 10:40:20 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wxrarnta-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 10:40:19 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 08:40:18 -0700
References: <57FA3A002D66E049AA7792D931B894C7060F5494@MOKSCY3MSGUSRGB.ITServices.sbc.com>
	<945CA011AD5F084CBEA3E851C0AB28894B8C3A14@SHSMSX101.ccr.corp.intel.com>
	<575E92DB.3080904@linux.vnet.ibm.com> <20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com> <20160616080520.GA2249@work-vm>
	<20160616082517.GC11426@redhat.com>
	<5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
	<20170301125414.GD10160@redhat.com>
	<OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
	<20170301151803.GF10160@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 1 Mar 2017 10:40:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170301151803.GF10160@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <2a01a2ed-0588-81ff-03d8-f0e86ae5d440@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Berger <stefanb@us.ibm.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>

On 03/01/2017 10:18 AM, Daniel P. Berrange wrote:
> On Wed, Mar 01, 2017 at 08:25:43AM -0500, Stefan Berger wrote:
>> "Daniel P. Berrange" <berrange@redhat.com> wrote on 03/01/2017 07:54:14
>> AM:
>>
>>> From: "Daniel P. Berrange" <berrange@redhat.com>
>>> To: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger/
>>> Watson/IBM@IBMUS, "mst@redhat.com" <mst@redhat.com>, "qemu-
>>> devel@nongnu.org" <qemu-devel@nongnu.org>, "SERBAN, CRISTINA"
>>> <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>,
>>> "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>,
>>> "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C"
>>> <cs1815@att.com>
>>> Date: 03/01/2017 08:03 AM
>>> Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE
>> TPM
>>> On Wed, Mar 01, 2017 at 07:25:28AM -0500, Stefan Berger wrote:
>>>> On 06/16/2016 04:25 AM, Daniel P. Berrange wrote:
>>>>> On Thu, Jun 16, 2016 at 09:05:20AM +0100, Dr. David Alan Gilbert
>> wrote:
>>>>>> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
>>>>>>> On 06/15/2016 03:30 PM, Dr. David Alan Gilbert wrote:
>>>>>> <snip>
>>>>>>
>>>>>>>> So what was the multi-instance vTPM proxy driver patch set
>> about?
>>>>>>> That's for containers.
>>>>>> Why have the two mechanisms? Can you explain how the
>> multi-instance
>>>>>> proxy works; my brief reading when I saw your patch series seemed
>>>>>> to suggest it could be used instead of CUSE for the non-container
>> case.
>>>>> One of the key things that was/is not appealing about this CUSE
>> approach
>>>>> is that it basically invents a new ioctl() mechanism for talking to
>>>>> a TPM chardev. With in-kernel vTPM support, QEMU probably doesn't
>> need
>>>>> to have any changes at all - its existing driver for talking to TPM
>>>> We still need the control channel with the vTPM to reset it upon VM
>> reset,
>>>> for getting and setting the state of the vTPM upon
>> snapshot/suspend/resume,
>>>> changing locality, etc.
>>> You ultimately need the same mechanisms if using in-kernel vTPM with
>>> containers as containers can support snapshot/suspend/resume/etc too.
>> The vTPM running on the backend side of the vTPM proxy driver is
>> essentially the same as the CUSE TPM used for QEMU. I has the same control
>> channel through sockets. So on that level we would have support for the
>> operations but not integrated with anything that would support container
>> migration.
> This goes back to the question Dave mentions above ? Ignoring the control
> channel aspect temporarily, can the CUSE TPM support the exact same ioctl
> interface as the existing kernel TPM device ? It feels like this should
> be possible, and if so, then this virtal TPM feature can be considered to
> have two separate pieces.

The existing kernel device has not ioctl interface. If it had one, it 
wouldn't have the same since the control channel implemented on the 
ioctl interface is related to low level commands such as resetting the 
device when the platform resets, etc.

>
> First enabling basic CUSE TPM device support would not require QEMU changes,
> as we could just use the existing tpm-passthrough driver against the CUSE
> device, albeit with the limitations around migration, snapshot etc.

... and device reset upon VM reset. You want to have at least that since 
otherwise the PCRs will not be in the correct state once the firmware 
with TPM support startes extending them. They need to be reset and the 
only way to do that is through some control channel command.


>
> Second we could consider the question of supporting a control channel as
> a separate topic. IIUC, QEMU essentially needs a way to trigger various
> operations in the underlying TPM implementation, when certain lifecycle
> operations are performed on the VM. I could see this being done as a
> simple network protocol over a UNIX socket. So, you could then add a
> new 'chardev' property to the tpm-passthrough device, which gives the
> ID of a character device that provides the control channel.

Why would that other control channel need to be a device rather than an 
ioctl on the device? Or maybe entirely access the emulated TPM through 
UnixIO ?


>
> This way QEMU does not need to have any special code to deal with CUSE
> directly. QEMU could be used with a real TPM device, a vTPM device or
> a CUSE TPM device, with the same driver. With both the vTPM and the
> CUSE TPM device, QEMU would have the ability to use a out of band
> control channel when migration/snapshot/etc take place.
>
> This cleanly isolates QEMU from the particular design & implementation
> that is currently used by the current swtpm code.

Someone needs to define the control channel commands.My definition is here:

https://github.com/stefanberger/qemu-tpm/commit/27d6cd856d5a14061955df7a93ee490697a7a174#diff-5cc0e46d3ec33a3f4262db773c193dfe


  This won't go away even if we changed the transport for the commands. 
ioctl's seem to be one way of achieving this with a character device. 
The socket based control channels of 'swtpm' use the same commands.

    Stefan

>
> Regards,
> Daniel
