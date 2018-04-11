Received: from eggs.gnu.org ([2001:4830:134:3::10]:53907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f66rw-0003Y0-8K
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f66rt-0000ns-8k
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:56:24 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:40711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1f66rs-0000n2-VA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 23:56:21 -0400
Received: by mail-pf0-x231.google.com with SMTP id y66so297308pfi.7
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 20:56:20 -0700 (PDT)
References: <20180409062538.1095-1-bharata@linux.vnet.ibm.com>
	<20180410030245.GF3361@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0344e7f6-2861-7a13-6510-19d63c01d96a@ozlabs.ru>
Date: Wed, 11 Apr 2018 13:56:14 +1000
MIME-Version: 1.0
In-Reply-To: <20180410030245.GF3361@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com

On 10/4/18 1:02 pm, David Gibson wrote:
> On Mon, Apr 09, 2018 at 11:55:38AM +0530, Bharata B Rao wrote:
>> The new property ibm,dynamic-memory-v2 allows memory to be represented
>> in a more compact manner in device tree.
> 
> I still need to look at this in more detail, but to start with:
> what's the rationale for this new format?
> 
> It's more compact, but why do we care?  The embedded people always
> whinge about the size of the deivce tree, but I didn't think that was
> really a concern with PAPR.


Well, booting a guest with 500 pci devices (let's say emulated e1000 or
virtio-net) creates >20sec delay in the guest while it is fetching the
device tree in early setup, property by property, I even have a patch for
pseries guest to get FDT as a whole blob from SLOF. It is not The Problem
but still annoying.


-- 
Alexey
