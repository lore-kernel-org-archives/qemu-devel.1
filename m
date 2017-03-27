Received: from eggs.gnu.org ([2001:4830:134:3::10]:59297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1csXEs-0004KB-2A
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1csXEm-0006ae-D2
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:11:26 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com
	([104.47.36.72]:23680
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1csXEl-0006Xi-TE
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:11:20 -0400
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900632968.27090.15435012868487968230.stgit@brijesh-build-machine>
	<20170323113517.GC12560@stefanha-x1.localdomain>
	<6ed30368-1433-cf00-ee2e-611faf2a98e3@amd.com>
	<20170324154007.GB5849@stefanha-x1.localdomain>
	<3b210d06-b6f9-af04-ff68-e7cee1c8033f@amd.com>
	<20170327120404.GA28620@stefanha-x1.localdomain>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ecc81dc9-6d1c-796d-cfc3-f252e3e10277@amd.com>
Date: Mon, 27 Mar 2017 11:11:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170327120404.GA28620@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 06/20] core: add new security-policy
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: brijesh.singh@amd.com, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com


On 03/27/2017 07:04 AM, Stefan Hajnoczi wrote:
> On Fri, Mar 24, 2017 at 02:42:47PM -0500, Brijesh Singh wrote:
>>
>> On 03/24/2017 10:40 AM, Stefan Hajnoczi wrote:
>>
>>>
>>> Having one security policy doesn't make sense to me.  As mentioned,
>>> there are many different areas of QEMU that have security relevant
>>> configuration.  They are all unrelated so combining them into one object
>>> with vague parameter names like "debug" makes for a confusing
>>> command-line interface.
>>>
>>> If the object is called sev-security-policy then I'm happy.
>>>
>>
>> Works for with me but one of the feedback was to use security-policy [1].
>> IIRC, the main reason for using 'security-policy' instead of 'sev-security-policy'
>> was to add a layer of abstraction so that in future if other platforms supports
>> memory encryption in slightly different way then all we need to do is to create
>> new object without needing to add a new parameter in -machine.
>>
>> [1] http://marc.info/?l=qemu-devel&m=147388592213137&w=2
>>
>> How about using 'memory-encryption-id' instead of security-policy ? If user wants
>> to launch SEV guest then memory-encryption-id should be set SEV specific object.
>> Something like this:
>>
>> -machine ..,memory-encryption-id=sev0 \
>> -object sev-guest,id=sev,debug=off,launch=launch0 \
>> -object sev-launch-info,id=launch0 \
>
> Something like that sounds good.  I think "-id" typically isn't included
> in the option name.
>
> So just the following is fine:
>
>  -machine memory-encryption=sev0 \
>  ...
>
> Other examples: -device virtio-blk-pci,drive=drive0 and -device
> e1000,netdev=netdev0.


Sounds good. I will take care of this in next rev. thanks for review

-Brijesh
