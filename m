Received: from eggs.gnu.org ([2001:4830:134:3::10]:60347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1f0P7X-00053S-Lc
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1f0P7T-0007Am-JZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:12:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:33886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1f0P7T-00078J-9z
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:12:51 -0400
References: <22f7f184-c295-4e18-c186-3fd9fdcce213@linux.intel.com>
	<20180323160252.GA27131@stefanha-x1.localdomain>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <1e0e5f9b-18b4-7f0f-dbd1-696ef1f7039c@linux.intel.com>
Date: Mon, 26 Mar 2018 18:12:44 +0800
MIME-Version: 1.0
In-Reply-To: <20180323160252.GA27131@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Consult] nfs-vsocks support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, yang.zhong@intel.com

Hi Stefan,

Thank you very much for the response! It truly gave me much help.

On 3/24/2018 12:02 AM, Stefan Hajnoczi wrote:
> On Fri, Mar 23, 2018 at 05:54:53PM +0800, Liu, Jing2 wrote:
>> I am currently trying to use nfs-vsocks on x86 for vitural machine
>> filesystem by some manuals on
>> https://www.spinics.net/lists/linux-nfs/msg64563.html
>> and https://lwn.net/Articles/647516/
>>
[...]
> 
>> 3. For the 5th step (Start nfsd), I'd like to know the rpc.nfsd --vsock is
>> enabled by which codes? Is it the CONFIG_VHOST_VSOCK kernel module in host?
>> Because I installed the kernel with vsock-nfs repo with the specified config
>> options but failed to do rpc.nfsd --vsock.
>>
>>
>> Could you give me some help and thanks in advance!
> 
> Here is a script that launches nfsd and runs a guest:
> https://github.com/stefanha/linux/commit/38cbc15661a6dd44b69c4f318091f2047d707035#diff-05f3fe8941076453942a8c059b409009

I have updated both host and guest kernel with vsock-nfsd repo and 
installed nfs-utils in both host and guest successfully.

There're two different manuals in 
https://www.spinics.net/lists/linux-nfs/msg64563.html(Quickstart 3~7) 
and nfs-utils (README step 3 DAEMON STARTUP ORDER).
Which one should be the best usage?

For the first quickstart manual step 7-Mount the export from the guest, 
two questions as follows.
1. why hypervisor's CID is 2? I didn't notice when it is specified?
2. Though I did step 3~7 successfully, I can't see the synchronistical 
changing on host folder /export/ and guest /mnt? So how to test the 
communcation between host and guest on the folder?

Thanks again!

Jing

> 
> Regarding rpc.nfsd, on my Fedora 27 system rfc.nfsd is launched by
> /usr/lib/systemd/system/nfs.service.  When developing NFS over AF_VSOCK
> I disable the NFS service and launch nfsd manually from the script
> above.
> 
> Stefan
> 
