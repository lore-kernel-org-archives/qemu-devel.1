Received: from eggs.gnu.org ([2001:4830:134:3::10]:55273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAKXr-0001Ce-1e
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAKXn-00017h-QI
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:53:22 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gAKXn-00017K-Iy
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:53:19 -0400
Received: by mail-pg1-x541.google.com with SMTP id c10-v6so3005819pgq.4
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 12:53:19 -0700 (PDT)
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<3F86795E-6F41-4C86-91C6-21E8312F5E4B@eideticom.com>
	<a9cf5e6c09eed752b123d5de842bdc3264e37117.camel@redhat.com>
	<5A5F4A2B-2DAF-4D70-BF1D-7ABC8461FDC8@raithlin.com>
	<63b741e2-b3e5-283a-4dfc-9c1db757c575@gmail.com>
	<D55C15F1-937F-474B-82B1-3F891E03638F@raithlin.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <99997a93-da91-6a03-bc0b-fb539f05d797@gmail.com>
Date: Wed, 10 Oct 2018 12:53:10 -0700
MIME-Version: 1.0
In-Reply-To: <D55C15F1-937F-474B-82B1-3F891E03638F@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Bates <sbates@raithlin.com>, Andrea Bolognani <abologna@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Keith Busch <keith.busch@intel.com>, "palmer@sifive.com" <palmer@sifive.com>, "Richard W.M. Jones" <rjones@redhat.com>



On 10/10/2018 11:47 AM, Stephen  Bates wrote:
>>     Why do you need two networking options?
> 
> I don't need the e1000 for networking. The e1000 option is there to test the PCIe since it implements a PCIe model of the e1000 NIC. Basically it's another test path for your PCIe patches and was used for testing when PCIe support to the arm virt model [1].
>      
>>     Strange. Is there any reason you need to use the e1000? The VirtIO
>>     networking device works for me.
>      
> As per above. The e1000 is there to test PCIe not networking.

Awe. My mistake. I thought that the VirtIO networking device was a PCIe 
device for some reason.

Alistair

> 
> Stephen
>      
> [1] https://github.com/qemu/qemu/commit/4ab29b8214cc4b54e0c1a8270b610a340311470e
> 
