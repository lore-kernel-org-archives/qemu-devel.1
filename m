Received: from eggs.gnu.org ([2001:4830:134:3::10]:41646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dSM0j-0005u8-B7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dSM0f-0002jc-7H
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:28:53 -0400
From: Laurent Vivier <lvivier@redhat.com>
References: <20170704110126.26806-1-lvivier@redhat.com>
	<20170704110126.26806-3-lvivier@redhat.com>
	<20170704131500.3ef448c8@bahia.lan>
	<2045ad91-17ad-3c69-9084-0d4ca2390690@redhat.com>
Message-ID: <878c8a38-7258-9ee3-8865-ca14573328e4@redhat.com>
Date: Tue, 4 Jul 2017 13:28:44 +0200
MIME-Version: 1.0
In-Reply-To: <2045ad91-17ad-3c69-9084-0d4ca2390690@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] target/ppc: move POWER9 DD1
 workaround to init_proc_POWER9()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>

On 04/07/2017 13:21, Laurent Vivier wrote:
> On 04/07/2017 13:15, Greg Kurz wrote:
>> On Tue,  4 Jul 2017 13:01:26 +0200
>> Laurent Vivier <lvivier@redhat.com> wrote:
>>
>>> Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
>>> disables compatibility mode for POWER9 DD1 to allow to
>>> boot on POWER9 DD1 host with KVM.
>>>
>>> As the workaround has been added in kvmppc_host_cpu_class_init(),
>>> it applies only on CPU created with "-cpu host".
>>> As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
>>> host, this patch moves the workaround from kvmppc_host_cpu_class_init()
>>> to init_proc_POWER9().
>>>
>>
>> As with ppc_cpu_initfn() in your previous version, init_proc_POWER9() is
>> called for every CPU instance.. ie, all CPU will adjust the @pcr_supported
>> class attribute...
>>
>> What about moving the workaround to ppc_POWER9_cpu_family_class_init()
>> instead ? This would just require to expose mfpvr() in some header.
> 
> I think I have already tried something like that, and I'm not sure the
> PVR is already set at this level of the initialization. But I'm going to
> try your patch.

oh, you check the host PVR, not the guest PVR.

Well, I'm not sure it's a good idea to modify the guest CPU property
according to the host CPU version. I let David to decide what is the
best solution here...

Thanks,
Laurent
