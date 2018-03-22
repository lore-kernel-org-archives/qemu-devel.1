Received: from eggs.gnu.org ([2001:4830:134:3::10]:48504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ez0Zc-00041e-0B
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ez0Zb-0000Vt-6M
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:48:08 -0400
References: <20180322031216.14569-1-wei@redhat.com>
	<20180322080156.x2q7w6wtdrvc3wk3@hawk.localdomain>
	<CAFEAcA_Sb6iz-8cg00JXhNF5pMS3z2=QxhoEhwSgG6PG04nKqg@mail.gmail.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <1571d9c0-de78-3daa-20f6-3e0e293f6658@redhat.com>
Date: Thu, 22 Mar 2018 08:47:44 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Sb6iz-8cg00JXhNF5pMS3z2=QxhoEhwSgG6PG04nKqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Set VM's SMBIOS system
 version to mc->desc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>



On 03/22/2018 05:53 AM, Peter Maydell wrote:
> On 22 March 2018 at 08:01, Andrew Jones <drjones@redhat.com> wrote:
>> I agree we should change the useless 1.0, but shouldn't we use
>> mc->name instead of mc->desc? mc->name would make it consistent
>> with pc-piix and q35 and also be a less verbose "version". We'd
>> get e.g.
>>
>>  System Information
>>         Manufacturer: QEMU
>>         Product Name: KVM Virtual Machine
>>         Version: virt-2.12
>>         Serial Number: Not Specified
> 
> I would vote for consistency with x86, I think.

Drew and you like ->name better because of its conciseness consistency
with x86. In my view virt-2.xx is not very informative. "Version" info
in real machine could be verbose. Using my Thinkpad as example:

	Manufacturer: LENOVO
	Product Name: 20FAS1EG0N
	Version: ThinkPad T460s

With that said, I will change it to mc->name.

> 
> thanks
> -- PMM
> 
